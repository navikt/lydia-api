package no.nav.lydia.container.helper

import com.nimbusds.jose.JOSEObjectType
import com.nimbusds.jwt.SignedJWT
import com.nimbusds.oauth2.sdk.AuthorizationCode
import com.nimbusds.oauth2.sdk.AuthorizationCodeGrant
import com.nimbusds.oauth2.sdk.TokenRequest
import com.nimbusds.oauth2.sdk.auth.ClientSecretBasic
import com.nimbusds.oauth2.sdk.auth.Secret
import com.nimbusds.oauth2.sdk.id.ClientID
import no.nav.security.mock.oauth2.OAuth2Config
import no.nav.security.mock.oauth2.token.DefaultOAuth2TokenCallback
import okhttp3.HttpUrl.Companion.toHttpUrl
import org.slf4j.Logger
import org.testcontainers.containers.GenericContainer
import org.testcontainers.containers.Network
import org.testcontainers.containers.output.Slf4jLogConsumer
import org.testcontainers.containers.wait.strategy.Wait
import org.testcontainers.images.builder.ImageFromDockerfile
import java.net.URI
import java.util.*


class AuthContainerHelper(network: Network, log: Logger) {
    private val mockOauth2NetworkAlias: String = "mockoauth2container"
    private val mockOauth2Port: String = "8100"
    private val mockOath2Server: GenericContainer<*>
    private val issuerName = "default"
    private val config = OAuth2Config()
    private val tokenEndpointUrl = "http://$mockOauth2NetworkAlias:$mockOauth2Port"
    val issuerUrl = "$tokenEndpointUrl/$issuerName"
    val jwksUri = "$issuerUrl/jwks"
    val lydiaApiToken: String

    init {
        mockOath2Server = GenericContainer(ImageFromDockerfile().withDockerfileFromBuilder { builder ->
            builder.from("ghcr.io/navikt/mock-oauth2-server:0.4.1")
                .env(
                    mapOf(
                        "TZ" to TimeZone.getDefault().id,
                        "SERVER_PORT" to mockOauth2Port,
                        "SERVER_HOSTNAME" to mockOauth2NetworkAlias
                    )
                )
        })
            .withLogConsumer(Slf4jLogConsumer(log).withPrefix("oAuthContainer").withSeparateOutputStreams())
            .withNetwork(network)
            .withNetworkAliases(mockOauth2NetworkAlias)
            .waitingFor(Wait.defaultWaitStrategy()).apply {
                start()

                // Henter ut token tidlig, fordi det er litt klokkeforskjeller mellom containerne :/
                lydiaApiToken = issueToken(
                    audience = "lydia-api",
                    claims = mapOf(
                        "NAVident" to "X12345"
                    )
                ).serialize()
            }
    }

    private fun issueToken(
        issuerId: String = issuerName,
        subject: String = UUID.randomUUID().toString(),
        audience: String = "lydia-api",
        claims: Map<String, Any> = emptyMap(),
        expiry: Long = 3600
    ): SignedJWT {
        val clientId = "default"
        val tokenCallback = DefaultOAuth2TokenCallback(
            issuerId,
            subject,
            JOSEObjectType.JWT.type,
            listOf(audience),
            claims,
            expiry
        )

        val tokenRequest = TokenRequest(
            URI.create(tokenEndpointUrl),
            ClientSecretBasic(ClientID(clientId), Secret("secret")),
            AuthorizationCodeGrant(AuthorizationCode("123"), URI.create("http://localhost"))
        )
        return config.tokenProvider.accessToken(tokenRequest, issuerUrl.toHttpUrl(), tokenCallback, null)
    }

}