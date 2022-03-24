package no.nav.lydia.helper

import com.github.tomakehurst.wiremock.client.WireMock
import com.github.tomakehurst.wiremock.common.Gzip
import com.google.common.net.HttpHeaders
import no.nav.lydia.integrasjoner.brreg.BrregDownloader

class IntegrationsHelper {
    companion object {

        const val virksomhetsnavn_bergen = "Virksomhet Bærgen"
        const val virksomhetsnavn_oslo = "Virksomhet Oslo"
        val adresser_oslo = listOf("c/o Oslo Tigersen", "Osloveien 1", "0977 Oslo")
        const val orgnr_bergen = "123456789"
        const val orgnr_oslo = "987654321"
        const val orgnr_oslo_flere_adresser = "555555555"
        const val orgnr_oslo_mangler_adresser = "666666666"
        const val orgnr_MANGLER_POSTNUMMER = "123123123"
        const val orgnr_MANGLER_BELIGGENHETSADRESSE = "321321321"
        const val næringskodeScenekunst = "90.012"
        const val næringskodeBedriftsrådgivning = "70.220"

        fun mockKallMotSsbNæringer(httpMock: HttpMock): String {
            val lastNedPath = "/naringmock/api/klass/v1/30/json"
            val næringMockUrl = httpMock.url(lastNedPath)

            val næringsJson = """
                {
                  "name": "Næringsgruppering 2007 (SN 2007)",
                  "validFrom": "2009-01-01",
                  "lastModified": "2020-04-07T12:46:55.000+0000",
                  "published": [],
                  "introduction": "",
                  "contactPerson": {},
                  "owningSection": "Regnskapsstatistikk og VoF",
                  "legalBase": "Rådsforordning (EF) nr. 1893/2006",
                  "publications": "http://www.ssb.no/a/publikasjoner/pdf/nos_d383/nos_d383.pdf",
                  "derivedFrom": "NACE Rev.2",
                  "correspondenceTables": [],
                  "classificationVariants": [],
                  "changelogs": [],
                  "levels": [],
                  "classificationItems": [
                    {
                      "code": "01",
                      "parentCode": "A",
                      "level": "2",
                      "name": "Jordbruk og tjenester tilknyttet jordbruk, jakt og viltstell",
                      "shortName": "Jordbruk, tilhør. tjenester, jakt",
                      "notes": "Inkluderer: Denne næringen omfatter to basisaktiviteter: produksjon av vegetabilske og animalske produkter, jordbruk, dyrking av genetisk modifiserte vekster og oppdrett av genetisk modifiserte dyr. Både dyrking av vekster på friland og i veksthus inngår\nInkluderer også: Omfatter også tjenester tilknyttet jordbruk, jakt og fangst\nEkskluderer: Grunnarbeid, f.eks. anlegg av jordterrasser, drenering o.l. grupperes under næringshovedområde: F Bygge- og anleggsvirksomhet. Kjøpere og andelslag engasjert i markedsføring av jordbruksprodukter grupperes under næringshovedområde: G Varehandel, reparasjon av motorvogner. Stell og vedlikehold av landskap grupperes under: 81.30 Beplantning av hager og parkanlegg"
                    },
                    {
                      "code": "01.1",
                      "parentCode": "01",
                      "level": "3",
                      "name": "Dyrking av ettårige vekster",
                      "shortName": "Dyrking av ettårige vekster",
                      "notes": "Inkluderer: Omfatter dyrking av ettårige vekster, dvs. planter som ikke varer i mer enn to vekstsesonger\nInkluderer også: Omfatter også dyrking av ettårige vekster med henblikk på produksjon av såfrø og såkorn"
                    },
                    {
                      "code": "01.12",
                      "parentCode": "01.1",
                      "level": "4",
                      "name": "Dyrking av ris",
                      "shortName": "Dyrk. av ris",
                      "notes": ""
                    },
                    {
                      "code": "01.120",
                      "parentCode": "01.12",
                      "level": "5",
                      "name": "Dyrking av ris",
                      "shortName": "Dyrk. av ris",
                      "notes": ""
                    },
                    {
                      "code": "A",
                      "parentCode": "",
                      "level": "1",
                      "name": "Jordbruk, skogbruk og fiske",
                      "shortName": "Jordbruk, skogbruk og fiske",
                      "notes": "Inkluderer: Omfatter bruken av planteressursene og de animalske ressursene, inkludert aktiviteter i forbindelse med dyrking av vekster, husdyrhold og -avl, produksjon av tømmer og høsting/utnyttelse av andre planter, dyr og animalske produkter fra en gård eller fra naturen"
                    },
                    {
                        "code": $næringskodeBedriftsrådgivning,
                        "parentCode": "70.22",
                        "level": "5",
                        "name": "Bedriftsrådgivning og annen administrativ rådgivning",
                        "shortName": "Bedriftsrådgiv./annen adm. rådgiv.",
                        "notes": "Inkluderer: Omfatter rådgivning, veiledning og bistand til virksomheter og organisasjoner vedrørende forvaltningsspørsmål som f.eks. strategisk og organisatorisk planlegging i virksomheter, reorganisering av forretningsprosedyrer, endringshåndtering/endringsledelse, kostnadsreduksjon og annen finansiell politikk, praksis og planlegging vedrørende personale, godtgjørelse og pensjonsstrategier, produksjonsplanlegging og kontrollplanlegging. Kan omfatte rådgivning, veiledning og bistand til private og offentlige virksomheter vedrørende lobbyvirksomhet, utvikling av regnskapsprosedyrer, programmer til kostnadsregnskap, budsjettkontrollprosedyrer, rådgivning og bistand til private og offentlige virksomheter vedrørende planlegging, organisasjon, rasjonalisering, kontroll, ledelsesinformasjon mv.\nEkskluderer: Utvikling av programvare til regnskapssystemer grupperes under: 62.01 Programmeringstjenester. Juridisk bistand og representasjon grupperes under: 69.10 Juridisk tjenesteyting. Regnskap, revisjon og skatterådgivning grupperes under: 69.20 Regnskap, revisjon og skatterådgivning. Arkitekt- og ingeniørvirksomhet grupperes under hhv.: 71.11 Arkitektvirksomhet og: 71.12 Teknisk konsulentvirksomhet. Rådgivningsvirksomhet innenfor miljø, agronomi, sikkerhet o.l. grupperes under: 74.909 Annen faglig,, vitenskapelig og teknisk virksomhet ikke nevnt annet sted. Medvirkning ved tilsetting eller rekruttering av overordnet personale grupperes under: 78.10 Rekruttering og formidling av arbeidskraft. Rådgivning i forbindelse med. utdanning grupperes under: 85.60 Tjenester tilknyttet undervisning"
                    },
                    {
                        "code": $næringskodeScenekunst,
                        "parentCode": "90.01",
                        "level": "5",
                        "name": "Utøvende kunstnere og underholdningsvirksomhet innen scenekunst",
                        "shortName": "Utøv. kunstnere innen scenekunst",
                        "notes": "Inkluderer: Omfatter produksjon av teaterforestillinger og dans og annen sceneopptreden, aktiviteter som utøves av kunstnere som for eksempel skuespillere og dansere"
                    }
                  ]
                }
            """.trimIndent()

            httpMock.wireMockServer.stubFor(
                WireMock.get(WireMock.urlPathEqualTo(lastNedPath))
                    .willReturn(
                        WireMock.ok()
                            .withBody(næringsJson)
                    )
            )
            return næringMockUrl
        }

        fun mockKallMotBrregUnderhenter(httpMock: HttpMock): String {
            val lastNedPath = "/brregmock/enhetsregisteret/api/underenheter/lastned"
            val brregMockUrl = httpMock.url(lastNedPath)

            val underEnheter = """
                [
                  {
                    "organisasjonsnummer" : $orgnr_bergen,
                    "navn" : "$virksomhetsnavn_bergen",
                    "organisasjonsform" : {
                      "kode" : "BEDR",
                      "beskrivelse" : "Bedrift",
                      "links" : [ ]
                    },
                    "registreringsdatoEnhetsregisteret" : "2010-08-25",
                    "registrertIMvaregisteret" : false,
                    "naeringskode1" : {
                      "beskrivelse" : "Bedriftsrådgivning og annen administrativ rådgivning",
                      "kode" : $næringskodeBedriftsrådgivning
                    },
                    "naeringskode2" : {
                      "beskrivelse" : "Utøvende kunstnere og underholdningsvirksomhet innen scenekunst",
                      "kode" : $næringskodeScenekunst
                    },
                    "antallAnsatte" : 1,
                    "overordnetEnhet" : "999888777",
                    "oppstartsdato" : "2010-07-01",
                    "beliggenhetsadresse" : {
                      "land" : "Norge",
                      "landkode" : "NO",
                      "postnummer" : "5034",
                      "poststed" : "BERGEN",
                      "adresse" : [ "Bergenveien 1" ],
                      "kommune" : "BERGEN",
                      "kommunenummer" : "4601"
                    },
                    "links" : [ ]
                  },
                  {
                    "organisasjonsnummer" : $orgnr_oslo,
                    "navn" : "$virksomhetsnavn_oslo",
                    "organisasjonsform" : {
                      "kode" : "BEDR",
                      "beskrivelse" : "Underenhet til næringsdrivende og offentlig forvaltning",
                      "links" : [ ]
                    },
                    "registreringsdatoEnhetsregisteret" : "2020-04-28",
                    "registrertIMvaregisteret" : false,
                    "naeringskode1" : {
                      "beskrivelse" : "Utøvende kunstnere og underholdningsvirksomhet innen scenekunst",
                      "kode" : $næringskodeScenekunst
                    },
                    "antallAnsatte" : 0,
                    "overordnetEnhet" : "111222333",
                    "oppstartsdato" : "2020-04-22",
                    "beliggenhetsadresse" : {
                      "land" : "Norge",
                      "landkode" : "NO",
                      "postnummer" : "0364",
                      "poststed" : "OSLO",
                      "adresse" : [ "Osloveien 1" ],
                      "kommune" : "OSLO",
                      "kommunenummer" : "0301"
                    },
                    "links" : [ ]
                  },
                  {
                    "organisasjonsnummer" : $orgnr_oslo_flere_adresser,
                    "navn" : "$virksomhetsnavn_oslo",
                    "organisasjonsform" : {
                      "kode" : "BEDR",
                      "beskrivelse" : "Underenhet til næringsdrivende og offentlig forvaltning",
                      "links" : [ ]
                    },
                    "registreringsdatoEnhetsregisteret" : "2020-04-28",
                    "registrertIMvaregisteret" : false,
                    "naeringskode1" : {
                      "beskrivelse" : "Utøvende kunstnere og underholdningsvirksomhet innen scenekunst",
                      "kode" : $næringskodeScenekunst
                    },
                    "naeringskode2" : {
                      "beskrivelse" : "Bedriftsrådgivning og annen administrativ rådgivning",
                      "kode" : $næringskodeBedriftsrådgivning
                    },
                    "antallAnsatte" : 0,
                    "overordnetEnhet" : "111222333",
                    "oppstartsdato" : "2020-04-22",
                    "beliggenhetsadresse" : {
                      "land" : "Norge",
                      "landkode" : "NO",
                      "postnummer" : "0364",
                      "poststed" : "OSLO",
                      "adresse" : [ ${adresser_oslo.joinToString(separator = ",", transform = {str -> "\"$str\""})} ],
                      "kommune" : "OSLO",
                      "kommunenummer" : "0301"
                    },
                    "links" : [ ]
                  },
                  {
                    "organisasjonsnummer" : $orgnr_oslo_mangler_adresser,
                    "navn" : "$virksomhetsnavn_oslo",
                    "organisasjonsform" : {
                      "kode" : "BEDR",
                      "beskrivelse" : "Underenhet til næringsdrivende og offentlig forvaltning",
                      "links" : [ ]
                    },
                    "registreringsdatoEnhetsregisteret" : "2020-04-28",
                    "registrertIMvaregisteret" : false,
                    "naeringskode1" : {
                      "beskrivelse" : "Utøvende kunstnere og underholdningsvirksomhet innen scenekunst",
                      "kode" : $næringskodeScenekunst
                    },
                    "antallAnsatte" : 0,
                    "overordnetEnhet" : "111222333",
                    "oppstartsdato" : "2020-04-22",
                    "beliggenhetsadresse" : {
                      "land" : "Norge",
                      "landkode" : "NO",
                      "postnummer" : "0364",
                      "poststed" : "OSLO",
                      "kommune" : "OSLO",
                      "kommunenummer" : "0301"
                    },
                    "links" : [ ]
                  },       
                  {
                      "organisasjonsnummer" : $orgnr_MANGLER_POSTNUMMER,
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
                      "overordnetEnhet" : "222333444",
                      "beliggenhetsadresse" : {
                        "land" : "Tyskland",
                        "landkode" : "DE",
                        "poststed" : "60313 FRANKFURT AM MAIN",
                        "adresse" : [ "Tysklandveien 1" ]
                      },
                      "links" : [ ]
                    },
                    { 
                      "organisasjonsnummer" : $orgnr_MANGLER_BELIGGENHETSADRESSE,
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
                      "overordnetEnhet" : "444555666",
                      "links" : [ ]
                    }
                ]
                """.trimIndent()
            httpMock.wireMockServer.stubFor(
                WireMock.get(WireMock.urlPathEqualTo(lastNedPath))
                    .willReturn(
                        WireMock.ok()
                            .withHeader(HttpHeaders.CONTENT_TYPE, BrregDownloader.underEnhetApplicationType)
                            .withBody(Gzip.gzip(underEnheter))
                    )
            )
            return brregMockUrl
        }
    }
}

