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
    private val teamPiaGroupId = "enTeamPiaGroupId"
    private val ugyldigRolleGroupId = "enHeltAnnenRolleGroupId"

    val lesebruker : TestBruker
    val lesebrukerAudit : TestBruker
    val saksbehandler1 : TestBruker
    val saksbehandler2 : TestBruker
    val superbruker1 : TestBruker
    val superbruker2 : TestBruker
    val brukerUtenTilgangsrolle : TestBruker

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
                lesebruker = TestBruker("L54321", lesetilgangGroupId)
                lesebrukerAudit = TestBruker("A54321", lesetilgangGroupId)
                saksbehandler1 = TestBruker("X12345", saksbehandlerGroupId)
                saksbehandler2 = TestBruker("Y54321", saksbehandlerGroupId)
                superbruker1 = TestBruker("S54321", superbrukerGroupId)
                superbruker2 = TestBruker("S22222", superbrukerGroupId)
                brukerUtenTilgangsrolle = TestBruker("U54321", ugyldigRolleGroupId)
            }
    }

    inner class TestBruker(val navIdent : String, gruppe : String) {
        val token = issueToken(
            audience = audience,
            claims = mapOf(
                NAV_IDENT_CLAIM to navIdent,
                GROUPS_CLAIM to listOf(gruppe)
            )
        ).serialize()
    }

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
        "FIA_LESETILGANG_GROUP_ID" to lesetilgangGroupId,
        "TEAM_PIA_GROUP_ID" to teamPiaGroupId
    )

}
