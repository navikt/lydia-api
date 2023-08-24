package no.nav.lydia.container.sykefraversstatistikk.importering

import io.kotest.matchers.shouldBe
import no.nav.lydia.Kafka
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.KVARTAL_2022_1
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.KVARTAL_2022_2
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.KVARTAL_2022_3
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.KVARTAL_2022_4
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.KVARTAL_2023_1
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.hentStatistikkGjeldendeKvartal
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.hentStatistikkSiste4Kvartal
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.shouldBeEqual
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.JsonMelding
import no.nav.lydia.helper.KafkaContainerHelper
import no.nav.lydia.helper.StatistikkHelper.Companion.hentSykefraværForVirksomhetSiste4Kvartaler
import no.nav.lydia.helper.StatistikkHelper.Companion.hentSykefraværForVirksomhetSisteTilgjengeligKvartal
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.lydiaApiContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldNotContainLog
import no.nav.lydia.sykefraversstatistikk.api.KvartalDto.Companion.toDto
import no.nav.lydia.sykefraversstatistikk.import.Kategori
import no.nav.lydia.sykefraversstatistikk.import.Siste4Kvartal
import no.nav.lydia.sykefraversstatistikk.import.SistePubliserteKvartal
import kotlin.test.BeforeTest
import kotlin.test.Test

/**
 * Tester som verifiserer felles use-cases i import av sykefraværsstatistikk
 *  - håndterer feil formatert meldinger
 *  - kan importere statistikk for flere kvartal
 *  - sykefraværsstatistikk skal oppdateres om det kommer nye versjoner av samme nøkler
 *  - importerte data skal kunne hentes ut og være like
 */

class SykefraversstatistikkImportTest {
    private val kafkaContainer = TestContainerHelper.kafkaContainerHelper

    @BeforeTest
    fun cleanUp() {
        SykefraversstatistikkImportTestUtils.cleanUpStatistikkTable(Kategori.VIRKSOMHET, "999999999")
        SykefraversstatistikkImportTestUtils.cleanUpStatistikkSiste4KvartalTable(Kategori.VIRKSOMHET, "999999999")
    }

    @Test
    fun `håndterer feil formatert meldinger`() {
        kafkaContainer.sendOgVentTilKonsumert(
                """
                {
                  "kategori": "UKJENT_KATEGORI",
                  "kode": "22",
                  "kvartal": ${KVARTAL_2023_1.kvartal},
                  "årstall": ${KVARTAL_2023_1.årstall}
                }""".trimIndent(),
                eksport_Q4_2022_For_Virksomhet.toJsonValue(),
                KafkaContainerHelper.statistikkVirksomhetTopic,
                Kafka.statistikkVirksomhetGroupId
        )

        lydiaApiContainer shouldNotContainLog "NullPointerException.*".toRegex()
        lydiaApiContainer shouldContainLog "Feil formatert Kafka melding i topic ${KafkaContainerHelper.statistikkVirksomhetTopic}".toRegex()
    }

    @Test
    fun `vi maskerer statistikk som eventuelt ikke er maskert i produsent`() {
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
                        antallPersoner = 4
                ),
                siste4Kvartal = siste4Kvartal_fra_Q1_2023
        )

        kafkaContainer.sendOgVentTilKonsumert(
                statistikkSomBurdeVæreMaskert.toJsonKey(),
                statistikkSomBurdeVæreMaskert.toJsonValue(),
                KafkaContainerHelper.statistikkVirksomhetTopic,
                Kafka.statistikkVirksomhetGroupId
        )

        val statistikk_Q1_2023 = hentStatistikkGjeldendeKvartal(
                Kategori.VIRKSOMHET,
                "999999999",
                KVARTAL_2023_1
        ).sistePubliserteKvartal
        val statistikkSiste4Kvartal = hentStatistikkSiste4Kvartal(Kategori.VIRKSOMHET, "999999999").siste4Kvartal

        statistikk_Q1_2023.erMaskert shouldBe true
        statistikk_Q1_2023.antallPersoner shouldBe 4
        statistikk_Q1_2023.prosent shouldBe 0.0
        statistikk_Q1_2023.muligeDagsverk shouldBe 0.0
        statistikk_Q1_2023.tapteDagsverk shouldBe 0.0
        statistikkSiste4Kvartal shouldBe siste4Kvartal_fra_Q1_2023
    }

    @Test
    fun `kan importere statistikk for flere kvartal for VIRKSOMHET`() {
        kafkaContainer.sendOgVentTilKonsumert(
                eksport_Q4_2022_For_Virksomhet.toJsonKey(),
                eksport_Q4_2022_For_Virksomhet.toJsonValue(),
                KafkaContainerHelper.statistikkVirksomhetTopic,
                Kafka.statistikkVirksomhetGroupId
        )
        kafkaContainer.sendOgVentTilKonsumert(
                eksport_Q1_2023_For_Virksomhet.toJsonKey(),
                eksport_Q1_2023_For_Virksomhet.toJsonValue(),
                KafkaContainerHelper.statistikkVirksomhetTopic,
                Kafka.statistikkVirksomhetGroupId
        )


        val statistikk_Q1_2023 = hentStatistikkGjeldendeKvartal(
                Kategori.VIRKSOMHET,
                "999999999",
                KVARTAL_2023_1
        ).sistePubliserteKvartal
        val statistikk_Q4_2022 = hentStatistikkGjeldendeKvartal(
                Kategori.VIRKSOMHET,
                "999999999",
                KVARTAL_2022_4
        ).sistePubliserteKvartal
        val statistikkSiste4Kvartal = hentStatistikkSiste4Kvartal(Kategori.VIRKSOMHET, "999999999").siste4Kvartal
        eksport_Q1_2023_For_Virksomhet shouldBeEqual statistikk_Q1_2023
        eksport_Q4_2022_For_Virksomhet shouldBeEqual statistikk_Q4_2022
        eksport_Q1_2023_For_Virksomhet shouldBeEqual statistikkSiste4Kvartal
    }

    @Test
    fun `sykefraværsstatistikk skal oppdateres om det kommer nye versjoner av samme nøkler`() {
        val oppdatertStatistikkSistePubliserteKvartal = sistePubliserteKvartal_Q1_2023.copy(
                prosent = 10.0,
                tapteDagsverk = 2000.0,
                muligeDagsverk = 20000.0,
        )
        val oppdatertStatistikkSiste4Kvartal = siste4Kvartal_fra_Q1_2023.copy(
                prosent = 5.0,
                tapteDagsverk = 5000.0,
                muligeDagsverk = 100000.0,
        )
        val nyEksport = JsonMelding(
                kategori = Kategori.VIRKSOMHET,
                kode = "999999999",
                kvartal = KVARTAL_2023_1,
                sistePubliserteKvartal = oppdatertStatistikkSistePubliserteKvartal,
                siste4Kvartal = oppdatertStatistikkSiste4Kvartal
        )
        kafkaContainer.sendOgVentTilKonsumert(
                eksport_Q1_2023_For_Virksomhet.toJsonKey(),
                eksport_Q1_2023_For_Virksomhet.toJsonValue(),
                KafkaContainerHelper.statistikkVirksomhetTopic,
                Kafka.statistikkVirksomhetGroupId
        )
        kafkaContainer.sendOgVentTilKonsumert(
                nyEksport.toJsonKey(),
                nyEksport.toJsonValue(),
                KafkaContainerHelper.statistikkVirksomhetTopic,
                Kafka.statistikkVirksomhetGroupId
        )

        val statistikk_Q1_2023 = hentStatistikkGjeldendeKvartal(
                Kategori.VIRKSOMHET,
                "999999999",
                KVARTAL_2023_1
        ).sistePubliserteKvartal
        val statistikkSiste4Kvartal = hentStatistikkSiste4Kvartal(Kategori.VIRKSOMHET, "999999999").siste4Kvartal
        nyEksport shouldBeEqual statistikk_Q1_2023
        nyEksport shouldBeEqual statistikkSiste4Kvartal
    }

    @Test
    fun `importerte data (på VIRKSOMHET) skal kunne hentes ut og være like`() {
        kafkaContainer.sendOgVentTilKonsumert(
                eksport_Q1_2023_For_Virksomhet.toJsonKey(),
                eksport_Q1_2023_For_Virksomhet.toJsonValue(),
                KafkaContainerHelper.statistikkVirksomhetTopic,
                Kafka.statistikkVirksomhetGroupId
        )

        val sykefraværSiste4Kvartal = hentSykefraværForVirksomhetSiste4Kvartaler("999999999")
        sykefraværSiste4Kvartal.orgnr shouldBe "999999999"
        sykefraværSiste4Kvartal.sykefraversprosent shouldBe eksport_Q1_2023_For_Virksomhet.value.siste4Kvartal.prosent
        sykefraværSiste4Kvartal.muligeDagsverk shouldBe eksport_Q1_2023_For_Virksomhet.value.siste4Kvartal.muligeDagsverk
        sykefraværSiste4Kvartal.tapteDagsverk shouldBe eksport_Q1_2023_For_Virksomhet.value.siste4Kvartal.tapteDagsverk
        sykefraværSiste4Kvartal.kvartaler shouldBe eksport_Q1_2023_For_Virksomhet.value.siste4Kvartal.kvartaler.toDto()

        val sykefraværSisteKvartal =
                hentSykefraværForVirksomhetSisteTilgjengeligKvartal("999999999")
        sykefraværSisteKvartal.arstall shouldBe eksport_Q1_2023_For_Virksomhet.value.sistePubliserteKvartal.årstall
        sykefraværSisteKvartal.kvartal shouldBe eksport_Q1_2023_For_Virksomhet.value.sistePubliserteKvartal.kvartal
        sykefraværSisteKvartal.antallPersoner shouldBe eksport_Q1_2023_For_Virksomhet.value.sistePubliserteKvartal.antallPersoner
        sykefraværSisteKvartal.sykefraversprosent shouldBe eksport_Q1_2023_For_Virksomhet.value.sistePubliserteKvartal.prosent
        sykefraværSisteKvartal.muligeDagsverk shouldBe eksport_Q1_2023_For_Virksomhet.value.sistePubliserteKvartal.muligeDagsverk
        sykefraværSisteKvartal.tapteDagsverk shouldBe eksport_Q1_2023_For_Virksomhet.value.sistePubliserteKvartal.tapteDagsverk
        sykefraværSisteKvartal.maskert shouldBe eksport_Q1_2023_For_Virksomhet.value.sistePubliserteKvartal.erMaskert
    }

    @Test
    fun `import av data er idempotent`() {
        kafkaContainer.sendOgVentTilKonsumert(
                eksport_Q1_2023_For_Virksomhet.toJsonKey(),
                eksport_Q1_2023_For_Virksomhet.toJsonValue(),
                KafkaContainerHelper.statistikkVirksomhetTopic,
                Kafka.statistikkVirksomhetGroupId
        )
        val førsteLagredeStatistikkSiste4Kvartal =
                hentSykefraværForVirksomhetSiste4Kvartaler("999999999")
        val førsteLagredeStatistikkSisteKvartal =
                hentSykefraværForVirksomhetSisteTilgjengeligKvartal("999999999")
        kafkaContainer.sendOgVentTilKonsumert(
                eksport_Q1_2023_For_Virksomhet.toJsonKey(),
                eksport_Q1_2023_For_Virksomhet.toJsonValue(),
                KafkaContainerHelper.statistikkVirksomhetTopic,
                Kafka.statistikkVirksomhetGroupId
        )
        val andreLagredeStatistikkSiste4Kvartal =
                hentSykefraværForVirksomhetSiste4Kvartaler("999999999")
        val andreLagredeStatistikkSisteKvartal =
                hentSykefraværForVirksomhetSisteTilgjengeligKvartal("999999999")

        andreLagredeStatistikkSiste4Kvartal.orgnr shouldBe førsteLagredeStatistikkSiste4Kvartal.orgnr
        andreLagredeStatistikkSiste4Kvartal.sykefraversprosent shouldBe førsteLagredeStatistikkSiste4Kvartal.sykefraversprosent
        andreLagredeStatistikkSiste4Kvartal.muligeDagsverk shouldBe førsteLagredeStatistikkSiste4Kvartal.muligeDagsverk
        andreLagredeStatistikkSiste4Kvartal.tapteDagsverk shouldBe førsteLagredeStatistikkSiste4Kvartal.tapteDagsverk
        andreLagredeStatistikkSisteKvartal.antallPersoner shouldBe førsteLagredeStatistikkSisteKvartal.antallPersoner
    }

    companion object {
        private val sistePubliserteKvartal_Q1_2023: SistePubliserteKvartal =
                SistePubliserteKvartal(
                        årstall = KVARTAL_2023_1.årstall,
                        kvartal = KVARTAL_2023_1.kvartal,
                        tapteDagsverk = 1740.5,
                        muligeDagsverk = 76139.3,
                        prosent = 2.3,
                        erMaskert = false,
                        antallPersoner = 1789
                )
        private val sistePubliserteKvartal_Q4_2022: SistePubliserteKvartal =
                SistePubliserteKvartal(
                        årstall = KVARTAL_2022_4.årstall,
                        kvartal = KVARTAL_2022_4.kvartal,
                        tapteDagsverk = 1820.1,
                        muligeDagsverk = 75000.0,
                        prosent = 2.4,
                        erMaskert = false,
                        antallPersoner = 1805
                )

        private val siste4Kvartal_fra_Q1_2023: Siste4Kvartal =
                Siste4Kvartal(
                        tapteDagsverk = 8020.0,
                        muligeDagsverk = 300991.3,
                        prosent = 2.7,
                        erMaskert = false,
                        kvartaler = listOf(KVARTAL_2023_1, KVARTAL_2022_4, KVARTAL_2022_3, KVARTAL_2022_2)
                )
        private val siste4Kvartal_fra_Q4_2022: Siste4Kvartal =
                Siste4Kvartal(
                        tapteDagsverk = 7990.1,
                        muligeDagsverk = 270221.7,
                        prosent = 2.9,
                        erMaskert = false,
                        kvartaler = listOf(KVARTAL_2022_4, KVARTAL_2022_3, KVARTAL_2022_2, KVARTAL_2022_1)
                )

        private val eksport_Q4_2022_For_Virksomhet = JsonMelding(
                kategori = Kategori.VIRKSOMHET,
                kode = "999999999",
                kvartal = KVARTAL_2022_4,
                sistePubliserteKvartal = sistePubliserteKvartal_Q4_2022,
                siste4Kvartal = siste4Kvartal_fra_Q4_2022
        )
        private val eksport_Q1_2023_For_Virksomhet = JsonMelding(
                kategori = Kategori.VIRKSOMHET,
                kode = "999999999",
                kvartal = KVARTAL_2023_1,
                sistePubliserteKvartal = sistePubliserteKvartal_Q1_2023,
                siste4Kvartal = siste4Kvartal_fra_Q1_2023
        )
    }
}
