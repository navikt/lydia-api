package no.nav.lydia.ia.sak.api.spørreundersøkelse

import kotlinx.datetime.LocalDateTime

data class SpørreundersøkelseSvar(
    val spørreundersøkelseId: String,
    val sesjonId: String,
    val spørsmålId: String,
    val svarIder: List<String>,
    val opprettet: LocalDateTime, // dato for første svar
    val endret: LocalDateTime?, // dato for siste svar om man har gått tilbake og svart flere ganger
)
