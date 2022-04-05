package no.nav.lydia.helper

import com.github.tomakehurst.wiremock.client.WireMock
import com.github.tomakehurst.wiremock.common.Gzip
import com.google.common.net.HttpHeaders
import no.nav.lydia.integrasjoner.brreg.BrregDownloader

class IntegrationsHelper {
    companion object {
        fun mockKallMotSsbNæringer(httpMock: HttpMock, testData: TestData): String {
            val lastNedPath = "/naringmock/api/klass/v1/30/json"
            val næringMockUrl = httpMock.url(lastNedPath)
            httpMock.wireMockServer.stubFor(
                WireMock.get(WireMock.urlPathEqualTo(lastNedPath))
                    .willReturn(
                        WireMock.ok()
                            .withBody(testData.ssbNæringMockData())
                    )
            )
            return næringMockUrl
        }

        fun mockKallMotBrregUnderhenter(httpMock: HttpMock, testData: TestData): String {
            val lastNedPath = "/brregmock/enhetsregisteret/api/underenheter/lastned"
            val brregMockUrl = httpMock.url(lastNedPath)

            httpMock.wireMockServer.stubFor(
                WireMock.get(WireMock.urlPathEqualTo(lastNedPath))
                    .willReturn(
                        WireMock.ok()
                            .withHeader(HttpHeaders.CONTENT_TYPE, BrregDownloader.underEnhetApplicationType)
                            .withBody(Gzip.gzip(testData.brregMockData()))
                    )
            )
            return brregMockUrl
        }
    }
}

