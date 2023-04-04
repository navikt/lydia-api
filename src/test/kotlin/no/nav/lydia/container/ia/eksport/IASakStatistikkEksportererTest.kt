package no.nav.lydia.container.ia.eksport

import ia.felles.definisjoner.bransjer.Bransjer
import io.kotest.inspectors.forAtLeastOne
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.doubles.plusOrMinus
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import kotlinx.coroutines.runBlocking
import kotlinx.datetime.toJavaLocalDateTime
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json
import no.nav.lydia.helper.*
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.oppdaterHendelsesTidspunkter
import no.nav.lydia.helper.SakHelper.Companion.opprettSakForVirksomhet
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.lydiaApiContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.oauth2ServerContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
import no.nav.lydia.helper.VirksomhetHelper.Companion.lastInnNyVirksomhet
import no.nav.lydia.ia.eksport.IASakStatistikkProdusent
import no.nav.lydia.ia.eksport.IA_SAK_STATISTIKK_EKSPORT_PATH
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASakshendelseType.TA_EIERSKAP_I_SAK
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_VURDERES
import no.nav.lydia.sykefraversstatistikk.api.Periode
import no.nav.lydia.tilgangskontroll.Rådgiver.Rolle
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import org.junit.After
import org.junit.Before
import kotlin.test.Test

class IASakStatistikkEksportererTest {
    private val konsument = kafkaContainerHelper.nyKonsument(consumerGroupId = this::class.java.name)

    @Before
    fun setUp() {
        konsument.subscribe(mutableListOf(KafkaContainerHelper.iaSakStatistikkTopic))
    }

    @After
    fun tearDown() {
        konsument.unsubscribe()
        konsument.close()
    }

    @Test
    fun `skal trigge kafka-eksport av IASakStatistikk`() {
        val næringskode = "${Bransjer.BYGG.næringskoder.first()}.123"
        val virksomhet = TestVirksomhet.nyVirksomhet(næringer = listOf(Næringsgruppe(kode = næringskode, navn = "Bygg og ting")))
        lastInnNyVirksomhet(virksomhet)

        val sak = opprettSakForVirksomhet(orgnummer = virksomhet.orgnr, token = oauth2ServerContainer.superbruker1.token)
            .nyHendelse(hendelsestype = TA_EIERSKAP_I_SAK, token = oauth2ServerContainer.saksbehandler1.token)

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = sak.saksnummer,
                konsument = konsument
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
                    it.sykefraversprosent shouldBe hentFraKvartal(it, "sykefraversprosent")
                    it.sykefraversprosentSiste4Kvartal shouldBe hentFraSiste4Kvartaler(it, "prosent")
                    it.bransjeprogram shouldBe Bransjer.BYGG
                    it.endretAvRolle shouldBe Rolle.SAKSBEHANDLER
                }
            }
        }
    }

    @Test
    fun `sjekk at vi får riktig sykefraværsstatistikk basert på når hendelsen skjedde`() {
        val sak = opprettSakForVirksomhet(orgnummer = lastInnNyVirksomhet(perioder = listOf(
            Periode.gjeldendePeriode(),
            Periode.forrigePeriode(),
            Periode.forrigePeriode().forrigePeriode(),
        )).orgnr)
        sak.oppdaterHendelsesTidspunkter(100)
        sak.nyHendelse(TA_EIERSKAP_I_SAK)

        lydiaApiContainer.performGet(IA_SAK_STATISTIKK_EKSPORT_PATH).tilSingelRespons<Unit>()

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = sak.saksnummer,
                konsument = konsument
            ) { meldinger ->
                val objektene = meldinger.map {
                    Json.decodeFromString<IASakStatistikkProdusent.IASakStatistikkValue>(it)
                }
                objektene shouldHaveSize 6
                objektene.forExactlyOne {
                    it.saksnummer shouldBe sak.saksnummer
                    it.hendelse shouldBe VIRKSOMHET_VURDERES
                    Periode.fraDato(dato = it.endretTidspunkt.toJavaLocalDateTime()) shouldNotBe Periode.gjeldendePeriode()
                    it.arstall shouldBe Periode.fraDato(dato = it.endretTidspunkt.toJavaLocalDateTime()).årstall
                    it.kvartal shouldBe Periode.fraDato(dato = it.endretTidspunkt.toJavaLocalDateTime()).kvartal
                    it.antallPersoner shouldBe hentFraKvartal(it, "antall_personer")
                    it.sykefraversprosent shouldBe hentFraKvartal(it, "sykefraversprosent")
                    it.sykefraversprosentSiste4Kvartal shouldBe null
                }
                objektene.forAtLeastOne {
                    it.saksnummer shouldBe sak.saksnummer
                    it.hendelse shouldBe TA_EIERSKAP_I_SAK
                    it.arstall shouldBe Periode.gjeldendePeriode().årstall
                    it.kvartal shouldBe Periode.gjeldendePeriode().kvartal
                    it.antallPersoner shouldBe hentFraKvartal(it, "antall_personer")
                    it.sykefraversprosent shouldBe hentFraKvartal(it, "sykefraversprosent")
                    it.sykefraversprosentSiste4Kvartal shouldBe hentFraSiste4Kvartaler(it, "prosent")
                }
            }
        }
    }

    private fun hentFraKvartal(
        it: IASakStatistikkProdusent.IASakStatistikkValue,
        kolonne: String,
    ) =
        postgresContainer.hentEnkelKolonne<Double>("select $kolonne from sykefravar_statistikk_virksomhet where orgnr = '${it.orgnr}' and kvartal = ${it.kvartal} and arstall = ${it.arstall}")
            .plusOrMinus(0.01)

    private fun hentFraSiste4Kvartaler(
        it: IASakStatistikkProdusent.IASakStatistikkValue,
        kolonne: String,
    ) =
        postgresContainer.hentEnkelKolonne<Double>("select $kolonne from sykefravar_statistikk_virksomhet_siste_4_kvartal where orgnr = '${it.orgnr}'")
            .plusOrMinus(0.01)
}

