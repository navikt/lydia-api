package no.nav.lydia.container.virksomhet

import io.kotest.matchers.collections.shouldContainInOrder
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.ktor.http.*
import io.ktor.server.testing.*
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json
import no.nav.lydia.*
import no.nav.lydia.helper.*
import no.nav.lydia.helper.TestVirksomhet.Companion.OSLO_FLERE_ADRESSER
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
            brregUnderEnhetUrl = "/brregmock/enhetsregisteret/api/underenheter/lastned"
        )
    )

    companion object {
        private val postgres = PostgrestContainerHelper()
        private val mockOAuth2Server = MockOAuth2Server().apply {
            start(port = 8100)
        }

        init {
            val testData = TestData(initsialiserStandardVirksomheter = true)
            HttpMock().also { httpMock ->
                httpMock.start()
                postgres.getDataSource().use { dataSource ->
                    NæringsDownloader(
                        url = IntegrationsHelper.mockKallMotSsbNæringer(httpMock = httpMock, testData = testData),
                        næringsRepository = NæringsRepository(dataSource = dataSource)
                    ).lastNedNæringer()

                    BrregDownloader(
                        url = IntegrationsHelper.mockKallMotBrregUnderhenter(httpMock = httpMock, testData = testData),
                        virksomhetRepository = VirksomhetRepository(dataSource = dataSource)
                    ).lastNed()
                }
                httpMock.stop()
            }
        }

        @AfterClass
        @JvmStatic
        fun afterAll() {
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
            with(handleRequest(HttpMethod.Get, "$VIRKSOMHET_PATH/${OSLO_FLERE_ADRESSER.orgnr}") {
                addHeader(HttpHeaders.Authorization, "Bearer $token")
            }) {
                assertNotNull(response.content)
                val dto = Json.decodeFromString<VirksomhetDto>(response.content!!)

                dto.orgnr shouldBe OSLO_FLERE_ADRESSER.orgnr
                dto.navn shouldBe OSLO_FLERE_ADRESSER.navn
                dto.adresse shouldContainInOrder OSLO_FLERE_ADRESSER.beliggenhet?.adresse!!
                dto.postnummer shouldBe OSLO_FLERE_ADRESSER.beliggenhet?.postnummer
                dto.poststed shouldBe OSLO_FLERE_ADRESSER.beliggenhet?.poststed
                dto.neringsgrupper shouldHaveSize 2
            }
        }
    }
}