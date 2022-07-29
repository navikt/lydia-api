package no.nav.lydia.helper

import com.github.tomakehurst.wiremock.WireMockServer
import com.github.tomakehurst.wiremock.client.WireMock.equalToJson
import com.github.tomakehurst.wiremock.client.WireMock.get
import com.github.tomakehurst.wiremock.client.WireMock.okJson
import com.github.tomakehurst.wiremock.client.WireMock.post
import com.github.tomakehurst.wiremock.client.WireMock.postRequestedFor
import com.github.tomakehurst.wiremock.client.WireMock.put
import com.github.tomakehurst.wiremock.client.WireMock.status
import com.github.tomakehurst.wiremock.client.WireMock.urlEqualTo
import com.github.tomakehurst.wiremock.client.WireMock.urlPathEqualTo
import com.github.tomakehurst.wiremock.core.WireMockConfiguration

class HttpMock {
    val wireMockServer: WireMockServer = WireMockServer(WireMockConfiguration.options().dynamicPort())

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
