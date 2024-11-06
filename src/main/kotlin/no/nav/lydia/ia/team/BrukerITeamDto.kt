package no.nav.lydia.ia.team

import kotlinx.serialization.Serializable

@Serializable
data class BrukerITeamDto(
    val ident: String,
    val saksnummer: String,
)
