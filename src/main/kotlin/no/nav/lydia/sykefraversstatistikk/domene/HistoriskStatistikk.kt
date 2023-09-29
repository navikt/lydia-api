package no.nav.lydia.sykefraversstatistikk.domene

import kotlinx.serialization.Serializable
import no.nav.lydia.sykefraversstatistikk.import.Kategori

@Serializable
data class HistoriskStatistikk(
    val virksomhetsstatistikk: KategoriStatistikk,
    val næringsstatistikk: KategoriStatistikk,
    val bransjestatistikk: KategoriStatistikk,
    val sektorstatistikk: KategoriStatistikk,
)

@Serializable
data class KategoriStatistikk (
    val kategori: Kategori,
    val kode: String,
    val statistikk: List<Statistikkdata>,
)

@Serializable
data class Statistikkdata (
    val kvartal : Int,
    val årstall : Int,
    val sykefraværsprosent : Double,
    val maskert : Boolean
)
