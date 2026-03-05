package no.nav.lydia.container.ny.flyt.migrering

import ia.felles.definisjoner.bransjer.Bransje
import ia.felles.definisjoner.bransjer.BransjeId
import ia.felles.integrasjoner.jobbsender.Jobb
import io.kotest.inspectors.forAll
import io.kotest.inspectors.forAtLeastOne
import io.kotest.matchers.collections.shouldContainExactly
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.comparables.shouldBeEqualComparingTo
import io.kotest.matchers.comparables.shouldBeGreaterThanOrEqualTo
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.kotest.matchers.string.shouldContain
import kotlinx.coroutines.runBlocking
import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.container.ia.eksport.IASakStatistikkEksportererTest.Companion.hentFraKvartal
import no.nav.lydia.container.ia.eksport.IASakStatistikkEksportererTest.Companion.hentFraSiste4Kvartaler
import no.nav.lydia.container.ny.flyt.NyFlytTest.Companion.hentVirksomhetTilstand
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.SakHelper.Companion.hentSak
import no.nav.lydia.helper.SakHelper.Companion.hentSamarbeidshistorikkNyFlyt
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.ia.eksport.IASakStatistikkProdusent
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetIATilstand
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetTilstandAutomatiskOppdateringDto
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetTilstandDto
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.tilgangskontroll.fia.Rolle
import no.nav.lydia.vedlikehold.IASakStatusOppdaterer.Companion.NAV_ENHET_FOR_MASKINELT_OPPDATERING
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import org.apache.kafka.clients.consumer.KafkaConsumer
import org.junit.AfterClass
import org.junit.BeforeClass

class MigreringTestUtils {
    companion object {
        private val iaSakTopic = Topic.IA_SAK_TOPIC
        private val iaSakStatistikkTopic = Topic.IA_SAK_STATISTIKK_TOPIC
        private lateinit var iaSakKonsument: KafkaConsumer<String, String>
        private lateinit var iaSakStatistikkKonsument: KafkaConsumer<String, String>

        @BeforeClass
        @JvmStatic
        fun utilsSetUp() {
            iaSakKonsument = kafkaContainerHelper.nyKonsument(topic = iaSakTopic)
            iaSakStatistikkKonsument = kafkaContainerHelper.nyKonsument(topic = iaSakStatistikkTopic)
            iaSakKonsument.subscribe(mutableListOf(iaSakTopic.navn))
            iaSakStatistikkKonsument.subscribe(mutableListOf(iaSakStatistikkTopic.navn))
        }

        @AfterClass
        @JvmStatic
        fun utilsTearDown() {
            iaSakKonsument.unsubscribe()
            iaSakKonsument.close()

            iaSakStatistikkKonsument.unsubscribe()
            iaSakStatistikkKonsument.close()
        }

        fun mirgeringSakIViBistår(): IASakDto {
            val næringskode = "${(Bransje.ANLEGG.bransjeId as BransjeId.Næring).næring}.120"
            val nyVirksomhet = TestVirksomhet.nyVirksomhet(
                næringer = listOf(Næringsgruppe(kode = næringskode, navn = "Bygging av jernbaner og undergrunnsbaner")),
            )
            val virksomhet = VirksomhetHelper.lastInnNyVirksomhet(nyVirksomhet)
            val iaSakDto = SakHelper.nySakIViBistår(virksomhet.orgnr)
            return iaSakDto
        }

        fun migreringSakIKartlegges(): IASakDto {
            val næringskode = "${(Bransje.ANLEGG.bransjeId as BransjeId.Næring).næring}.120"
            val nyVirksomhet = TestVirksomhet.nyVirksomhet(
                næringer = listOf(Næringsgruppe(kode = næringskode, navn = "Bygging av jernbaner og undergrunnsbaner")),
            )
            val virksomhet = VirksomhetHelper.lastInnNyVirksomhet(nyVirksomhet)
            val iaSakDto = SakHelper.nySakIKartlegges(virksomhet.orgnr)
            return iaSakDto
        }

        fun tømmKafkaTopics(iaSakDto: IASakDto) {
            val hentetSakStatus = hentSak(orgnummer = iaSakDto.orgnr, saksnummer = iaSakDto.saksnummer).status

            runBlocking {
                kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                    key = iaSakDto.saksnummer,
                    konsument = iaSakKonsument,
                ) { meldinger ->
                    meldinger.forAtLeastOne { hendelse: String ->
                        hendelse shouldContain iaSakDto.orgnr
                        hendelse shouldContain iaSakDto.saksnummer
                        hendelse shouldContain hentetSakStatus.name
                    }
                }
                kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                    key = iaSakDto.saksnummer,
                    konsument = iaSakStatistikkKonsument,
                ) { meldinger ->
                    val objektene = meldinger.map {
                        Json.decodeFromString<IASakStatistikkProdusent.IASakStatistikkValue>(it)
                    }
                    objektene.forAtLeastOne {
                        it.orgnr shouldBe iaSakDto.orgnr
                        it.saksnummer shouldBe iaSakDto.saksnummer
                        it.status shouldBe hentetSakStatus
                    }
                }
            }
        }

        fun sendMigreringsmeldingOgVerifiserSak(
            iaSakDto: IASakDto,
            sistEndretAvBruker: LocalDateTime?,
            forventetStatus: IASak.Status,
            forventetTilstand: VirksomhetIATilstand,
            forventetAutomatiskOppdatering: VirksomhetTilstandAutomatiskOppdateringDto? = null,
            migrer: Boolean = true,
        ) {
            kafkaContainerHelper.sendJobbMelding(Jobb.migrerEnVirksomhetTilNyFlyt, parameter = "${iaSakDto.orgnr}:$migrer")

            val migrertSak = SakHelper.hentSakNyFlyt(orgnummer = iaSakDto.orgnr)
            migrertSak.status shouldBe forventetStatus
            migrertSak.endretTidspunkt!! shouldBeEqualComparingTo sistEndretAvBruker!!

            val virksomhetsTilstand: VirksomhetTilstandDto = hentVirksomhetTilstand(orgnr = iaSakDto.orgnr)
            virksomhetsTilstand.tilstand shouldBe forventetTilstand

            if (forventetAutomatiskOppdatering != null) {
                virksomhetsTilstand.nesteTilstand shouldNotBe null
                virksomhetsTilstand.nesteTilstand!!.startTilstand shouldBe forventetAutomatiskOppdatering.startTilstand
                virksomhetsTilstand.nesteTilstand.nyTilstand shouldBe forventetAutomatiskOppdatering.nyTilstand
                virksomhetsTilstand.nesteTilstand.planlagtHendelse shouldBe forventetAutomatiskOppdatering.planlagtHendelse
                virksomhetsTilstand.nesteTilstand.planlagtDato shouldBeGreaterThanOrEqualTo forventetAutomatiskOppdatering.planlagtDato
            } else {
                virksomhetsTilstand.nesteTilstand shouldBe null
            }
        }

        fun verifiserHistorikk(
            orgnummer: String,
            forventedeStatuser: List<IASak.Status>,
            forventedeHendelsestyper: List<IASakshendelseType>,
        ) {
            hentSamarbeidshistorikkNyFlyt(orgnummer = orgnummer).also { samarbeidshistorikk ->
                samarbeidshistorikk shouldHaveSize 1
                val sakshistorikk = samarbeidshistorikk.first()
                sakshistorikk.sakshendelser.map { it.status } shouldContainExactly forventedeStatuser
                sakshistorikk.sakshendelser.map { it.hendelsestype } shouldContainExactly forventedeHendelsestyper
            }
        }

        fun verifiserKafkaMeldinger(
            iaSakDto: IASakDto,
            forventetStatus: IASak.Status,
        ) {
            runBlocking {
                kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(key = iaSakDto.saksnummer, konsument = iaSakKonsument) { meldinger ->
                    meldinger.forAll { hendelse ->
                        hendelse shouldContain iaSakDto.saksnummer
                        hendelse shouldContain iaSakDto.orgnr
                    }
                    meldinger shouldHaveSize 1
                    meldinger[0] shouldContain forventetStatus.name
                }
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
                        it.status shouldBe forventetStatus
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
    }
}
