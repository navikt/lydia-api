package no.nav.lydia.container.ia.sak.kartlegging

import com.github.kittinunf.fuel.core.extensions.authentication
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettKartlegging
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.sendKartleggingSvarTilKafka
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.start
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.sak.api.kartlegging.IASakKartleggingDto
import no.nav.lydia.ia.sak.api.kartlegging.KARTLEGGING_BASE_ROUTE
import no.nav.lydia.ia.sak.domene.KartleggingStatus
import no.nav.lydia.ia.sak.domene.SpørreundersøkelseDto
import org.junit.After
import org.junit.Before
import java.util.*
import kotlin.test.Test

class IASakKartleggingSvarKonsumentTest {

    val kartleggingKonsument = TestContainerHelper.kafkaContainerHelper.nyKonsument(this::class.java.name)

    @Before
    fun setUp() {
        kartleggingKonsument.subscribe(mutableListOf(Topic.SPORREUNDERSOKELSE_TOPIC.navn))
    }

    @After
    fun tearDown() {
        kartleggingKonsument.unsubscribe()
        kartleggingKonsument.close()
    }

    @Test
    fun `skal lagre svar mottatt på Kafka topic`() {
        val sak = SakHelper.nySakIKartlegges()
        val kartlegging = sak.opprettKartlegging()
        kartlegging.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        val kartleggingSvarDto = kartlegging.sendKartleggingSvarTilKafka()

        TestContainerHelper.postgresContainer
            .hentEnkelKolonne<String>(
                "select kartlegging_id from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'"
            ) shouldBe kartleggingSvarDto.spørreundersøkelseId
    }

    @Test
    fun `Skal ikke kunne svare på kartlegging som ikke eksisterer`() {
        val kartleggingSvarDto = sendKartleggingSvarTilKafka()

        TestContainerHelper.postgresContainer
            .hentAlleRaderTilEnkelKolonne<String>(
                "select kartlegging_id from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'"
            ) shouldHaveSize 0
        TestContainerHelper.lydiaApiContainer.shouldContainLog("Fant ikke kartlegging på denne iden".toRegex())
    }

    @Test
    fun `Skal bare kunne svare på kartlegging dersom den er i pågående status`() {
        val sak = SakHelper.nySakIKartlegges()
        val kartlegging =  sak.opprettKartlegging()

        //OPRETTET
        kartlegging.sendKartleggingSvarTilKafka()
        TestContainerHelper.lydiaApiContainer.shouldContainLog("Kan ikke svare på en kartlegging i status OPPRETTET".toRegex())

        //PÅBEGYNT (ok å sende svar)
        kartlegging.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        kartlegging.sendKartleggingSvarTilKafka()
        TestContainerHelper.postgresContainer
            .hentAlleRaderTilEnkelKolonne<String>(
                "select kartlegging_id from ia_sak_kartlegging_svar where kartlegging_id = '${kartlegging.kartleggingId}'"
            ) shouldHaveSize 1

        //AVSLUTTET
        TestContainerHelper.lydiaApiContainer.performPost("$KARTLEGGING_BASE_ROUTE/${sak.orgnr}/${sak.saksnummer}/${kartlegging.kartleggingId}/avslutt")
            .authentication().bearer(TestContainerHelper.oauth2ServerContainer.saksbehandler1.token)
            .tilSingelRespons<IASakKartleggingDto>()
        kartlegging.sendKartleggingSvarTilKafka()
        TestContainerHelper.lydiaApiContainer.shouldContainLog("Kan ikke svare på en kartlegging i status AVSLUTTET".toRegex())

        //SLETTET
        TestContainerHelper.lydiaApiContainer.performPost("$KARTLEGGING_BASE_ROUTE/${sak.orgnr}/${sak.saksnummer}/${kartlegging.kartleggingId}/slett")
            .authentication().bearer(TestContainerHelper.oauth2ServerContainer.saksbehandler1.token)
            .tilSingelRespons<IASakKartleggingDto>()
        kartlegging.sendKartleggingSvarTilKafka()
        TestContainerHelper.lydiaApiContainer.shouldContainLog("Kan ikke svare på en kartlegging i status SLETTET".toRegex())
    }

    @Test
    fun `skal oppdatere ved nytt svar mottatt på Kafka topic`() {
        val sak = SakHelper.nySakIKartlegges()
        val kartleggingDto =  sak.opprettKartlegging()
        kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        val kartleggingSvarDto = kartleggingDto.sendKartleggingSvarTilKafka()

        TestContainerHelper.postgresContainer
            .hentEnkelKolonne<String>(
                "select svar_id from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'"
            ) shouldBe kartleggingSvarDto.svarId

        TestContainerHelper.postgresContainer
            .hentEnkelKolonne<String>(
                "select endret from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'"
            ) shouldBe null

        val nySvarId = UUID.randomUUID().toString()

        sendKartleggingSvarTilKafka(
            kartleggingId = kartleggingSvarDto.spørreundersøkelseId,
            spørsmålId = kartleggingSvarDto.spørsmålId,
            sesjonId = kartleggingSvarDto.sesjonId,
            svarId = nySvarId
        )

        TestContainerHelper.postgresContainer
            .hentEnkelKolonne<String>(
                "select svar_id from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'"
            ) shouldBe nySvarId
        TestContainerHelper.postgresContainer
            .hentEnkelKolonne<String>(
                "select endret from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'"
            ) shouldNotBe null
    }

    @Test
    fun `skal oppdatere spørreundersøkelses kafkamelding ved nytt svar`() {
        val sak = SakHelper.nySakIKartlegges()
        val kartleggingDto = sak.opprettKartlegging()
        kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        runBlocking {
            TestContainerHelper.kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                    key = kartleggingDto.kartleggingId,
                    konsument = kartleggingKonsument
            ) {
                it.forExactlyOne { melding ->
                    val spørreundersøkelse = Json.decodeFromString<SpørreundersøkelseDto>(melding)
                    spørreundersøkelse.status shouldBe KartleggingStatus.PÅBEGYNT
                    spørreundersøkelse.spørsmålOgSvaralternativer.first().antallSvar shouldBe 0
                }
            }
        }

        kartleggingDto.sendKartleggingSvarTilKafka()

        runBlocking {
            TestContainerHelper.kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                    key = kartleggingDto.kartleggingId,
                    konsument = kartleggingKonsument
            ) {
                it.forExactlyOne { melding ->
                    val spørreundersøkelse = Json.decodeFromString<SpørreundersøkelseDto>(melding)
                    spørreundersøkelse.status shouldBe KartleggingStatus.PÅBEGYNT
                    spørreundersøkelse.spørsmålOgSvaralternativer.first().antallSvar shouldBe 1
                }
            }
        }
    }
}
