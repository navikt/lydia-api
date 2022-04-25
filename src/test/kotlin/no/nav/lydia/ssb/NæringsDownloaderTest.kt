package no.nav.lydia.ssb

import io.kotest.matchers.shouldBe
import io.ktor.http.*
import io.ktor.server.testing.*
import no.nav.lydia.AzureConfig
import no.nav.lydia.Database
import no.nav.lydia.Integrasjoner
import no.nav.lydia.Kafka
import no.nav.lydia.NaisEnvironment
import no.nav.lydia.Security
import no.nav.lydia.helper.HttpMock
import no.nav.lydia.helper.IntegrationsHelper
import no.nav.lydia.helper.PostgrestContainerHelper
import no.nav.lydia.helper.TestData
import no.nav.lydia.helper.TestVirksomhet.Companion.SCENEKUNST
import no.nav.lydia.integrasjoner.ssb.NÆRINGSIMPORT_URL
import no.nav.lydia.lydiaRestApi
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
                audience = "lydia-api",
                jwksUri = URL("http://localhost:8100/default/jwks"),
                issuer = "http://localhost:8100/default",
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
            brregUnderEnhetUrl = "")
    )

    @Test
    fun `kan laste ned og hente ut næringer`() {
        withTestApplication({ lydiaRestApi(naisEnvironment = naisEnvironment, dataSource = postgres.getDataSource()) }) {
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