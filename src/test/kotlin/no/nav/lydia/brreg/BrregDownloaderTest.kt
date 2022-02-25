package no.nav.lydia.brreg

import com.github.tomakehurst.wiremock.client.WireMock
import com.github.tomakehurst.wiremock.client.WireMock.ok
import com.github.tomakehurst.wiremock.common.Gzip
import com.google.common.net.HttpHeaders
import io.kotest.matchers.shouldBe
import io.ktor.http.*
import io.ktor.http.HttpStatusCode.Companion.OK
import io.ktor.server.testing.*
import no.nav.lydia.*
import no.nav.lydia.helper.HttpMock
import no.nav.lydia.helper.PostgrestContainerHelper
import no.nav.lydia.virksomhet.brreg.BrregDownloader
import no.nav.lydia.virksomhet.brreg.VIRKSOMHETSIMPORT_PATH
import org.junit.AfterClass
import org.junit.BeforeClass
import java.net.URL
import kotlin.test.Test


class BrregDownloaderTest {
    val postgres = PostgrestContainerHelper()
    val path = "/brregmock/enhetsregisteret/api/underenheter/lastned"
    val brregMockUrl = httpMock.url(path)

    val naisEnvironment = NaisEnvironment(
        database = Database(
            host = "",
            port = "",
            username = "",
            password = "",
            name = "",
        ), security = Security(
            AzureConfig(
                audience = "lydia-api",
                jwksUri = URL("http://localhost:8100/default/jwks"),
                issuer = "http://localhost:8100/default"
            )
        ), kafka = Kafka(
            brokers = "",
            truststoreLocation = "",
            keystoreLocation = "",
            credstorePassword = "",
            statistikkTopic = "",
            consumerLoopDelay = 200L
        ), integrasjoner = Integrasjoner(
            ssbNæringsUrl = "/naringmock/api/klass/v1/30/json",
            brregUnderEnhetUrl = brregMockUrl)
    )
    companion object {
        val httpMock = HttpMock()

        @BeforeClass
        @JvmStatic
        fun beforeAll() {
            httpMock.start()
        }


        @AfterClass
        @JvmStatic
        fun afterAll() {
            httpMock.stop()
        }
    }



    @Test
    fun `vi kan laste ned liste med underenheter fra Brreg flere ganger uten konflikt`() {
        httpMock.wireMockServer.stubFor(
            WireMock.get(WireMock.urlPathEqualTo(path))
                .willReturn(
                    ok()
                        .withHeader(HttpHeaders.CONTENT_TYPE, BrregDownloader.underEnhetApplicationType)
                        .withBody(Gzip.gzip(underEnheter))
                )
        )

        withTestApplication({ lydiaRestApi(naisEnvironment = naisEnvironment, dataSource = postgres.getDataSource()) }) {
            val næringskodeMock = "70.220"
            postgres.performInsert("insert into naring (kode, navn, kort_navn) VALUES ('$næringskodeMock', 'A', 'B')")
            val resultSetNæring = postgres.performQuery("select * from naring")
            resultSetNæring.row shouldBe 1

            with(handleRequest(HttpMethod.Get, VIRKSOMHETSIMPORT_PATH)) {
                this.response.status() shouldBe OK


                val resultSet = postgres.performQuery("select id from virksomhet where orgnr = '995858266'")
                resultSet.row shouldBe 1

                val id = resultSet.getLong("id")


                val resultSetFraVirksomhetNæring = postgres.performQuery("select * from virksomhet_naring where virksomhet = '$id'")
                resultSetFraVirksomhetNæring.row shouldBe 1
                resultSetFraVirksomhetNæring.getString("narings_kode") shouldBe næringskodeMock

                val resultSetUtenPostnummer = postgres.performQuery("select * from virksomhet where orgnr = '921972539'")
                resultSetUtenPostnummer.row shouldBe 0

                val resultSetUtenAdresse = postgres.performQuery("select * from virksomhet where orgnr = '921972540'")
                resultSetUtenAdresse.row shouldBe 0
            }
            // sjekk at næringer blir populert på nytt ved ny import av virksomheter
            postgres.performInsert("delete from virksomhet_naring")
            with(handleRequest(HttpMethod.Get, VIRKSOMHETSIMPORT_PATH)){
                this.response.status() shouldBe OK
                val resultSet = postgres.performQuery("select id from virksomhet where orgnr = '995858266'")
                resultSet.row shouldBe 1
                val id = resultSet.getLong("id")
                val resultSetFraVirksomhetNæring = postgres.performQuery("select * from virksomhet_naring where virksomhet = '$id'")
                resultSetFraVirksomhetNæring.row shouldBe 1
                resultSetFraVirksomhetNæring.getString("narings_kode") shouldBe næringskodeMock
            }
        }
    }


    val underEnheter =
        """
          [{
          "organisasjonsnummer" : "995858266",
          "navn" : ":-) PROSJEKTER",
          "organisasjonsform" : {
            "kode" : "BEDR",
            "beskrivelse" : "Bedrift",
            "links" : [ ]
          },
          "registreringsdatoEnhetsregisteret" : "2010-08-25",
          "registrertIMvaregisteret" : false,
          "naeringskode1" : {
            "beskrivelse" : "Bedriftsrådgivning og annen administrativ rådgivning",
            "kode" : "70.220"
          },
          "antallAnsatte" : 1,
          "overordnetEnhet" : "995849364",
          "oppstartsdato" : "2010-07-01",
          "beliggenhetsadresse" : {
            "land" : "Norge",
            "landkode" : "NO",
            "postnummer" : "5034",
            "poststed" : "BERGEN",
            "adresse" : [ "Skanselien 37" ],
            "kommune" : "BERGEN",
            "kommunenummer" : "4601"
          },
          "links" : [ ]
        },
        {
          "organisasjonsnummer" : "921972539",
          "navn" : "MANGLER POSTNUMMER",
          "organisasjonsform" : {
            "kode" : "AAFY",
            "beskrivelse" : "Underenhet til ikke-næringsdrivende",
            "links" : [ ]
          },
          "registreringsdatoEnhetsregisteret" : "2018-12-22",
          "registrertIMvaregisteret" : false,
          "naeringskode1" : {
            "beskrivelse" : "Butikkhandel med datamaskiner og utstyr til datamaskiner",
            "kode" : "47.410"
          },
          "antallAnsatte" : 0,
          "overordnetEnhet" : "921780583",
          "beliggenhetsadresse" : {
            "land" : "Tyskland",
            "landkode" : "DE",
            "poststed" : "60313 FRANKFURT AM MAIN",
            "adresse" : [ "Thurn-und-Taxis-Platz 6" ]
          },
          "links" : [ ]
        },
        {
          "organisasjonsnummer" : "921972540",
          "navn" : "MANGLER BELIGGENHETSADRESSE",
          "organisasjonsform" : {
            "kode" : "AAFY",
            "beskrivelse" : "Underenhet til ikke-næringsdrivende",
            "links" : [ ]
          },
          "registreringsdatoEnhetsregisteret" : "2018-12-22",
          "registrertIMvaregisteret" : false,
          "naeringskode1" : {
            "beskrivelse" : "Butikkhandel med datamaskiner og utstyr til datamaskiner",
            "kode" : "47.410"
          },
          "antallAnsatte" : 0,
          "overordnetEnhet" : "921780583",
          "links" : [ ]
        }
        ]
        """.trimIndent()
}
