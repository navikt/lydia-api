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
import java.util.TimeZone
import java.util.UUID



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
            builder.from("ghcr.io/navikt/mock-oauth2-server:0.5.5")
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
        "AZURE_OPENID_CONFIG_TOKEN_ENDPOINT" to "$issuerUrl/token",
        "AZURE_APP_JWK" to """
            {
                "p": "5E2G6sOsbC6oBwx-EiRotMLYfVqOmzvRKxe2_hiquWQxg8bhVTf2XkqLPsHZB3Zy36pQlBghljW7Eti72tkA6oDwaTBkHaL_FVs2xzHHKPfh2j1XQxhr8VriPKNVGIr3ueRRGlIMKd3shwcpkB9fHrcN9BIl-Ml2VT5cZmtYGL8",
                "kty": "RSA",
                "q": "yYdq__td3d5COnjmYOzZiw-Nqr83m2SfF5nToey-HM3Za2BSqQLBC2Xy7Sefo7FA-9GzG76Wd3Yp6ofP6Dzp93-kjtcVBBoppJSYKzvC11L0rdsV3kVd7iRxP1MLqSO2DY6CHRpOk2YxqgskGt3-IKwZ9p3sYGEMH8iAuT1V0Wc",
                "d": "boLVdxUVZNCOiGQqaNMxYROupjqkwBbCD2JujIVLgRvgPRSqFLeWkttAVn6ekXT3vxss8VNwQkMXuDhfuy2MQjlfXPFfDM4go5Ec7ZMxmhzXsP-tnS-jaVC0MWsNsZyBVJuxmlxsqY5vt8A8vrYhatO82w6D_tWqkPdQkupyL6-U_u8ikxMMo0SmD3OYAzVhgvrnfinh7itGrmgo9xqEt5IjFJ9f1BFy21o5YA0LReNeaOrMYhZoUIQAjcTpFgEsU5vORT8boXIN3_Bbby32_xlizXBtXlWxWRMN0k3EuzSPar8QvAXdBZf8GsARoSrbfqBtDKQyp94tl5bCH5XIiQ",
                "e": "AQAB",
                "use": "sig",
                "kid": "azure",
                "qi": "Hu7hgJvc5XvFf6OZeHbYkKEgwttO-INjMVSWvBCR89KKN2Njy8e7zAu7T25YuVxbxtLAvwg-sA-ZtELH28DQhR7AnNmJkh_r0IWuOUHROMrCO2iix9Jl1xrCPanQLGx9iTS7LltaYO5jrv9GGYmFBqIvGByKxI7FytgeXhh2NLk",
                "dp": "odtw_nnRgTUmvTCXJMeZUCYfk-ei2N10ssdyXf0g9KTbEeDrGh691SWmSMzn0Ami8X1u-T-OeE8JnRf5PvPAWYEmcHz1TamkjQCI-noJB7uN7Mq2VgQ3avqTEIh_qRHFBY6gDTgEFZ6XtTdXuSz0o_MFuncvYo16Dn9SxO3vnEM",
                "dq": "GugXoyG-gJbiJMhridlVmjlzYq6xD_A5RX9mQCJJp7LcKnfr0WDqwUjVTFCUAdjyoix3S2cA0-ZU5llHquwnGMJUCDYzOh78HFsyjeMmunT68hNkMg704YzACgJedjCsZ9b1DEms4AUu8FMYePXWrioMNV8UZjHO2pd8iD7mLFU",
                "n": "s7mjPNyx4wtQ-ij0VIAvfooN9m2qgqidE7wJ50zAzmG2cS9Y9XpV09KJAAgP21RVQNqbxU3BCwltYD5bhsYSn-T5HZ7uXbjb9zgSY5XUM0TWGMV7qqdISWmHCH6-LYZGrJiN7ofDW3XGINsRlxj3gZbSuSNnXdbreOC97wT5i-qVxWt9xhobB60Jjf3gNiA3XMaOGyE47Ty-6WMH_zs_sENWXQ0eGoD58DROqbF1CUb_9ppubK9nU4Sjo0ih57J14n8aKZVEWg4uN02Gv0TL1ratvyDTwRZrtKprfgFBzylxtV2zkvhETsi7zkrzjsrv4v8hap6V32NgXc8E1xDj2Q"
            }
        """.trimIndent(),
        "AZURE_OPENID_CONFIG_JWKS_URI" to jwksUri,
        "FIA_SUPERBRUKER_GROUP_ID" to superbrukerGroupId,
        "FIA_SAKSBEHANDLER_GROUP_ID" to saksbehandlerGroupId,
        "FIA_LESETILGANG_GROUP_ID" to lesetilgangGroupId,
        "TEAM_PIA_GROUP_ID" to teamPiaGroupId
    )

}
