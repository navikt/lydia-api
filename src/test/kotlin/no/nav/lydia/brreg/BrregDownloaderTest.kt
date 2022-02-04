package no.nav.lydia.brreg

import com.github.tomakehurst.wiremock.client.WireMock
import com.github.tomakehurst.wiremock.client.WireMock.ok
import com.github.tomakehurst.wiremock.common.Gzip
import com.google.common.net.HttpHeaders
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.DbTestHelper
import no.nav.lydia.helper.DbTestHelper.Companion.performQuery
import no.nav.lydia.helper.HttpMock
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.runMigration
import no.nav.lydia.virksomhet.VirksomhetRepository
import no.nav.lydia.virksomhet.brreg.BrregDownloader
import org.junit.jupiter.api.AfterAll
import kotlin.test.Test


class BrregDownloaderTest {
    val httpMock = HttpMock().start()
    val lastNedPath = "/brregmock/enhetsregisteret/api/underenheter/lastned"
    val brregMockUrl = httpMock.url(lastNedPath)

    val postgres = TestContainerHelper.postgresContainer
    val dataSource = DbTestHelper.getDataSource(postgresContainer = postgres).apply {
        runMigration(this)
    }

    @AfterAll
    fun teardown() {
        httpMock.stop()
    }

    @Test
    fun `Vi kan laste ned liste med underenheter og deres beliggenhetsadresser fra Brreg`() {
        httpMock.wireMockServer.stubFor(
            WireMock.get(WireMock.urlPathEqualTo(lastNedPath))
                .willReturn(
                    ok()
                        .withHeader(HttpHeaders.CONTENT_TYPE, BrregDownloader.underEnhetApplicationType)
                        .withBody(Gzip.gzip(underEnheter))
                )
        )

        val virksomhetRepository = VirksomhetRepository(dataSource = dataSource)
        BrregDownloader(url = brregMockUrl, virksomhetRepository = virksomhetRepository).lastNed()

        val resultSet = postgres.performQuery("select * from virksomhet where orgnr = '995858266'")
        resultSet.row shouldBe 1
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
        }]
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
