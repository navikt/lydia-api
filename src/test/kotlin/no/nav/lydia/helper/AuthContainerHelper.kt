package no.nav.lydia.helper

import com.nimbusds.jose.JOSEObjectType
import com.nimbusds.jwt.SignedJWT
import com.nimbusds.oauth2.sdk.AuthorizationCode
import com.nimbusds.oauth2.sdk.AuthorizationCodeGrant
import com.nimbusds.oauth2.sdk.Scope
import com.nimbusds.oauth2.sdk.TokenRequest
import com.nimbusds.oauth2.sdk.auth.ClientSecretBasic
import com.nimbusds.oauth2.sdk.auth.Secret
import com.nimbusds.oauth2.sdk.id.ClientID
import no.nav.lydia.Security.Companion.GROUPS_CLAIM
import no.nav.lydia.Security.Companion.NAME_CLAIM
import no.nav.lydia.Security.Companion.NAV_IDENT_CLAIM
import no.nav.lydia.Security.Companion.OBJECT_ID_CLAIM
import no.nav.security.mock.oauth2.OAuth2Config
import no.nav.security.mock.oauth2.token.DefaultOAuth2TokenCallback
import okhttp3.HttpUrl.Companion.toHttpUrl
import org.slf4j.Logger
import org.testcontainers.containers.GenericContainer
import org.testcontainers.containers.Network
import org.testcontainers.containers.output.Slf4jLogConsumer
import org.testcontainers.containers.wait.strategy.HostPortWaitStrategy
import org.testcontainers.utility.DockerImageName
import java.net.URI
import java.util.TimeZone
import java.util.UUID

class AuthContainerHelper(
    network: Network,
    log: Logger,
) {
    private val port = 8100
    private val networkalias = "authserver"
    private val baseEndpointUrl = "http://$networkalias:$port"
    private val config = OAuth2Config()

    companion object {
        private const val SUPERBRUKER_GROUP_ID = "ensuperbrukerGroupId"
        private const val SAKSBEHANDLER_GROUP_ID = "ensaksbehandlerGroupId"
        private const val LESETILGANG_GROUP_ID = "enlesetilgangGroupId"
        private const val TEAM_PLA_GROUP_ID = "enTeamPiaGroupId"
        private const val UGYILDIG_ROLLE_GROUP_ID = "enHeltAnnenRolleGroupId"
        const val FNR = "12345678901"
    }

    val lesebruker: TestBruker
    val lesebrukerAudit: TestBruker
    val saksbehandler1: TestBruker
    val saksbehandler2: TestBruker
    val superbruker1: TestBruker
    val superbruker2: TestBruker
    val teamPiaBruker: TestBruker
    val brukerUtenTilgangsrolle: TestBruker

    val container: GenericContainer<*> = GenericContainer(DockerImageName.parse("ghcr.io/navikt/mock-oauth2-server:2.2.1"))
        .withNetwork(network)
        .waitingFor(HostPortWaitStrategy())
        .withNetworkAliases(networkalias)
        .withCreateContainerCmdModifier { cmd -> cmd.withName("$networkalias-${System.currentTimeMillis()}") }
        .withLogConsumer(
            Slf4jLogConsumer(log)
                .withPrefix("authContainer")
                .withSeparateOutputStreams(),
        )
        .withEnv(
            mapOf(
                "TZ" to TimeZone.getDefault().id,
                "SERVER_PORT" to "$port",
                "SERVER_HOSTNAME" to networkalias,
            ),
        )
        .apply { start() }
        .also {
            // Henter ut token tidlig, fordi det er litt klokkeforskjeller mellom containerne :/
            lesebruker = TestBruker(navIdent = "L54321", LESETILGANG_GROUP_ID)
            lesebrukerAudit = TestBruker(navIdent = "A54321", LESETILGANG_GROUP_ID)
            saksbehandler1 = TestBruker(navIdent = "X12345", SAKSBEHANDLER_GROUP_ID)
            saksbehandler2 = TestBruker(navIdent = "Y54321", SAKSBEHANDLER_GROUP_ID)
            superbruker1 = TestBruker(navIdent = "S54321", SUPERBRUKER_GROUP_ID)
            superbruker2 = TestBruker(navIdent = "S22222", SUPERBRUKER_GROUP_ID)
            teamPiaBruker = TestBruker(navIdent = "P12345", TEAM_PLA_GROUP_ID)
            brukerUtenTilgangsrolle = TestBruker(navIdent = "U54321", UGYILDIG_ROLLE_GROUP_ID)
        }

    inner class TestBruker(
        val navIdent: String,
        gruppe: String,
        audience: String = "lydia-api",
        issuerId: String = "default",
    ) {
        val navn = "F_$navIdent E_$navIdent"
        val token: String = issueToken(
            audience = audience,
            claims = mapOf(
                NAV_IDENT_CLAIM to navIdent,
                NAME_CLAIM to navn,
                GROUPS_CLAIM to listOf(gruppe),
                OBJECT_ID_CLAIM to UUID.randomUUID().toString(),
            ),
            issuerId = issuerId,
        ).serialize()
    }

    private fun issueToken(
        issuerId: String,
        subject: String = UUID.randomUUID().toString(),
        audience: String,
        claims: Map<String, Any> = emptyMap(),
        expiry: Long = 3600,
    ): SignedJWT {
        val issuerUrl = "$baseEndpointUrl/$issuerId"
        val tokenCallback = DefaultOAuth2TokenCallback(
            issuerId,
            subject,
            JOSEObjectType.JWT.type,
            listOf(audience),
            claims,
            expiry,
        )

        val tokenRequest = TokenRequest(
            URI.create(baseEndpointUrl),
            ClientSecretBasic(ClientID(issuerId), Secret("secret")),
            AuthorizationCodeGrant(AuthorizationCode(FNR), URI.create("http://localhost")),
            Scope(audience),
        )
        return config.tokenProvider.accessToken(tokenRequest, issuerUrl.toHttpUrl(), tokenCallback, null)
    }

    fun envVars() =
        mapOf(
            "AZURE_APP_CLIENT_ID" to "lydia-api",
            "AZURE_APP_CLIENT_SECRET" to "AZURE_APP_CLIENT_SECRET",
            "AZURE_OPENID_CONFIG_ISSUER" to "$baseEndpointUrl/default",
            "AZURE_OPENID_CONFIG_TOKEN_ENDPOINT" to "$baseEndpointUrl/default/token",
            "AZURE_APP_JWK" to
                """
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
            "AZURE_OPENID_CONFIG_JWKS_URI" to "$baseEndpointUrl/default/jwks",
            "FIA_SUPERBRUKER_GROUP_ID" to SUPERBRUKER_GROUP_ID,
            "FIA_SAKSBEHANDLER_GROUP_ID" to SAKSBEHANDLER_GROUP_ID,
            "FIA_LESETILGANG_GROUP_ID" to LESETILGANG_GROUP_ID,
            "TEAM_PIA_GROUP_ID" to TEAM_PLA_GROUP_ID,
        )
}
