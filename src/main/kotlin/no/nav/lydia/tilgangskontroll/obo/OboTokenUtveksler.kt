package no.nav.lydia.tilgangskontroll.obo

import arrow.core.left
import arrow.core.right
import com.github.kittinunf.fuel.httpPost
import kotlinx.serialization.json.Json
import no.nav.lydia.NaisEnvironment
import no.nav.lydia.tilgangskontroll.TilgangskontrollFeil
import no.nav.lydia.tilgangskontroll.TokenResponse
import org.slf4j.LoggerFactory

class OboTokenUtveksler(naisEnvironment: NaisEnvironment) {
	private val log = LoggerFactory.getLogger(this::class.java)

	private val azureTokenEndpoint = naisEnvironment.security.azureConfig.tokenEndpoint
	private val azureAppClientId = naisEnvironment.security.azureConfig.clientId
	private val azureAppClientSecret = naisEnvironment.security.azureConfig.clientSecret

	private val json = Json {
		ignoreUnknownKeys = true
	}

	fun veksleTokenTil(accessToken: String, scope: String) =
		azureTokenEndpoint.httpPost(
			listOf(
				"grant_type" to "urn:ietf:params:oauth:grant-type:jwt-bearer",
				"client_id" to azureAppClientId,
				"client_secret" to azureAppClientSecret,
				"assertion" to accessToken,
				"scope" to scope,
				"requested_token_use" to "on_behalf_of",
			)
		).response().third.fold(
			success = {
				json.decodeFromString<TokenResponse>(
					it.toString(charset = Charsets.UTF_8)
				).right()
			},
			failure = {
				log.error("Feil ved veksling av token til $scope: ${it.message}")
				TilgangskontrollFeil.KunneIkkeVeksleToken.left()
			}
		)
}
