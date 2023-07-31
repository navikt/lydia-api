package no.nav.lydia.container.sykefraversstatistikk

import io.kotest.matchers.shouldBe
import no.nav.lydia.Kafka
import no.nav.lydia.helper.KafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestData.Companion.NÆRING_SKOGBRUK
import no.nav.lydia.helper.TestData.Companion.SEKTOR_PRIVAT_NÆRINGSVIRKSOMHET
import no.nav.lydia.sykefraversstatistikk.import.Kategori
import no.nav.lydia.sykefraversstatistikk.import.Kvartal
import no.nav.lydia.sykefraversstatistikk.import.SistePubliserteKvartal
import java.math.BigDecimal
import kotlin.test.BeforeTest
import kotlin.test.Test


class SykefraversstatistikkPerKategoriImportGjeldendeKvartalTest {
    private val kafkaContainer = TestContainerHelper.kafkaContainerHelper
    private val KVARTAL_2023_1 = Kvartal(2023, 1)
    private val tabellnavn = mapOf(
        Kategori.LAND to "sykefravar_statistikk_land",
        Kategori.SEKTOR to "sykefravar_statistikk_sektor",
        Kategori.NÆRING to "sykefravar_statistikk_naring",
        Kategori.VIRKSOMHET to "sykefravar_statistikk_virksomhet"
    )
    private val kodenavn = mapOf(
        Kategori.LAND to "land",
        Kategori.SEKTOR to "sektor_kode",
        Kategori.NÆRING to "naring",
        Kategori.VIRKSOMHET to "orgnr"
    )


    @BeforeTest
    fun cleanUp() {
        tabellnavn.forEach {
            TestContainerHelper.postgresContainer.performUpdate("""
            delete from ${it.value} 
            where arstall = ${KVARTAL_2023_1.årstall}
              and kvartal = ${KVARTAL_2023_1.kvartal}
        """.trimIndent())
        }
    }
    @Test
    fun `vi lagrer sykefraværsstatistikk siste gjeldende kvartal for kategori LAND`() {
        kafkaContainer.sendOgVentTilKonsumert(
            jsonKey(
                kategori = Kategori.LAND,
                kode = "NO",
                kvartal = KVARTAL_2023_1
            ),
            jsonValue(
                kategori = Kategori.LAND,
                kode = "NO",
                kvartal = KVARTAL_2023_1,
                erMaskert = false,
                tapteDagsverk = BigDecimal(125000.0),
                muligeDagsverk = BigDecimal(2500000.5),
                prosent = BigDecimal(5.0),
                antallPersoner = 3500000
            ),
            KafkaContainerHelper.statistikkLandTopic,
            Kafka.statistikkPerKategoriGroupId
        )

        val result = hentStatistikkGjeldendeKvartal(Kategori.LAND, "NO", KVARTAL_2023_1)
        result.sistePubliserteKvartal.antallPersoner shouldBe 3500000
        result.sistePubliserteKvartal.prosent shouldBe 5.0
        result.sistePubliserteKvartal.muligeDagsverk shouldBe 2500000.5
        result.sistePubliserteKvartal.tapteDagsverk shouldBe 125000.0
        result.sistePubliserteKvartal.erMaskert shouldBe false
    }

    @Test
    fun `vi lagrer sykefraværsstatistikk siste gjeldende kvartal for kategori SEKTOR`() {
        kafkaContainer.sendOgVentTilKonsumert(
            jsonKey(
                Kategori.SEKTOR,
                SEKTOR_PRIVAT_NÆRINGSVIRKSOMHET,
                KVARTAL_2023_1
            ),
            jsonValue(
                Kategori.SEKTOR,
                SEKTOR_PRIVAT_NÆRINGSVIRKSOMHET,
                KVARTAL_2023_1,
                false,
                BigDecimal(125000.0),
                BigDecimal(2500000.5),
                BigDecimal(5.0),
                3500000
            ),
            KafkaContainerHelper.statistikkLandTopic,
            Kafka.statistikkPerKategoriGroupId
        )

        val result = hentStatistikkGjeldendeKvartal(Kategori.SEKTOR, SEKTOR_PRIVAT_NÆRINGSVIRKSOMHET, KVARTAL_2023_1)
        result.sistePubliserteKvartal.antallPersoner shouldBe 3500000
        result.sistePubliserteKvartal.prosent shouldBe 5.0
        result.sistePubliserteKvartal.muligeDagsverk shouldBe 2500000.5
        result.sistePubliserteKvartal.tapteDagsverk shouldBe 125000.0
        result.sistePubliserteKvartal.erMaskert shouldBe false
    }

    @Test
    fun `vi lagrer sykefraværsstatistikk siste gjeldende kvartal for kategori NÆRING`() {
        kafkaContainer.sendOgVentTilKonsumert(
            jsonKey(
                Kategori.NÆRING,
                NÆRING_SKOGBRUK,
                KVARTAL_2023_1
            ),
            jsonValue(
                Kategori.NÆRING,
                NÆRING_SKOGBRUK,
                KVARTAL_2023_1,
                false,
                BigDecimal(125000.0),
                BigDecimal(2500000.5),
                BigDecimal(5.0),
                3500000
            ),
            KafkaContainerHelper.statistikkLandTopic,
            Kafka.statistikkPerKategoriGroupId
        )

        val result = hentStatistikkGjeldendeKvartal(Kategori.NÆRING, NÆRING_SKOGBRUK, KVARTAL_2023_1)
        result.sistePubliserteKvartal.antallPersoner shouldBe 3500000
        result.sistePubliserteKvartal.prosent shouldBe 5.0
        result.sistePubliserteKvartal.muligeDagsverk shouldBe 2500000.5
        result.sistePubliserteKvartal.tapteDagsverk shouldBe 125000.0
        result.sistePubliserteKvartal.erMaskert shouldBe false
    }

    @Test
    fun `vi lagrer sykefraværsstatistikk gjeldende kvartal for kategori VIRKSOMHET`() {
        kafkaContainer.sendOgVentTilKonsumert(
            jsonKey(
                Kategori.VIRKSOMHET,
                "999999999",
                KVARTAL_2023_1
            ),
            jsonValue(
                Kategori.VIRKSOMHET,
                "999999999",
                KVARTAL_2023_1,
                false,
                BigDecimal(125000.0),
                BigDecimal(2500000.5),
                BigDecimal(5.0),
                3500000
            ),
            KafkaContainerHelper.statistikkVirksomhetTopic,
            Kafka.statistikkPerKategoriGroupId
        )

        val result = hentStatistikkGjeldendeKvartal(Kategori.VIRKSOMHET, "999999999", KVARTAL_2023_1)
        result.sistePubliserteKvartal.antallPersoner shouldBe 3500000
        result.sistePubliserteKvartal.prosent shouldBe 5.0
        result.sistePubliserteKvartal.muligeDagsverk shouldBe 2500000.5
        result.sistePubliserteKvartal.tapteDagsverk shouldBe 125000.0
        result.sistePubliserteKvartal.erMaskert shouldBe false
    }

    @Test
    fun `vi maskerer sykefraværssprosent i gjeldende kvartal for kategori VIRKSOMHET dersom antall ansatte er under 5`() {
        kafkaContainer.sendOgVentTilKonsumert(
            jsonKey(
                Kategori.VIRKSOMHET,
                "999999999",
                KVARTAL_2023_1
            ),
            jsonValue(
                kategori = Kategori.VIRKSOMHET,
                kode = "999999999",
                kvartal = KVARTAL_2023_1,
                erMaskert = false,
                tapteDagsverk = BigDecimal(125.0),
                muligeDagsverk = BigDecimal(2500.5),
                prosent = BigDecimal(5.0),
                antallPersoner = 4
            ),
            KafkaContainerHelper.statistikkVirksomhetTopic,
            Kafka.statistikkPerKategoriGroupId
        )

        val result = hentStatistikkGjeldendeKvartal(Kategori.VIRKSOMHET, "999999999", KVARTAL_2023_1)
        result.sistePubliserteKvartal.antallPersoner shouldBe 4
        result.sistePubliserteKvartal.prosent shouldBe 0.0
        result.sistePubliserteKvartal.muligeDagsverk shouldBe 0.0
        result.sistePubliserteKvartal.tapteDagsverk shouldBe 0.0
        result.sistePubliserteKvartal.erMaskert shouldBe true
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

    private fun hentStatistikkGjeldendeKvartal(
        kategori: Kategori,
        verdi: String,
        kvartal: Kvartal
    ): StatistikkGjeldendeKvartal {
        val erKategoriTabell = kategori != Kategori.VIRKSOMHET
        val query = """
            select * from ${tabellnavn[kategori]} 
             where ${kodenavn[kategori]} = '$verdi'
             and arstall = ${kvartal.årstall} and kvartal = ${kvartal.kvartal}
        """.trimMargin()
        TestContainerHelper.postgresContainer.dataSource.connection.use { connection ->
            val statement = connection.createStatement()
            statement.execute(query)
            val rs = statement.resultSet
            rs.next()
            rs.row shouldBe 1
            return StatistikkGjeldendeKvartal(
                kategori = kategori,
                kode = rs.getString(kodenavn[kategori]),
                sistePubliserteKvartal = SistePubliserteKvartal(
                    årstall = rs.getInt("arstall"),
                    kvartal = rs.getInt("kvartal"),
                    prosent = if (erKategoriTabell) rs.getDouble("prosent") else rs.getDouble("sykefraversprosent"),
                    tapteDagsverk = rs.getDouble("tapte_dagsverk"),
                    muligeDagsverk = rs.getDouble("mulige_dagsverk"),
                    antallPersoner = rs.getInt("antall_personer"),
                    erMaskert = rs.getBoolean("maskert")
                )
            )
        }
    }

    data class StatistikkGjeldendeKvartal(
        val kategori: Kategori,
        val kode: String,
        val sistePubliserteKvartal: SistePubliserteKvartal,
    )
}
