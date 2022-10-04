package no.nav.lydia.integrasjoner.azure


import com.auth0.jwt.JWT
import com.auth0.jwt.algorithms.Algorithm
import com.github.kittinunf.fuel.httpPost
import com.nimbusds.jose.jwk.RSAKey
import kotlinx.serialization.Serializable
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json
import no.nav.lydia.NaisEnvironment
import org.slf4j.LoggerFactory
import java.time.Instant
import java.util.Date
import java.util.UUID

class AzureTokenFetcher(
    val naisEnvironment: NaisEnvironment,
) {
    private val privateKey = RSAKey.parse(naisEnvironment.security.azureConfig.privateJwk).toRSAPrivateKey()
    private val logger = LoggerFactory.getLogger(this.javaClass)

    @Serializable
    private data class TokenResponse(val access_token: String)

    private val deserializer = Json {
        ignoreUnknownKeys = true
    }

    internal fun clientCredentialsToken(): String {
            val now = Instant.now()
            val clientAssertion = JWT.create().apply {
                withSubject(naisEnvironment.security.azureConfig.clientId)
                withIssuer(naisEnvironment.security.azureConfig.clientId)
                withAudience(naisEnvironment.security.azureConfig.tokenEndpoint)
                withJWTId(UUID.randomUUID().toString())
                withIssuedAt(Date.from(now))
                withNotBefore(Date.from(now))
                withExpiresAt(Date.from(now.plusSeconds(120)))
            }.sign(Algorithm.RSA256(null, privateKey))
            val parameters = listOf(
                "grant_type" to "client_credentials",
                "scope" to "https://graph.microsoft.com/.default",
                "client_assertion_type" to "urn:ietf:params:oauth:client-assertion-type:jwt-bearer",
                "client_assertion" to clientAssertion
            )
            return naisEnvironment.security.azureConfig.tokenEndpoint
                .httpPost(parameters = parameters)
                .response()
                .third
                .fold(success = {
                    deserializer.decodeFromString<TokenResponse>(it.toString(charset = Charsets.UTF_8)).access_token
                }, failure = {
                    throw it
                })
    }
}
