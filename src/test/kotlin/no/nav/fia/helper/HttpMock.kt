package no.nav.fia.helper

import com.github.tomakehurst.wiremock.WireMockServer
import com.github.tomakehurst.wiremock.client.WireMock.*
import com.github.tomakehurst.wiremock.core.WireMockConfiguration

// Porten bør ikke være på 8080 for å kollidere med appen
class HttpMock(portNumber: Int = 6969) {
    val wireMockServer: WireMockServer = WireMockServer(WireMockConfiguration.options().port(portNumber))

    fun start(): HttpMock {
        if (!wireMockServer.isRunning) {
            wireMockServer.start()
        }
        return this
    }

    fun stop() {
        if (wireMockServer.isRunning) {
            wireMockServer.stop()
        }
    }

    fun url(path: String) = wireMockServer.url(path)

    fun stubGet(path: String, returnJson: String) = wireMockServer.stubFor(
        get(urlPathEqualTo(path))
            .willReturn(okJson(returnJson))
    )

    fun stubPost(path: String, returnJson: String) = wireMockServer.stubFor(
        post(urlEqualTo(path))
            .willReturn(okJson(returnJson))
    )

    fun stubPost(path: String, statusCode: Int) = wireMockServer.stubFor(
        post(urlEqualTo(path))
            .willReturn(status(statusCode))
    )

    fun verifyPost(path: String, expectedJsonBody: String) {
        wireMockServer.verify(
            postRequestedFor(urlEqualTo(path))
                .withRequestBody(equalToJson(expectedJsonBody))
        )
    }

    fun stubPut(path: String, returnJson: String) = wireMockServer.stubFor(
        put(urlPathEqualTo(path))
            .willReturn(okJson(returnJson))
    )
}
