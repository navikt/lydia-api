package no.nav.lydia.integrasjoner.azure

import com.auth0.jwt.JWT
import com.auth0.jwt.algorithms.Algorithm
import com.github.kittinunf.fuel.httpPost
import com.nimbusds.jose.jwk.RSAKey
import kotlinx.serialization.json.Json
import no.nav.lydia.NaisEnvironment
import no.nav.lydia.exceptions.AzureException
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

    internal fun clientCredentialsToken(): String {
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
        val parameters = listOf(
            "grant_type" to "client_credentials",
            "scope" to "https://graph.microsoft.com/.default",
            "client_id" to naisEnvironment.security.azureConfig.clientId,
            "client_assertion_type" to "urn:ietf:params:oauth:client-assertion-type:jwt-bearer",
            "client_assertion" to clientAssertion,
        )
        return naisEnvironment.security.azureConfig.tokenEndpoint
            .httpPost(parameters = parameters)
            .response()
            .third
            .fold(success = {
                deserializer.decodeFromString<TokenResponse>(it.toString(charset = Charsets.UTF_8)).access_token
            }, failure = {
                log.error("Azure token feilet. Response body ${it.errorData.toString(Charsets.UTF_8)}")
                throw AzureException("Feilet under henting av Azure token: ${it.message}", it)
            })
    }
}
