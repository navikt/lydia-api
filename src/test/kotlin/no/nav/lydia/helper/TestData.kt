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
        const val NÆRING_PLEIE_OG_OMSORGSTJENESTER_I_INSTITUSJON = "87"
        const val NÆRINGSKODE_BARNEHAGER = "88911"

        val NÆRINGSMIDLER_IKKE_NEVNT = Næringsgruppe(kode = "10.890", navn = "Produksjon av næringsmidler ikke nevnt annet sted")
        val BARNEHAGER = Næringsgruppe(kode = "88.911", navn = "Barnehager")
        val NÆRING_MED_BINDESTREK = Næringsgruppe(kode = "91.012", navn = "Drift av fag- og forskningsbiblioteker")
        val BOLIGBYGGELAG = Næringsgruppe(kode = "41.101", navn = "Boligbyggelag")
        val DYRKING_AV_KORN = Næringsgruppe(kode = "$NÆRING_JORDBRUK.110", navn = "Dyrking av korn (unntatt ris), belgvekster og oljeholdige vekster")
        val DYRKING_AV_RIS = Næringsgruppe(kode = "$NÆRING_JORDBRUK.120", navn = "Dyrking av ris")

        val SKOGSKJØTSEL = Næringsgruppe(kode = "$NÆRING_SKOGBRUK.100", navn = "Skogskjøtsel")
        val AVVIRKNING = Næringsgruppe(kode = "$NÆRING_SKOGBRUK.200", navn = "Avvirkning")
        val SCENEKUNST =
            Næringsgruppe(kode = "90.012", navn = "Utøvende kunstnere og underholdningsvirksomhet innen scenekunst")
        val BEDRIFTSRÅDGIVNING =
            Næringsgruppe(kode = "70.220", navn = "Bedriftsrådgivning og annen administrativ rådgivning")

        val gjeldendePeriode = Periode(årstall = 2023, kvartal = 2)
        fun fraVirksomhet(
            virksomhet: TestVirksomhet,
            sektor: Sektor = Sektor.STATLIG,
            perioder: List<Periode> = listOf(gjeldendePeriode, gjeldendePeriode.forrigePeriode()),
            sykefraværsProsent: Double? = null,
        ) =
            TestData().lagData(
                virksomhet = virksomhet,
                perioder = perioder,
                sektor = sektor,
                sykefraværsProsent = sykefraværsProsent
            )

        fun Periode.lagPerioder(antall: Int): List<Periode> {
            return rekursivtLagPerioder(antall, mutableListOf(), this)
        }

        private fun rekursivtLagPerioder(
                perioderIgjen: Int,
                perioder: MutableList<Periode>,
                periode: Periode
        ): List<Periode> {
            return if (perioderIgjen == 0) {
                perioder
            } else {
                perioder.add(periode)
                rekursivtLagPerioder(perioderIgjen - 1, perioder, periode.forrigePeriode())
            }
        }
    }

    private val sykefraværsstatistikkVirksomhetKafkaMeldinger =
        mutableSetOf<SykefraversstatistikkPerKategoriImportDto>()
    private val sykefraværsstatistikkMetadataVirksomhetKafkaMeldinger =
        mutableSetOf<SykefraversstatistikkMetadataVirksomhetImportDto>()
    val brregVirksomheter = mutableSetOf<TestVirksomhet>()

    init {
        if (inkluderStandardVirksomheter) {
            lagData(
                virksomhet = TestVirksomhet.OSLO,
                perioder = listOf(gjeldendePeriode, gjeldendePeriode.forrigePeriode()),
                antallPersoner = 6.0
            )
            lagData(
                virksomhet = TestVirksomhet.BERGEN,
                perioder = gjeldendePeriode.lagPerioder(20),
                sykefraværsProsent = 7.0
            )

            lagData(virksomhet = TestVirksomhet.OSLO_FLERE_ADRESSER, perioder = listOf(gjeldendePeriode))
            lagData(virksomhet = TestVirksomhet.OSLO_MANGLER_ADRESSER, perioder = listOf())
            lagData(virksomhet = TestVirksomhet.MANGLER_BELIGGENHETSADRESSE, perioder = listOf())
            lagData(virksomhet = TestVirksomhet.UTENLANDSK, perioder = listOf())
            lagData(virksomhet = TestVirksomhet.TESTVIRKSOMHET_FOR_IMPORT, emptyList())
            lagData(
                virksomhet = TestVirksomhet.TESTVIRKSOMHET_FOR_STATUSFILTER,
                perioder = gjeldendePeriode.lagPerioder(2),
                sykefraværsProsent = 6.0
            )
            lagData(
                virksomhet = TestVirksomhet.TESTVIRKSOMHET_FOR_GRUNNLAG,
                perioder = gjeldendePeriode.lagPerioder(2),
                antallPersoner = 42.0,
                sykefraværsProsent = 6.0
            )
            lagData(
                virksomhet = TestVirksomhet.TESTVIRKSOMHET_FOR_OPPDATERING,
                perioder = gjeldendePeriode.lagPerioder(2),
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
            sykefraværsstatistikkVirksomhetKafkaMeldinger.add(
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
                    bransje = virksomhet.næringsundergruppe1.tilBransje()?.name,
                    naring = virksomhet.næringsundergruppe1.tilTosifret()
                )
            )
        }
        brregVirksomheter.add(virksomhet)

        return this
    }

    fun sykefraværsstatistikkVirksomhetMeldinger() =
        sykefraværsstatistikkVirksomhetKafkaMeldinger

    fun sykefraværsstatistikkMetadataVirksomhetKafkaMeldinger() =
        sykefraværsstatistikkMetadataVirksomhetKafkaMeldinger

}

fun lagSykefraversstatistikkPerKategoriImportDto(
    kategori: Kategori,
    kode: String,
    periode: Periode,
    sykefraværsProsent: Double = 2.0,
    antallPersoner: Int = 6,
    tapteDagsverk: Double = 20.0,
    muligeDagsverk: Double = 125.0,
    maskert: Boolean = false,
) =
    SykefraversstatistikkPerKategoriImportDto(
        kategori = kategori,
        kode = kode,
        sistePubliserteKvartal = SistePubliserteKvartal(
            årstall = periode.årstall,
            kvartal = periode.kvartal,
            prosent = sykefraværsProsent,
            antallPersoner = antallPersoner,
            tapteDagsverk = tapteDagsverk,
            muligeDagsverk = muligeDagsverk,
            erMaskert = maskert
        ),
        siste4Kvartal = Siste4Kvartal(
            prosent = sykefraværsProsent,
            tapteDagsverk = tapteDagsverk * 4,
            muligeDagsverk = muligeDagsverk * 4,
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
