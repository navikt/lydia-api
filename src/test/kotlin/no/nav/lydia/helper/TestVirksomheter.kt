package no.nav.lydia.helper

import no.nav.lydia.helper.IntegrationsHelper.Companion.næringskodeBedriftsrådgivning
import no.nav.lydia.helper.IntegrationsHelper.Companion.næringskodeScenekunst
import no.nav.lydia.helper.IntegrationsHelper.Companion.orgnr_bergen
import no.nav.lydia.helper.IntegrationsHelper.Companion.orgnr_oslo
import no.nav.lydia.helper.IntegrationsHelper.Companion.virksomhetsnavn_bergen
import no.nav.lydia.helper.IntegrationsHelper.Companion.virksomhetsnavn_oslo
import no.nav.lydia.sykefraversstatistikk.api.Periode

class TestVirksomheter(
) {
    val kafkaMeldinger = mutableSetOf<String>()
    val næringer = mutableSetOf<String>()
    val brregVirksomheter = mutableSetOf<String>()

    init {
        kafkaMeldinger.add(lagKafkaMelding(orgnr = orgnr_oslo, periode = Periode.gjeldenePeriode()))
        kafkaMeldinger.add(lagKafkaMelding(orgnr = orgnr_oslo, periode = Periode.forrigePeriode()))
        kafkaMeldinger.add(lagKafkaMelding(orgnr = orgnr_bergen, periode = Periode.gjeldenePeriode()))
        kafkaMeldinger.add(lagKafkaMelding(orgnr = orgnr_bergen, periode = Periode.forrigePeriode()))
        næringer.add(lagSsbNæringInnslag(kode = næringskodeScenekunst, navn = "Utøvende kunstnere og underholdningsvirksomhet innen scenekunst"))
        næringer.add(lagSsbNæringInnslag(kode = næringskodeBedriftsrådgivning, navn = "Bedriftsrådgivning og annen administrativ rådgivning"))
        brregVirksomheter.add(lagBrregVirksomhetsInnslag(orgnr_oslo, virksomhetsnavn_oslo, listOf(næringskodeScenekunst)))
        brregVirksomheter.add(lagBrregVirksomhetsInnslag(orgnr_bergen, virksomhetsnavn_bergen, listOf(næringskodeScenekunst, næringskodeBedriftsrådgivning)))
    }

}


enum class Melding(val melding: String) {
    osloForrigeKvartal(melding = lagKafkaMelding(orgnr = orgnr_oslo, periode = Periode.forrigePeriode())),
    osloGjeldeneKvartal(melding = lagKafkaMelding(orgnr = orgnr_oslo, periode = Periode.gjeldenePeriode())),
    bergenForrigeKvartal(melding = lagKafkaMelding(orgnr = orgnr_bergen, periode = Periode.forrigePeriode())),
    bergenGjeldeneKvartal(melding = lagKafkaMelding(orgnr = orgnr_bergen, periode = Periode.gjeldenePeriode()))
}

fun lagBrregVirksomhetsInnslag(orgnr: String, navn: String, næringsKoder: List<String>) =
    """
        {
            "organisasjonsnummer" : "$orgnr",
            "navn" : "$navn",
            "organisasjonsform" : {
              "kode" : "BEDR",
              "beskrivelse" : "Bedrift",
              "links" : [ ]
            },
            "registreringsdatoEnhetsregisteret" : "2010-08-25",
            "registrertIMvaregisteret" : false,
            "naeringskode1" : {
              "beskrivelse" : "Bedriftsrådgivning og annen administrativ rådgivning",
              "kode" : "$næringskodeBedriftsrådgivning"
            },
            "naeringskode2" : {
              "beskrivelse" : "Utøvende kunstnere og underholdningsvirksomhet innen scenekunst",
              "kode" : "$næringskodeScenekunst"
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
        }
    """.trimIndent()

fun lagSsbNæringInnslag(kode: String, navn: String) =
    """
        {
          "code": "$kode",
          "parentCode": "A",
          "level": "2",
          "name": "$navn",
          "shortName": "Kortnavn for $kode",
          "notes": "Notater for $kode"
        }
    """.trimIndent()

fun lagKafkaMelding(orgnr: String, periode: Periode) =
    """
        {
          "key": {
            "orgnr": "$orgnr",
            "kvartal": ${periode.kvartal},
            "årstall": ${periode.årstall}
          },
          "value": {
            "virksomhetSykefravær": {
              "orgnr": $orgnr,
              "navn": "Virksomhet Bergen",
              "årstall": ${periode.årstall},
              "kvartal": ${periode.kvartal},
              "tapteDagsverk": 20.0,
              "muligeDagsverk": 500.0,
              "antallPersoner": 6,
              "prosent": 2.0,
              "erMaskert": false,
              "kategori": "VIRKSOMHET"
            },
            "næring5SifferSykefravær": [
              {
                "kategori": "NÆRING5SIFFER",
                "kode": "11000",
                "årstall": ${periode.årstall},
                "kvartal": ${periode.kvartal},
                "tapteDagsverk": "40.0",
                "muligeDagsverk": 4000.0,
                "antallPersoner": 1250,
                "prosent": 1.0,
                "erMaskert": false
              }
            ],
            "næringSykefravær": {
              "kategori": "NÆRING2SIFFER",
              "kode": "11",
              "årstall": ${periode.årstall},
              "kvartal": ${periode.kvartal},
              "tapteDagsverk": "100.0",
              "muligeDagsverk": 5000.0,
              "antallPersoner": 150,
              "prosent": 2.0,
              "erMaskert": false
            },
            "sektorSykefravær": {
              "kategori": "SEKTOR",
              "kode": "1",
              "årstall": ${periode.årstall},
              "kvartal": ${periode.kvartal},
              "tapteDagsverk": "1340.0",
              "muligeDagsverk": 88000.0,
              "antallPersoner": 33000,
              "prosent": 1.5,
              "erMaskert": false
            },
            "landSykefravær": {
              "kategori": "LAND",
              "kode": "NO",
              "årstall": ${periode.årstall},
              "kvartal": ${periode.kvartal},
              "tapteDagsverk": "10000000.0",
              "muligeDagsverk": 500000000.0,
              "antallPersoner": 2500000,
              "prosent": 2.0,
              "erMaskert": false
            }
          }
        }
    """.trimIndent()