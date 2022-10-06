package no.nav.lydia.helper

import com.github.tomakehurst.wiremock.WireMockServer
import com.github.tomakehurst.wiremock.core.WireMockConfiguration
import org.testcontainers.Testcontainers

class WireMockContainerHelper() {
    private val mockServer = WireMockServer(WireMockConfiguration.options().dynamicPort()).also {
        if (!it.isRunning) {
            it.start()
        }

        println("Starter Wiremock på port ${it.port()}")
        Testcontainers.exposeHostPorts(it.port())
    }

    fun envVars() = mapOf(
        "AZURE_GRAPH_URL" to "http://host.testcontainers.internal:${mockServer.port()}/v1.0"
    )
}