package no.nav.lydia.sykefraversstatistikk.domene

import kotlinx.serialization.Serializable

@Serializable
data class VirksomhetsstatistikkSiden2019(
        val orgnr: String,
        val kvartalliste : List<Virksomhetsstatistikk>,
)

@Serializable
data class Virksomhetsstatistikk (
        val orgnr: String,
        val kvartal : Int,
        val årstall : Int,
        val sykefraværsprosent : Double,
        val maskert : Boolean
)
