package no.nav.lydia.konfigurasjon

import com.auth0.jwk.JwkProviderBuilder
import com.auth0.jwt.interfaces.Claim
import com.auth0.jwt.interfaces.DecodedJWT
import io.ktor.server.application.Application
import io.ktor.server.application.install
import io.ktor.server.application.log
import io.ktor.server.auth.Authentication
import io.ktor.server.auth.jwt.JWTPrincipal
import io.ktor.server.auth.jwt.jwt
import no.nav.lydia.NaisEnvironment
import java.util.concurrent.TimeUnit

fun Application.configureSecurity(naisEnv: NaisEnvironment) {
    val azureJwkProvider = JwkProviderBuilder(naisEnv.security.azureConfig.jwksUri)
        .cached(10, 24, TimeUnit.HOURS)
        .rateLimited(10, 1, TimeUnit.MINUTES)
        .build()

    val tokenxJwkProvider = JwkProviderBuilder(naisEnv.security.tokenXConfig.tokenxJwksUri)
        .cached(10, 24, TimeUnit.HOURS)
        .rateLimited(10, 1, TimeUnit.MINUTES)
        .build()

    install(Authentication) {
        jwt(name = "tokenx") {
            val tokenFortsattGyldigFørUtløpISekunder = 3L
            verifier(tokenxJwkProvider, issuer = naisEnv.security.tokenXConfig.tokenxIssuer) {
                acceptLeeway(tokenFortsattGyldigFørUtløpISekunder)
                withAudience(naisEnv.security.tokenXConfig.tokenxClientId)
                withClaim("acr") { claim: Claim, _: DecodedJWT ->
                    claim.asString().equals("Level4") || claim.asString().equals("idporten-loa-high")
                }
                withClaimPresence("pid")
            }
            validate { token ->
                JWTPrincipal(token.payload)
            }
        }

        jwt(name = "azure") {
            verifier(azureJwkProvider, naisEnv.security.azureConfig.issuer)
            validate { token ->
                try {
                    requireNotNull(token.payload.audience) {
                        "Auth: Missing audience in token"
                    }
                    require(token.payload.audience.contains(naisEnv.security.azureConfig.clientId)) {
                        "Auth: Valid audience not found in claims"
                    }
                    JWTPrincipal(token.payload)
                } catch (e: Throwable) {
                    application.log.error("Feil under autentisering")
                    application.log.error(e.message)
                    null
                }
            }
        }
    }
}
