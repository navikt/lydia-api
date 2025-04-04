package no.nav.lydia.container.sykefraværsstatistikk.importering

import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import no.nav.lydia.Topic
import no.nav.lydia.container.sykefraværsstatistikk.importering.SykefraværsstatistikkImportTestUtils.Companion.KVARTAL_2023_1
import no.nav.lydia.container.sykefraværsstatistikk.importering.SykefraværsstatistikkImportTestUtils.Companion.hentStatistikkGjeldendeKvartal
import no.nav.lydia.container.sykefraværsstatistikk.importering.SykefraværsstatistikkImportTestUtils.Companion.hentStatistikkSiste4Kvartal
import no.nav.lydia.container.sykefraværsstatistikk.importering.SykefraværsstatistikkImportTestUtils.Companion.siste4KvartalShouldBeEqual
import no.nav.lydia.container.sykefraværsstatistikk.importering.SykefraværsstatistikkImportTestUtils.Companion.sistePubliserteKvartalShouldBeEqual
import no.nav.lydia.container.sykefraværsstatistikk.importering.SykefraværsstatistikkImportTestUtils.JsonMelding
import no.nav.lydia.helper.StatistikkHelper.Companion.hentSykefraværForAlleVirksomheterMedFilter
import no.nav.lydia.helper.StatistikkHelper.Companion.hentSykefraværForVirksomhetSiste4Kvartaler
import no.nav.lydia.helper.StatistikkHelper.Companion.hentSykefraværForVirksomhetSisteTilgjengeligKvartal
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldNotContainLog
import no.nav.lydia.helper.TestData.Companion.gjeldendePeriode
import no.nav.lydia.helper.TestData.Companion.lagPerioder
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.sykefraværsstatistikk.api.KvartalDto.Companion.toDto
import no.nav.lydia.sykefraværsstatistikk.import.Kategori
import no.nav.lydia.sykefraværsstatistikk.import.Siste4Kvartal
import no.nav.lydia.sykefraværsstatistikk.import.SistePubliserteKvartal
import kotlin.test.BeforeTest
import kotlin.test.Test

/**
 * Tester som verifiserer felles use-cases i import av sykefraværsstatistikk
 *  - håndterer feil formatert meldinger
 *  - kan importere statistikk for flere kvartal
 *  - sykefraværsstatistikk skal oppdateres om det kommer nye versjoner av samme nøkler
 *  - importerte data skal kunne hentes ut og være like
 */

class SykefraværsstatistikkImportTest {
    @BeforeTest
    fun cleanUp() {
        SykefraværsstatistikkImportTestUtils.cleanUpStatistikkTable(Kategori.VIRKSOMHET, "999999999")
        SykefraværsstatistikkImportTestUtils.cleanUpStatistikkSiste4KvartalTable(Kategori.VIRKSOMHET, "999999999")
    }

    @Test
    fun `håndterer feil formatert meldinger`() {
        kafkaContainerHelper.sendOgVentTilKonsumert(
            """
            {
              "kategori": "UKJENT_KATEGORI",
              "kode": "22",
              "kvartal": ${KVARTAL_2023_1.kvartal},
              "årstall": ${KVARTAL_2023_1.årstall}
            }
            """.trimIndent(),
            eksport_Forrige_Kvartal_For_Virksomhet.toJsonValue(),
            Topic.STATISTIKK_VIRKSOMHET_TOPIC,
        )

        applikasjon shouldNotContainLog "NullPointerException.*".toRegex()
        applikasjon shouldContainLog "Feil formatert Kafka melding i topic ${Topic.STATISTIKK_VIRKSOMHET_TOPIC.navn}".toRegex()
    }

    @Test
    fun `vi maskerer statistikk for siste kvartal som eventuelt ikke er maskert i produsent`() {
        val statistikkSomBurdeVæreMaskert = JsonMelding(
            kategori = Kategori.VIRKSOMHET,
            kode = "999999999",
            kvartal = KVARTAL_2023_1,
            sistePubliserteKvartal = SistePubliserteKvartal(
                årstall = KVARTAL_2023_1.årstall,
                kvartal = KVARTAL_2023_1.kvartal,
                tapteDagsverk = 17.5,
                muligeDagsverk = 761.3,
                prosent = 2.3,
                erMaskert = false,
                antallPersoner = 4,
            ),
            siste4Kvartal = siste4Kvartal,
        )

        kafkaContainerHelper.sendOgVentTilKonsumert(
            statistikkSomBurdeVæreMaskert.toJsonKey(),
            statistikkSomBurdeVæreMaskert.toJsonValue(),
            Topic.STATISTIKK_VIRKSOMHET_TOPIC,
        )

        val statistikkQ12023 = hentStatistikkGjeldendeKvartal(
            Kategori.VIRKSOMHET,
            "999999999",
            KVARTAL_2023_1,
        ).sistePubliserteKvartal
        val statistikkSiste4Kvartal =
            hentStatistikkSiste4Kvartal(Kategori.VIRKSOMHET, "999999999", KVARTAL_2023_1).siste4Kvartal

        statistikkQ12023.erMaskert shouldBe true
        statistikkQ12023.antallPersoner shouldBe 4
        statistikkQ12023.prosent shouldBe 0.0
        statistikkQ12023.muligeDagsverk shouldBe 0.0
        statistikkQ12023.tapteDagsverk shouldBe 0.0
        statistikkSiste4Kvartal shouldBe siste4Kvartal
    }

    @Test
    fun `vi maskerer statistikk for siste fire kvartal som eventuelt ikke er maskert i produsent`() {
        val statistikkSomBurdeVæreMaskert = JsonMelding(
            kategori = Kategori.VIRKSOMHET,
            kode = "999999999",
            kvartal = KVARTAL_2023_1,
            siste4Kvartal = Siste4Kvartal(
                tapteDagsverk = 17.5,
                muligeDagsverk = 761.3,
                prosent = 2.3,
                erMaskert = true, // her stoler vi på at `maskert` er riktig siden vi ikke har antallPersoner for siste4kvartal
                kvartaler = siste4Kvartal.kvartaler,
            ),
            sistePubliserteKvartal = sistePubliserteKvartal,
        )

        kafkaContainerHelper.sendOgVentTilKonsumert(
            statistikkSomBurdeVæreMaskert.toJsonKey(),
            statistikkSomBurdeVæreMaskert.toJsonValue(),
            Topic.STATISTIKK_VIRKSOMHET_TOPIC,
        )

        val statistikkSiste4Kvartal =
            hentStatistikkSiste4Kvartal(Kategori.VIRKSOMHET, "999999999", KVARTAL_2023_1).siste4Kvartal

        statistikkSiste4Kvartal.tapteDagsverk shouldBe 0.0
        statistikkSiste4Kvartal.muligeDagsverk shouldBe 0.0
        statistikkSiste4Kvartal.prosent shouldBe 0.0
        statistikkSiste4Kvartal.erMaskert shouldBe true
    }

    @Test
    fun `hent ut virksomheter hvor sykefraværsprosent er lik NULL i kafkamelding`() {
        val virksomhet = VirksomhetHelper.lastInnNyVirksomhet(
            nyVirksomhet = TestVirksomhet.nyVirksomhet(
                orgnr = "99999999",
            ),
            perioder = gjeldendePeriode.forrigePeriode().lagPerioder(4),
        )

        val statistikkSomBurdeVæreMaskert = JsonMelding(
            kategori = Kategori.VIRKSOMHET,
            kode = virksomhet.orgnr,
            kvartal = gjeldendePeriode.tilKvartal(),
            sistePubliserteKvartal = sistePubliserteKvartal_gjeldende_periode,
            siste4Kvartal = Siste4Kvartal(
                tapteDagsverk = null,
                muligeDagsverk = null,
                prosent = null,
                erMaskert = true,
                kvartaler = siste4Kvartal_gjeldende_periode.kvartaler,
            ),
        )
        kafkaContainerHelper.sendOgVentTilKonsumert(
            statistikkSomBurdeVæreMaskert.toJsonKey(),
            statistikkSomBurdeVæreMaskert.toJsonValue(),
            Topic.STATISTIKK_VIRKSOMHET_TOPIC,
        )
        postgresContainerHelper.performUpdate("REFRESH MATERIALIZED VIEW virksomhetsstatistikk_for_prioritering")

        val listeAvVirksomheter = hentSykefraværForAlleVirksomheterMedFilter(
            ansatteFra = "0",
            sykefraværsprosentFra = "0.00",
        )

        listeAvVirksomheter.filter { it.orgnr == virksomhet.orgnr } shouldHaveSize 1
    }

    @Test
    fun `kan importere statistikk for flere kvartal for VIRKSOMHET`() {
        kafkaContainerHelper.sendOgVentTilKonsumert(
            eksport_Forrige_Kvartal_For_Virksomhet.toJsonKey(),
            eksport_Forrige_Kvartal_For_Virksomhet.toJsonValue(),
            Topic.STATISTIKK_VIRKSOMHET_TOPIC,
        )
        kafkaContainerHelper.sendOgVentTilKonsumert(
            eksport_Siste_Kvartal_For_Virksomhet.toJsonKey(),
            eksport_Siste_Kvartal_For_Virksomhet.toJsonValue(),
            Topic.STATISTIKK_VIRKSOMHET_TOPIC,
        )

        val statistikkGjeldendePeriode = hentStatistikkGjeldendeKvartal(
            Kategori.VIRKSOMHET,
            "999999999",
            gjeldendePeriode.tilKvartal(),
        ).sistePubliserteKvartal
        val statistikkForrigePeriode = hentStatistikkGjeldendeKvartal(
            Kategori.VIRKSOMHET,
            "999999999",
            gjeldendePeriode.forrigePeriode().tilKvartal(),
        ).sistePubliserteKvartal
        val statistikkSiste4Kvartal = hentStatistikkSiste4Kvartal(
            Kategori.VIRKSOMHET,
            "999999999",
            gjeldendePeriode.tilKvartal(),
        ).siste4Kvartal
        eksport_Siste_Kvartal_For_Virksomhet sistePubliserteKvartalShouldBeEqual statistikkGjeldendePeriode
        eksport_Forrige_Kvartal_For_Virksomhet sistePubliserteKvartalShouldBeEqual statistikkForrigePeriode
        eksport_Siste_Kvartal_For_Virksomhet siste4KvartalShouldBeEqual statistikkSiste4Kvartal
    }

    @Test
    fun `sykefraværsstatistikk skal oppdateres om det kommer nye versjoner av samme nøkler`() {
        val oppdatertStatistikkSistePubliserteKvartal = sistePubliserteKvartal.copy(
            prosent = 10.0,
            tapteDagsverk = 2000.0,
            muligeDagsverk = 20000.0,
        )
        val oppdatertStatistikkSiste4Kvartal = siste4Kvartal.copy(
            prosent = 5.0,
            tapteDagsverk = 5000.0,
            muligeDagsverk = 100000.0,
        )
        val nyEksport = JsonMelding(
            kategori = Kategori.VIRKSOMHET,
            kode = "999999999",
            kvartal = KVARTAL_2023_1,
            sistePubliserteKvartal = oppdatertStatistikkSistePubliserteKvartal,
            siste4Kvartal = oppdatertStatistikkSiste4Kvartal,
        )
        kafkaContainerHelper.sendOgVentTilKonsumert(
            eksport_Siste_Kvartal_For_Virksomhet.toJsonKey(),
            eksport_Siste_Kvartal_For_Virksomhet.toJsonValue(),
            Topic.STATISTIKK_VIRKSOMHET_TOPIC,
        )
        kafkaContainerHelper.sendOgVentTilKonsumert(
            nyEksport.toJsonKey(),
            nyEksport.toJsonValue(),
            Topic.STATISTIKK_VIRKSOMHET_TOPIC,
        )

        val statistikkQ12023 = hentStatistikkGjeldendeKvartal(
            Kategori.VIRKSOMHET,
            "999999999",
            KVARTAL_2023_1,
        ).sistePubliserteKvartal
        val statistikkSiste4Kvartal =
            hentStatistikkSiste4Kvartal(Kategori.VIRKSOMHET, "999999999", KVARTAL_2023_1).siste4Kvartal
        nyEksport sistePubliserteKvartalShouldBeEqual statistikkQ12023
        nyEksport siste4KvartalShouldBeEqual statistikkSiste4Kvartal
    }

    @Test
    fun `importerte data (på VIRKSOMHET) skal kunne hentes ut og være like`() {
        kafkaContainerHelper.sendOgVentTilKonsumert(
            eksport_Siste_Kvartal_For_Virksomhet.toJsonKey(),
            eksport_Siste_Kvartal_For_Virksomhet.toJsonValue(),
            Topic.STATISTIKK_VIRKSOMHET_TOPIC,
        )

        val sykefraværSiste4Kvartal = hentSykefraværForVirksomhetSiste4Kvartaler("999999999")
        sykefraværSiste4Kvartal.orgnr shouldBe "999999999"
        sykefraværSiste4Kvartal.sykefraværsprosent shouldBe eksport_Siste_Kvartal_For_Virksomhet.value.siste4Kvartal.prosent
        sykefraværSiste4Kvartal.muligeDagsverk shouldBe eksport_Siste_Kvartal_For_Virksomhet.value.siste4Kvartal.muligeDagsverk
        sykefraværSiste4Kvartal.tapteDagsverk shouldBe eksport_Siste_Kvartal_For_Virksomhet.value.siste4Kvartal.tapteDagsverk
        sykefraværSiste4Kvartal.kvartaler shouldBe eksport_Siste_Kvartal_For_Virksomhet.value.siste4Kvartal.kvartaler.toDto()

        val sykefraværSisteKvartal =
            hentSykefraværForVirksomhetSisteTilgjengeligKvartal("999999999")
        sykefraværSisteKvartal.arstall shouldBe eksport_Siste_Kvartal_For_Virksomhet.value.sistePubliserteKvartal.årstall
        sykefraværSisteKvartal.kvartal shouldBe eksport_Siste_Kvartal_For_Virksomhet.value.sistePubliserteKvartal.kvartal
        sykefraværSisteKvartal.antallPersoner shouldBe eksport_Siste_Kvartal_For_Virksomhet.value.sistePubliserteKvartal.antallPersoner
        sykefraværSisteKvartal.sykefraværsprosent shouldBe eksport_Siste_Kvartal_For_Virksomhet.value.sistePubliserteKvartal.prosent
        sykefraværSisteKvartal.muligeDagsverk shouldBe eksport_Siste_Kvartal_For_Virksomhet.value.sistePubliserteKvartal.muligeDagsverk
        sykefraværSisteKvartal.tapteDagsverk shouldBe eksport_Siste_Kvartal_For_Virksomhet.value.sistePubliserteKvartal.tapteDagsverk
        sykefraværSisteKvartal.maskert shouldBe eksport_Siste_Kvartal_For_Virksomhet.value.sistePubliserteKvartal.erMaskert
    }

    @Test
    fun `import av data er idempotent`() {
        kafkaContainerHelper.sendOgVentTilKonsumert(
            eksport_Siste_Kvartal_For_Virksomhet.toJsonKey(),
            eksport_Siste_Kvartal_For_Virksomhet.toJsonValue(),
            Topic.STATISTIKK_VIRKSOMHET_TOPIC,
        )
        val førsteLagredeStatistikkSiste4Kvartal =
            hentSykefraværForVirksomhetSiste4Kvartaler("999999999")
        val førsteLagredeStatistikkSisteKvartal =
            hentSykefraværForVirksomhetSisteTilgjengeligKvartal("999999999")
        kafkaContainerHelper.sendOgVentTilKonsumert(
            eksport_Siste_Kvartal_For_Virksomhet.toJsonKey(),
            eksport_Siste_Kvartal_For_Virksomhet.toJsonValue(),
            Topic.STATISTIKK_VIRKSOMHET_TOPIC,
        )
        val andreLagredeStatistikkSiste4Kvartal =
            hentSykefraværForVirksomhetSiste4Kvartaler("999999999")
        val andreLagredeStatistikkSisteKvartal =
            hentSykefraværForVirksomhetSisteTilgjengeligKvartal("999999999")

        andreLagredeStatistikkSiste4Kvartal.orgnr shouldBe førsteLagredeStatistikkSiste4Kvartal.orgnr
        andreLagredeStatistikkSiste4Kvartal.sykefraværsprosent shouldBe førsteLagredeStatistikkSiste4Kvartal.sykefraværsprosent
        andreLagredeStatistikkSiste4Kvartal.muligeDagsverk shouldBe førsteLagredeStatistikkSiste4Kvartal.muligeDagsverk
        andreLagredeStatistikkSiste4Kvartal.tapteDagsverk shouldBe førsteLagredeStatistikkSiste4Kvartal.tapteDagsverk
        andreLagredeStatistikkSisteKvartal.antallPersoner shouldBe førsteLagredeStatistikkSisteKvartal.antallPersoner
    }

    companion object {
        private val sistePubliserteKvartal_gjeldende_periode: SistePubliserteKvartal =
            SistePubliserteKvartal(
                årstall = gjeldendePeriode.årstall,
                kvartal = gjeldendePeriode.kvartal,
                tapteDagsverk = 1740.5,
                muligeDagsverk = 76139.3,
                prosent = 2.3,
                erMaskert = false,
                antallPersoner = 1789,
            )
        private val sistePubliserteKvartal: SistePubliserteKvartal =
            SistePubliserteKvartal(
                årstall = gjeldendePeriode.årstall,
                kvartal = gjeldendePeriode.kvartal,
                tapteDagsverk = 1740.5,
                muligeDagsverk = 76139.3,
                prosent = 2.3,
                erMaskert = false,
                antallPersoner = 1789,
            )
        private val sistePubliserteKvartal_Forrige_Periode: SistePubliserteKvartal =
            SistePubliserteKvartal(
                årstall = gjeldendePeriode.forrigePeriode().årstall,
                kvartal = gjeldendePeriode.forrigePeriode().kvartal,
                tapteDagsverk = 1820.1,
                muligeDagsverk = 75000.0,
                prosent = 2.4,
                erMaskert = false,
                antallPersoner = 1805,
            )

        private val siste4Kvartal_gjeldende_periode: Siste4Kvartal =
            Siste4Kvartal(
                tapteDagsverk = 8020.0,
                muligeDagsverk = 300991.3,
                prosent = 2.7,
                erMaskert = false,
                kvartaler = gjeldendePeriode.lagPerioder(4).map { it.tilKvartal() },
            )
        private val siste4Kvartal: Siste4Kvartal =
            Siste4Kvartal(
                tapteDagsverk = 8020.0,
                muligeDagsverk = 300991.3,
                prosent = 2.7,
                erMaskert = false,
                kvartaler = gjeldendePeriode.lagPerioder(4).map { it.tilKvartal() },
            )
        private val siste4Kvartal_Forrige_Periode: Siste4Kvartal =
            Siste4Kvartal(
                tapteDagsverk = 7990.1,
                muligeDagsverk = 270221.7,
                prosent = 2.9,
                erMaskert = false,
                kvartaler = gjeldendePeriode.forrigePeriode().lagPerioder(4).map { it.tilKvartal() },
            )

        private val eksport_Forrige_Kvartal_For_Virksomhet = JsonMelding(
            kategori = Kategori.VIRKSOMHET,
            kode = "999999999",
            kvartal = gjeldendePeriode.forrigePeriode().tilKvartal(),
            sistePubliserteKvartal = sistePubliserteKvartal_Forrige_Periode,
            siste4Kvartal = siste4Kvartal_Forrige_Periode,
        )
        private val eksport_Siste_Kvartal_For_Virksomhet = JsonMelding(
            kategori = Kategori.VIRKSOMHET,
            kode = "999999999",
            kvartal = gjeldendePeriode.tilKvartal(),
            sistePubliserteKvartal = sistePubliserteKvartal,
            siste4Kvartal = siste4Kvartal,
        )
    }
}
