package no.nav.lydia.container.ia.eksport

import io.kotest.inspectors.forAtLeastOne
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldContain
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.helper.KafkaContainerHelper
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.SakHelper.Companion.leggTilLeveranseOgFullførSak
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.nyIkkeAktuellHendelse
import no.nav.lydia.helper.SakHelper.Companion.opprettSakForVirksomhet
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.oauth2ServerContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestData.Companion.BOLIGBYGGELAG
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper.Companion.lastInnNyVirksomhet
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.eksport.IASakStatusProdusent
import no.nav.lydia.ia.eksport.IA_SAK_STATUS_EKSPORT_PATH
import no.nav.lydia.ia.sak.domene.IAProsessStatus.FULLFØRT
import no.nav.lydia.ia.sak.domene.IAProsessStatus.KONTAKTES
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.IASakshendelseType.TA_EIERSKAP_I_SAK
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES
import org.junit.After
import org.junit.Before
import kotlin.test.Test

class IASakStatusEksportørTest {
    private val konsument = kafkaContainerHelper.nyKonsument(consumerGroupId = this::class.java.name)

    @Before
    fun setUp() {
        konsument.subscribe(mutableListOf(KafkaContainerHelper.iaSakStatusTopic))
    }

    @After
    fun tearDown() {
        konsument.unsubscribe()
        konsument.close()
    }

    @Test
    fun `skal trigge kafka-eksport av IASakStatus`() {
        val virksomhet =
            TestVirksomhet.nyVirksomhet(næringer = listOf(BOLIGBYGGELAG))
        lastInnNyVirksomhet(virksomhet)

        val sak =
            opprettSakForVirksomhet(orgnummer = virksomhet.orgnr, token = oauth2ServerContainer.superbruker1.token)
                .nyHendelse(hendelsestype = TA_EIERSKAP_I_SAK, token = oauth2ServerContainer.saksbehandler1.token)
                .nyHendelse(
                    hendelsestype = VIRKSOMHET_SKAL_KONTAKTES,
                    token = oauth2ServerContainer.saksbehandler1.token
                )

        TestContainerHelper.lydiaApiContainer.performGet(IA_SAK_STATUS_EKSPORT_PATH).tilSingelRespons<Unit>()

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = sak.orgnr,
                konsument = konsument
            ) { meldinger ->
                val objektene = meldinger.map {
                    Json.decodeFromString<IASakStatusProdusent.IASakStatus>(it)
                }
                objektene shouldHaveSize 5
                objektene.forAtLeastOne {
                    it.orgnr shouldBe sak.orgnr
                    it.saksnummer shouldBe sak.saksnummer
                    it.status shouldBe KONTAKTES
                }
                objektene.filter { it.status == KONTAKTES } shouldHaveSize 2
            }
        }
    }

    @Test
    fun `sletting av feilåpnet sak produserer en slett melding på topic og spiller ut aktiv sak sin status`() {
        runBlocking {
            val eldsteSak = SakHelper.nySakIViBistår().nyIkkeAktuellHendelse()
            val gammelSak = SakHelper.nySakIViBistår(orgnummer = eldsteSak.orgnr).leggTilLeveranseOgFullførSak()

            // -- Slett en sak, for å teste om siste melding er den gjeldene aktive statusen
            opprettSakForVirksomhet(orgnummer = eldsteSak.orgnr)
                .nyHendelse(IASakshendelseType.SLETT_SAK, token = oauth2ServerContainer.superbruker1.token)

            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(eldsteSak.orgnr, konsument) { meldinger ->
                meldinger shouldHaveSize 18
                // -- Siste meldingen skal være den gamle fullførte saken
                meldinger[17] shouldContain gammelSak.saksnummer
                meldinger[17] shouldContain gammelSak.orgnr
                meldinger[17] shouldContain FULLFØRT.name
            }
        }
    }
}
