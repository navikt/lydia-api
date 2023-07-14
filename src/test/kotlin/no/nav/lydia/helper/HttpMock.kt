package no.nav.lydia.helper

import com.github.tomakehurst.wiremock.WireMockServer
import com.github.tomakehurst.wiremock.core.WireMockConfiguration

class HttpMock {
    val wireMockServer: WireMockServer = WireMockServer(WireMockConfiguration.options().dynamicPort())

    fun start(): HttpMock {
        if (!wireMockServer.isRunning) {
            wireMockServer.start()
        }
        return this
    }

    fun url(path: String) = wireMockServer.url(path)
}
