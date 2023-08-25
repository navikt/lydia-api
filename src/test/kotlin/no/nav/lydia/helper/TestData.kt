package no.nav.lydia.helper

import com.google.gson.Gson
import no.nav.lydia.sykefraversstatistikk.api.Periode
import no.nav.lydia.sykefraversstatistikk.import.*
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import no.nav.lydia.virksomhet.domene.Sektor
import kotlin.random.Random

const val MAX_SYKEFRAVÆRSPROSENT = 20

class TestData(
    inkluderStandardVirksomheter: Boolean = false,
    antallTilfeldigeVirksomheter: Int = 0,
) {
    companion object {
        const val LANDKODE_NO = "NO"
        const val BRANSJE_BARNEHAGE = "Barnehager"
        const val BRANSJE_NÆRINGSMIDDELINDUSTRI = "Næringsmiddelindustri"
        const val NÆRING_JORDBRUK = "01"
        const val NÆRING_SKOGBRUK = "02"
        const val NÆRINGSKODE_BARNEHAGER = "88911"

        val DYRKING_AV_KORN = Næringsgruppe(kode = "$NÆRING_JORDBRUK.110", navn = "Dyrking av korn, unntatt ris")
        val DYRKING_AV_RIS = Næringsgruppe(kode = "$NÆRING_JORDBRUK.120", navn = "Dyrking av ris")

        val SKOGSKJØTSEL = Næringsgruppe(kode = "$NÆRING_SKOGBRUK.100", navn = "Skogskjøtsel")
        val AVVIRKNING = Næringsgruppe(kode = "$NÆRING_SKOGBRUK.200", navn = "Avvirkning")
        val SCENEKUNST =
            Næringsgruppe(kode = "90.012", navn = "Utøvende kunstnere og underholdningsvirksomhet innen scenekunst")
        val BEDRIFTSRÅDGIVNING =
            Næringsgruppe(kode = "70.220", navn = "Bedriftsrådgivning og annen administrativ rådgivning")

        val gjeldendePeriode = Periode(årstall = 2023, kvartal = 1)
        fun fraVirksomhet(
            virksomhet: TestVirksomhet,
            sektor: Sektor = Sektor.STATLIG,
            perioder: List<Periode> = listOf(gjeldendePeriode, gjeldendePeriode.forrigePeriode()),
        ) =
            TestData().lagData(
                virksomhet = virksomhet,
                perioder = perioder,
                sektor = sektor
            )

    }

    private val sykefraværsstatistikkPerKategoriKafkaMeldinger =
        mutableSetOf<SykefraversstatistikkPerKategoriImportDto>()
    private val sykefraværsstatistikkMetadataVirksomhetKafkaMeldinger =
        mutableSetOf<SykefraversstatistikkMetadataVirksomhetImportDto>()
    private val næringer = mutableSetOf<String>()
    private val brregVirksomheter = mutableSetOf<String>()

    init {
        if (inkluderStandardVirksomheter) {
            lagData(
                virksomhet = TestVirksomhet.OSLO,
                perioder = listOf(gjeldendePeriode, gjeldendePeriode.forrigePeriode()),
                antallPersoner = 6.0
            )
            lagData(
                virksomhet = TestVirksomhet.BERGEN,
                perioder = listOf(gjeldendePeriode, gjeldendePeriode.forrigePeriode()),
                sykefraværsProsent = 7.0
            )

            lagData(virksomhet = TestVirksomhet.OSLO_FLERE_ADRESSER, perioder = listOf(gjeldendePeriode))
            lagData(virksomhet = TestVirksomhet.OSLO_MANGLER_ADRESSER, perioder = listOf())
            lagData(virksomhet = TestVirksomhet.MANGLER_BELIGGENHETSADRESSE, perioder = listOf())
            lagData(virksomhet = TestVirksomhet.UTENLANDSK, perioder = listOf())
            lagData(virksomhet = TestVirksomhet.TESTVIRKSOMHET_FOR_IMPORT, emptyList())
            lagData(
                virksomhet = TestVirksomhet.TESTVIRKSOMHET_FOR_STATUSFILTER,
                listOf(gjeldendePeriode, gjeldendePeriode.forrigePeriode()),
                sykefraværsProsent = 6.0
            )
            lagData(
                virksomhet = TestVirksomhet.TESTVIRKSOMHET_FOR_GRUNNLAG,
                listOf(gjeldendePeriode, gjeldendePeriode.forrigePeriode()),
                antallPersoner = 42.0,
                sykefraværsProsent = 6.0
            )
            lagData(
                virksomhet = TestVirksomhet.TESTVIRKSOMHET_FOR_OPPDATERING,
                listOf(gjeldendePeriode, gjeldendePeriode.forrigePeriode()),
                antallPersoner = 42.0,
                sykefraværsProsent = 6.0
            )
            lagData(
                virksomhet = TestVirksomhet.TESTVIRKSOMHET_FOR_Å_TESTE_FEILAKTIG_MASKERT_STATISTIKK,
                listOf(gjeldendePeriode, gjeldendePeriode.forrigePeriode()),
            )

        }
        genererTilfeldigeVirksomheter(antallVirksomheter = antallTilfeldigeVirksomheter)
    }

    private fun genererTilfeldigeVirksomheter(antallVirksomheter: Int) {
        (0..antallVirksomheter).forEach { _ ->
            lagData(
                virksomhet = TestVirksomhet.nyVirksomhet(),
                perioder = listOf(gjeldendePeriode),
                sektor = Sektor.entries[(0..3).random()]
            )
        }
    }

    fun lagData(
        virksomhet: TestVirksomhet,
        perioder: List<Periode>,
        sykefraværsProsent: Double? = null,
        antallPersoner: Double = Random.nextDouble(5.0, 1000.0),
        tapteDagsverk: Double = Random.nextDouble(5.0, 10000.0),
        sektor: Sektor = Sektor.STATLIG,
    ): TestData {
        perioder.forEach { periode ->
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
            sykefraværsstatistikkMetadataVirksomhetKafkaMeldinger.add(
                SykefraversstatistikkMetadataVirksomhetImportDto(
                    orgnr = virksomhet.orgnr,
                    årstall = periode.årstall,
                    kvartal = periode.kvartal,
                    sektor = sektor.name,
                    bransje = "BARNEHAGER",
                    naring = "88"
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

    fun sykefraværsstatistikkPerKategoriMeldinger() =
        sykefraværsstatistikkPerKategoriKafkaMeldinger

    fun sykefraværsstatistikkMetadataVirksomhetKafkaMeldinger() =
        sykefraværsstatistikkMetadataVirksomhetKafkaMeldinger

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
            kvartaler = listOf(TestData.gjeldendePeriode.tilKvartal(), TestData.gjeldendePeriode.forrigePeriode().tilKvartal())
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
