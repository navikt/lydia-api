package no.nav.lydia.container.ia.eksport

import ia.felles.definisjoner.bransjer.Bransjer
import io.kotest.inspectors.forAtLeastOne
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json
import no.nav.lydia.helper.KafkaContainerHelper
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.opprettSakForVirksomhet
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.oauth2ServerContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper.Companion.lastInnNyVirksomhet
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.eksport.IASakStatusProdusent
import no.nav.lydia.ia.eksport.IA_SAK_STATUS_EKSPORT_PATH
import no.nav.lydia.ia.sak.domene.IAProsessStatus.KONTAKTES
import no.nav.lydia.ia.sak.domene.IASakshendelseType.TA_EIERSKAP_I_SAK
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES
import no.nav.lydia.virksomhet.domene.Næringsgruppe
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
        val næringskode = "${Bransjer.BYGG.næringskoder.first()}.123"
        val virksomhet = TestVirksomhet.nyVirksomhet(næringer = listOf(Næringsgruppe(kode = næringskode, navn = "Bygg og ting")))
        lastInnNyVirksomhet(virksomhet)

        val sak = opprettSakForVirksomhet(orgnummer = virksomhet.orgnr, token = oauth2ServerContainer.superbruker1.token)
            .nyHendelse(hendelsestype = TA_EIERSKAP_I_SAK, token = oauth2ServerContainer.saksbehandler1.token)
            .nyHendelse(hendelsestype = VIRKSOMHET_SKAL_KONTAKTES, token = oauth2ServerContainer.saksbehandler1.token)

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
}

