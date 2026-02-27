package no.nav.lydia.container.ny.flyt.migrering

import ia.felles.definisjoner.bransjer.Bransje
import ia.felles.definisjoner.bransjer.BransjeId
import ia.felles.integrasjoner.jobbsender.Jobb
import io.kotest.inspectors.forAll
import io.kotest.matchers.collections.shouldContainExactly
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.comparables.shouldBeEqualComparingTo
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldContain
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.container.ia.eksport.IASakStatistikkEksportererTest.Companion.hentFraKvartal
import no.nav.lydia.container.ia.eksport.IASakStatistikkEksportererTest.Companion.hentFraSiste4Kvartaler
import no.nav.lydia.container.ny.flyt.NyFlytTest.Companion.hentVirksomhetTilstand
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.SakHelper.Companion.hentSamarbeidshistorikkNyFlyt
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.opprettNyttSamarbeid
import no.nav.lydia.ia.eksport.IASakStatistikkProdusent
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetIATilstand
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.tilgangskontroll.fia.Rolle
import no.nav.lydia.vedlikehold.IASakStatusOppdaterer.Companion.NAV_ENHET_FOR_MASKINELT_OPPDATERING
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test

class NyFlytMigreringSakKartleggesTest {
    // Rad #6
    @Test
    fun `sak med status KARTLEGGES og et aktivt samarbeid migreres til AKTIV status`() {
        val næringskode = "${(Bransje.ANLEGG.bransjeId as BransjeId.Næring).næring}.120"
        val nyVirksomhet = TestVirksomhet.nyVirksomhet(
            næringer = listOf(`Næringsgruppe`(kode = næringskode, navn = "Bygging av jernbaner og undergrunnsbaner")),
        )
        val virksomhet = VirksomhetHelper.lastInnNyVirksomhet(nyVirksomhet)
        val iaSakDto = SakHelper.nySakIKartlegges(virksomhet.orgnr)
        val sistEndretAvBruker = iaSakDto.opprettNyttSamarbeid().endretTidspunkt

        // konsummer kafka meldinger som er sent før migrering for å "tømme" topicene, slik at vi kun får med meldinger som er sendt som følge av migreringen
        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(key = iaSakDto.saksnummer, konsument = iaSakKonsument) {}
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = iaSakDto.saksnummer,
                konsument = iaSakStatistikkKonsument,
            ) {}
        }

        // send jobbmelding
        kafkaContainerHelper.sendJobbMelding(Jobb.migrerEnVirksomhetTilNyFlyt, parameter = virksomhet.orgnr)

        // tilstand = vurderes
        val migrertSak: IASakDto = SakHelper.hentSakNyFlyt(orgnummer = iaSakDto.orgnr)
        val sistEndretEtterMigrering = migrertSak.endretTidspunkt
        migrertSak.status shouldBe IASak.Status.AKTIV

        // Sjekk at tidspunkt for sist endret på sak IKKE er oppdatert til migreringstidspunkt
        sistEndretEtterMigrering!! shouldBeEqualComparingTo sistEndretAvBruker!!

        // tilstand = VirksomhetHarAktiveSamarbeid
        val virksomhetsTilstandOppdatert = hentVirksomhetTilstand(orgnr = iaSakDto.orgnr)
        virksomhetsTilstandOppdatert.tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        // Historikk
        hentSamarbeidshistorikkNyFlyt(orgnummer = iaSakDto.orgnr).also { samarbeidshistorikk ->
            samarbeidshistorikk shouldHaveSize 1
            val sakshistorikk = samarbeidshistorikk.first()
            sakshistorikk.sakshendelser.map { it.status } shouldContainExactly listOf(
                IASak.Status.NY,
                IASak.Status.VURDERES,
                IASak.Status.VURDERES,
                IASak.Status.KONTAKTES,
                IASak.Status.KARTLEGGES,
                IASak.Status.KARTLEGGES,
                IASak.Status.AKTIV,
            )
            sakshistorikk.sakshendelser.map { it.hendelsestype } shouldContainExactly listOf(
                IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
                IASakshendelseType.VIRKSOMHET_VURDERES,
                IASakshendelseType.TA_EIERSKAP_I_SAK,
                IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
                IASakshendelseType.VIRKSOMHET_KARTLEGGES,
                IASakshendelseType.NY_PROSESS,
                IASakshendelseType.MIGRERING_TIL_NY_FLYT,
            )
        }

        // Sjekk avhengigheter er varslet
        runBlocking {
            // Sak observer - IASakProdusent
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(key = iaSakDto.saksnummer, konsument = iaSakKonsument) { meldinger ->
                meldinger.forAll { hendelse ->
                    hendelse shouldContain iaSakDto.saksnummer
                    hendelse shouldContain iaSakDto.orgnr
                }
                meldinger shouldHaveSize 1
                meldinger[0] shouldContain IASak.Status.AKTIV.name
            }
            // IASakStatistikkProdusent
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = iaSakDto.saksnummer,
                konsument = iaSakStatistikkKonsument,
            ) { meldinger ->
                val objektene = meldinger.map {
                    Json.decodeFromString<IASakStatistikkProdusent.IASakStatistikkValue>(it)
                }
                objektene shouldHaveSize 1
                objektene.forExactlyOne {
                    it.orgnr shouldBe iaSakDto.orgnr
                    it.saksnummer shouldBe iaSakDto.saksnummer
                    it.eierAvSak shouldBe iaSakDto.eidAv
                    it.status shouldBe IASak.Status.AKTIV
                    it.antallPersoner shouldBe hentFraKvartal(it, "antall_personer")
                    it.sykefraversprosent shouldBe hentFraKvartal(it, "sykefravarsprosent")
                    it.sykefraversprosentSiste4Kvartal shouldBe hentFraSiste4Kvartaler(it, "prosent")
                    it.bransjeprogram shouldBe Bransje.ANLEGG
                    it.endretAv shouldBe "Fia system"
                    it.endretAvRolle shouldBe Rolle.SUPERBRUKER
                    it.enhetsnummer shouldBe NAV_ENHET_FOR_MASKINELT_OPPDATERING.enhetsnummer
                    it.enhetsnavn shouldBe NAV_ENHET_FOR_MASKINELT_OPPDATERING.enhetsnavn
                }
            }
        }
    }

    companion object {
        private val iaSakTopic = Topic.IA_SAK_TOPIC
        private val iaSakStatistikkTopic = Topic.IA_SAK_STATISTIKK_TOPIC
        private val iaSakKonsument = kafkaContainerHelper.nyKonsument(topic = iaSakTopic)
        private val iaSakStatistikkKonsument = kafkaContainerHelper.nyKonsument(topic = iaSakStatistikkTopic)

        @BeforeClass
        @JvmStatic
        fun setUp() {
            iaSakKonsument.subscribe(mutableListOf(iaSakTopic.navn))
            iaSakStatistikkKonsument.subscribe(mutableListOf(iaSakStatistikkTopic.navn))
        }

        @AfterClass
        @JvmStatic
        fun tearDown() {
            iaSakKonsument.unsubscribe()
            iaSakKonsument.close()

            iaSakStatistikkKonsument.unsubscribe()
            iaSakStatistikkKonsument.close()
        }
    }
}
