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

        val brregMockUrl = IntegrationsHelper.mockKallMotBrregUnderenheterForNedlasting(
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
                    clientId = "lydia-api",
                    jwksUri = mockOAuth2Server.jwksUrl("default").toUrl(),
                    issuer = mockOAuth2Server.issuerUrl("default").toString(),
                    tokenEndpoint = mockOAuth2Server.tokenEndpointUrl("default").toString(),
                    privateJwk = """
                        {
            "p": "5E2G6sOsbC6oBwx-EiRotMLYfVqOmzvRKxe2_hiquWQxg8bhVTf2XkqLPsHZB3Zy36pQlBghljW7Eti72tkA6oDwaTBkHaL_FVs2xzHHKPfh2j1XQxhr8VriPKNVGIr3ueRRGlIMKd3shwcpkB9fHrcN9BIl-Ml2VT5cZmtYGL8",
            "kty": "RSA",
            "q": "yYdq__td3d5COnjmYOzZiw-Nqr83m2SfF5nToey-HM3Za2BSqQLBC2Xy7Sefo7FA-9GzG76Wd3Yp6ofP6Dzp93-kjtcVBBoppJSYKzvC11L0rdsV3kVd7iRxP1MLqSO2DY6CHRpOk2YxqgskGt3-IKwZ9p3sYGEMH8iAuT1V0Wc",
            "d": "boLVdxUVZNCOiGQqaNMxYROupjqkwBbCD2JujIVLgRvgPRSqFLeWkttAVn6ekXT3vxss8VNwQkMXuDhfuy2MQjlfXPFfDM4go5Ec7ZMxmhzXsP-tnS-jaVC0MWsNsZyBVJuxmlxsqY5vt8A8vrYhatO82w6D_tWqkPdQkupyL6-U_u8ikxMMo0SmD3OYAzVhgvrnfinh7itGrmgo9xqEt5IjFJ9f1BFy21o5YA0LReNeaOrMYhZoUIQAjcTpFgEsU5vORT8boXIN3_Bbby32_xlizXBtXlWxWRMN0k3EuzSPar8QvAXdBZf8GsARoSrbfqBtDKQyp94tl5bCH5XIiQ",
            "e": "AQAB",
            "use": "sig",
            "kid": "azure",
            "qi": "Hu7hgJvc5XvFf6OZeHbYkKEgwttO-INjMVSWvBCR89KKN2Njy8e7zAu7T25YuVxbxtLAvwg-sA-ZtELH28DQhR7AnNmJkh_r0IWuOUHROMrCO2iix9Jl1xrCPanQLGx9iTS7LltaYO5jrv9GGYmFBqIvGByKxI7FytgeXhh2NLk",
            "dp": "odtw_nnRgTUmvTCXJMeZUCYfk-ei2N10ssdyXf0g9KTbEeDrGh691SWmSMzn0Ami8X1u-T-OeE8JnRf5PvPAWYEmcHz1TamkjQCI-noJB7uN7Mq2VgQ3avqTEIh_qRHFBY6gDTgEFZ6XtTdXuSz0o_MFuncvYo16Dn9SxO3vnEM",
            "dq": "GugXoyG-gJbiJMhridlVmjlzYq6xD_A5RX9mQCJJp7LcKnfr0WDqwUjVTFCUAdjyoix3S2cA0-ZU5llHquwnGMJUCDYzOh78HFsyjeMmunT68hNkMg704YzACgJedjCsZ9b1DEms4AUu8FMYePXWrioMNV8UZjHO2pd8iD7mLFU",
            "n": "s7mjPNyx4wtQ-ij0VIAvfooN9m2qgqidE7wJ50zAzmG2cS9Y9XpV09KJAAgP21RVQNqbxU3BCwltYD5bhsYSn-T5HZ7uXbjb9zgSY5XUM0TWGMV7qqdISWmHCH6-LYZGrJiN7ofDW3XGINsRlxj3gZbSuSNnXdbreOC97wT5i-qVxWt9xhobB60Jjf3gNiA3XMaOGyE47Ty-6WMH_zs_sENWXQ0eGoD58DROqbF1CUb_9ppubK9nU4Sjo0ih57J14n8aKZVEWg4uN02Gv0TL1ratvyDTwRZrtKprfgFBzylxtV2zkvhETsi7zkrzjsrv4v8hap6V32NgXc8E1xDj2Q"
        }
                    """.trimIndent(),
                    graphDatabaseUrl = ""
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
                statistikkLandTopic = "",
                iaSakHendelseTopic = "",
                iaSakTopic = "",
                brregOppdateringTopic = "",
                consumerLoopDelay = 200L,
                statistikkVirksomhetTopic = "",
            ), integrasjoner = Integrasjoner(
                ssbNæringsUrl = næringMockUrl,
                brregUnderEnhetUrl = brregMockUrl
            ),
            cluster = "lokal"
        )
    }
}
