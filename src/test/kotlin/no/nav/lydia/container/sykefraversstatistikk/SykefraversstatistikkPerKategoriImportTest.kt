package no.nav.lydia.container.sykefraversstatistikk

import io.kotest.assertions.json.shouldEqualJson
import io.kotest.matchers.comparables.shouldBeGreaterThan
import io.kotest.matchers.shouldBe
import no.nav.lydia.Kafka
import no.nav.lydia.helper.KafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
import no.nav.lydia.helper.TestData.Companion.NÆRING_JORDBRUK
import no.nav.lydia.sykefraversstatistikk.import.Kategori
import no.nav.lydia.sykefraversstatistikk.import.Kategori.*
import java.sql.Timestamp
import kotlin.test.Test

class SykefraversstatistikkPerKategoriImportTest {
    private val kafkaContainer = TestContainerHelper.kafkaContainerHelper

    @Test
    fun `vi lagrer sykefraværsstatistikk for virksomhet siste 4 kvartaler`() {
        kafkaContainer.sendOgVentTilKonsumert(
            jsonKey(VIRKSOMHET, "999999999"),
            jsonValue(VIRKSOMHET, "999999999"),
            KafkaContainerHelper.statistikkVirksomhetTopic,
            Kafka.statistikkPerKategoriGroupId)

        postgresContainer.hentEnkelKolonne<String>(sql =
            """
                select orgnr from sykefravar_statistikk_virksomhet_siste_4_kvartal
                where orgnr = '999999999'
            """.trimIndent()
        ) shouldBe "999999999"

        postgresContainer.hentEnkelKolonne<String>(sql =
            """
                select kvartaler::text from sykefravar_statistikk_virksomhet_siste_4_kvartal
                where orgnr = '999999999'
            """.trimIndent()
        ) shouldEqualJson """[
            {
              "årstall": 2021,
              "kvartal": 2
            },
            {
              "årstall": 2021,
              "kvartal": 3
            },
            {
              "årstall": 2021,
              "kvartal": 4
            },
            {
              "årstall": 2022,
              "kvartal": 1
            }
            ]""".trimIndent()
    }

    @Test
    fun `vi oppdaterer sykefraværsstatistikk for virksomhet siste 4 kvartaler`() {
        val hentSistEndretSql = """
                select sist_endret from sykefravar_statistikk_virksomhet_siste_4_kvartal
                where orgnr = '999999999'
            """.trimIndent()
        kafkaContainer.sendOgVentTilKonsumert(
            jsonKey(VIRKSOMHET, "999999999"),
            jsonValue(VIRKSOMHET, "999999999"),
            KafkaContainerHelper.statistikkVirksomhetTopic,
            Kafka.statistikkPerKategoriGroupId)

        val førstSkrevet = postgresContainer.hentEnkelKolonne<Timestamp>(sql = hentSistEndretSql)

        kafkaContainer.sendOgVentTilKonsumert(
            jsonKey(VIRKSOMHET, "999999999"),
            jsonValue(VIRKSOMHET, "999999999"),
            KafkaContainerHelper.statistikkVirksomhetTopic,
            Kafka.statistikkPerKategoriGroupId)
        val oppdatertDato = postgresContainer.hentEnkelKolonne<Timestamp>(sql = hentSistEndretSql)

        oppdatertDato shouldBeGreaterThan førstSkrevet
    }

    @Test
    fun `vi lagrer sykefraværsstatistikk siste 4 kvartaler per kategori (LAND)`() {
        kafkaContainer.sendOgVentTilKonsumert(
            jsonKey(LAND, "NO"),
            jsonValue(LAND, "NO"),
            KafkaContainerHelper.statistikkLandTopic,
            Kafka.statistikkPerKategoriGroupId)

        postgresContainer.hentEnkelKolonne<String>(
            """
                select kode from sykefravar_statistikk_kategori_siste_4_kvartal
                where kode = 'NO' and kategori = 'LAND'
            """.trimIndent()
        )  shouldBe "NO"
        postgresContainer.hentEnkelKolonne<String>(
            """
                select kategori from sykefravar_statistikk_kategori_siste_4_kvartal
                where kode = 'NO' and kategori = 'LAND'
            """.trimIndent()
        )  shouldBe "LAND"
    }

    @Test
    fun `vi lagrer sykefraværsstatistikk siste 4 kvartaler per kategori (SEKTOR)`() {
        kafkaContainer.sendOgVentTilKonsumert(
            jsonKey(SEKTOR, "NO"),
            jsonValue(SEKTOR, "3"),
            KafkaContainerHelper.statistikkSektorTopic,
            Kafka.statistikkPerKategoriGroupId)

        postgresContainer.hentEnkelKolonne<String>(
            """
                select kode from sykefravar_statistikk_kategori_siste_4_kvartal
                where kode = '3' and kategori = 'SEKTOR'
            """.trimIndent()
        )  shouldBe "3"
        postgresContainer.hentEnkelKolonne<String>(
            """
                select kategori from sykefravar_statistikk_kategori_siste_4_kvartal
                where kode = '3' and kategori = 'SEKTOR'
            """.trimIndent()
        )  shouldBe "SEKTOR"
    }

    @Test
    fun `vi lagrer sykefraværsstatistikk siste 4 kvartaler per kategori (NÆRING)`() {
        kafkaContainer.sendOgVentTilKonsumert(
            jsonKey(NÆRING, NÆRING_JORDBRUK),
            jsonValue(NÆRING, NÆRING_JORDBRUK),
            KafkaContainerHelper.statistikkSektorTopic,
            Kafka.statistikkPerKategoriGroupId)

        postgresContainer.hentEnkelKolonne<String>(
            """
                select kode from sykefravar_statistikk_kategori_siste_4_kvartal
                where kode = '$NÆRING_JORDBRUK' and kategori = '${NÆRING.name}'
            """.trimIndent()
        )  shouldBe NÆRING_JORDBRUK
        postgresContainer.hentEnkelKolonne<String>(
            """
                select kategori from sykefravar_statistikk_kategori_siste_4_kvartal
                where kode = '$NÆRING_JORDBRUK' and kategori = '${NÆRING.name}'
            """.trimIndent()
        )  shouldBe NÆRING.name
    }
}



private fun jsonKey(kategori: Kategori, kode: String) =
    """
      {
        "kategori": "${kategori.name}",
        "kode": "$kode",
        "kvartal": 1,
        "årstall": 2022
      }
""".trimIndent()

private fun jsonValue(kategori: Kategori, kode: String) = """
      {
        "kategori": "${kategori.name}",
        "kode": "$kode",
        "sistePubliserteKvartal": {
          "årstall": 2022,
          "kvartal": 1,
          "prosent": null,
          "tapteDagsverk": null,
          "muligeDagsverk": null,
          "antallPersoner": 4,
          "erMaskert": true
        },
        "siste4Kvartal": {
          "prosent": 6.3,
          "tapteDagsverk": 48.0,
          "muligeDagsverk": 756.4,
          "erMaskert": false,
          "kvartaler": [
            {
              "årstall": 2021,
              "kvartal": 2
            },
            {
              "årstall": 2021,
              "kvartal": 3
            },
            {
              "årstall": 2021,
              "kvartal": 4
            },
            {
              "årstall": 2022,
              "kvartal": 1
            }
          ]
        }
      }
""".trimIndent()

