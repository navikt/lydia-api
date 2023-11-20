package no.nav.lydia.container.sykefraværsstatistikk.importering

import io.kotest.inspectors.forAll
import no.nav.lydia.Kafka
import no.nav.lydia.container.sykefraværsstatistikk.importering.SykefraværsstatistikkImportTestUtils.Companion.cleanUpStatistikkSiste4KvartalTable
import no.nav.lydia.container.sykefraværsstatistikk.importering.SykefraværsstatistikkImportTestUtils.Companion.cleanUpStatistikkTable
import no.nav.lydia.container.sykefraværsstatistikk.importering.SykefraværsstatistikkImportTestUtils.Companion.siste4KvartalShouldBeEqual
import no.nav.lydia.container.sykefraværsstatistikk.importering.SykefraværsstatistikkImportTestUtils.Companion.sistePubliserteKvartalShouldBeEqual
import no.nav.lydia.helper.KafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestData
import no.nav.lydia.sykefraværsstatistikk.import.Kategori
import no.nav.lydia.sykefraværsstatistikk.import.Siste4Kvartal
import no.nav.lydia.sykefraværsstatistikk.import.SistePubliserteKvartal
import no.nav.lydia.virksomhet.domene.Sektor
import kotlin.test.BeforeTest
import kotlin.test.Test

class SykefraværsstatistikkKategoriImportTest {
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
            val kafkaMelding = SykefraværsstatistikkImportTestUtils.JsonMelding(
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
                    SykefraværsstatistikkImportTestUtils.hentStatistikkGjeldendeKvartal(
                        kategori,
                        kode,
                        TestData.gjeldendePeriode.tilKvartal()
                    ).sistePubliserteKvartal
            kafkaMelding siste4KvartalShouldBeEqual
                    SykefraværsstatistikkImportTestUtils.hentStatistikkSiste4Kvartal(
                        kategori,
                        kode,
                        TestData.gjeldendePeriode.tilKvartal()
                    ).siste4Kvartal
        }
    }

    @Test
    fun `vi oppdaterer sykefraværsstatistikk for kategorier`() {
        KATEGORIER.forAll { kategori ->
            val kode = kodeForKategori(kategori)
            val førsteKafkaMelding = SykefraværsstatistikkImportTestUtils.JsonMelding(
                kategori = kategori,
                kode = kode,
                kvartal = TestData.gjeldendePeriode.tilKvartal(),
                sistePubliserteKvartal = sistePubliserteKvartal,
                siste4Kvartal = siste4Kvartal
            )

            val oppdatertKafkaMelding = SykefraværsstatistikkImportTestUtils.JsonMelding(
                kategori = kategori,
                kode = kode,
                kvartal = TestData.gjeldendePeriode.tilKvartal(),
                sistePubliserteKvartal = sistePubliserteKvartal.copy(
                    prosent = 15.0,
                    antallPersoner = 4000001,
                    tapteDagsverk = 604339.8,
                    muligeDagsverk = 20104849.1
                ),
                siste4Kvartal = siste4Kvartal.copy(
                    prosent = 15.0,
                    tapteDagsverk = 41505774.2,
                    muligeDagsverk = 678099000.3
                )
            )

            kafkaContainerHelper.sendOgVentTilKonsumert(
                førsteKafkaMelding.toJsonKey(),
                førsteKafkaMelding.toJsonValue(),
                topicForKategori(kategori),
                groupIdForKategori(kategori)
            )

            kafkaContainerHelper.sendOgVentTilKonsumert(
                oppdatertKafkaMelding.toJsonKey(),
                oppdatertKafkaMelding.toJsonValue(),
                topicForKategori(kategori),
                groupIdForKategori(kategori)
            )

            oppdatertKafkaMelding sistePubliserteKvartalShouldBeEqual
                    SykefraværsstatistikkImportTestUtils.hentStatistikkGjeldendeKvartal(
                        kategori,
                        kode,
                        TestData.gjeldendePeriode.tilKvartal()
                    ).sistePubliserteKvartal
            oppdatertKafkaMelding siste4KvartalShouldBeEqual
                    SykefraværsstatistikkImportTestUtils.hentStatistikkSiste4Kvartal(
                        kategori,
                        kode,
                        TestData.gjeldendePeriode.tilKvartal()
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
            årstall = SykefraværsstatistikkImportTestUtils.KVARTAL_2023_1.årstall,
            kvartal = SykefraværsstatistikkImportTestUtils.KVARTAL_2023_1.kvartal,
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
            kvartaler = listOf(SykefraværsstatistikkImportTestUtils.KVARTAL_2023_1)
        )
}
