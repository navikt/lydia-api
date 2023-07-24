package no.nav.lydia.container.sykefraversstatistikk

import io.kotest.matchers.shouldBe
import no.nav.lydia.Kafka
import no.nav.lydia.helper.KafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.sykefraversstatistikk.import.Kategori
import no.nav.lydia.sykefraversstatistikk.import.Kvartal
import java.math.BigDecimal
import kotlin.test.Test

class SykefraversstatistikkPerKategoriImportGjeldendeKvartalTest {
    private val kafkaContainer = TestContainerHelper.kafkaContainerHelper

    @Test
    fun `vi lagrer sykefraværsstatistikk siste gjeldende kvartal for kategori LAND`() {
        val gjeldendeKvartal = Kvartal(2023, 1)
        TestContainerHelper.postgresContainer.performUpdate("""
            DELETE FROM sykefravar_statistikk_land 
            WHERE 
                land = 'NO' 
                and arstall = ${gjeldendeKvartal.årstall}
                and kvartal = ${gjeldendeKvartal.kvartal}
        """.trimIndent())
        kafkaContainer.sendOgVentTilKonsumert(
            jsonKey(
                Kategori.LAND,
                "NO",
                gjeldendeKvartal
            ),
            jsonValue(
                Kategori.LAND,
                "NO",
                gjeldendeKvartal,
                false,
                BigDecimal(125000.0),
                BigDecimal(2500000.5),
                BigDecimal(5.0),
                3500000
            ),
            KafkaContainerHelper.statistikkLandTopic,
            Kafka.statistikkPerKategoriGroupId
        )

        TestContainerHelper.postgresContainer.hentEnkelKolonne<Int>(
            """
                select antall_personer from sykefravar_statistikk_land
                where 
                land = 'NO' 
                and arstall = ${gjeldendeKvartal.årstall}
                and kvartal = ${gjeldendeKvartal.kvartal}
            """.trimIndent()
        ).toInt()  shouldBe 3500000
    }

    private fun jsonKey(
        kategori: Kategori,
        kode: String,
        kvartal: Kvartal = Kvartal(2023, 1)
    ) =
        """
      {
        "kategori": "${kategori.name}",
        "kode": "$kode",
        "kvartal": ${kvartal.kvartal},
        "årstall": ${kvartal.årstall}
      }
""".trimIndent()

    private fun jsonValue(
        kategori: Kategori,
        kode: String,
        kvartal: Kvartal = Kvartal(2023, 1),
        erMaskert: Boolean = true,
        tapteDagsverk: BigDecimal? = null,
        muligeDagsverk: BigDecimal? = null,
        prosent: BigDecimal? = null,
        antallPersoner: Int = 4
    ): String {
        return """{
        "kategori": "${kategori.name}",
        "kode": "$kode",
        "sistePubliserteKvartal": {
          "årstall": ${kvartal.årstall},
          "kvartal": ${kvartal.kvartal},
          "prosent": $prosent,
          "tapteDagsverk": $tapteDagsverk,
          "muligeDagsverk": $muligeDagsverk,
          "antallPersoner": $antallPersoner,
          "erMaskert": $erMaskert
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
""".trimIndent()}
}
