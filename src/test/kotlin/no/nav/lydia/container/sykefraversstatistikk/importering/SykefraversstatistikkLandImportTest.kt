package no.nav.lydia.container.sykefraversstatistikk.importering

import no.nav.lydia.Kafka
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.KVARTAL_2022_2
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.KVARTAL_2022_3
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.KVARTAL_2022_4
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.KVARTAL_2023_1
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.cleanUpStatistikkSiste4KvartalTable
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.cleanUpStatistikkTable
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.hentStatistikkGjeldendeKvartal
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.hentStatistikkSiste4Kvartal
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.shouldBeEqual
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.JsonMelding
import no.nav.lydia.helper.KafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.sykefraversstatistikk.import.Kategori.LAND
import no.nav.lydia.sykefraversstatistikk.import.Siste4Kvartal
import no.nav.lydia.sykefraversstatistikk.import.SistePubliserteKvartal
import kotlin.test.BeforeTest
import kotlin.test.Test


class SykefraversstatistikkLandImportTest {
    private val kafkaContainer = TestContainerHelper.kafkaContainerHelper

    private val sistePubliserteKvartal: SistePubliserteKvartal =
            SistePubliserteKvartal(
                    årstall = KVARTAL_2023_1.årstall,
                    kvartal = KVARTAL_2023_1.kvartal,
                    tapteDagsverk = 9000000.6,
                    muligeDagsverk = 150000000.9,
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
                    kvartaler = listOf(KVARTAL_2023_1, KVARTAL_2022_4, KVARTAL_2022_3, KVARTAL_2022_2)
            )

    @BeforeTest
    fun cleanUp() {
        cleanUpStatistikkTable(LAND, "NO")
        cleanUpStatistikkSiste4KvartalTable(LAND, "NO")
    }

    @Test
    fun `vi lagrer sykefraværsstatistikk for kategori LAND (både siste kvartal OG siste 4 kvartaler)`() {
        val kafkaMelding = JsonMelding(
                kategori = LAND,
                kode = "NO",
                kvartal = KVARTAL_2023_1,
                sistePubliserteKvartal = sistePubliserteKvartal,
                siste4Kvartal = siste4Kvartal
        )

        kafkaContainer.sendOgVentTilKonsumert(
                kafkaMelding.toJsonKey(),
                kafkaMelding.toJsonValue(),
                KafkaContainerHelper.statistikkLandTopic,
                Kafka.statistikkLandGroupId
        )

        kafkaMelding shouldBeEqual
                hentStatistikkGjeldendeKvartal(
                        LAND,
                        "NO",
                        KVARTAL_2023_1
                ).sistePubliserteKvartal
        kafkaMelding shouldBeEqual
                hentStatistikkSiste4Kvartal(LAND, "NO").siste4Kvartal
    }
}
