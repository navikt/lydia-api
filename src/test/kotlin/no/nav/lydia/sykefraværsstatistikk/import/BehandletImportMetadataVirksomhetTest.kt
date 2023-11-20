package no.nav.lydia.sykefraværsstatistikk.import

import io.kotest.assertions.throwables.shouldThrow
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldStartWith
import no.nav.lydia.sykefraværsstatistikk.import.BehandletImportMetadataVirksomhet.Companion.tilBehandletImportMetadataVirksomhet
import no.nav.lydia.virksomhet.domene.Sektor
import java.lang.IllegalStateException
import kotlin.test.Test

class BehandletImportMetadataVirksomhetTest {

    @Test
    fun `Metadata virksomhet uten gyldig sektor skal ikke kunne mappes direkte til BehandletImportMetadataVirksomhet`() {
        assertSektorIkkeStøttesTilImport("")
        assertSektorIkkeStøttesTilImport("UKJENT")
    }

    @Test
    fun `Metadata virksomhet uten gyldig sektor filtreres vekk og blir ikke importert`() {
        val result = listOf(
            SykefraværsstatistikkMetadataVirksomhetImportDto(
                sektor = "",
                årstall = 2023,
                kvartal = 2,
                orgnr = "999999999",
                naring = "41",
                bransje = "BYGG"
            ),
            SykefraværsstatistikkMetadataVirksomhetImportDto(
                sektor = "PRIVAT",
                årstall = 2023,
                kvartal = 2,
                orgnr = "777777777",
                naring = "49",
                bransje = "TRANSPORT"
            ),
            SykefraværsstatistikkMetadataVirksomhetImportDto(
                sektor = "UKJENT",
                årstall = 2023,
                kvartal = 2,
                orgnr = "666666666",
                naring = "49",
                bransje = "TRANSPORT"
            )
        ).tilBehandletImportMetadataVirksomhet()

        result.size shouldBe 1
        result[0].orgnr shouldBe "777777777"
        result[0].sektor shouldBe Sektor.PRIVAT
    }


    private fun assertSektorIkkeStøttesTilImport(sektor: String) {
        val exceptionFordiSektorIkkeStøttesTilImport = shouldThrow<IllegalStateException> {
            SykefraværsstatistikkMetadataVirksomhetImportDto(
                sektor = sektor,
                årstall = 2023,
                kvartal = 2,
                orgnr = "999999999",
                naring = "41",
                bransje = "BYGG"
            ).tilBehandletImportMetadataVirksomhet()
        }

        exceptionFordiSektorIkkeStøttesTilImport.message shouldStartWith "Sektor '$sektor' funnet i import"
    }
}
