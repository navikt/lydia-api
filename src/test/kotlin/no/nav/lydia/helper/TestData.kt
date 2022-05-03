package no.nav.lydia.helper

import com.google.gson.Gson
import no.nav.lydia.sykefraversstatistikk.api.Periode

class TestData(
    inkluderStandardVirksomheter: Boolean = false,
    antallTilfeldigeVirksomheter: Int = 0
) {
    private val kafkaMeldinger = mutableSetOf<String>()
    private val næringer = mutableSetOf<String>()
    private val brregVirksomheter = mutableSetOf<String>()

    init {
        if (inkluderStandardVirksomheter) {
            lagData(virksomhet = TestVirksomhet.OSLO, perioder = listOf(Periode.gjeldenePeriode(), Periode.forrigePeriode()), antallPersoner = 6)
            lagData(virksomhet = TestVirksomhet.BERGEN, perioder = listOf(Periode.gjeldenePeriode(), Periode.forrigePeriode()), sykefraværsProsent = "7.0")

            lagData(virksomhet = TestVirksomhet.NAV_KONTOR, perioder = listOf(Periode.gjeldenePeriode(), Periode.forrigePeriode()), antallPersoner = 1001)
            lagData(virksomhet = TestVirksomhet.OSLO_FLERE_ADRESSER, perioder = listOf())
            lagData(virksomhet = TestVirksomhet.OSLO_MANGLER_ADRESSER, perioder = listOf())
            lagData(virksomhet = TestVirksomhet.MANGLER_BELIGGENHETSADRESSE, perioder = listOf())
            lagData(virksomhet = TestVirksomhet.UTENLANDSK, perioder = listOf())
            lagData(virksomhet = TestVirksomhet.TESTVIRKSOMHET_FOR_IMPORT, emptyList())
            lagData(virksomhet = TestVirksomhet.TESTVIRKSOMHET_FOR_STATUSFILTER, listOf(Periode.gjeldenePeriode(), Periode.forrigePeriode()), sykefraværsProsent = "6.0")
            lagData(virksomhet = TestVirksomhet.TESTVIRKSOMHET_FOR_GRUNNLAG, listOf(Periode.gjeldenePeriode(), Periode.forrigePeriode()), antallPersoner = 42, sykefraværsProsent = "6.0")
        }
        genererTilfeldigeVirksomheter(antallVirksomheter = antallTilfeldigeVirksomheter)
    }

    private fun genererTilfeldigeVirksomheter(antallVirksomheter: Int) {
        (0 .. antallVirksomheter).forEach { _ ->
            lagData(TestVirksomhet.nyVirksomhet(), listOf(Periode.gjeldenePeriode()))
        }
    }

    fun lagData(
        virksomhet: TestVirksomhet,
        perioder: List<Periode>,
        sykefraværsProsent: String = "2.0",
        antallPersoner: Int = (5 .. 1000).random()
    ) {
        perioder.forEach { periode ->
            kafkaMeldinger.add(lagKafkaMelding(
                orgnr = virksomhet.orgnr,
                periode = periode,
                navn = virksomhet.navn,
                sykefraværsProsent = sykefraværsProsent,
                antallPersoner = antallPersoner))
        }
        virksomhet.næringsgrupper.forEach { næring ->
            næringer.add(lagSsbNæringInnslag(kode = næring.kode, navn = næring.navn))
        }
        brregVirksomheter.add(virksomhet.brregJson())
    }

    fun sykefraværsStatistikkMeldinger() =
        kafkaMeldinger

    fun brregMockData() =
        brregVirksomheter.joinToString(prefix = "[", postfix = "]", separator = ",")

    fun ssbNæringMockData() =
        næringer.joinToString(
            prefix =
            """
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
            """.trimIndent(),
            postfix =
            """
                  ]
                }
            """.trimIndent(),
            separator = ","
        )
}


enum class Melding(val melding: String) {
    testVirksomhetForrigeKvartal(
        melding = lagKafkaMelding(
            orgnr = TestVirksomhet.TESTVIRKSOMHET_FOR_IMPORT.orgnr,
            navn = TestVirksomhet.TESTVIRKSOMHET_FOR_IMPORT.navn,
            periode = Periode.forrigePeriode(),
            antallPersoner = 6
        )
    ),
    testVirksomhetGjeldeneKvartal(
        melding = lagKafkaMelding(
            orgnr = TestVirksomhet.TESTVIRKSOMHET_FOR_IMPORT.orgnr,
            navn = TestVirksomhet.TESTVIRKSOMHET_FOR_IMPORT.navn,
            periode = Periode.gjeldenePeriode(),
            antallPersoner = 6
        )
    )
}

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

fun lagKafkaMelding(
    orgnr: String,
    navn: String,
    periode: Periode,
    sykefraværsProsent: String = "2.0",
    antallPersoner: Int = 6) =
    """
        {
          "key": {
            "orgnr": "$orgnr",
            "kvartal": ${periode.kvartal},
            "årstall": ${periode.årstall}
          },
          "value": {
            "virksomhetSykefravær": {
              "orgnr": "$orgnr",
              "navn": "$navn",
              "årstall": ${periode.årstall},
              "kvartal": ${periode.kvartal},
              "tapteDagsverk": 20.0,
              "muligeDagsverk": 500.0,
              "antallPersoner": $antallPersoner,
              "prosent": $sykefraværsProsent,
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

fun TestVirksomhet.brregJson() =
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
              "beskrivelse" : "${næringskode1.navn}",
              "kode" : "${næringskode1.kode}"
            },            
            ${næringskode2?.let { 
                """
                    "naeringskode2" : {
                      "beskrivelse" : "${it.navn}",
                      "kode" : "${it.kode}"
                    },                     
                """.trimIndent()
            } ?: ""}
            ${næringskode3?.let { 
                """
                    "naeringskode3" : {
                      "beskrivelse" : "${it.navn}",
                      "kode" : "${it.kode}"
                    },                     
                """.trimIndent()
            } ?: ""}
            "antallAnsatte" : 1,
            "overordnetEnhet" : "999888777",
            "oppstartsdato" : "2010-07-01",
            ${beliggenhet?.let {
                "beliggenhetsadresse:" + Gson().toJson(it) + ","
            } ?: ""}
            "links" : [ ]
        }
    """.trimIndent()