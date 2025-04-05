package no.nav.lydia.tilgangskontroll

import kotlinx.serialization.Serializable

@Serializable
data class TokenResponse(
    val access_token: String,
    val expires_in: Long?,
    val token_type: String?,
) {
    private val utløper = utløperFraExpiresIn(expires_in)

    fun erUtløpt() = System.currentTimeMillis() > utløper
}

private fun utløperFraExpiresIn(expiresIn: Long?) =
    if (expiresIn == null) {
        0
    } else {
        System.currentTimeMillis() + ((expiresIn - 120) * 1000L)
    }
