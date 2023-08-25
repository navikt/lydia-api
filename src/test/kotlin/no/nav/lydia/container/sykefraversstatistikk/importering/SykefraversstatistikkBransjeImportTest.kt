package no.nav.lydia.container.sykefraversstatistikk.importering

import no.nav.lydia.Kafka
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.KVARTAL_2023_1
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.cleanUpStatistikkSiste4KvartalTable
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.cleanUpStatistikkTable
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.hentStatistikkGjeldendeKvartal
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.hentStatistikkSiste4Kvartal
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.shouldBeEqual
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.JsonMelding
import no.nav.lydia.helper.KafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestData
import no.nav.lydia.sykefraversstatistikk.import.Kategori.BRANSJE
import no.nav.lydia.sykefraversstatistikk.import.Siste4Kvartal
import no.nav.lydia.sykefraversstatistikk.import.SistePubliserteKvartal
import kotlin.test.BeforeTest
import kotlin.test.Test


class SykefraversstatistikkBransjeImportTest {
    private val kafkaContainer = TestContainerHelper.kafkaContainerHelper

    private val sistePubliserteKvartal: SistePubliserteKvartal =
        SistePubliserteKvartal(
            årstall = KVARTAL_2023_1.årstall,
            kvartal = KVARTAL_2023_1.kvartal,
            tapteDagsverk = 504339.8,
            muligeDagsverk = 10104849.1,
            prosent = 6.0,
            erMaskert = false,
            antallPersoner = 3000001
        )
    private val siste4Kvartal: Siste4Kvartal =
        Siste4Kvartal(
            tapteDagsverk = 31505774.2,
            muligeDagsverk = 578099000.3,
            prosent = 5.4,
            erMaskert = false,
            kvartaler = listOf(KVARTAL_2023_1)
        )

    @BeforeTest
    fun cleanUp() {
        cleanUpStatistikkTable(BRANSJE, TestData.BRANSJE_BARNEHAGE)
        cleanUpStatistikkSiste4KvartalTable(BRANSJE, TestData.BRANSJE_BARNEHAGE)
    }

    @Test
    fun `kan lagre bransje med langt bransjenavn`() {
        val kafkaMelding = JsonMelding(
            kategori = BRANSJE,
            kode = TestData.BRANSJE_NÆRINGSMIDDELINDUSTRI,
            kvartal = KVARTAL_2023_1,
            sistePubliserteKvartal = sistePubliserteKvartal,
            siste4Kvartal = siste4Kvartal
        )

        kafkaContainer.sendOgVentTilKonsumert(
            nøkkel = kafkaMelding.toJsonKey(),
            melding = kafkaMelding.toJsonValue(),
            topic = KafkaContainerHelper.statistikkBransjeTopic,
            konsumentGruppeId = Kafka.statistikkBransjeGroupId
        )

        kafkaMelding shouldBeEqual
                hentStatistikkGjeldendeKvartal(
                    BRANSJE,
                    TestData.BRANSJE_NÆRINGSMIDDELINDUSTRI,
                    KVARTAL_2023_1
                ).sistePubliserteKvartal
        kafkaMelding shouldBeEqual
                hentStatistikkSiste4Kvartal(BRANSJE, TestData.BRANSJE_NÆRINGSMIDDELINDUSTRI).siste4Kvartal
    }

    @Test
    fun `vi lagrer sykefraværsstatistikk for kategori BRANSJE (både siste kvartal OG siste 4 kvartaler)`() {
        val kafkaMelding = JsonMelding(
            kategori = BRANSJE,
            kode = TestData.BRANSJE_BARNEHAGE,
            kvartal = KVARTAL_2023_1,
            sistePubliserteKvartal = sistePubliserteKvartal,
            siste4Kvartal = siste4Kvartal
        )

        kafkaContainer.sendOgVentTilKonsumert(
            nøkkel = kafkaMelding.toJsonKey(),
            melding = kafkaMelding.toJsonValue(),
            topic = KafkaContainerHelper.statistikkBransjeTopic,
            konsumentGruppeId = Kafka.statistikkBransjeGroupId
        )

        kafkaMelding shouldBeEqual
                hentStatistikkGjeldendeKvartal(
                    BRANSJE,
                    TestData.BRANSJE_BARNEHAGE,
                    KVARTAL_2023_1
                ).sistePubliserteKvartal
        kafkaMelding shouldBeEqual
                hentStatistikkSiste4Kvartal(BRANSJE, TestData.BRANSJE_BARNEHAGE).siste4Kvartal
    }
}
