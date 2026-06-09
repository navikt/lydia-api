package no.nav.lydia.abc.team

import kotlinx.serialization.Serializable

@Serializable
data class BrukerITeamDto(
    val ident: String,
    val saksnummer: String,
)
