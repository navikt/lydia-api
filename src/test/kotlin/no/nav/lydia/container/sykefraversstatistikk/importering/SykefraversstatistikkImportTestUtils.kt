package no.nav.lydia.container.sykefraversstatistikk.importering

import com.google.gson.Gson
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestData
import no.nav.lydia.sykefraversstatistikk.import.*


class SykefraversstatistikkImportTestUtils {

    data class StatistikkGjeldendeKvartal(
            val kategori: Kategori,
            val kode: String,
            val sistePubliserteKvartal: SistePubliserteKvartal,
    )

    data class StatistikkSiste4Kvartal(
            val kategori: Kategori,
            val kode: String,
            val siste4Kvartal: Siste4Kvartal,
    )

    data class JsonMelding(
            val key: JsonKey,
            val value: JsonValue
    ) {
        constructor(
                kategori: Kategori,
                kode: String,
                kvartal: Kvartal = Kvartal(2023, 1),
                sistePubliserteKvartal: SistePubliserteKvartal,
                siste4Kvartal: Siste4Kvartal,
        ) : this(
                JsonKey(
                        kategori = kategori,
                        kode = kode,
                        kvartal = kvartal
                ),
                JsonValue(
                        kategori = kategori,
                        kode = kode,
                        kvartal = kvartal,
                        sistePubliserteKvartal = sistePubliserteKvartal,
                        siste4Kvartal = siste4Kvartal
                )
        )
        fun toJsonKey() = key.toJson()
        fun toJsonValue() = value.toJson()
    }

    data class JsonMeldingGradering(
            val key: JsonKeyGradering,
            val value: JsonValueGradering
    ) {
        constructor(
                kategori: String,
                kode: String,
                kvartal: Kvartal = Kvartal(2023, 1),
                sistePubliserteKvartal: GraderingSistePubliserteKvartal,
                siste4Kvartal: GraderingSiste4Kvartal,
        ) : this(
                JsonKeyGradering(
                        kategori = kategori,
                        kode = kode,
                        kvartal = kvartal
                ),
                JsonValueGradering(
                        kategori = kategori,
                        kode = kode,
                        kvartal = kvartal,
                        sistePubliserteKvartal = sistePubliserteKvartal,
                        siste4Kvartal = siste4Kvartal
                )
        )
        fun toJsonKey() = key.toJson()
        fun toJsonValue() = value.toJson()
    }

    data class JsonKey(
            val kategori: Kategori,
            val kode: String,
            val kvartal: Kvartal
    )

   data class JsonValue(
            val kategori: Kategori,
            val kode: String,
            val kvartal: Kvartal,
            val sistePubliserteKvartal: SistePubliserteKvartal,
            val siste4Kvartal: Siste4Kvartal,
    )
    data class JsonKeyGradering(
            val kategori: String,
            val kode: String,
            val kvartal: Kvartal
    )
    data class JsonValueGradering(
            val kategori: String,
            val kode: String,
            val kvartal: Kvartal,
            val sistePubliserteKvartal: GraderingSistePubliserteKvartal,
            val siste4Kvartal: GraderingSiste4Kvartal,
    )

    companion object {
        val KVARTAL_2023_1 = Kvartal(2023, 1)
        val KVARTAL_2022_4 = Kvartal(2022, 4)
        val KVARTAL_2022_3 = Kvartal(2022, 3)
        val KVARTAL_2022_2 = Kvartal(2022, 2)
        val KVARTAL_2022_1 = Kvartal(2022, 1)


        fun cleanUpStatistikkTable(
                kategori: Kategori,
                verdi: String? = null,
                kvartal: Kvartal = TestData.gjeldendePeriode.tilKvartal(),
        ) {
            val optionalClauseOnKode = if (verdi == null) "" else "and ${kategori.kodenavn()} = '$verdi'"

            TestContainerHelper.postgresContainer.performUpdate("""
            delete from ${kategori.tabellnavn()} 
            where arstall = ${kvartal.årstall}
              and kvartal = ${kvartal.kvartal}
              $optionalClauseOnKode
        """.trimIndent())
        }

        fun cleanUpStatistikkSiste4KvartalTable(
                kategori: Kategori,
                verdi: String? = null
        ) {
            val erKategoriTabell = kategori != Kategori.VIRKSOMHET
            val tabellnavn = if (erKategoriTabell) "sykefravar_statistikk_kategori_siste_4_kvartal" else "sykefravar_statistikk_virksomhet_siste_4_kvartal"
            val kodeKolonneLabel = if (erKategoriTabell) "kode" else "orgnr"
            val optionalClauseOnKode = if (verdi == null) "" else "where $kodeKolonneLabel = '$verdi'"
            TestContainerHelper.postgresContainer.performUpdate("""
              delete from $tabellnavn 
              $optionalClauseOnKode
        """.trimIndent())
        }

        fun JsonKey.toJson(): String = """
                {
                  "kategori": "${kategori.name}",
                  "kode": "$kode",
                  "kvartal": ${kvartal.kvartal},
                  "årstall": ${kvartal.årstall}
                }""".trimIndent()

        fun List<Kvartal>.toJson(): String =
                this.joinToString(
                        transform = { """{"årstall": ${it.årstall},"kvartal": ${it.kvartal}}""" },
                        separator = ","
                ).trimIndent()

        fun JsonKeyGradering.toJson(): String = """
                {
                  "kategori": "$kategori",
                  "kode": "$kode",
                  "kvartal": ${kvartal.kvartal},
                  "årstall": ${kvartal.årstall}
                }""".trimIndent()
        fun JsonValueGradering.toJson(): String = """
                {
                  "kategori": "$kategori",
                  "kode": "${kode}",
                  "sistePubliserteKvartal": {
                    "årstall": ${kvartal.årstall},
                    "kvartal": ${kvartal.kvartal},
                    "prosent": ${sistePubliserteKvartal.prosent?.toPlainString()},
                    "tapteDagsverkGradert": ${sistePubliserteKvartal.tapteDagsverkGradert?.toPlainString()},
                    "tapteDagsverk": ${sistePubliserteKvartal.tapteDagsverk?.toPlainString()},
                    "antallPersoner": ${sistePubliserteKvartal.antallPersoner},
                    "erMaskert": ${sistePubliserteKvartal.erMaskert}
                  },
                  "siste4Kvartal": {
                    "prosent": ${siste4Kvartal.prosent?.toPlainString()},
                    "tapteDagsverkGradert": ${siste4Kvartal.tapteDagsverkGradert?.toPlainString()},
                    "tapteDagsverk": ${siste4Kvartal.tapteDagsverk?.toPlainString()},
                    "erMaskert": ${siste4Kvartal.erMaskert},
                    "kvartaler": [${siste4Kvartal.kvartaler.toJson()}]
                  }
                }""".trimIndent()
        fun JsonValue.toJson(): String = """
                {
                  "kategori": "${kategori.name}",
                  "kode": "${kode}",
                  "sistePubliserteKvartal": {
                    "årstall": ${kvartal.årstall},
                    "kvartal": ${kvartal.kvartal},
                    "prosent": ${sistePubliserteKvartal.prosent?.toPlainString()},
                    "tapteDagsverk": ${sistePubliserteKvartal.tapteDagsverk?.toPlainString()},
                    "muligeDagsverk": ${sistePubliserteKvartal.muligeDagsverk?.toPlainString()},
                    "antallPersoner": ${sistePubliserteKvartal.antallPersoner},
                    "erMaskert": ${sistePubliserteKvartal.erMaskert}
                  },
                  "siste4Kvartal": {
                    "prosent": ${siste4Kvartal.prosent?.toPlainString()},
                    "tapteDagsverk": ${siste4Kvartal.tapteDagsverk?.toPlainString()},
                    "muligeDagsverk": ${siste4Kvartal.muligeDagsverk?.toPlainString()},
                    "erMaskert": ${siste4Kvartal.erMaskert},
                    "kvartaler": [${siste4Kvartal.kvartaler.toJson()}]
                  }
                }""".trimIndent()

        fun Double.toPlainString(): String =
                this.toBigDecimal().toPlainString()

        infix fun Double?.shouldBeOrEqualZeroIfNull(expected: Double?) =
                when (expected) {
                    null -> this shouldBe 0.0
                    0.0 -> this shouldBe null
                    else -> this shouldBe expected
                }

        infix fun JsonMelding.sistePubliserteKvartalShouldBeEqual(sistePubliserteKvartal: SistePubliserteKvartal) {
            sistePubliserteKvartal.antallPersoner shouldBe this.value.sistePubliserteKvartal.antallPersoner
            sistePubliserteKvartal.prosent shouldBeOrEqualZeroIfNull this.value.sistePubliserteKvartal.prosent
            sistePubliserteKvartal.muligeDagsverk shouldBeOrEqualZeroIfNull this.value.sistePubliserteKvartal.muligeDagsverk
            sistePubliserteKvartal.tapteDagsverk shouldBeOrEqualZeroIfNull this.value.sistePubliserteKvartal.tapteDagsverk
            sistePubliserteKvartal.erMaskert shouldBe this.value.sistePubliserteKvartal.erMaskert
        }

        infix fun JsonMelding.siste4KvartalShouldBeEqual(siste4Kvartal: Siste4Kvartal) {
            siste4Kvartal.prosent shouldBeOrEqualZeroIfNull this.value.siste4Kvartal.prosent
            siste4Kvartal.muligeDagsverk shouldBeOrEqualZeroIfNull this.value.siste4Kvartal.muligeDagsverk
            siste4Kvartal.tapteDagsverk shouldBeOrEqualZeroIfNull this.value.siste4Kvartal.tapteDagsverk
            siste4Kvartal.erMaskert shouldBe this.value.siste4Kvartal.erMaskert
            siste4Kvartal.kvartaler shouldBe this.value.siste4Kvartal.kvartaler
        }

        fun hentStatistikkGjeldendeKvartal(
                kategori: Kategori,
                verdi: String,
                kvartal: Kvartal
        ): StatistikkGjeldendeKvartal {
            val erKategoriTabell = kategori != Kategori.VIRKSOMHET
            val query = """
            select * from ${kategori.tabellnavn()} 
             where ${kategori.kodenavn()} = '$verdi'
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
                        kode = rs.getString(kategori.kodenavn()),
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

        fun hentStatistikkSiste4Kvartal(kategori: Kategori, verdi: String, kvartal: Kvartal): StatistikkSiste4Kvartal {
            val erKategoriTabell = kategori != Kategori.VIRKSOMHET
            val tabellnavn = if (erKategoriTabell) "sykefravar_statistikk_kategori_siste_4_kvartal" else "sykefravar_statistikk_virksomhet_siste_4_kvartal"
            val kodeKolonneLabel = if (erKategoriTabell) "kode" else "orgnr"
            val query = """
            select * from $tabellnavn 
             where 
               $kodeKolonneLabel = '$verdi'
               AND publisert_kvartal = ${kvartal.kvartal}
               AND publisert_arstall = ${kvartal.årstall}
        """.trimMargin()
            TestContainerHelper.postgresContainer.dataSource.connection.use { connection ->
                val statement = connection.createStatement()
                statement.execute(query)
                val rs = statement.resultSet
                rs.next()
                rs.row shouldBe 1
                return StatistikkSiste4Kvartal(
                        kategori = kategori,
                        kode = rs.getString(kodeKolonneLabel),
                        siste4Kvartal = Siste4Kvartal(
                                prosent = rs.getDouble("prosent"),
                                tapteDagsverk = rs.getDouble("tapte_dagsverk"),
                                muligeDagsverk = rs.getDouble("mulige_dagsverk"),
                                erMaskert = rs.getBoolean("maskert"),
                                kvartaler = rs.getString("kvartaler").tilKvartaler()
                        )
                )
            }
        }

        private fun String.tilKvartaler(): List<Kvartal> =
                Gson().fromJson(this, Array<Kvartal>::class.java).asList()
    }
}
