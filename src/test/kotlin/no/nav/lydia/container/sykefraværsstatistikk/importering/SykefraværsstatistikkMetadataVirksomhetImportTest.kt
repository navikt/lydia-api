package no.nav.lydia.container.sykefraværsstatistikk.importering

import io.kotest.matchers.shouldBe
import no.nav.lydia.Topic
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.sykefraværsstatistikk.import.Kategori
import no.nav.lydia.sykefraværsstatistikk.import.Kvartal
import no.nav.lydia.virksomhet.domene.Sektor
import kotlin.test.BeforeTest
import kotlin.test.Test

class SykefraværsstatistikkMetadataVirksomhetImportTest {
    companion object {
        private val KVARTAL_2022_4 = Kvartal(2022, 4)
    }

    @BeforeTest
    fun cleanUp() {
        postgresContainerHelper.performUpdate(
            """
            delete from virksomhet_statistikk_metadata
            where orgnr in ('888888888', '999999999')
            """.trimIndent(),
        )
    }

    @Test
    fun `vi lagrer sykefraværsstatistikk metadata for virksomhet`() {
        kafkaContainerHelper.sendOgVentTilKonsumert(
            jsonKey("999999999"),
            jsonValue(orgnr = "999999999", sektor = "KOMMUNAL"),
            Topic.STATISTIKK_METADATA_VIRKSOMHET_TOPIC,
        )

        val results = hentMetadataVirksomhet("888888888", "999999999")
        val virksomhetMetadata = results.first()
        virksomhetMetadata.sektor shouldBe Sektor.KOMMUNAL.kode
    }

    @Test
    fun `sykefraværsstatistikk metadata for virksomhet med ukjent sektor blir ignorert`() {
        kafkaContainerHelper.sendOgVentTilKonsumert(
            jsonKey("999999999"),
            jsonValue(orgnr = "999999999", sektor = "STATLIG"),
            Topic.STATISTIKK_METADATA_VIRKSOMHET_TOPIC,
        )
        kafkaContainerHelper.sendOgVentTilKonsumert(
            jsonKey("888888888"),
            jsonValue(orgnr = "888888888", sektor = "EN_HELT_UKJENT_SEKTOR"),
            Topic.STATISTIKK_METADATA_VIRKSOMHET_TOPIC,
        )

        val results = hentMetadataVirksomhet("888888888", "999999999")
        results.size shouldBe 1
        val virksomhetMetadata = results.first()
        virksomhetMetadata.sektor shouldBe Sektor.STATLIG.kode
        virksomhetMetadata.kategori shouldBe Kategori.VIRKSOMHET.name
        virksomhetMetadata.orgnr shouldBe "999999999"
    }

    @Test
    fun `bransje til en virksomhet kan være null`() {
        val value = jsonValue(orgnr = "999999999", sektor = "STATLIG", bransje = null)
        kafkaContainerHelper.sendOgVentTilKonsumert(
            jsonKey("999999999"),
            value,
            Topic.STATISTIKK_METADATA_VIRKSOMHET_TOPIC,
        )

        val results = hentMetadataVirksomhet("999999999")
        results.size shouldBe 1
        val virksomhetMetadata = results.first()
        virksomhetMetadata.sektor shouldBe Sektor.STATLIG.kode
        virksomhetMetadata.kategori shouldBe Kategori.VIRKSOMHET.name
        virksomhetMetadata.orgnr shouldBe "999999999"
    }

    @Test
    fun `sykefraværsstatistikk metadata for virksomhet vil oppdateres dersom to meldinger på samme orgnr er mottatt`() {
        kafkaContainerHelper.sendOgVentTilKonsumert(
            jsonKey("999999999"),
            jsonValue(orgnr = "999999999", sektor = "STATLIG"),
            Topic.STATISTIKK_METADATA_VIRKSOMHET_TOPIC,
        )
        kafkaContainerHelper.sendOgVentTilKonsumert(
            jsonKey("999999999"),
            jsonValue(orgnr = "999999999", sektor = "PRIVAT"),
            Topic.STATISTIKK_METADATA_VIRKSOMHET_TOPIC,
        )

        val results = hentMetadataVirksomhet("999999999")
        results.size shouldBe 1
        val virksomhetMetadata = results.first()
        virksomhetMetadata.sektor shouldBe Sektor.PRIVAT.kode
        virksomhetMetadata.kategori shouldBe Kategori.VIRKSOMHET.name
        virksomhetMetadata.orgnr shouldBe "999999999"
    }

    private fun jsonKey(
        orgnr: String,
        kvartal: Kvartal = KVARTAL_2022_4,
    ) = """
        {
          "orgnr": "$orgnr",
          "arstall": ${kvartal.årstall},
          "kvartal": ${kvartal.kvartal}
        }
        """.trimIndent()

    private fun jsonValue(
        orgnr: String,
        kvartal: Kvartal = KVARTAL_2022_4,
        næring: String = "88",
        bransje: String? = "BARNEHAGER",
        sektor: String = Sektor.PRIVAT.name,
    ): String =
        """
        {
          "orgnr": "$orgnr",
          "arstall": ${kvartal.årstall},
          "kvartal": ${kvartal.kvartal},
          "naring": $næring,
          "bransje": $bransje,
          "sektor": $sektor
        }
        """.trimIndent()

    private fun hentMetadataVirksomhet(vararg orgnr: String): List<VirksomhetMetadata> {
        var filter = ""
        if (orgnr.isNotEmpty()) {
            val orgnrListe = orgnr.joinToString(transform = { nummer: String -> "'$nummer'" }, separator = ",")
            filter = "where orgnr in ($orgnrListe)"
        }
        val query = """
            select * from virksomhet_statistikk_metadata
            $filter
        """.trimMargin()
        postgresContainerHelper.dataSource.connection.use { connection ->
            val statement = connection.createStatement()
            statement.execute(query)
            val rs = statement.resultSet
            val list = mutableListOf<VirksomhetMetadata>()
            while (rs.next()) {
                list.add(
                    VirksomhetMetadata(
                        orgnr = rs.getString("orgnr"),
                        kategori = rs.getString("kategori"),
                        sektor = rs.getString("sektor"),
                    ),
                )
            }
            return list
        }
    }

    private data class VirksomhetMetadata(
        val orgnr: String,
        val kategori: String,
        val sektor: String,
    )
}
