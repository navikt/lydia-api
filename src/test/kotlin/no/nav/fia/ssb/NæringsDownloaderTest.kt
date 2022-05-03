package no.nav.fia.ssb

import io.kotest.matchers.shouldBe
import io.ktor.http.*
import io.ktor.server.testing.*
import no.nav.fia.AzureConfig
import no.nav.fia.Database
import no.nav.fia.FiaRoller
import no.nav.fia.Integrasjoner
import no.nav.fia.Kafka
import no.nav.fia.NaisEnvironment
import no.nav.fia.Security
import no.nav.fia.helper.HttpMock
import no.nav.fia.helper.IntegrationsHelper
import no.nav.fia.helper.PostgrestContainerHelper
import no.nav.fia.helper.TestData
import no.nav.fia.helper.TestVirksomhet.Companion.SCENEKUNST
import no.nav.fia.integrasjoner.ssb.NÆRINGSIMPORT_URL
import no.nav.fia.fiaRestApi
import org.junit.AfterClass
import org.junit.BeforeClass
import java.net.URL
import kotlin.test.Test

class NæringsDownloaderTest {
    companion object {
        val httpMock = HttpMock()

        @BeforeClass
        @JvmStatic
        fun beforeAll() {
            httpMock.start()
        }


        @AfterClass
        @JvmStatic
        fun afterAll() {
            httpMock.stop()
        }
    }

    val postgres = PostgrestContainerHelper()
    val testData = TestData(inkluderStandardVirksomheter = true)
    val næringMockUrl = IntegrationsHelper.mockKallMotSsbNæringer(httpMock = httpMock, testData = testData)

    val naisEnvironment = NaisEnvironment(
        database = Database(
            host = "",
            port = "",
            username = "",
            password = "",
            name = "",
        ), security = Security(
            AzureConfig(
                audience = "fia-api",
                jwksUri = URL("http://localhost:8100/default/jwks"),
                issuer = "http://localhost:8100/default"
            ), fiaRoller = FiaRoller(
                superbrukerGroupId = "123",
                saksbehandlerGroupId = "456",
                lesetilgangGroupId = "789"
            )
        ), kafka = Kafka(
            brokers = "",
            truststoreLocation = "",
            keystoreLocation = "",
            credstorePassword = "",
            statistikkTopic = "",
            consumerLoopDelay = 200L
        ), integrasjoner = Integrasjoner(
            ssbNæringsUrl = næringMockUrl,
            brregUnderEnhetUrl = ""),
        cluster = "lokal"
    )

    @Test
    fun `kan laste ned og hente ut næringer`() {
        withTestApplication({ fiaRestApi(naisEnvironment = naisEnvironment, dataSource = postgres.getDataSource()) }) {
            with(handleRequest(HttpMethod.Get, NÆRINGSIMPORT_URL)) {
                this.response.status() shouldBe HttpStatusCode.OK

                val rs = postgres.performQuery("select * from naring where kode = '${SCENEKUNST.kode}'")
                rs.row shouldBe 1
                rs.getString("navn") shouldBe SCENEKUNST.navn
                rs.getString("kort_navn") shouldBe "Kortnavn for ${SCENEKUNST.kode}"
            }
        }
    }
}