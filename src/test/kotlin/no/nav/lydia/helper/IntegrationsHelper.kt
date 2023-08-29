package no.nav.lydia.helper

import com.github.tomakehurst.wiremock.client.WireMock

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
    }
}

