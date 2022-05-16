package no.nav.lydia.helper

import no.nav.lydia.AzureConfig
import no.nav.lydia.Database
import no.nav.lydia.FiaRoller
import no.nav.lydia.Integrasjoner
import no.nav.lydia.Kafka
import no.nav.lydia.NaisEnvironment
import no.nav.lydia.Security
import no.nav.security.mock.oauth2.MockOAuth2Server

class KtorTestHelper {
    companion object {
        private val mockOAuth2Server = MockOAuth2Server().apply {
            start()
        }

        val httpMock = HttpMock().start()
        val testData = TestData(inkluderStandardVirksomheter = true)
        val næringMockUrl =
            IntegrationsHelper.mockKallMotSsbNæringer(httpMock = httpMock, testData = testData)

        val brregMockUrl = IntegrationsHelper.mockKallMotBrregUnderhenter(
            httpMock = httpMock,
            testData = testData
        )

        val ktorNaisEnvironment = NaisEnvironment(
            database = Database(
                host = "",
                port = "",
                username = "",
                password = "",
                name = "",
            ), security = Security(
                AzureConfig(
                    audience = "lydia-api",
                    jwksUri = mockOAuth2Server.jwksUrl("default").toUrl(),
                    issuer = mockOAuth2Server.issuerUrl("default").toString()
                ), fiaRoller = FiaRoller(
                    superbrukerGroupId = "123",
                    saksbehandlerGroupId = "456",
                    lesetilgangGroupId = "789",
                    teamPiaGroupId = "1011"
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
                brregUnderEnhetUrl = brregMockUrl
            ),
            cluster = "lokal"
        )
    }
}