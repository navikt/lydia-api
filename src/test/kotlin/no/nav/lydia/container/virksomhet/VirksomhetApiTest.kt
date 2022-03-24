package no.nav.lydia.container.virksomhet

import io.kotest.matchers.collections.shouldContainInOrder
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.ktor.http.*
import io.ktor.server.testing.*
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json
import no.nav.lydia.*
import no.nav.lydia.helper.HttpMock
import no.nav.lydia.helper.IntegrationsHelper
import no.nav.lydia.helper.IntegrationsHelper.Companion.adresser_oslo
import no.nav.lydia.helper.IntegrationsHelper.Companion.orgnr_oslo_flere_adresser
import no.nav.lydia.helper.IntegrationsHelper.Companion.virksomhetsnavn_oslo
import no.nav.lydia.helper.PostgrestContainerHelper
import no.nav.lydia.integrasjoner.brreg.BrregDownloader
import no.nav.lydia.integrasjoner.ssb.NæringsDownloader
import no.nav.lydia.integrasjoner.ssb.NæringsRepository
import no.nav.lydia.virksomhet.VirksomhetRepository
import no.nav.lydia.virksomhet.api.VIRKSOMHET_PATH
import no.nav.lydia.virksomhet.api.VirksomhetDto
import no.nav.security.mock.oauth2.MockOAuth2Server
import org.junit.AfterClass
import java.net.URL
import kotlin.test.Test
import kotlin.test.assertNotNull

class VirksomhetApiTest {
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
            brregUnderEnhetUrl = "/brregmock/enhetsregisteret/api/underenheter/lastned")
    )

    companion object {
        private val httpMock = HttpMock()
        private val postgres = PostgrestContainerHelper()
        private val mockOAuth2Server = MockOAuth2Server().apply {
            start(port = 8100)
        }

        init {
            httpMock.start()
            postgres.getDataSource().use { dataSource ->
                NæringsDownloader(
                    url = IntegrationsHelper.mockKallMotSsbNæringer(httpMock = httpMock),
                    næringsRepository = NæringsRepository(dataSource = dataSource)
                ).lastNedNæringer()
                BrregDownloader(
                    url = IntegrationsHelper.mockKallMotBrregUnderhenter(httpMock = httpMock),
                    virksomhetRepository = VirksomhetRepository(dataSource = dataSource)
                ).lastNed()
            }
        }

        @AfterClass
        @JvmStatic
        fun afterAll() {
            httpMock.stop()
            mockOAuth2Server.shutdown()
        }
    }

    @Test
    fun `skal kunne hente ut opplysninger om en virksomhet`() {
        val token = mockOAuth2Server.issueToken(
            audience = "lydia-api", claims = mapOf(
                "NAVident" to "X12345"
            )
        ).serialize()

        withTestApplication({
            lydiaRestApi(
                naisEnvironment = naisEnvironment,
                dataSource = postgres.getDataSource()
            )
        }) {
            with(handleRequest(HttpMethod.Get, "$VIRKSOMHET_PATH/$orgnr_oslo_flere_adresser") {
                addHeader(HttpHeaders.Authorization, "Bearer $token")
            }) {
                assertNotNull(response.content)
                val dto = Json.decodeFromString<VirksomhetDto>(response.content!!)

                dto.orgnr shouldBe orgnr_oslo_flere_adresser
                dto.navn shouldBe virksomhetsnavn_oslo
                dto.adresse shouldContainInOrder adresser_oslo
                dto.neringsgrupper shouldHaveSize 2
            }
        }
    }
}