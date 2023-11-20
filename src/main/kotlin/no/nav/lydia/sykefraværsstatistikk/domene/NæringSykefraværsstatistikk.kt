package no.nav.lydia.sykefraværsstatistikk.domene

import kotlinx.serialization.Serializable
import no.nav.lydia.sykefraværsstatistikk.import.Siste4Kvartal
import no.nav.lydia.sykefraværsstatistikk.import.SistePubliserteKvartal

@Serializable
data class NæringSykefraværsstatistikk (
        val næring: String,
        val sisteGjeldendeKvartal: SistePubliserteKvartal,
        val siste4Kvartal: Siste4Kvartal,
)
