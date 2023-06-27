package no.nav.lydia.helper

import com.github.tomakehurst.wiremock.WireMockServer
import com.github.tomakehurst.wiremock.core.WireMockConfiguration
import org.testcontainers.Testcontainers

class WireMockContainerHelper {
    val azureMock: WireMockServer
    init {
        azureMock = WireMockServer(WireMockConfiguration.options().dynamicPort()).also {
            if (!it.isRunning) {
                it.start()
            }

            println("Starter Wiremock på port ${it.port()}")
            Testcontainers.exposeHostPorts(it.port())
        }
    }

    fun envVars() = mapOf(
        "AZURE_GRAPH_URL" to "http://host.testcontainers.internal:${azureMock.port()}/v1.0"
    )
}