package no.nav.lydia.helper

import com.github.tomakehurst.wiremock.WireMockServer
import com.github.tomakehurst.wiremock.core.WireMockConfiguration
import org.testcontainers.Testcontainers

class WiremockContainerHelper {
    private val azureMock: WireMockServer
    private val salesforceMock: WireMockServer
    private val naringMock: WireMockServer
    private val journalpostMock: WireMockServer
    private val azureOpenAiMock: WireMockServer

    init {
        azureMock = lagMockServer("azure")
        salesforceMock = lagMockServer("salesforce")
        naringMock = lagMockServer("naring")
        journalpostMock = lagMockServer("journalpost")
        azureOpenAiMock = lagMockServer("azure-openai")
    }

    private fun lagMockServer(service: String) =
        WireMockServer(WireMockConfiguration.options().dynamicPort()).also {
            if (!it.isRunning) {
                it.start()
            }

            println("Starter Wiremock for $service på port ${it.port()}")
            Testcontainers.exposeHostPorts(it.port())
        }

    fun envVars() =
        mapOf(
            "AZURE_GRAPH_URL" to "http://host.testcontainers.internal:${azureMock.port()}/v1.0",
            "SALESFORCE_TOKEN_BASE_URL" to "http://host.testcontainers.internal:${salesforceMock.port()}",
            "SSB_NARINGS_URL" to "http://host.testcontainers.internal:${naringMock.port()}/naringmock/api/klass/v1/30/json",
            "SALESFORCE_CLIENT_ID" to "clientId",
            "SALESFORCE_CLIENT_SECRET" to "clientSecret",
            "SALESFORCE_USERNAME" to "username",
            "SALESFORCE_PASSWORD" to "password",
            "SALESFORCE_SECURITY_TOKEN" to "securityToken",
            "JOURNALPOST_V1_URL" to "http://host.testcontainers.internal:${journalpostMock.port()}/rest/journalpostapi/v1/journalpost",
            "JOURNALPOST_SCOPE" to "api://dev-fss.teamdokumenthandtering.dokarkiv/.default",
            "AZURE_OPENAI_ENDPOINT" to "http://host.testcontainers.internal:${azureOpenAiMock.port()}",
            "AZURE_OPENAI_API_KEY" to "test-api-key",
            "AZURE_OPENAI_DEPLOYMENT" to "test-deployment",
        )
}
