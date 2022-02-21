package no.nav.lydia.brreg

import com.github.tomakehurst.wiremock.client.WireMock
import com.github.tomakehurst.wiremock.client.WireMock.ok
import com.github.tomakehurst.wiremock.common.Gzip
import com.google.common.net.HttpHeaders
import io.kotest.matchers.shouldBe
import io.ktor.http.*
import io.ktor.server.testing.*
import no.nav.lydia.AzureConfig
import no.nav.lydia.Brreg
import no.nav.lydia.Database
import no.nav.lydia.Kafka
import no.nav.lydia.NaisEnvironment
import no.nav.lydia.Security
import no.nav.lydia.helper.HttpMock
import no.nav.lydia.helper.PostgrestContainerHelper
import no.nav.lydia.lydiaRestApi
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
            statistikkTopic = ""
        ), brreg = Brreg(underEnhetUrl = brregMockUrl)
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
    fun `vi kan laste ned liste med underenheter og deres beliggenhetsadresser fra Brreg`() {
        httpMock.wireMockServer.stubFor(
            WireMock.get(WireMock.urlPathEqualTo(path))
                .willReturn(
                    ok()
                        .withHeader(HttpHeaders.CONTENT_TYPE, BrregDownloader.underEnhetApplicationType)
                        .withBody(Gzip.gzip(underEnheter))
                )
        )
        withTestApplication({ lydiaRestApi(naisEnvironment = naisEnvironment, dataSource = postgres.getDataSource()) }) {
            with(handleRequest(HttpMethod.Get, VIRKSOMHETSIMPORT_PATH)) {
                val resultSet = postgres.performQuery("select * from virksomhet where orgnr = '995858266'")
                resultSet.row shouldBe 1

                val resultSetUtenlandskVirksomhet = postgres.performQuery("select * from virksomhet where orgnr = '921972539'")
                resultSetUtenlandskVirksomhet.row shouldBe 0
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
          "navn" : "09 SOLUTIONS EUROPE GMBH",
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
        }
        ]
        """.trimIndent()


    val enhetsListe =
        """
        [
          {
          "organisasjonsnummer" : "922924368",
          "navn" : "- A THOUSAND WORDS - ØDEGÅRDEN GJERRUD TRANSLATIONS",
          "organisasjonsform" : {
            "kode" : "ENK",
            "beskrivelse" : "Enkeltpersonforetak",
            "links" : [ ]
          },
          "registreringsdatoEnhetsregisteret" : "2019-06-19",
          "registrertIMvaregisteret" : true,
          "naeringskode1" : {
            "beskrivelse" : "Oversettelses- og tolkevirksomhet",
            "kode" : "74.300"
          },
          "antallAnsatte" : 0,
          "forretningsadresse" : {
            "land" : "Norge",
            "landkode" : "NO",
            "postnummer" : "3060",
            "poststed" : "SVELVIK",
            "adresse" : [ "Storgaten 120" ],
            "kommune" : "DRAMMEN",
            "kommunenummer" : "3005"
          },
          "institusjonellSektorkode" : {
            "kode" : "8200",
            "beskrivelse" : "Personlig næringsdrivende"
          },
          "registrertIForetaksregisteret" : false,
          "registrertIStiftelsesregisteret" : false,
          "registrertIFrivillighetsregisteret" : false,
          "konkurs" : false,
          "underAvvikling" : false,
          "underTvangsavviklingEllerTvangsopplosning" : false,
          "maalform" : "Bokmål",
          "links" : [ ]
        },
          {
          "organisasjonsnummer" : "916627939",
          "navn" : "- P A L M E R A -",
          "organisasjonsform" : {
            "kode" : "FLI",
            "beskrivelse" : "Forening/lag/innretning",
            "links" : [ ]
          },
          "hjemmeside" : "palmera-i-bergen.no",
          "postadresse" : {
            "land" : "Norge",
            "landkode" : "NO",
            "postnummer" : "5033",
            "poststed" : "BERGEN",
            "adresse" : [ "c/o Lady Tatiana Lozano Prieto", "Hans Hauges gate 37" ],
            "kommune" : "BERGEN",
            "kommunenummer" : "4601"
          },
          "registreringsdatoEnhetsregisteret" : "2016-01-26",
          "registrertIMvaregisteret" : false,
          "naeringskode1" : {
            "beskrivelse" : "Aktiviteter i andre interesseorganisasjoner ikke nevnt annet sted",
            "kode" : "94.991"
          },
          "antallAnsatte" : 0,
          "forretningsadresse" : {
            "land" : "Norge",
            "landkode" : "NO",
            "postnummer" : "5004",
            "poststed" : "BERGEN",
            "adresse" : [ "Strandgaten 208" ],
            "kommune" : "BERGEN",
            "kommunenummer" : "4601"
          },
          "stiftelsesdato" : "2015-11-01",
          "institusjonellSektorkode" : {
            "kode" : "7000",
            "beskrivelse" : "Ideelle organisasjoner"
          },
          "registrertIForetaksregisteret" : false,
          "registrertIStiftelsesregisteret" : false,
          "registrertIFrivillighetsregisteret" : false,
          "konkurs" : false,
          "underAvvikling" : false,
          "underTvangsavviklingEllerTvangsopplosning" : false,
          "maalform" : "Bokmål",
          "links" : [ ]
        },
          {
          "organisasjonsnummer" : "911963582",
          "navn" : "- TTT- WINES TORE EUGEN KRISTIANSEN",
          "organisasjonsform" : {
            "kode" : "ENK",
            "beskrivelse" : "Enkeltpersonforetak",
            "links" : [ ]
          },
          "registreringsdatoEnhetsregisteret" : "2013-05-25",
          "registrertIMvaregisteret" : false,
          "naeringskode1" : {
            "beskrivelse" : "Engroshandel med vin og brennevin",
            "kode" : "46.341"
          },
          "antallAnsatte" : 0,
          "forretningsadresse" : {
            "land" : "Norge",
            "landkode" : "NO",
            "postnummer" : "1344",
            "poststed" : "HASLUM",
            "adresse" : [ "Hasselveien 16" ],
            "kommune" : "BÆRUM",
            "kommunenummer" : "3024"
          },
          "institusjonellSektorkode" : {
            "kode" : "8200",
            "beskrivelse" : "Personlig næringsdrivende"
          },
          "registrertIForetaksregisteret" : false,
          "registrertIStiftelsesregisteret" : false,
          "registrertIFrivillighetsregisteret" : false,
          "konkurs" : false,
          "underAvvikling" : false,
          "underTvangsavviklingEllerTvangsopplosning" : false,
          "maalform" : "Bokmål",
          "links" : [ ]
        }]
    """.trimIndent()
}
