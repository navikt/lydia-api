package no.nav.lydia.helper

import com.github.tomakehurst.wiremock.client.WireMock
import com.github.tomakehurst.wiremock.client.WireMock.matching
import io.ktor.http.*
import kotlinx.datetime.Clock
import no.nav.lydia.integrasjoner.brreg.Beliggenhetsadresse
import no.nav.lydia.sykefraversstatistikk.api.Periode
import no.nav.lydia.sykefraversstatistikk.import.BrregOppdateringConsumer.BrregVirksomhetEndringstype
import no.nav.lydia.sykefraversstatistikk.import.BrregOppdateringConsumer.BrregVirksomhetEndringstype.Endring
import no.nav.lydia.sykefraversstatistikk.import.BrregOppdateringConsumer.BrregVirksomhetEndringstype.Fjernet
import no.nav.lydia.sykefraversstatistikk.import.BrregOppdateringConsumer.BrregVirksomhetEndringstype.Ny
import no.nav.lydia.sykefraversstatistikk.import.BrregOppdateringConsumer.BrregVirksomhetEndringstype.Sletting
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
                LogMessageWaitStrategy().withRegEx(".*App info kafka.producer for pia-brreg unregistered.*\\n")
            )
            .start()
}

class PiaBrregOppdateringTestData {

    companion object {
        private val virksomheterSomSkalOppdateres: MutableMap<TestVirksomhet, BrregVirksomhetEndringstype> =
            mutableMapOf()
        private val testData = TestData()
        val gjeldendePeriode = TestData.gjeldendePeriode
        val endredeVirksomheter = lagVirksomheterForOppdatering(endringstype = Endring, gjeldendePeriode = gjeldendePeriode)
        val fjernedeVirksomheter = lagVirksomheterForOppdatering(endringstype = Fjernet, gjeldendePeriode = gjeldendePeriode)
        val slettedeVirksomheter = lagVirksomheterForOppdatering(endringstype = Sletting, gjeldendePeriode = gjeldendePeriode)
        val nyeVirksomheter: MutableList<TestVirksomhet> = mutableListOf()
        val virksomhetSomSkalFåNæringskodeOppdatert =
            TestVirksomhet.nyVirksomhet(
                næringer = listOf(
                    TestData.DYRKING_AV_RIS,
                    TestData.DYRKING_AV_KORN,
                    TestData.SCENEKUNST
                )
            )
        val virksomhetUtenAdresse = TestVirksomhet.nyVirksomhet(beliggenhet = Beliggenhetsadresse())

        private fun lagVirksomheterForOppdatering(endringstype: BrregVirksomhetEndringstype, gjeldendePeriode: Periode) =
            (1..5).map {
                val virksomhet = TestVirksomhet.nyVirksomhet()
                virksomheterSomSkalOppdateres[virksomhet] = endringstype
                testData.lagData(
                    virksomhet = virksomhet,
                    perioder = listOf(gjeldendePeriode)
                )
                virksomhet
            }

        fun lagTestDataForPiaBrregOppdatering(httpMock: HttpMock): TestData {
            repeat(times = 5) {
                val virksomhet = TestVirksomhet.nyVirksomhet()
                nyeVirksomheter.add(virksomhet)
                virksomheterSomSkalOppdateres[virksomhet] = Ny
            }
            val gjeldendePeriode = TestData.gjeldendePeriode

            testData.lagData(virksomhetSomSkalFåNæringskodeOppdatert, perioder = listOf(gjeldendePeriode))
            testData.lagData(virksomhetUtenAdresse, perioder = listOf(gjeldendePeriode))
            virksomheterSomSkalOppdateres[virksomhetUtenAdresse] = Endring
            virksomheterSomSkalOppdateres[virksomhetSomSkalFåNæringskodeOppdatert.copy(
                næringsundergrupper = listOf(
                    TestData.DYRKING_AV_RIS,
                    TestData.DYRKING_AV_KORN,
                    TestData.BEDRIFTSRÅDGIVNING
                )
            )] = Endring

            mockPiaBrregOppdateringTestData(httpMock = httpMock)
            return testData
        }

        fun mockPiaBrregOppdateringTestData(httpMock: HttpMock) {
            mockKallMotBrregOppdaterteUnderenheter(
                httpMock = httpMock
            )
            mockKallMotBrregUnderenhet(
                httpMock = httpMock,
                testVirksomheter = virksomheterSomSkalOppdateres.filterValues { it == Endring }.keys.map { testVirksomhet ->
                    testVirksomhet.copy(
                        navn = testVirksomhet.genererEndretNavn()
                    )
                }
            )
            mockKallMotBrregUnderenhet(
                httpMock = httpMock,
                testVirksomheter = virksomheterSomSkalOppdateres.filterValues { it == Ny }.keys.toList()
            )
        }

        private fun mockKallMotBrregOppdaterteUnderenheter(
            httpMock: HttpMock,
        ) {
            httpMock.wireMockServer.stubFor(
                WireMock.get(WireMock.urlPathEqualTo(brregOppdaterteUnderenheterMockPath))
                    .willReturn(
                        WireMock.ok()
                            .withHeader(HttpHeaders.ContentType, "application/json")
                            .withBody(brregOppdatertUnderenhetJson())
                    )
            )
        }

        private fun mockKallMotBrregUnderenhet(httpMock: HttpMock, testVirksomheter: List<TestVirksomhet>) {
            httpMock.wireMockServer.stubFor(
                WireMock.get(WireMock.urlPathEqualTo(brregUnderenheterMockPath))
                    .withQueryParam(
                        "organisasjonsnummer", matching(
                            testVirksomheter.joinToString(
                                separator = "",
                                prefix = "^",
                                transform = { "(?=.*\\b${it.orgnr}\\b)" },
                                postfix = ".+"
                            )
                        )
                    )
                    .willReturn(
                        WireMock.ok()
                            .withHeader(HttpHeaders.ContentType, "application/json")
                            .withBody(testVirksomheter.brregUnderenheterEmbeddedResponsJson())
                    )
            )
        }

        private fun brregOppdatertUnderenhetJson(): String {
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

fun TestVirksomhet.genererEndretNavn() = this.navn.reversed()
