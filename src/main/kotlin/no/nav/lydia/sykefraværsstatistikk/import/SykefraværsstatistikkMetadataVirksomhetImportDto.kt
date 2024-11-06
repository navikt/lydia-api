package no.nav.lydia.sykefraværsstatistikk.import

import com.google.gson.annotations.SerializedName

data class SykefraværsstatistikkMetadataVirksomhetImportDto(
    @SerializedName("orgnr")
    val orgnr: String,
    @SerializedName("arstall")
    val årstall: Int,
    @SerializedName("kvartal")
    val kvartal: Int,
    @SerializedName("naring")
    val naring: String,
    @SerializedName("bransje")
    val bransje: String?,
    @SerializedName("sektor")
    val sektor: String,
)

data class KeySykefraværsstatistikkMetadataVirksomhet(
    val orgnr: String,
    val arstall: Int,
    val kvartal: Int,
)
