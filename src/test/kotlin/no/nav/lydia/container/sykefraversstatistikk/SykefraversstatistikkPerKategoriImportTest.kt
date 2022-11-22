package no.nav.lydia.container.sykefraversstatistikk

import io.kotest.matchers.shouldBe
import no.nav.lydia.Kafka
import no.nav.lydia.helper.KafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
import no.nav.lydia.sykefraversstatistikk.import.Kategori
import no.nav.lydia.sykefraversstatistikk.import.Kategori.LAND
import no.nav.lydia.sykefraversstatistikk.import.Kategori.VIRKSOMHET
import kotlin.test.Test

class SykefraversstatistikkPerKategoriImportTest {
    private val kafkaContainer = TestContainerHelper.kafkaContainerHelper

    @Test
    fun `vi lagrer sykefraværsstatistikk for virksomhet siste 4 kvartaler`() {
        kafkaContainer.sendOgVentTilKonsumert(
            jsonKey(VIRKSOMHET, "999999999"),
            jsonValue(VIRKSOMHET, "999999999"),
            KafkaContainerHelper.statistikkVirksomhetTopic,
            Kafka.statistikkNyConsumerGroupId)

        val rs = postgresContainer.performQuery(
            """
                select * from sykefravar_statistikk_virksomhet_siste_4_kvartal
                where orgnr = '999999999'
            """.trimIndent()
        )
        rs.row shouldBe 1
        rs.getString("orgnr") shouldBe "999999999"
    }

    @Test
    fun `vi lagrer sykefraværsstatistikk siste 4 kvartaler per kategori (andre kategorier enn VIRKSOMHET)`() {
        kafkaContainer.sendOgVentTilKonsumert(
            jsonKey(LAND, "NO"),
            jsonValue(LAND, "NO"),
            KafkaContainerHelper.statistikkLandTopic,
            Kafka.statistikkNyConsumerGroupId)

        val rs = postgresContainer.performQuery(
            """
                select * from sykefravar_statistikk_kategori_siste_4_kvartal
                where kode = 'NO' and kategori = 'LAND'
            """.trimIndent()
        )
        rs.row shouldBe 1
        rs.getString("kode") shouldBe "NO"
        rs.getString("kategori") shouldBe "LAND"
    }


//    @Test
//    fun `tidspunktet for oppdatering av sykefraværsstatistikk per kategori oppdaterer seg`() {
//        TODO()
//    }
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
