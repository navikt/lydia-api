package no.nav.lydia.helper

import com.github.tomakehurst.wiremock.client.WireMock
import com.github.tomakehurst.wiremock.client.WireMock.equalTo
import com.google.common.net.HttpHeaders
import kotlinx.datetime.Clock
import no.nav.lydia.sykefraversstatistikk.api.Periode
import no.nav.lydia.sykefraversstatistikk.import.BrregOppdateringConsumer.BrregVirksomhetEndringstype
import no.nav.lydia.sykefraversstatistikk.import.BrregOppdateringConsumer.BrregVirksomhetEndringstype.*
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.testcontainers.containers.GenericContainer
import org.testcontainers.containers.Network
import org.testcontainers.containers.output.Slf4jLogConsumer
import org.testcontainers.containers.wait.strategy.LogMessageWaitStrategy
import org.testcontainers.images.builder.ImageFromDockerfile
import java.util.TimeZone

const val brregOppdateringTopic = "pia.brreg-oppdatering"
const val brregOppdaterteUnderenheterMockPath = "/brregmock/api/oppdateringer/underenheter"
const val brregUnderenheterMockPath = "/brregmock/api/underenheter"

class PiaBrregOppdateringContainerHelper(
    httpMock: HttpMock,
    network: Network = Network.newNetwork(),
    log: Logger = LoggerFactory.getLogger(PiaBrregOppdateringContainerHelper::class.java)
) {

    val brregOppdateringContainer: GenericContainer<*> =
        GenericContainer(ImageFromDockerfile().withDockerfileFromBuilder { builder ->
            builder.from("ghcr.io/navikt/pia-brreg-oppdaterer:latest")
                .env(
                    mapOf(
                        "TZ" to TimeZone.getDefault().id
                    )
                )
        })
            .dependsOn(
                TestContainerHelper.kafkaContainerHelper.kafkaContainer,
            )
            .withLogConsumer(
                Slf4jLogConsumer(log).withPrefix("brregOppdateringContainer").withSeparateOutputStreams()
            )
            .withNetwork(network)
            .withEnv(
                TestContainerHelper.kafkaContainerHelper.envVars()
                    .plus(
                        mapOf(
                            "BRREG_OPPDATERING_UNDERENHET_URL" to "http://host.testcontainers.internal:${httpMock.wireMockServer.port()}$brregOppdaterteUnderenheterMockPath",
                            "BRREG_UNDERENHET_URL" to "http://host.testcontainers.internal:${httpMock.wireMockServer.port()}$brregUnderenheterMockPath",
                            "NAIS_CLUSTER_NAME" to "lokal",
                        )
                    )
            )

    fun start() =
        brregOppdateringContainer
            .waitingFor(
                LogMessageWaitStrategy().withRegEx(".*Sendte oppdatering.*\\n")
            )
            .start()
}

class PiaBrregOppdateringTestData {

    companion object {
        private val testData = TestData()
        val endredeVirksomheter: MutableList<TestVirksomhet> = mutableListOf()
        val fjernedeVirksomheter: MutableList<TestVirksomhet> = mutableListOf()
        val slettedeVirksomheter: MutableList<TestVirksomhet> = mutableListOf()
        val virksomhetSomSkalFåNæringskodeOppdatert =
            TestVirksomhet.nyVirksomhet(
                næringer = listOf(
                    TestData.DYRKING_AV_RIS,
                    TestData.DYRKING_AV_KORN,
                    TestData.SCENEKUNST
                )
            )
        private val virksomheterSomSkalOppdateres: MutableMap<TestVirksomhet, BrregVirksomhetEndringstype> =
            mutableMapOf()

        fun lagTestDataForPiaBrregOppdatering(httpMock: HttpMock): TestData {
            repeat(times = 5) {
                val nyVirksomhet = TestVirksomhet.nyVirksomhet()
                endredeVirksomheter.add(nyVirksomhet)
                virksomheterSomSkalOppdateres[nyVirksomhet] = Endring
                testData.lagData(
                    virksomhet = nyVirksomhet,
                    perioder = listOf(Periode.gjeldendePeriode())
                )
            }
            repeat(times = 5) {
                val nyVirksomhet = TestVirksomhet.nyVirksomhet()
                fjernedeVirksomheter.add(nyVirksomhet)
                virksomheterSomSkalOppdateres[nyVirksomhet] = Fjernet
                testData.lagData(
                    virksomhet = nyVirksomhet,
                    perioder = listOf(Periode.gjeldendePeriode())
                )
            }
            repeat(times = 5) {
                val nyVirksomhet = TestVirksomhet.nyVirksomhet()
                slettedeVirksomheter.add(nyVirksomhet)
                virksomheterSomSkalOppdateres[nyVirksomhet] = Sletting
                testData.lagData(
                    virksomhet = nyVirksomhet,
                    perioder = listOf(Periode.gjeldendePeriode())
                )
            }

            testData.lagData(virksomhetSomSkalFåNæringskodeOppdatert, perioder = listOf(Periode.gjeldendePeriode()))
            mockPiaBrregOppdaringTestData(httpMock = httpMock)
            return testData
        }

        private fun mockPiaBrregOppdaringTestData(httpMock: HttpMock) {
            mockKallMotBrregOppdaterteUnderenheter(
                httpMock = httpMock,
                virksomheterSomSkalOppdateres = virksomheterSomSkalOppdateres
            )
            mockKallMotBrregUnderenhet(
                httpMock = httpMock,
                testVirksomheter = virksomheterSomSkalOppdateres.keys.toList()
            )
        }

        private fun mockKallMotBrregOppdaterteUnderenheter(
            httpMock: HttpMock,
            virksomheterSomSkalOppdateres: Map<TestVirksomhet, BrregVirksomhetEndringstype>
        ) {
            httpMock.wireMockServer.stubFor(
                WireMock.get(WireMock.urlPathEqualTo(brregOppdaterteUnderenheterMockPath))
                    .willReturn(
                        WireMock.ok()
                            .withHeader(HttpHeaders.CONTENT_TYPE, "application/json")
                            .withBody(brregOppdatertUnderenhetJson(virksomheterSomSkalOppdateres))
                    )
            )
        }

        private fun mockKallMotBrregUnderenhet(httpMock: HttpMock, testVirksomheter: List<TestVirksomhet>) {
            httpMock.wireMockServer.stubFor(
                WireMock.get(WireMock.urlPathEqualTo(brregUnderenheterMockPath))
                    .withQueryParam("organisasjonsnummer", equalTo(testVirksomheter.joinToString(",") { it.orgnr }))
                    .willReturn(
                        WireMock.ok()
                            .withHeader(HttpHeaders.CONTENT_TYPE, "application/json")
                            .withBody(testVirksomheter.brregUnderenheterEmbeddedResponsJson())
                    )
            )
        }

        private fun brregOppdatertUnderenhetJson(virksomheterSomSkalOppdateres: Map<TestVirksomhet, BrregVirksomhetEndringstype>): String {
            val oppdaterteEnheter = """[
                  ${
                virksomheterSomSkalOppdateres.entries.joinToString(",") { (virksomhet, endringstype) ->
                    brregOppdatertUnderenhetJson(virksomhet = virksomhet, endringstype = endringstype.name)
                }
            }
                ]""".trimIndent()

            return """{
              "_embedded": {
                "oppdaterteUnderenheter": $oppdaterteEnheter
              },
              "_links": {
                "first": {
                  "href": "https://data.brreg.no/enhetsregisteret/api/oppdateringer/underenheter?dato=2022-07-05T00:00:00.000Z&page=0&size=10"
                },
                "self": {
                  "href": "https://data.brreg.no/enhetsregisteret/api/oppdateringer/underenheter?dato=2022-07-05T00:00:00.000Z&size=10"
                },
                "next": {
                  "href": "https://data.brreg.no/enhetsregisteret/api/oppdateringer/underenheter?dato=2022-07-05T00:00:00.000Z&page=1&size=10"
                },
                "last": {
                  "href": "https://data.brreg.no/enhetsregisteret/api/oppdateringer/underenheter?dato=2022-07-05T00:00:00.000Z&page=89&size=10"
                }
              },
              "page": {
                "size": 1,
                "totalElements": 1,
                "totalPages": 1,
                "number": 0
              }
            }""".trimIndent()
        }

        private fun brregOppdatertUnderenhetJson(virksomhet: TestVirksomhet, endringstype: String) = """
            {
                "oppdateringsid": ${virksomhet.orgnr.toInt() + 1},
                "dato": "${Clock.System.now()}",
                "organisasjonsnummer": "${virksomhet.orgnr}",
                "endringstype": "$endringstype",
                "_links": {
                    "underenhet": {
                        "href": "https://data.brreg.no/enhetsregisteret/api/underenheter/${virksomhet.orgnr}"
                    }
                }
            }
            """.trimIndent()

        private fun List<TestVirksomhet>.brregUnderenheterEmbeddedResponsJson() =
            """
        {
        
          "_embedded": {
            "underenheter": [${this.joinToString(",") { it.brregUnderenhetJson() }}]
          },
          "_links": {
            "self": {
              "href": "https://data.brreg.no/enhetsregisteret/api/underenheter/?organisasjonsnummer=927818310"
            }
          },
          "page": {
            "size": 20,
            "totalElements": 1,
            "totalPages": 1,
            "number": 0
          }
        }
    """.trimIndent()
    }
}
