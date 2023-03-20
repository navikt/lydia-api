package no.nav.lydia.container.ia.eksport

import ia.felles.definisjoner.bransjer.Bransjer
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.doubles.plusOrMinus
import io.kotest.matchers.shouldBe
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json
import no.nav.lydia.helper.*
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.oauth2ServerContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
import no.nav.lydia.ia.eksport.IASakStatistikkProdusent
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASakshendelseType
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
        VirksomhetHelper.lastInnNyVirksomhet(virksomhet)

        val sak = SakHelper.opprettSakForVirksomhet(orgnummer = virksomhet.orgnr, token = oauth2ServerContainer.superbruker1.token)
            .nyHendelse(hendelsestype = IASakshendelseType.TA_EIERSKAP_I_SAK, token = oauth2ServerContainer.saksbehandler1.token)

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

