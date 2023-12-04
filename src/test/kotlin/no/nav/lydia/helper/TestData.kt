package no.nav.lydia.helper

import no.nav.lydia.helper.StatistikkHelper.Companion.hentPubliseringsinfo
import no.nav.lydia.sykefraværsstatistikk.api.Periode
import no.nav.lydia.sykefraværsstatistikk.import.*
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import no.nav.lydia.virksomhet.domene.Sektor
import java.math.RoundingMode
import java.time.LocalDate
import kotlin.random.Random
import no.nav.lydia.ia.sak.domene.IATjeneste
import no.nav.lydia.ia.sak.domene.Modul

const val MAX_SYKEFRAVÆRSPROSENT = 20
const val MAX_GRADERINGSPROSENT = 80

class TestData(
    inkluderStandardVirksomheter: Boolean = false,
    antallTilfeldigeVirksomheter: Int = 0,
) {
    companion object {
        const val BRANSJE_BARNEHAGE = "Barnehager"
        const val BRANSJE_NÆRINGSMIDDELINDUSTRI = "Næringsmiddelindustri"
        const val NÆRING_JORDBRUK = "01"
        const val NÆRING_SKOGBRUK = "02"
        const val NÆRING_PLEIE_OG_OMSORGSTJENESTER_I_INSTITUSJON = "87"
        const val NÆRINGSKODE_BARNEHAGER = "88911"
        val NÆRING_BARNEHAGE = Næringsgruppe(kode = "88", navn = "Omsorg uten botilbud, barnehager mv.")

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

        private val AKTIV_IATJENESTE = IATjeneste(1, "Redusere sykefravær", false)
        val AKTIV_MODUL = Modul(15, AKTIV_IATJENESTE, "Redusere sykefravær", false)

        val gjeldendePeriode: Periode by lazy {
            val publiseringsinfo = hentPubliseringsinfo()
            Periode(
                årstall = publiseringsinfo.fraTil.til.årstall,
                kvartal = publiseringsinfo.fraTil.til.kvartal
            )
        }

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

        fun datoSentIGjeldendePeriode() = LocalDate.of(gjeldendePeriode.årstall, (gjeldendePeriode.kvartal*3), 30)

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
        mutableSetOf<SykefraværsstatistikkPerKategoriImportDto>()
    private val graderingStatistikkVirksomhetKafkaMeldinger =
            mutableSetOf<GradertSykemeldingImportDto>()
    private val sykefraværsstatistikkMetadataVirksomhetKafkaMeldinger =
        mutableSetOf<SykefraværsstatistikkMetadataVirksomhetImportDto>()
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
                perioder = gjeldendePeriode.lagPerioder(2),
                sykefraværsProsent = 7.0,
                graderingsprosent = 20.0,
                tapteDagsverk = 1000.0
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
            lagData(
                virksomhet = TestVirksomhet.VIRKSOMHET_MED_HISTORISK_STATISTIKK,
                gjeldendePeriode.lagPerioder(20),
                tapteDagsverk = 1_000_000.0
            )

        }
        genererTilfeldigeVirksomheter(antallVirksomheter = antallTilfeldigeVirksomheter)
    }

    private fun genererTilfeldigeVirksomheter(antallVirksomheter: Int) {
        (0..antallVirksomheter).forEach { _ ->
            lagData(
                virksomhet = TestVirksomhet.nyVirksomhet(),
                perioder = listOf(gjeldendePeriode),
                sektor = Sektor.entries[(0..2).random()]
            )
        }
    }

    fun lagData(
        virksomhet: TestVirksomhet,
        perioder: List<Periode>,
        sykefraværsProsent: Double? = null,
        graderingsprosent: Double? = null,
        antallPersoner: Double = Random.nextDouble(5.0, 1000.0),
        tapteDagsverk: Double = Random.nextDouble(5.0, 10000.0),
        sektor: Sektor = Sektor.STATLIG,
    ): TestData {
        perioder.forEach { periode ->
            val graderingsProsent = graderingsprosent ?: (1..MAX_GRADERINGSPROSENT).random().toDouble()
            val tapteDagsverkGradert = (tapteDagsverk * graderingsProsent/100).toBigDecimal().setScale(1, RoundingMode.UP).toDouble()
            sykefraværsstatistikkVirksomhetKafkaMeldinger.add(
                lagSykefraværsstatistikkPerKategoriImportDto(
                    kategori = Kategori.VIRKSOMHET,
                    kode = virksomhet.orgnr,
                    periode = periode,
                    sykefraværsProsent = sykefraværsProsent ?: (1..MAX_SYKEFRAVÆRSPROSENT).random().toDouble(),
                    antallPersoner = antallPersoner.toInt(),
                    tapteDagsverk = tapteDagsverk,
                )
            )
            graderingStatistikkVirksomhetKafkaMeldinger.add(
                    GradertSykemeldingImportDto(
                            kategori = "VIRKSOMHET_GRADERT",
                            kode = virksomhet.orgnr,
                            sistePubliserteKvartal = GraderingSistePubliserteKvartal(
                                    årstall = periode.årstall,
                                    kvartal = periode.kvartal,
                                    prosent = graderingsProsent,
                                    tapteDagsverkGradert = tapteDagsverkGradert,
                                    tapteDagsverk = tapteDagsverk,
                                    antallPersoner = antallPersoner.toInt(),
                                    erMaskert = false
                            ),
                            siste4Kvartal = GraderingSiste4Kvartal(
                                    prosent = graderingsProsent,
                                    tapteDagsverkGradert = tapteDagsverkGradert,
                                    tapteDagsverk = tapteDagsverk,
                                    erMaskert = false,
                                    kvartaler = listOf(gjeldendePeriode.tilKvartal(), gjeldendePeriode.forrigePeriode().tilKvartal())
                            )
                    )
            )
            sykefraværsstatistikkMetadataVirksomhetKafkaMeldinger.add(
                SykefraværsstatistikkMetadataVirksomhetImportDto(
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

    fun graderingStatistikkVirksomhetKafkaMeldinger() =
        graderingStatistikkVirksomhetKafkaMeldinger

    fun sykefraværsstatistikkMetadataVirksomhetKafkaMeldinger() =
        sykefraværsstatistikkMetadataVirksomhetKafkaMeldinger

}

fun lagSykefraværsstatistikkPerKategoriImportDto(
    kategori: Kategori,
    kode: String,
    periode: Periode,
    sykefraværsProsent: Double = 2.0,
    antallPersoner: Int = 6,
    tapteDagsverk: Double = 20.0,
    muligeDagsverk: Double = 125.0,
    maskert: Boolean = false,
) =
    SykefraværsstatistikkPerKategoriImportDto(
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
