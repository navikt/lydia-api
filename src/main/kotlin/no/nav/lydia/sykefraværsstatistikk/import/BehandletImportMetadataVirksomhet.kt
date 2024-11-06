package no.nav.lydia.sykefraværsstatistikk.import

import no.nav.lydia.virksomhet.domene.Sektor
import java.lang.IllegalStateException

private val SEKTOR_FRA_SYKEFRAVÆRSSTATISTIKK_TIL_IMPORT = Sektor.entries.map { it.name }.toList()

data class BehandletImportMetadataVirksomhet(
    val orgnr: String,
    val kvartal: Kvartal,
    val naring: String,
    val bransje: String,
    val sektor: Sektor,
) {
    companion object {
        fun SykefraværsstatistikkMetadataVirksomhetImportDto.tilBehandletImportMetadataVirksomhet() =
            BehandletImportMetadataVirksomhet(
                orgnr = this.orgnr,
                kvartal = Kvartal(this.årstall, this.kvartal),
                naring = this.naring,
                bransje = this.bransje ?: "",
                sektor = this.sektor.fraSykefraværsstistikkSektortilSektor() ?: throw IllegalStateException(
                    "Sektor '${this.sektor}' funnet i import av metadata virksomhet. " +
                        "Denne skal ikke importeres. Sektor skal være en av " +
                        SEKTOR_FRA_SYKEFRAVÆRSSTATISTIKK_TIL_IMPORT.joinToString(separator = ", "),
                ),
            )

        fun List<SykefraværsstatistikkMetadataVirksomhetImportDto>.tilBehandletImportMetadataVirksomhet() =
            this.filter { dto ->
                dto.sektor.isNotEmpty() && SEKTOR_FRA_SYKEFRAVÆRSSTATISTIKK_TIL_IMPORT.contains(dto.sektor)
            }.map { it.tilBehandletImportMetadataVirksomhet() }
    }
}

fun String.fraSykefraværsstistikkSektortilSektor(): Sektor? =
    when (this) {
        "STATLIG" -> Sektor.STATLIG
        "KOMMUNAL" -> Sektor.KOMMUNAL
        "PRIVAT" -> Sektor.PRIVAT
        else -> null
    }
