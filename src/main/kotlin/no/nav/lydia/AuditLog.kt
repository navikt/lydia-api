package no.nav.lydia

import com.github.guepardoapps.kulid.ULID
import io.ktor.server.application.*
import io.ktor.server.auth.*
import io.ktor.server.auth.jwt.*
import io.ktor.server.request.*
import io.ktor.util.pipeline.*
import no.nav.lydia.NaisEnvironment.Companion.Environment.LOKALT
import no.nav.lydia.NaisEnvironment.Companion.Environment.PROD_GCP
import no.nav.lydia.Security.Companion.NAV_IDENT_CLAIM
import org.slf4j.LoggerFactory

private val auditLog = LoggerFactory.getLogger("auditLog")

enum class AuditType {
    access, update, create
}

enum class Tilgang(val tilgang: String) {
    Ja("Permit"), Nei("Deny")
}

fun PipelineContext<Unit, ApplicationCall>.auditLog(orgnr: String, auditType: AuditType, tilgang: Tilgang, sakId: String? = null) {
    call.principal<JWTPrincipal>()?.let { principal ->
        val uri = call.request.uri
        val method = call.request.httpMethod.value
        principal.payload.claims?.get(NAV_IDENT_CLAIM)?.asString()?.let { navIdent ->
            auditLog(navIdent = navIdent, uri = uri, method = method, orgnr = orgnr, auditType = auditType, tilgang = tilgang, sakId = sakId)
        }
    }
}

private fun auditLog(navIdent: String, uri: String, method: String, orgnr: String, auditType: AuditType, tilgang: Tilgang, sakId: String?) {
    val logstring =
        "CEF:0|lydia-api|auditLog|1.0|audit:${auditType.name}|lydia-api|INFO|end=${System.currentTimeMillis()} " +
                "suid=$navIdent " +
                "duid=$orgnr " +
                "sproc=${ULID.random()} " +
                "requestMethod=$method " +
                "request=${
                    uri.substring(
                        0,
                        uri.length.coerceAtMost(70)
                    )
                } " +
                "flexString1Label=Decision " +
                "flexString1=${tilgang.tilgang}" +
                (sakId?.let { " flexString2Label=sakId flexString2=$it" } ?: "")

    when(NaisEnvironment.miljø()) {
        PROD_GCP -> auditLog.info(logstring)
        LOKALT -> auditLog.info(logstring)
        else -> Unit
    }
}