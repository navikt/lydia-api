package no.nav.lydia.tilgangskontroll.obo

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.client.HttpClient
import io.ktor.client.engine.cio.CIO
import io.ktor.client.request.forms.submitForm
import io.ktor.client.statement.bodyAsText
import io.ktor.http.isSuccess
import io.ktor.http.parameters
import kotlinx.serialization.json.Json
import no.nav.lydia.NaisEnvironment
import no.nav.lydia.felles.Feil
import no.nav.lydia.tilgangskontroll.TilgangskontrollFeil
import no.nav.lydia.tilgangskontroll.TokenResponse
import org.slf4j.LoggerFactory

class OboTokenUtveksler(
    naisEnvironment: NaisEnvironment,
) {
    private val log = LoggerFactory.getLogger(this::class.java)

    private val azureTokenEndpoint = naisEnvironment.security.azureConfig.tokenEndpoint
    private val azureAppClientId = naisEnvironment.security.azureConfig.clientId
    private val azureAppClientSecret = naisEnvironment.security.azureConfig.clientSecret

    private val json = Json {
        ignoreUnknownKeys = true
    }

    private val httpClient = HttpClient(CIO)

    private val cache = mutableMapOf<String, TokenResponse>()

    suspend fun hentOboTokenForScope(
        accessToken: String,
        scope: String,
    ): Either<Feil, TokenResponse> {
        val cacheNøkkel = "$scope-$accessToken"
        val tokenFraCache = cache[cacheNøkkel]
        return if (tokenFraCache != null && !tokenFraCache.erUtløpt()) {
            tokenFraCache.right()
        } else {
            veksleTokenTil(accessToken, scope).onRight {
                cache[cacheNøkkel] = it
            }
        }
    }

    private suspend fun veksleTokenTil(
        accessToken: String,
        scope: String,
    ): Either<Feil, TokenResponse> {
        val response = httpClient.submitForm(
            url = azureTokenEndpoint,
            formParameters = parameters {
                append("grant_type", "urn:ietf:params:oauth:grant-type:jwt-bearer")
                append("client_id", azureAppClientId)
                append("client_secret", azureAppClientSecret)
                append("assertion", accessToken)
                append("scope", scope)
                append("requested_token_use", "on_behalf_of")
            },
        )
        val body = response.bodyAsText()
        return if (response.status.isSuccess()) {
            json.decodeFromString<TokenResponse>(body).right()
        } else {
            log.error("Feil ved veksling av token til $scope: ${response.status}")
            TilgangskontrollFeil.KunneIkkeVeksleToken.left()
        }
    }
}
