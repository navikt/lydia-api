package no.nav.fia

import arrow.core.Either
import com.github.guepardoapps.kulid.ULID
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.request.*
import io.ktor.util.pipeline.*
import no.nav.fia.NaisEnvironment.Companion.Environment
import no.nav.fia.NaisEnvironment.Companion.Environment.PROD_GCP
import no.nav.fia.ia.sak.api.Feil
import no.nav.fia.ia.sak.api.IASakDto
import no.nav.fia.tilgangskontroll.navIdent
import org.slf4j.LoggerFactory


enum class AuditType {
    access, update, create
}

enum class Tillat(val tillat: String) {
    Ja("Permit"), Nei("Deny")
}

class AuditLog(val miljø: Environment) {
    private val auditLog = LoggerFactory.getLogger("auditLog")
    private val fiaLog = LoggerFactory.getLogger(this::class.java)

    fun log(
        navIdent: String,
        uri: String,
        method: String,
        orgnummer: String,
        auditType: AuditType,
        tillat: Tillat,
        saksnummer: String?
    ) {
        val logstring =
            "CEF:0|lydia-api|auditLog|1.0|audit:${auditType.name}|lydia-api|INFO|end=${System.currentTimeMillis()} " +
                    "suid=$navIdent " +
                    "duid=$orgnummer " +
                    "sproc=${ULID.random()} " +
                    "requestMethod=$method " +
                    "request=${
                        uri.substring(
                            0,
                            uri.length.coerceAtMost(70)
                        )
                    } " +
                    "flexString1Label=Decision " +
                    "flexString1=${tillat.tillat}" +
                    (saksnummer?.let { " flexString2Label=saksnummer flexString2=$it" } ?: "")

        when (miljø) {
            PROD_GCP -> auditLog.info(logstring)
            else -> fiaLog.info(logstring)
        }
    }

    fun auditloggEither(
        call: ApplicationCall,
        either: Either<Feil, IASakDto>,
        orgnummer: String,
        saksnummer: String?,
        auditType: AuditType
    ) {
        val tillat = when (either) {
            is Either.Left -> either.value.httpStatusCode.tilTillat()
            else -> Tillat.Ja
        }

        call.navIdent()?.let { navIdent ->
            log(
                navIdent = navIdent,
                uri = call.request.uri,
                method = call.request.httpMethod.value,
                orgnummer = orgnummer,
                auditType = auditType,
                tillat = tillat,
                saksnummer = saksnummer
            )
        }
    }

    fun HttpStatusCode.tilTillat() =
        when (this) {
            HttpStatusCode.Forbidden, HttpStatusCode.Unauthorized -> Tillat.Nei
            else -> Tillat.Ja
        }
}

fun PipelineContext<Unit, ApplicationCall>.auditLog(
    auditLog: AuditLog,
    orgnummer: String,
    auditType: AuditType,
    tillat: Tillat,
    saksnummer: String? = null
) {
    call.navIdent()?.let { navIdent ->
        auditLog.log(
            navIdent = navIdent,
            uri = call.request.uri,
            method = call.request.httpMethod.value,
            orgnummer = orgnummer,
            auditType = auditType,
            tillat = tillat,
            saksnummer = saksnummer
        )
    }
}
