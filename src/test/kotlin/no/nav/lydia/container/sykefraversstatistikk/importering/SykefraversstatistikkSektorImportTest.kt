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
import no.nav.lydia.sykefraversstatistikk.import.Kategori.SEKTOR
import no.nav.lydia.sykefraversstatistikk.import.Siste4Kvartal
import no.nav.lydia.sykefraversstatistikk.import.SistePubliserteKvartal
import no.nav.lydia.virksomhet.domene.Sektor
import kotlin.test.BeforeTest
import kotlin.test.Test


class SykefraversstatistikkSektorImportTest {
    private val kafkaContainer = TestContainerHelper.kafkaContainerHelper

    private val sistePubliserteKvartal: SistePubliserteKvartal =
            SistePubliserteKvartal(
                    årstall = KVARTAL_2023_1.årstall,
                    kvartal = KVARTAL_2023_1.kvartal,
                    tapteDagsverk = 5074554.7,
                    muligeDagsverk = 98867111.1,
                    prosent = 5.1,
                    erMaskert = false,
                    antallPersoner = 2063300
            )
    private val siste4Kvartal: Siste4Kvartal =
            Siste4Kvartal(
                    tapteDagsverk = 19200624.2,
                    muligeDagsverk = 388000123.5,
                    prosent = 4.9,
                    erMaskert = false,
                    kvartaler = listOf(KVARTAL_2023_1)
            )

    @BeforeTest
    fun cleanUp() {
        cleanUpStatistikkTable(SEKTOR, Sektor.PRIVAT.kode)
        cleanUpStatistikkSiste4KvartalTable(SEKTOR, Sektor.PRIVAT.kode)
    }

    @Test
    fun `vi lagrer sykefraværsstatistikk for kategori SEKTOR (både siste kvartal OG siste 4 kvartaler)`() {
        val kafkaMelding = JsonMelding(
                kategori = SEKTOR,
                kode = Sektor.PRIVAT.kode,
                kvartal = KVARTAL_2023_1,
                sistePubliserteKvartal = sistePubliserteKvartal,
                siste4Kvartal = siste4Kvartal
        )

        kafkaContainer.sendOgVentTilKonsumert(
                kafkaMelding.toJsonKey(),
                kafkaMelding.toJsonValue(),
                KafkaContainerHelper.statistikkSektorTopic,
                Kafka.statistikkSektorGroupId
        )

        kafkaMelding shouldBeEqual
                hentStatistikkGjeldendeKvartal(
                        SEKTOR,
                        Sektor.PRIVAT.kode,
                        KVARTAL_2023_1
                ).sistePubliserteKvartal
        kafkaMelding shouldBeEqual
                hentStatistikkSiste4Kvartal(SEKTOR, Sektor.PRIVAT.kode).siste4Kvartal
    }
}
