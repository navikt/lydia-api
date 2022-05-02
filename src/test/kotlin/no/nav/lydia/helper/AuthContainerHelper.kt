package no.nav.lydia.helper

import com.nimbusds.jose.JOSEObjectType
import com.nimbusds.jwt.SignedJWT
import com.nimbusds.oauth2.sdk.AuthorizationCode
import com.nimbusds.oauth2.sdk.AuthorizationCodeGrant
import com.nimbusds.oauth2.sdk.TokenRequest
import com.nimbusds.oauth2.sdk.auth.ClientSecretBasic
import com.nimbusds.oauth2.sdk.auth.Secret
import com.nimbusds.oauth2.sdk.id.ClientID
import no.nav.lydia.Security.Companion.GROUPS_CLAIM
import no.nav.lydia.Security.Companion.NAV_IDENT_CLAIM
import no.nav.security.mock.oauth2.OAuth2Config
import no.nav.security.mock.oauth2.token.DefaultOAuth2TokenCallback
import okhttp3.HttpUrl.Companion.toHttpUrl
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.testcontainers.containers.GenericContainer
import org.testcontainers.containers.Network
import org.testcontainers.containers.output.Slf4jLogConsumer
import org.testcontainers.containers.wait.strategy.HostPortWaitStrategy
import org.testcontainers.images.builder.ImageFromDockerfile
import java.net.URI
import java.util.*



class AuthContainerHelper(network: Network = Network.newNetwork(), log: Logger = LoggerFactory.getLogger(AuthContainerHelper::class.java)) {
    companion object {
        const val NAV_IDENT_SAKSBEHANDLER_1_X12345 = "X12345"
        const val NAV_IDENT_SAKSBEHANDLER_2_Y54321 = "Y54321"
        const val NAV_IDENT_SUPERBRUKER_S54321 = "S54321"
        const val NAV_IDENT_LESEBRUKER_1_L54321 = "L54321"
        const val NAV_IDENT_LESEBRUKER_AUDIT_A54321 = "A54321"
    }

    private val mockOauth2NetworkAlias: String = "mockoauth2container"
    private val mockOauth2Port: String = "8100"
    val mockOath2Server: GenericContainer<*>
    private val issuerName = "default"
    private val config = OAuth2Config()
    private val tokenEndpointUrl = "http://$mockOauth2NetworkAlias:$mockOauth2Port"
    private val issuerUrl = "$tokenEndpointUrl/$issuerName"
    private val jwksUri = "$issuerUrl/jwks"
    private val audience = "lydia-api"
    private val superbrukerGroupId = "ensuperbrukerGroupId"
    private val saksbehandlerGroupId = "ensaksbehandlerGroupId"
    private val lesetilgangGroupId = "enlesetilgangGroupId"
    val saksbehandlerToken1: String
    val saksbehandlerToken2: String
    val superbrukerToken: String
    val lesebrukerToken: String
    val lesebrukerAuditToken: String

    init {
        mockOath2Server = GenericContainer(ImageFromDockerfile().withDockerfileFromBuilder { builder ->
            builder.from("ghcr.io/navikt/mock-oauth2-server:0.4.4")
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
            .withCreateContainerCmdModifier { cmd -> cmd.withName("$mockOauth2NetworkAlias-${System.currentTimeMillis()}") }
            .waitingFor(
                HostPortWaitStrategy()
            ).apply {
                start()

                // Henter ut token tidlig, fordi det er litt klokkeforskjeller mellom containerne :/
                saksbehandlerToken1 = issueToken(
                    audience = audience,
                    claims = mapOf(
                        NAV_IDENT_CLAIM to NAV_IDENT_SAKSBEHANDLER_1_X12345,
                        GROUPS_CLAIM to listOf(saksbehandlerGroupId)
                    )
                ).serialize()
                saksbehandlerToken2 = issueToken(
                    audience = audience,
                    claims = mapOf(
                        NAV_IDENT_CLAIM to NAV_IDENT_SAKSBEHANDLER_2_Y54321,
                        GROUPS_CLAIM to listOf(saksbehandlerGroupId)
                    )
                ).serialize()
                superbrukerToken = issueToken(
                    audience = audience,
                    claims = mapOf(
                        NAV_IDENT_CLAIM to NAV_IDENT_SUPERBRUKER_S54321,
                        GROUPS_CLAIM to listOf(superbrukerGroupId)
                    )
                ).serialize()
                lesebrukerToken = genererLesebrukerToken(NAV_IDENT_LESEBRUKER_1_L54321)
                lesebrukerAuditToken = genererLesebrukerToken(NAV_IDENT_LESEBRUKER_AUDIT_A54321)
            }
    }

    fun genererLesebrukerToken(navIdent: String) = issueToken(audience = audience, claims = mapOf(
            NAV_IDENT_CLAIM to navIdent,
            GROUPS_CLAIM to listOf(lesetilgangGroupId)
        )).serialize()

    private fun issueToken(
        issuerId: String = issuerName,
        subject: String = UUID.randomUUID().toString(),
        audience: String = this.audience,
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

    fun envVars() = mapOf(
        "AZURE_APP_CLIENT_ID" to audience,
        "AZURE_OPENID_CONFIG_ISSUER" to issuerUrl,
        "AZURE_OPENID_CONFIG_JWKS_URI" to jwksUri,
        "FIA_SUPERBRUKER_GROUP_ID" to superbrukerGroupId,
        "FIA_SAKSBEHANDLER_GROUP_ID" to saksbehandlerGroupId,
        "FIA_LESETILGANG_GROUP_ID" to lesetilgangGroupId
    )

}
