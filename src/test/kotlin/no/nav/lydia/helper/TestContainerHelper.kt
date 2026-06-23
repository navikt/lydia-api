package no.nav.lydia.helper

import com.github.kittinunf.fuel.core.Request
import com.github.kittinunf.fuel.httpDelete
import com.github.kittinunf.fuel.httpGet
import com.github.kittinunf.fuel.httpPost
import com.github.kittinunf.fuel.httpPut
import com.github.kittinunf.fuel.serialization.responseObject
import ia.felles.definisjoner.bransjer.Bransje
import io.kotest.matchers.string.shouldContain
import io.kotest.matchers.string.shouldNotContain
import kotlinx.serialization.InternalSerializationApi
import kotlinx.serialization.builtins.ListSerializer
import kotlinx.serialization.json.Json
import kotlinx.serialization.serializer
import no.nav.lydia.Topic
import no.nav.lydia.helper.TestData.Companion.lagPerioder
import no.nav.lydia.integrasjoner.ssb.NæringsDownloader
import no.nav.lydia.integrasjoner.ssb.NæringsRepository
import no.nav.lydia.prioritering.sykefraværsstatistikk.LANDKODE_NO
import no.nav.lydia.prioritering.sykefraværsstatistikk.import.Kategori
import no.nav.lydia.prioritering.virksomhet.domene.Sektor
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.testcontainers.containers.GenericContainer
import org.testcontainers.containers.Network
import org.testcontainers.containers.output.Slf4jLogConsumer
import org.testcontainers.containers.wait.strategy.HttpWaitStrategy
import org.testcontainers.images.builder.ImageFromDockerfile
import kotlin.io.path.Path

class TestContainerHelper {
    companion object {
        private const val ANTALL_NÆRINGS_PERIODER = 10
        private const val ANTALL_BRANSJE_PERIODER = 11
        private const val ANTALL_SEKTOR_PERIODER = 9
        private const val ANTALL_TEST_VIRKSOMHETER = 150

        private var log: Logger = LoggerFactory.getLogger(this::class.java)

        private val network = Network.newNetwork()

        val authContainerHelper = AuthContainerHelper(network = network, log = log)
        val kafkaContainerHelper = KafkaContainerHelper(network = network, log = log)
        val postgresContainerHelper = PostgresContainerHelper(network = network, log = log)
        private val wiremockContainerHelper = WiremockContainerHelper()

        val applikasjon: GenericContainer<*> = GenericContainer(ImageFromDockerfile().withDockerfile(Path("./Dockerfile")))
            .dependsOn(
                authContainerHelper.container,
                kafkaContainerHelper.container,
                postgresContainerHelper.container,
            )
            .withNetwork(network)
            .withExposedPorts(8080)
            .waitingFor(HttpWaitStrategy().forPath("/internal/isready"))
            .withCreateContainerCmdModifier { cmd -> cmd.withName("lydia-${System.currentTimeMillis()}") }
            .withLogConsumer(
                Slf4jLogConsumer(log)
                    .withPrefix("lydiaApiContainer")
                    .withSeparateOutputStreams(),
            )
            .withEnv(
                mapOf(
                    "CONSUMER_LOOP_DELAY" to "1",
                    "NAIS_CLUSTER_NAME" to "lokal",
                    "PIA_PDFGEN_URL" to "http://pia-pdfgen",
                    "LOKAL_TEAM_LOGS" to "1",
                )
                    .plus(authContainerHelper.envVars())
                    .plus(kafkaContainerHelper.envVars())
                    .plus(postgresContainerHelper.envVars())
                    .plus(wiremockContainerHelper.envVars()),
            )
            .apply { start() }

        private val dataSource = postgresContainerHelper.nyDataSource()
        private val næringsRepository = NæringsRepository(dataSource = dataSource)

        init {
            // -- generer testdata for land
            kafkaContainerHelper.sendSykefraværsstatistikkPerKategoriIBulkOgVentTilKonsumert(
                TestData.gjeldendePeriode.lagPerioder(20).map { periode ->
                    lagSykefraværsstatistikkPerKategoriImportDto(
                        kategori = Kategori.LAND,
                        kode = LANDKODE_NO,
                        periode = periode,
                        sykefraværsProsent = (4..7).random().toDouble(),
                        antallPersoner = 1000,
                        muligeDagsverk = 250_000.0,
                        tapteDagsverk = 12_500.0,
                    )
                },
                topic = Topic.STATISTIKK_LAND_TOPIC,
            )

            // -- Last inn alle næringer
            NæringsDownloader(url = "", næringsRepository = næringsRepository).lastInnNæringerFraFil()

            // -- generer statistikk for næringer
            kafkaContainerHelper.sendSykefraværsstatistikkPerKategoriIBulkOgVentTilKonsumert(
                importDtoer = næringsRepository.hentNæringer().flatMap { næring ->
                    TestData.gjeldendePeriode.lagPerioder(ANTALL_NÆRINGS_PERIODER).map { periode ->
                        lagSykefraværsstatistikkPerKategoriImportDto(
                            kategori = Kategori.NÆRING,
                            kode = næring.kode,
                            periode = periode,
                            sykefraværsProsent = 5.0,
                            antallPersoner = 1000,
                            muligeDagsverk = 250_000.0,
                            tapteDagsverk = 12_500.0,
                        )
                    }
                },
                topic = Topic.STATISTIKK_NARING_TOPIC,
            )
            // -- generer statistikk for bransjer
            kafkaContainerHelper.sendSykefraværsstatistikkPerKategoriIBulkOgVentTilKonsumert(
                importDtoer = Bransje.entries.flatMap { bransje ->
                    TestData.gjeldendePeriode.lagPerioder(ANTALL_BRANSJE_PERIODER).map { periode ->
                        lagSykefraværsstatistikkPerKategoriImportDto(
                            kategori = Kategori.BRANSJE,
                            kode = bransje.name,
                            periode = periode,
                            sykefraværsProsent = 6.0,
                            antallPersoner = 100000,
                            muligeDagsverk = 250_000.0,
                            tapteDagsverk = 15_000.0,
                        )
                    }
                },
                topic = Topic.STATISTIKK_BRANSJE_TOPIC,
            )
            // -- generer statistikk for sektorer
            kafkaContainerHelper.sendSykefraværsstatistikkPerKategoriIBulkOgVentTilKonsumert(
                importDtoer = Sektor.entries.flatMap { sektor ->
                    TestData.gjeldendePeriode.lagPerioder(ANTALL_SEKTOR_PERIODER).map { periode ->
                        lagSykefraværsstatistikkPerKategoriImportDto(
                            kategori = Kategori.SEKTOR,
                            kode = sektor.kode,
                            periode = periode,
                            sykefraværsProsent = 4.9,
                            antallPersoner = 100000,
                            muligeDagsverk = 250_000.0,
                            tapteDagsverk = 12_250.0,
                        )
                    }
                },
                topic = Topic.STATISTIKK_SEKTOR_TOPIC,
            )

            // -- laster inn standard virksomheter (med statistikk)
            VirksomhetHelper.lastInnStandardTestdata(ANTALL_TEST_VIRKSOMHETER)
        }

        internal fun tokenXAccessToken(
            subject: String = "123",
            audience: String = "tokenx:lydia-api",
            claims: Map<String, String> = mapOf(
                "acr" to "Level4",
                "pid" to subject,
            ),
        ) = authContainerHelper.issueToken(
            subject = subject,
            audience = audience,
            claims = claims,
            issuerId = "tokenx",
        )

        private fun GenericContainer<*>.buildUrl(url: String) = "http://${this.host}:${this.getMappedPort(8080)}/$url"

        fun GenericContainer<*>.performGet(url: String) = buildUrl(url = url).httpGet()

        fun GenericContainer<*>.performPost(url: String) = buildUrl(url = url).httpPost()

        fun GenericContainer<*>.performDelete(url: String) = buildUrl(url = url).httpDelete()

        fun GenericContainer<*>.performPut(url: String) = buildUrl(url = url).httpPut()

        infix fun GenericContainer<*>.shouldContainLog(regex: Regex) = logs shouldContain regex

        infix fun GenericContainer<*>.shouldNotContainLog(regex: Regex) = logs shouldNotContain regex
    }
}

@OptIn(InternalSerializationApi::class)
inline fun <reified T : Any> Request.tilListeRespons() = this.responseObject(loader = ListSerializer(T::class.serializer()), json = Json)

@OptIn(InternalSerializationApi::class)
inline fun <reified T : Any> Request.tilSingelRespons() = this.responseObject(loader = T::class.serializer(), json = Json)
