package no.nav.lydia.brreg

import io.kotest.matchers.shouldBe
import io.ktor.http.*
import io.ktor.http.HttpStatusCode.Companion.OK
import io.ktor.server.testing.*
import no.nav.lydia.*
import no.nav.lydia.helper.HttpMock
import no.nav.lydia.helper.IntegrationsHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.virksomhet.brreg.VIRKSOMHETSIMPORT_PATH
import no.nav.lydia.virksomhet.ssb.NæringsDownloader
import no.nav.lydia.virksomhet.ssb.NæringsRepository
import org.junit.AfterClass
import java.net.URL
import kotlin.test.Test


class BrregDownloaderTest {
    val naisEnvironment = NaisEnvironment(
        database = Database(
            host = "",
            port = "",
            username = "",
            password = "",
            name = "",
        ), security = Security(
            AzureConfig(
                audience = "lydia-api",
                jwksUri = URL("http://localhost:8100/default/jwks"),
                issuer = "http://localhost:8100/default"
            )
        ), kafka = Kafka(
            brokers = "",
            truststoreLocation = "",
            keystoreLocation = "",
            credstorePassword = "",
            statistikkTopic = "",
            consumerLoopDelay = 200L
        ), integrasjoner = Integrasjoner(
            ssbNæringsUrl = "/naringmock/api/klass/v1/30/json",
            brregUnderEnhetUrl = IntegrationsHelper.mockKallMotBrregUnderhenter(httpMock = httpMock)
        )
    )

    companion object {
        val httpMock = HttpMock()
        val postgres = TestContainerHelper.postgresContainer

        init {
            httpMock.start()
            postgres.getDataSource().use { dataSource ->
                NæringsDownloader(
                    url = IntegrationsHelper.mockKallMotSsbNæringer(httpMock = httpMock),
                    næringsRepository = NæringsRepository(dataSource = dataSource)
                ).lastNedNæringer()
            }
        }

        @AfterClass
        @JvmStatic
        fun afterAll() {
            httpMock.stop()
        }
    }

    @Test
    fun `vi kan laste ned liste med underenheter fra Brreg flere ganger uten konflikt`() {
        val næringskodeMock = "70.220"
        withTestApplication({
            lydiaRestApi(
                naisEnvironment = naisEnvironment,
                dataSource = postgres.getDataSource()
            )
        }) {
            with(handleRequest(HttpMethod.Get, VIRKSOMHETSIMPORT_PATH)) {
                this.response.status() shouldBe OK

                val resultSet = postgres.performQuery("select id from virksomhet where orgnr = '995858266'")
                resultSet.row shouldBe 1

                val id = resultSet.getLong("id")


                val resultSetFraVirksomhetNæring =
                    postgres.performQuery("select * from virksomhet_naring where virksomhet = '$id'")
                resultSetFraVirksomhetNæring.row shouldBe 1
                resultSetFraVirksomhetNæring.getString("narings_kode") shouldBe næringskodeMock

                val resultSetUtenPostnummer =
                    postgres.performQuery("select * from virksomhet where orgnr = '921972539'")
                resultSetUtenPostnummer.row shouldBe 0
            }

            // sjekk at næringer blir populert på nytt ved ny import av virksomheter
            postgres.performInsert("delete from virksomhet_naring")
            with(handleRequest(HttpMethod.Get, VIRKSOMHETSIMPORT_PATH)) {
                this.response.status() shouldBe OK
                val resultSet = postgres.performQuery("select id from virksomhet where orgnr = '995858266'")
                resultSet.row shouldBe 1
                val id = resultSet.getLong("id")
                val resultSetFraVirksomhetNæring =
                    postgres.performQuery("select * from virksomhet_naring where virksomhet = '$id'")
                resultSetFraVirksomhetNæring.row shouldBe 1
                resultSetFraVirksomhetNæring.getString("narings_kode") shouldBe næringskodeMock
            }
        }
    }
}
