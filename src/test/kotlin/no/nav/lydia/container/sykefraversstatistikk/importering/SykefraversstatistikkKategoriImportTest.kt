package no.nav.lydia.container.sykefraversstatistikk.importering

import io.kotest.inspectors.forAll
import no.nav.lydia.Kafka
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.cleanUpStatistikkSiste4KvartalTable
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.cleanUpStatistikkTable
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.siste4KvartalShouldBeEqual
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.sistePubliserteKvartalShouldBeEqual
import no.nav.lydia.helper.KafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestData
import no.nav.lydia.sykefraversstatistikk.import.Kategori
import no.nav.lydia.sykefraversstatistikk.import.Siste4Kvartal
import no.nav.lydia.sykefraversstatistikk.import.SistePubliserteKvartal
import no.nav.lydia.virksomhet.domene.Sektor
import kotlin.test.BeforeTest
import kotlin.test.Test

class SykefraversstatistikkKategoriImportTest {
    val KATEGORIER = Kategori.entries.filter { it != Kategori.VIRKSOMHET }

    @BeforeTest
    fun cleanUp() {
        KATEGORIER.forEach {
            cleanUpStatistikkTable(kategori = it)
            cleanUpStatistikkSiste4KvartalTable(kategori = it)
        }
    }

    @Test
    fun `vi lagrer sykefraværsstatistikk for kategori (både siste kvartal OG siste 4 kvartaler)`() {
        KATEGORIER.forAll { kategori ->
            val kode = kodeForKategori(kategori)
            val kafkaMelding = SykefraversstatistikkImportTestUtils.JsonMelding(
                kategori = kategori,
                kode = kode,
                kvartal = TestData.gjeldendePeriode.tilKvartal(),
                sistePubliserteKvartal = sistePubliserteKvartal,
                siste4Kvartal = siste4Kvartal
            )

            kafkaContainerHelper.sendOgVentTilKonsumert(
                kafkaMelding.toJsonKey(),
                kafkaMelding.toJsonValue(),
                topicForKategori(kategori),
                groupIdForKategori(kategori)
            )

            kafkaMelding sistePubliserteKvartalShouldBeEqual
                    SykefraversstatistikkImportTestUtils.hentStatistikkGjeldendeKvartal(
                        kategori,
                        kode,
                        TestData.gjeldendePeriode.tilKvartal()
                    ).sistePubliserteKvartal
            kafkaMelding siste4KvartalShouldBeEqual
                    SykefraversstatistikkImportTestUtils.hentStatistikkSiste4Kvartal(
                        kategori,
                        kode
                    ).siste4Kvartal
        }
    }

    private fun kodeForKategori(kategori: Kategori) = when(kategori) {
        Kategori.NÆRING -> TestData.NÆRING_JORDBRUK
        Kategori.NÆRINGSKODE -> TestData.NÆRINGSKODE_BARNEHAGER
        Kategori.LAND -> "NO"
        Kategori.SEKTOR -> Sektor.PRIVAT.kode
        Kategori.BRANSJE -> TestData.BRANSJE_BARNEHAGE
        else -> error("Kategori $kategori støttes ikke i testen")
    }
    private fun topicForKategori(kategori: Kategori) = kafkaConfigForKategori(kategori).first
    private fun groupIdForKategori(kategori: Kategori) = kafkaConfigForKategori(kategori).second
    private fun kafkaConfigForKategori(kategori: Kategori) = when(kategori) {
        Kategori.NÆRING -> KafkaContainerHelper.statistikkNæringTopic to Kafka.statistikkNæringGroupId
        Kategori.NÆRINGSKODE -> KafkaContainerHelper.statistikkNæringskodeTopic to Kafka.statistikkNæringskodeGroupId
        Kategori.LAND -> KafkaContainerHelper.statistikkLandTopic to Kafka.statistikkLandGroupId
        Kategori.SEKTOR -> KafkaContainerHelper.statistikkSektorTopic to Kafka.statistikkSektorGroupId
        Kategori.BRANSJE -> KafkaContainerHelper.statistikkBransjeTopic to Kafka.statistikkBransjeGroupId
        else -> error("Kategori $kategori støttes ikke i testen")
    }

    private val sistePubliserteKvartal: SistePubliserteKvartal =
        SistePubliserteKvartal(
            årstall = SykefraversstatistikkImportTestUtils.KVARTAL_2023_1.årstall,
            kvartal = SykefraversstatistikkImportTestUtils.KVARTAL_2023_1.kvartal,
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
            kvartaler = listOf(SykefraversstatistikkImportTestUtils.KVARTAL_2023_1)
        )
}