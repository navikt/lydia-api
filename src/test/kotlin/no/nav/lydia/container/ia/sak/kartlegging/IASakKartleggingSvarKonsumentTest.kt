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
import no.nav.lydia.helper.TestContainerHelper.Companion.performDelete
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.sak.api.kartlegging.IASakKartleggingDto
import no.nav.lydia.ia.sak.api.kartlegging.KARTLEGGING_BASE_ROUTE
import no.nav.lydia.ia.sak.api.kartlegging.SpørreundersøkelseAntallSvarDto
import no.nav.lydia.ia.sak.domene.KartleggingStatus
import no.nav.lydia.ia.sak.domene.SpørreundersøkelseDto
import org.junit.After
import org.junit.Before
import java.util.*
import kotlin.test.Test
import org.postgresql.util.PGobject

class IASakKartleggingSvarKonsumentTest {

    val kartleggingKonsument = TestContainerHelper.kafkaContainerHelper.nyKonsument("spørreundersøkelse")
    val spørreundersøkelseAntallSvarKonsument = TestContainerHelper.kafkaContainerHelper.nyKonsument("spørreundersøkelseAntallSvar")

    @Before
    fun setUp() {
        kartleggingKonsument.subscribe(mutableListOf(Topic.SPORREUNDERSOKELSE_TOPIC.navn))
        spørreundersøkelseAntallSvarKonsument.subscribe(mutableListOf(Topic.SPORREUNDERSOKELSE_ANTALL_SVAR_TOPIC.navn))
    }

    @After
    fun tearDown() {
        kartleggingKonsument.unsubscribe()
        kartleggingKonsument.close()
        spørreundersøkelseAntallSvarKonsument.unsubscribe()
        spørreundersøkelseAntallSvarKonsument.close()
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
        TestContainerHelper.lydiaApiContainer.performDelete("$KARTLEGGING_BASE_ROUTE/${sak.orgnr}/${sak.saksnummer}/${kartlegging.kartleggingId}")
            .authentication().bearer(TestContainerHelper.oauth2ServerContainer.saksbehandler1.token)
            .tilSingelRespons<IASakKartleggingDto>()
        kartlegging.sendKartleggingSvarTilKafka()
        TestContainerHelper.lydiaApiContainer.shouldContainLog("Kan ikke svare på en kartlegging i status SLETTET".toRegex())
    }

    @Test
    fun `svar skal overskrives i DB ved nytt svar mottatt på Kafka topic`() {
        val sak = SakHelper.nySakIKartlegges()
        val kartleggingDto =  sak.opprettKartlegging()
        kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        val kartleggingSvarDto = kartleggingDto.sendKartleggingSvarTilKafka()

        val lagredeSvarIder = TestContainerHelper.postgresContainer
            .hentEnkelKolonne<PGobject>(
                "select svar_ider from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'"
            )
        lagredeSvarIder.value shouldNotBe null
        lagredeSvarIder.value?.let { Json.decodeFromString<List<String>>(it) shouldBe kartleggingSvarDto.svarIder }

        TestContainerHelper.postgresContainer
            .hentEnkelKolonne<String>(
                "select endret from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'"
            ) shouldBe null

        val nyeSvarIder = listOf(UUID.randomUUID().toString())

        sendKartleggingSvarTilKafka(
            kartleggingId = kartleggingSvarDto.spørreundersøkelseId,
            spørsmålId = kartleggingSvarDto.spørsmålId,
            sesjonId = kartleggingSvarDto.sesjonId,
            svarIder = nyeSvarIder
        )

        val oppdaterteSvarIderEtterNyttSvar = TestContainerHelper.postgresContainer
            .hentEnkelKolonne<PGobject>(
                "select svar_ider from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'"
            )
        oppdaterteSvarIderEtterNyttSvar.value shouldNotBe null
        oppdaterteSvarIderEtterNyttSvar.value?.let { Json.decodeFromString<List<String>>(it) shouldBe nyeSvarIder }

        TestContainerHelper.postgresContainer
            .hentEnkelKolonne<String>(
                "select endret from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'"
            ) shouldNotBe null
    }

    @Test
    fun `skal få oppdatert antall som har svart på et spørsmål i en kartlegging`() {
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
                }
            }
        }

        val spørsmålId = kartleggingDto.temaMedSpørsmålOgSvaralternativer.first().spørsmålOgSvaralternativer.first().id
        kartleggingDto.sendKartleggingSvarTilKafka(
            spørsmålId = spørsmålId
        )

        runBlocking {
            TestContainerHelper.kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                    key = "${kartleggingDto.kartleggingId}-$spørsmålId",
                    konsument = spørreundersøkelseAntallSvarKonsument
            ) {
                it.forExactlyOne { melding ->
                    val antallSvarForSpørsmål = Json.decodeFromString<SpørreundersøkelseAntallSvarDto>(melding)
                    antallSvarForSpørsmål.spørreundersøkelseId shouldBe kartleggingDto.kartleggingId
                    antallSvarForSpørsmål.spørsmålId shouldBe spørsmålId
                    antallSvarForSpørsmål.antallSvar shouldBe 1
                }
            }
        }
    }
}
