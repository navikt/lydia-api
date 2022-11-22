package no.nav.lydia.container.sykefraversstatistikk

import io.kotest.matchers.shouldBe
import no.nav.lydia.Kafka
import no.nav.lydia.helper.KafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
import kotlin.test.Test

class SykefraversstatistikkPerKategoriImportTest {
    private val kafkaContainer = TestContainerHelper.kafkaContainerHelper

    @Test
    fun `deserialisering av sykefraværsstatistikk per kategori virker`() {
        kafkaContainer.sendOgVentTilKonsumert(
            jsonKey,
            jsonValue,
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

//    @Test
//    fun `tidspunktet for oppdatering av sykefraværsstatistikk per kategori oppdaterer seg`() {
//        TODO()
//    }
}

private val jsonKey = """
      {
        "kategori": "VIRKSOMHET",
        "kode": "999999999",
        "kvartal": 1,
        "årstall": 2022
      }
""".trimIndent()

private val jsonValue = """
      {
        "kategori": "VIRKSOMHET",
        "kode": "999999999",
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