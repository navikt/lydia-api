package no.nav.lydia.ia.sak.api.spørreundersøkelse

import kotlinx.serialization.Serializable

@Serializable
data class EndreSamarbeidTilSpørreundersøkelseDto(
    val orgnummer: String,
    val saksnummer: String,
    val prosessId: Int,
)
