package no.nav.lydia.helper

import com.google.gson.Gson
import no.nav.lydia.sykefraversstatistikk.api.Periode

class TestData(
    initsialiserStandardVirksomheter: Boolean = false
) {
    private val kafkaMeldinger = mutableSetOf<String>()
    private val næringer = mutableSetOf<String>()
    private val brregVirksomheter = mutableSetOf<String>()

    init {
        if (initsialiserStandardVirksomheter) {
            lagData(virksomhet = TestVirksomhet.OSLO, perioder = listOf(Periode.gjeldenePeriode(), Periode.forrigePeriode()))
            lagData(virksomhet = TestVirksomhet.BERGEN, perioder = listOf(Periode.gjeldenePeriode(), Periode.forrigePeriode()), sykefraværsProsent = "7.0")

            lagData(virksomhet = TestVirksomhet.OSLO_FLERE_ADRESSER, perioder = listOf())
            lagData(virksomhet = TestVirksomhet.OSLO_MANGLER_ADRESSER, perioder = listOf())
            lagData(virksomhet = TestVirksomhet.MANGLER_BELIGGENHETSADRESSE, perioder = listOf())
            lagData(virksomhet = TestVirksomhet.UTENLANDSK, perioder = listOf())
        }
    }

    fun lagData(
        virksomhet: TestVirksomhet,
        perioder: List<Periode>,
        sykefraværsProsent: String = "2.0"
    ): TestData {
        perioder.forEach { periode ->
            kafkaMeldinger.add(lagKafkaMelding(orgnr = virksomhet.orgnr, periode = periode, navn = virksomhet.navn, sykefraværsProsent = sykefraværsProsent))
        }
        virksomhet.næringsgrupper.forEach { næring ->
            næringer.add(lagSsbNæringInnslag(kode = næring.kode, navn = næring.navn))
        }
        brregVirksomheter.add(virksomhet.brregJson())
        return this
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
    osloForrigeKvartal(
        melding = lagKafkaMelding(
            orgnr = TestVirksomhet.OSLO.orgnr,
            navn = TestVirksomhet.OSLO.navn,
            periode = Periode.forrigePeriode()
        )
    ),
    osloGjeldeneKvartal(
        melding = lagKafkaMelding(
            orgnr = TestVirksomhet.OSLO.orgnr,
            navn = TestVirksomhet.OSLO.navn,
            periode = Periode.gjeldenePeriode()
        )
    ),
    bergenForrigeKvartal(
        melding = lagKafkaMelding(
            orgnr = TestVirksomhet.BERGEN.orgnr,
            navn = TestVirksomhet.BERGEN.navn,
            periode = Periode.forrigePeriode()
        )
    ),
    bergenGjeldeneKvartal(
        melding = lagKafkaMelding(
            orgnr = TestVirksomhet.BERGEN.orgnr,
            navn = TestVirksomhet.BERGEN.navn,
            periode = Periode.gjeldenePeriode()
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
    sykefraværsProsent: String = "2.0") =
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
              "antallPersoner": 6,
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