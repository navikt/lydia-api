package no.nav.lydia.container.sykefraversstatistikk.importering

import no.nav.lydia.Kafka
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.KVARTAL_2023_1
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.cleanUpStatistikkSiste4KvartalTable
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.cleanUpStatistikkTable
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.hentStatistikkGjeldendeKvartal
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.hentStatistikkSiste4Kvartal
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.shouldBeEqual
import no.nav.lydia.helper.KafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.sykefraversstatistikk.import.Kategori.VIRKSOMHET
import no.nav.lydia.sykefraversstatistikk.import.Siste4Kvartal
import no.nav.lydia.sykefraversstatistikk.import.SistePubliserteKvartal
import kotlin.test.BeforeTest
import kotlin.test.Test


class SykefraversstatistikkVirksomhetImportTest {
    private val kafkaContainer = TestContainerHelper.kafkaContainerHelper

    private val sistePubliserteKvartal: SistePubliserteKvartal =
            SistePubliserteKvartal(
                    årstall = KVARTAL_2023_1.årstall,
                    kvartal = KVARTAL_2023_1.kvartal,
                    tapteDagsverk = 1740.5,
                    muligeDagsverk = 76139.3,
                    prosent = 2.3,
                    erMaskert = false,
                    antallPersoner = 1789
            )
    private val siste4Kvartal: Siste4Kvartal =
            Siste4Kvartal(
                    tapteDagsverk = 8020.0,
                    muligeDagsverk = 300991.3,
                    prosent = 2.7,
                    erMaskert = false,
                    kvartaler = listOf(KVARTAL_2023_1)
            )

    @BeforeTest
    fun cleanUp() {
        cleanUpStatistikkTable(VIRKSOMHET, "999999999")
        cleanUpStatistikkSiste4KvartalTable(VIRKSOMHET, "999999999")
    }

    @Test
    fun `vi lagrer sykefraværsstatistikk for kategori VIRKSOMHET (både siste kvartal OG siste 4 kvartaler)`() {
        val kafkaMelding = SykefraversstatistikkImportTestUtils.JsonMelding(
                kategori = VIRKSOMHET,
                kode = "999999999",
                kvartal = KVARTAL_2023_1,
                sistePubliserteKvartal = sistePubliserteKvartal,
                siste4Kvartal = siste4Kvartal
        )

        kafkaContainer.sendOgVentTilKonsumert(
                kafkaMelding.toJsonKey(),
                kafkaMelding.toJsonValue(),
                KafkaContainerHelper.statistikkVirksomhetTopic,
                Kafka.statistikkVirksomhetGroupId
        )

        kafkaMelding shouldBeEqual
                hentStatistikkGjeldendeKvartal(
                        VIRKSOMHET,
                        "999999999",
                        KVARTAL_2023_1
                ).sistePubliserteKvartal
        kafkaMelding shouldBeEqual
                hentStatistikkSiste4Kvartal(VIRKSOMHET, "999999999").siste4Kvartal
    }
}
