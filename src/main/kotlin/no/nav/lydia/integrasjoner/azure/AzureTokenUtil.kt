package no.nav.lydia.integrasjoner.azure


import com.auth0.jwt.JWT
import com.auth0.jwt.algorithms.Algorithm
import io.ktor.client.HttpClient
import io.ktor.client.call.body
import io.ktor.client.request.forms.FormDataContent
import io.ktor.client.request.post
import io.ktor.client.request.setBody
import io.ktor.http.Parameters
import no.nav.lydia.NaisEnvironment
import org.slf4j.LoggerFactory
import java.net.URI
import java.time.Instant
import java.util.Date
import java.util.UUID

class TokenExchanger(
    val naisEnvironment: NaisEnvironment,
) {
    private val privateKey = RSAKey.parse(naisEnvironment.security.azureConfig.privateJwk).toRSAPrivateKey()
    private val logger = LoggerFactory.getLogger(this.javaClass)
    internal suspend fun exchangeToken(token: String, audience: String): String {
        return try {
            HttpClient.client.post(URI.create(naisEnvironment.security.azureConfig.tokenEndpoint).toURL()) {
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
                setBody(FormDataContent(Parameters.build {
                    append("grant_type", "urn:ietf:params:oauth:grant-type:token-exchange")
                    append("client_assertion_type", "urn:ietf:params:oauth:client-assertion-type:jwt-bearer")
                    append("scope", "https://graph.microsoft.com/.default")
                    append("client_assertion", clientAssertion)
                }))
            }.body<Map<String, String>>()["access_token"] ?: throw IllegalStateException("Fikk ingen token i response")
        } catch (e: Exception) {
            logger.error("Feil i token exchange", e)
            throw RuntimeException("Token exchange feil")
        }
    }
}
