package no.nav.lydia.helper

import com.google.gson.Gson
import no.nav.lydia.helper.TestData.Companion.DYRKING_AV_KORN
import no.nav.lydia.helper.TestData.Companion.LANDKODE_NO
import no.nav.lydia.helper.TestData.Companion.NÆRING_JORDBRUK
import no.nav.lydia.sykefraversstatistikk.api.Periode
import no.nav.lydia.sykefraversstatistikk.import.*
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import kotlin.random.Random

const val MAX_SYKEFRAVÆRSPROSENT = 20

class TestData(
    inkluderStandardVirksomheter: Boolean = false,
    antallTilfeldigeVirksomheter: Int = 0,
) {
    companion object {
        const val LANDKODE_NO = "NO"
        const val SEKTOR_STATLIG_FORVALTNING = "1"
        const val SEKTOR_KOMMUNAL_FORVALTNING = "2"
        const val SEKTOR_PRIVAT_NÆRINGSVIRKSOMHET = "3"
        const val NÆRING_JORDBRUK = "01"
        const val NÆRING_SKOGBRUK = "02"

        val DYRKING_AV_KORN = Næringsgruppe(kode = "$NÆRING_JORDBRUK.110", navn = "Dyrking av korn, unntatt ris")
        val DYRKING_AV_RIS = Næringsgruppe(kode = "$NÆRING_JORDBRUK.120", navn = "Dyrking av ris")

        val SKOGSKJØTSEL = Næringsgruppe(kode = "$NÆRING_SKOGBRUK.100", navn = "Skogskjøtsel")
        val AVVIRKNING = Næringsgruppe(kode = "$NÆRING_SKOGBRUK.200", navn = "Avvirkning")
        val SCENEKUNST =
            Næringsgruppe(kode = "90.012", navn = "Utøvende kunstnere og underholdningsvirksomhet innen scenekunst")
        val BEDRIFTSRÅDGIVNING =
            Næringsgruppe(kode = "70.220", navn = "Bedriftsrådgivning og annen administrativ rådgivning")

        fun fraVirksomhet(
            virksomhet: TestVirksomhet,
            sektor: String = SEKTOR_STATLIG_FORVALTNING,
            perioder: List<Periode> = listOf(Periode.gjeldendePeriode(), Periode.forrigePeriode()),
        ) =
            TestData().lagData(
                virksomhet = virksomhet,
                perioder = perioder,
                sektor = sektor
            )

    }

    private val kafkaMeldinger = mutableSetOf<SykefraversstatistikkImportDto>()
    private val sykefraværsstatistikkPerKategoriKafkaMeldinger =
        mutableSetOf<SykefraversstatistikkPerKategoriImportDto>()
    private val næringer = mutableSetOf<String>()
    private val brregVirksomheter = mutableSetOf<String>()

    init {
        if (inkluderStandardVirksomheter) {
            lagData(
                virksomhet = TestVirksomhet.OSLO,
                perioder = listOf(Periode.gjeldendePeriode(), Periode.forrigePeriode()),
                antallPersoner = 6.0
            )
            lagData(
                virksomhet = TestVirksomhet.BERGEN,
                perioder = listOf(Periode.gjeldendePeriode(), Periode.forrigePeriode()),
                sykefraværsProsent = 7.0
            )

            lagData(virksomhet = TestVirksomhet.OSLO_FLERE_ADRESSER, perioder = listOf(Periode.gjeldendePeriode()))
            lagData(virksomhet = TestVirksomhet.OSLO_MANGLER_ADRESSER, perioder = listOf())
            lagData(virksomhet = TestVirksomhet.MANGLER_BELIGGENHETSADRESSE, perioder = listOf())
            lagData(virksomhet = TestVirksomhet.UTENLANDSK, perioder = listOf())
            lagData(virksomhet = TestVirksomhet.TESTVIRKSOMHET_FOR_IMPORT, emptyList())
            lagData(
                virksomhet = TestVirksomhet.TESTVIRKSOMHET_FOR_STATUSFILTER,
                listOf(Periode.gjeldendePeriode(), Periode.forrigePeriode()),
                sykefraværsProsent = 6.0
            )
            lagData(
                virksomhet = TestVirksomhet.TESTVIRKSOMHET_FOR_GRUNNLAG,
                listOf(Periode.gjeldendePeriode(), Periode.forrigePeriode()),
                antallPersoner = 42.0,
                sykefraværsProsent = 6.0
            )
            lagData(
                virksomhet = TestVirksomhet.TESTVIRKSOMHET_FOR_OPPDATERING,
                listOf(Periode.gjeldendePeriode(), Periode.forrigePeriode()),
                antallPersoner = 42.0,
                sykefraværsProsent = 6.0
            )
            lagData(
                virksomhet = TestVirksomhet.TESTVIRKSOMHET_FOR_Å_TESTE_FEILAKTIG_MASKERT_STATISTIKK,
                listOf(Periode.gjeldendePeriode(), Periode.forrigePeriode()),
            )

        }
        genererTilfeldigeVirksomheter(antallVirksomheter = antallTilfeldigeVirksomheter)
    }

    private fun genererTilfeldigeVirksomheter(antallVirksomheter: Int) {
        (0..antallVirksomheter).forEach { _ ->
            lagData(
                virksomhet = TestVirksomhet.nyVirksomhet(),
                perioder = listOf(Periode.gjeldendePeriode()),
                sektor = (0..3).random().toString()
            )
        }
    }

    fun lagData(
        virksomhet: TestVirksomhet,
        perioder: List<Periode>,
        sykefraværsProsent: Double? = null,
        antallPersoner: Double = Random.nextDouble(5.0, 1000.0),
        tapteDagsverk: Double = Random.nextDouble(5.0, 10000.0),
        sektor: String = SEKTOR_STATLIG_FORVALTNING,
    ): TestData {
        perioder.forEach { periode ->
            kafkaMeldinger.add(
                lagSykefraværsstatistikkImportDto(
                    orgnr = virksomhet.orgnr,
                    periode = periode,
                    sykefraværsProsent = sykefraværsProsent ?: (1..MAX_SYKEFRAVÆRSPROSENT).random().toDouble(),
                    antallPersoner = antallPersoner,
                    tapteDagsverk = tapteDagsverk,
                    sektor = sektor
                )
            )
            sykefraværsstatistikkPerKategoriKafkaMeldinger.add(
                lagSykefraversstatistikkPerKategoriImportDto(
                    kategori = Kategori.VIRKSOMHET,
                    kode = virksomhet.orgnr,
                    periode = periode,
                    sykefraværsProsent = sykefraværsProsent ?: (1..MAX_SYKEFRAVÆRSPROSENT).random().toDouble(),
                    antallPersoner = antallPersoner.toInt(),
                    tapteDagsverk = tapteDagsverk,
                )
            )
        }
        virksomhet.næringsundergrupper
            .map(Næringsgruppe::tilTosifret)
            .toSet()
            .forEach { næringer.add(lagSsbNæringInnslag(kode = it, navn = "Næring")) }
        virksomhet.næringsundergrupper.forEach { næring ->
            næringer.add(lagSsbNæringInnslag(kode = næring.kode, navn = næring.navn))
        }
        brregVirksomheter.add(virksomhet.brregUnderenhetJson())

        return this
    }

    fun sykefraværsStatistikkMeldinger() =
        kafkaMeldinger

    fun sykefraværsstatistikkPerKategoriMeldinger() =
        sykefraværsstatistikkPerKategoriKafkaMeldinger

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

enum class SykefraværsstatistikkPerKategoriTestData(
    val sykefraversstatistikkPerKategoriImportDto: SykefraversstatistikkPerKategoriImportDto,
) {
    testVirksomhetForrigeKvartal(
        sykefraversstatistikkPerKategoriImportDto = lagSykefraversstatistikkPerKategoriImportDto(
            kategori = Kategori.VIRKSOMHET,
            kode = TestVirksomhet.TESTVIRKSOMHET_FOR_IMPORT.orgnr,
            periode = Periode.forrigePeriode(),
            antallPersoner = 6,
        )
    ),
    testVirksomhetGjeldeneKvartal(
        sykefraversstatistikkPerKategoriImportDto = lagSykefraversstatistikkPerKategoriImportDto(
            kategori = Kategori.VIRKSOMHET,
            kode = TestVirksomhet.TESTVIRKSOMHET_FOR_IMPORT.orgnr,
            periode = Periode.gjeldendePeriode(),
            antallPersoner = 6,
        )
    )
}

enum class SykefraværsstatistikkTestData(val sykefraværsstatistikkImportDto: SykefraversstatistikkImportDto) {
    testVirksomhetForrigeKvartal(
        sykefraværsstatistikkImportDto = lagSykefraværsstatistikkImportDto(
            orgnr = TestVirksomhet.TESTVIRKSOMHET_FOR_IMPORT.orgnr,
            periode = Periode.forrigePeriode(),
            antallPersoner = 6.0,
            sektor = "1"
        )
    ),
    testVirksomhetGjeldeneKvartal(
        sykefraværsstatistikkImportDto = lagSykefraværsstatistikkImportDto(
            orgnr = TestVirksomhet.TESTVIRKSOMHET_FOR_IMPORT.orgnr,
            periode = Periode.gjeldendePeriode(),
            antallPersoner = 6.0,
            sektor = "1"
        )
    ),
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

fun lagSykefraværsstatistikkImportDto(
    orgnr: String,
    periode: Periode,
    sykefraværsProsent: Double = 2.0,
    antallPersoner: Double = 6.0,
    tapteDagsverk: Double = 20.0,
    sektor: String,
    landKode: String = LANDKODE_NO,
    næring: String = NÆRING_JORDBRUK,
    næringsundergrupper: List<String> = listOf(DYRKING_AV_KORN.kode),
    maskert: Boolean = false,
) =
    SykefraversstatistikkImportDto(
        virksomhetSykefravær = SykefraværsstatistikkForVirksomhet(
            årstall = periode.årstall,
            kvartal = periode.kvartal,
            orgnr = orgnr,
            prosent = sykefraværsProsent,
            antallPersoner = antallPersoner,
            tapteDagsverk = tapteDagsverk,
            muligeDagsverk = 500.0,
            maskert = maskert,
            kategori = "VIRKSOMHET"
        ),
        sektorSykefravær = SektorSykefravær(
            årstall = periode.årstall,
            kvartal = periode.kvartal,
            kode = sektor,
            prosent = 1.5,
            tapteDagsverk = 1340.0,
            muligeDagsverk = 8000.0,
            antallPersoner = 33000.0,
            maskert = maskert,
            kategori = "SEKTOR"
        ),
        landSykefravær = LandSykefravær(
            årstall = periode.årstall,
            kvartal = periode.kvartal,
            prosent = 2.0,
            kode = landKode,
            tapteDagsverk = 10000000.0,
            muligeDagsverk = 500000000.0,
            antallPersoner = 2500000.0,
            maskert = maskert,
            kategori = "LAND"
        ),
        næringSykefravær = NæringSykefravær(
            årstall = periode.årstall,
            kvartal = periode.kvartal,
            kode = næring,
            tapteDagsverk = 100.0,
            muligeDagsverk = 5000.0,
            antallPersoner = 150.0,
            prosent = 2.0,
            maskert = maskert,
            kategori = "NÆRING2SIFFER"
        ),
        næring5SifferSykefravær = næringsundergrupper.map { næringsundergruppe ->
            NæringsundergruppeSykefravær(
                årstall = periode.årstall,
                kvartal = periode.kvartal,
                kode = næringsundergruppe,
                tapteDagsverk = 40.0,
                muligeDagsverk = 4000.0,
                antallPersoner = 1250.0,
                prosent = 1.0,
                maskert = maskert,
                kategori = "NÆRING5SIFFER"
            )
        }
    )

fun lagSykefraversstatistikkPerKategoriImportDto(
    kategori: Kategori,
    kode: String,
    periode: Periode,
    sykefraværsProsent: Double = 2.0,
    antallPersoner: Int = 6,
    tapteDagsverk: Double = 20.0,
    maskert: Boolean = false,
) =
    SykefraversstatistikkPerKategoriImportDto(
        kategori = kategori,
        kode = kode,
        sistePubliserteKvartal = SistePubliserteKvartal(
            årstall = periode.årstall,
            kvartal = periode.kvartal,
            prosent = 1.5,
            antallPersoner = antallPersoner,
            tapteDagsverk = 12.8,
            muligeDagsverk = 125.0,
            erMaskert = maskert
        ),
        siste4Kvartal = Siste4Kvartal(
            prosent = sykefraværsProsent,
            tapteDagsverk = tapteDagsverk,
            muligeDagsverk = 500.0,
            erMaskert = maskert,
            kvartaler = listOf(Periode.gjeldendePeriode().tilKvartal(), Periode.forrigePeriode().tilKvartal())
        )
    )


fun TestVirksomhet.brregUnderenhetJson() =
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
              "beskrivelse" : "${næringsundergruppe1.navn}",
              "kode" : "${næringsundergruppe1.kode}"
            },            
            ${
        næringsundergruppe2?.let {
            """
                    "naeringskode2" : {
                      "beskrivelse" : "${it.navn}",
                      "kode" : "${it.kode}"
                    },                     
                """.trimIndent()
        } ?: ""
    }
            ${
        næringsundergruppe3?.let {
            """
                    "naeringskode3" : {
                      "beskrivelse" : "${it.navn}",
                      "kode" : "${it.kode}"
                    },                     
                """.trimIndent()
        } ?: ""
    }
            "antallAnsatte" : 1,
            "overordnetEnhet" : "999888777",
            "oppstartsdato" : "2010-07-01",
            ${
        beliggenhet?.let {
            "\"beliggenhetsadresse\":" + Gson().toJson(it) + ","
        } ?: ""
    }
            "links" : [ ]
        }
    """.trimIndent()

val sektorStatistikk = """
    {
        "kategori": "SEKTOR",
        "kode": "0",
        "sistePubliserteKvartal": {
            "årstall": 2022,
            "kvartal": 4,
            "prosent": 2.3,
            "tapteDagsverk": 1740.5,
            "muligeDagsverk": 76139.3,
            "antallPersoner": 1723,
            "erMaskert": false
        },
        "siste4Kvartal": {
            "prosent": 2.7,
            "tapteDagsverk": 8020.0,
            "muligeDagsverk": 300991.3,
            "erMaskert": false,
            "kvartaler": [
                {
                    "årstall": 2022,
                    "kvartal": 3
                },
                {
                    "årstall": 2022,
                    "kvartal": 4
                }
            ]
        }
    }
    """.trimIndent()
