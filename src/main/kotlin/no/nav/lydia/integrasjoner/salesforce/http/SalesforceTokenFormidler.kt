package no.nav.lydia.integrasjoner.salesforce.http

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.client.HttpClient
import io.ktor.client.engine.cio.CIO
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.client.request.forms.submitForm
import io.ktor.client.statement.bodyAsText
import io.ktor.http.isSuccess
import io.ktor.http.parameters
import io.ktor.serialization.kotlinx.json.json
import kotlinx.datetime.Clock
import kotlinx.serialization.json.Json
import no.nav.lydia.Salesforce
import no.nav.lydia.ia.sak.api.Feil
import org.slf4j.LoggerFactory.getLogger

class SalesforceTokenFormidler(
    private val salesforceKonfig: Salesforce = Salesforce(),
) {
    private val tokenTimeoutMs = 50 * 60 * 1000 // 50 min i ms
    private val logger = getLogger(this::class.java)
    private val httpClient = HttpClient(CIO) {
        install(ContentNegotiation) {
            json()
        }
    }

    private var cachedToken: SalesforceAccessToken? = null

    suspend fun hentGyldigToken() =
        if (måOppdatereToken(cachedToken)) {
            hentNyttTokenFraSalesforce().onRight { cachedToken = it }
        } else {
            cachedToken!!.right()
        }

    private suspend fun hentNyttTokenFraSalesforce(): Either<Feil, SalesforceAccessToken> {
        val tokenUrl = "${salesforceKonfig.tokenBaseUrl}/services/oauth2/token"
        val response = httpClient.submitForm(
            url = tokenUrl,
            formParameters = parameters {
                append("grant_type", "password")
                append("client_id", salesforceKonfig.clientId)
                append("client_secret", salesforceKonfig.clientSecret)
                append("username", salesforceKonfig.username)
                append("password", salesforceKonfig.password + salesforceKonfig.securityToken)
            },
        )

        if (!response.status.isSuccess()) {
            logger.error("Feil ved henting av token. Status: ${response.status}, responsebody: ${response.bodyAsText()}")
            return SalesforceFeil.`feil ved uthenting av token`.left()
        }

        return mapToken(response.bodyAsText())
    }

    private fun mapToken(tokenJson: String) =
        Either.catch {
            Json.decodeFromString<SalesforceAccessToken>(tokenJson)
        }.mapLeft {
            logger.error("Klarte ikke deserialisere salesforce-token", it)
            SalesforceFeil.`feil ved parsing av token`
        }

    private fun måOppdatereToken(token: SalesforceAccessToken?) =
        token?.let {
            val nå = Clock.System.now().toEpochMilliseconds()
            (nå > token.issuedAt + tokenTimeoutMs)
        } ?: true
}
