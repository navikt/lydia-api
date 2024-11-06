package no.nav.lydia.sykefraværsstatistikk.domene

import kotlinx.serialization.Serializable
import no.nav.lydia.sykefraværsstatistikk.import.Kategori

@Serializable
data class HistoriskStatistikk(
    val virksomhetsstatistikk: KategoriStatistikk,
    val næringsstatistikk: KategoriStatistikk,
    val bransjestatistikk: KategoriStatistikk,
    val sektorstatistikk: KategoriStatistikk,
    val landsstatistikk: KategoriStatistikk,
)

@Serializable
data class KategoriStatistikk(
    val kategori: Kategori,
    val kode: String,
    val beskrivelse: String,
    val statistikk: List<Statistikkdata>,
)

@Serializable
data class Statistikkdata(
    val kvartal: Int,
    val årstall: Int,
    val sykefraværsprosent: Double,
    val maskert: Boolean,
)
