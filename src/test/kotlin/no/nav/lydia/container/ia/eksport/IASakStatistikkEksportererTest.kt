package no.nav.lydia.container.ia.eksport

import ia.felles.definisjoner.bransjer.Bransje
import ia.felles.definisjoner.bransjer.BransjeId
import ia.felles.integrasjoner.jobbsender.Jobb.iaSakStatistikkEksport
import io.kotest.inspectors.forAtLeastOne
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.doubles.plusOrMinus
import io.kotest.matchers.shouldBe
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.SakHelper.Companion.leggTilLeveranseOgFullførSak
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.SakHelper.Companion.oppdaterHendelsespunkterTilDato
import no.nav.lydia.helper.SakHelper.Companion.opprettSakForVirksomhet
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.oauth2ServerContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
import no.nav.lydia.helper.TestData
import no.nav.lydia.helper.TestData.Companion.datoSentIGjeldendePeriode
import no.nav.lydia.helper.TestData.Companion.lagPerioder
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper.Companion.lastInnNyVirksomhet
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.ia.eksport.IASakStatistikkProdusent
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASakshendelseType.FULLFØR_BISTAND
import no.nav.lydia.ia.sak.domene.IASakshendelseType.TA_EIERSKAP_I_SAK
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_VURDERES
import no.nav.lydia.tilgangskontroll.fia.Rolle
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test

class IASakStatistikkEksportererTest {
    companion object {
        private val konsument = kafkaContainerHelper.nyKonsument(consumerGroupId = this::class.java.name)

        @BeforeClass
        @JvmStatic
        fun setUp() {
            konsument.subscribe(mutableListOf(Topic.IA_SAK_STATISTIKK_TOPIC.navn))
        }

        @AfterClass
        @JvmStatic
        fun tearDown() {
            konsument.unsubscribe()
            konsument.close()
        }
    }

    @Test
    fun `skal trigge kafka-eksport av IASakStatistikk`() {
        val næringskode = "${(Bransje.ANLEGG.bransjeId as BransjeId.Næring).næring}.120"
        val virksomhet = TestVirksomhet.nyVirksomhet(
            næringer = listOf(Næringsgruppe(kode = næringskode, navn = "Bygging av jernbaner og undergrunnsbaner")),
        )
        lastInnNyVirksomhet(virksomhet)

        val sak =
            opprettSakForVirksomhet(orgnummer = virksomhet.orgnr, token = oauth2ServerContainer.superbruker1.token)
                .nyHendelse(hendelsestype = TA_EIERSKAP_I_SAK, token = oauth2ServerContainer.saksbehandler1.token)

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = sak.saksnummer,
                konsument = konsument,
            ) { meldinger ->
                val objektene = meldinger.map {
                    Json.decodeFromString<IASakStatistikkProdusent.IASakStatistikkValue>(it)
                }
                objektene shouldHaveSize 3
                objektene.forExactlyOne {
                    it.saksnummer shouldBe sak.saksnummer
                    it.eierAvSak shouldBe oauth2ServerContainer.saksbehandler1.navIdent
                    it.status shouldBe IAProsessStatus.VURDERES
                    it.antallPersoner shouldBe hentFraKvartal(it, "antall_personer")
                    it.sykefraversprosent shouldBe hentFraKvartal(it, "sykefravarsprosent")
                    it.sykefraversprosentSiste4Kvartal shouldBe hentFraSiste4Kvartaler(it, "prosent")
                    it.bransjeprogram shouldBe Bransje.ANLEGG
                    it.endretAvRolle shouldBe Rolle.SAKSBEHANDLER
                    it.enhetsnummer shouldBe "2900"
                    it.enhetsnavn shouldBe "IT-avdelingen" // -- Bør ha fallback til minst spesifikk avdeling
                }
            }
        }
    }

    @Test
    fun `sjekk at vi får riktig sykefraværsstatistikk basert på når hendelsen skjedde`() {
        /*
         * Statistikken for “Gjeldende periode” blir publisert etter at kvartalet er over.
         * Det betyr at hendelser som skjedde på en dato i “Gjeldende periode” hadde annen statistikk enn det som skjedde “nå”.
         * Hendelser som skjer i dag bruker statistikk fra "gjeldende periode".
         * Hendelser som skjer i "gjeldende periode" bruker statistikk fra "forrige periode".
         * */
        val gjeldendePeriode = TestData.gjeldendePeriode
        val forrigePeriode = gjeldendePeriode.forrigePeriode()
        val sak = opprettSakForVirksomhet(orgnummer = lastInnNyVirksomhet(perioder = gjeldendePeriode.lagPerioder(3)).orgnr)
        sak.oppdaterHendelsespunkterTilDato(datoSentIGjeldendePeriode())
        sak.nyHendelse(TA_EIERSKAP_I_SAK)

        kafkaContainerHelper.sendJobbMelding(iaSakStatistikkEksport)

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = sak.saksnummer,
                konsument = konsument,
            ) { meldinger ->
                val objektene = meldinger.map {
                    Json.decodeFromString<IASakStatistikkProdusent.IASakStatistikkValue>(it)
                }
                objektene shouldHaveSize 6

                // Kun en hendelse av typen VIRKSOMHET_VURDERES skal ha skjedd i forrige periode
                objektene.forExactlyOne {
                    it.saksnummer shouldBe sak.saksnummer
                    it.hendelse shouldBe VIRKSOMHET_VURDERES
                    it.arstall shouldBe forrigePeriode.årstall
                    it.kvartal shouldBe forrigePeriode.kvartal
                    it.antallPersoner shouldBe hentFraKvartal(it, "antall_personer")
                    it.sykefraversprosent shouldBe hentFraKvartal(it, "sykefravarsprosent")
                    it.sykefraversprosentSiste4Kvartal shouldBe null
                }

                // Minst en hendelse av typen TA_EIERSKAP_I_SAK skal ha skjedd i gjeldende periode
                objektene.forAtLeastOne {
                    it.saksnummer shouldBe sak.saksnummer
                    it.hendelse shouldBe TA_EIERSKAP_I_SAK
                    it.arstall shouldBe gjeldendePeriode.årstall
                    it.kvartal shouldBe gjeldendePeriode.kvartal
                    it.antallPersoner shouldBe hentFraKvartal(it, "antall_personer")
                    it.sykefraversprosent shouldBe hentFraKvartal(it, "sykefravarsprosent")
                    it.sykefraversprosentSiste4Kvartal shouldBe hentFraSiste4Kvartaler(it, "prosent")
                }
            }
        }
    }

    @Test
    fun `det skal være mulig å eksportere fullførte saker uten leveranser selv om det ikke er mulig å fullføre en sak`() {
        // uten leveranser fra FIA
        val sak = nySakIViBistår().leggTilLeveranseOgFullførSak()
        postgresContainer.performUpdate("DELETE from iasak_leveranse where saksnummer='${sak.saksnummer}'")

        kafkaContainerHelper.sendJobbMelding(iaSakStatistikkEksport)

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = sak.saksnummer,
                konsument = konsument,
            ) { meldinger ->
                val objektene = meldinger.map {
                    Json.decodeFromString<IASakStatistikkProdusent.IASakStatistikkValue>(it)
                }
                objektene.forAtLeastOne {
                    it.saksnummer shouldBe sak.saksnummer
                    it.hendelse shouldBe FULLFØR_BISTAND
                }
            }
        }
    }

    private fun hentFraKvartal(
        it: IASakStatistikkProdusent.IASakStatistikkValue,
        kolonne: String,
    ) = postgresContainer.hentEnkelKolonne<Double>(
        "select $kolonne from sykefravar_statistikk_virksomhet where orgnr = '${it.orgnr}' and kvartal = ${it.kvartal} and arstall = ${it.arstall}",
    )
        .plusOrMinus(0.01)

    private fun hentFraSiste4Kvartaler(
        it: IASakStatistikkProdusent.IASakStatistikkValue,
        kolonne: String,
    ) = postgresContainer.hentEnkelKolonne<Double>(
        "select $kolonne from sykefravar_statistikk_virksomhet_siste_4_kvartal where orgnr = '${it.orgnr}'",
    )
        .plusOrMinus(0.01)
}
