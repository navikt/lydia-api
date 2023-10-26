package no.nav.lydia.helper

import com.github.tomakehurst.wiremock.WireMockServer
import com.github.tomakehurst.wiremock.core.WireMockConfiguration
import org.testcontainers.Testcontainers

class WiremockContainerHelper {
    val azureMock: WireMockServer
    val salesforceMock: WireMockServer
    init {
        azureMock = lagMockServer("azure")
        salesforceMock = lagMockServer("salesforce")
    }

    private fun lagMockServer(service: String) = WireMockServer(WireMockConfiguration.options().dynamicPort()).also {
        if (!it.isRunning) {
            it.start()
        }

        println("Starter Wiremock for $service på port ${it.port()}")
        Testcontainers.exposeHostPorts(it.port())
    }

    fun envVars() = mapOf(
        "AZURE_GRAPH_URL" to "http://host.testcontainers.internal:${azureMock.port()}/v1.0",
        "SALESFORCE_TOKEN_HOST" to "http://host.testcontainers.internal:${salesforceMock.port()}",
        "SALESFORCE_CLIENT_ID" to "clientId",
        "SALESFORCE_CLIENT_SECRET" to "clientSecret",
        "SALESFORCE_USERNAME" to "username",
        "SALESFORCE_PASSWORD" to "password",
        "SALESFORCE_SECURITY_TOKEN" to "securityToken"
    )
}