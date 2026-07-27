package no.nav.lydia.integrasjoner.azure

import com.auth0.jwt.JWT
import com.auth0.jwt.algorithms.Algorithm
import com.nimbusds.jose.jwk.RSAKey
import io.ktor.client.HttpClient
import io.ktor.client.engine.cio.CIO
import io.ktor.client.request.forms.submitForm
import io.ktor.client.statement.bodyAsText
import io.ktor.http.isSuccess
import io.ktor.http.parameters
import kotlinx.serialization.json.Json
import no.nav.lydia.NaisEnvironment
import no.nav.lydia.tilgangskontroll.TokenResponse
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.time.Instant
import java.util.Date
import java.util.UUID

class AzureTokenFetcher(
    val naisEnvironment: NaisEnvironment,
) {
    private companion object {
        val log: Logger = LoggerFactory.getLogger(this::class.java)
    }

    private val privateKey = RSAKey.parse(naisEnvironment.security.azureConfig.privateJwk)

    private val deserializer = Json {
        ignoreUnknownKeys = true
    }

    private val httpClient = HttpClient(CIO)

    internal suspend fun clientCredentialsToken(): String {
        val now = Instant.now()
        val clientAssertion = JWT.create().apply {
            withKeyId(privateKey.keyID)
            withSubject(naisEnvironment.security.azureConfig.clientId)
            withIssuer(naisEnvironment.security.azureConfig.clientId)
            withAudience(naisEnvironment.security.azureConfig.tokenEndpoint)
            withJWTId(UUID.randomUUID().toString())
            withIssuedAt(Date.from(now))
            withNotBefore(Date.from(now))
            withExpiresAt(Date.from(now.plusSeconds(120)))
        }.sign(Algorithm.RSA256(null, privateKey.toRSAPrivateKey()))

        val response = httpClient.submitForm(
            url = naisEnvironment.security.azureConfig.tokenEndpoint,
            formParameters = parameters {
                append("grant_type", "client_credentials")
                append("scope", "https://graph.microsoft.com/.default")
                append("client_id", naisEnvironment.security.azureConfig.clientId)
                append("client_assertion_type", "urn:ietf:params:oauth:client-assertion-type:jwt-bearer")
                append("client_assertion", clientAssertion)
            },
        )
        val body = response.bodyAsText()
        if (!response.status.isSuccess()) {
            log.error("Azure token feilet. Response body $body")
            throw AzureException("Feilet under henting av Azure token: ${response.status}", RuntimeException(body))
        }
        return deserializer.decodeFromString<TokenResponse>(body).access_token
    }
}
