package no.nav.lydia.sykefraversstatistikk.domene

import kotlinx.serialization.Serializable
import no.nav.lydia.sykefraversstatistikk.import.Siste4Kvartal
import no.nav.lydia.sykefraversstatistikk.import.SistePubliserteKvartal

@Serializable
data class NæringSykefraværsstatistikk (
        val næring: String,
        val sisteGjeldendeKvartal: SistePubliserteKvartal,
        val siste4Kvartal: Siste4Kvartal,
)
