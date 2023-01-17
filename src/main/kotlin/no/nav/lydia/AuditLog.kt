package no.nav.lydia

import arrow.core.Either
import com.github.guepardoapps.kulid.ULID
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.request.*
import no.nav.lydia.NaisEnvironment.Companion.Environment
import no.nav.lydia.NaisEnvironment.Companion.Environment.`PROD-GCP`
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.tilgangskontroll.innloggetNavIdent
import org.slf4j.LoggerFactory


enum class AuditType {
    access, update, create
}

enum class Tillat(val tillat: String) {
    Ja("Permit"), Nei("Deny")
}

class AuditLog(val miljø: Environment) {
    private val auditLog = LoggerFactory.getLogger("auditLogger")
    private val fiaLog = LoggerFactory.getLogger(this::class.java)

    fun log(
        navIdent: String,
        uri: String,
        method: String,
        orgnummer: String?,
        auditType: AuditType,
        tillat: Tillat,
        saksnummer: String?,
        melding: String?,
        severity: String
    ) {
        val logstring =
            "CEF:0|fia-api|auditLog|1.0|audit:${auditType.name}|fia-api|$severity|end=${System.currentTimeMillis()} " +
                    "suid=$navIdent " +
                    (orgnummer?.let { "duid=$it " } ?: "") +
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
                    (saksnummer?.let { " flexString2Label=saksnummer flexString2=$it" } ?: "") +
                    (melding?.let { " msg=$it" } ?: "")

        when (miljø) {
            `PROD-GCP` -> auditLog.info(logstring)
            Environment.`DEV-GCP` -> Unit
            Environment.LOKAL -> fiaLog.info(logstring)
        }
    }

    fun auditloggEither(
        call: ApplicationCall,
        either: Either<Feil, Any>,
        orgnummer: String?,
        saksnummer: String? = null,
        melding: String? = null,
        auditType: AuditType,
        severity: String = if (orgnummer.isNullOrEmpty()) "WARN" else "INFO"
    ) {
        val tillat = when (either) {
            is Either.Left -> either.value.httpStatusCode.tilTillat()
            else -> Tillat.Ja
        }

        call.innloggetNavIdent()?.let { navIdent ->
            log(
                navIdent = navIdent,
                uri = call.request.uri,
                method = call.request.httpMethod.value,
                orgnummer = orgnummer,
                auditType = auditType,
                tillat = tillat,
                saksnummer = saksnummer,
                melding = melding,
                severity = severity
            )
        }
    }

    fun HttpStatusCode.tilTillat() =
        when (this) {
            HttpStatusCode.Forbidden, HttpStatusCode.Unauthorized -> Tillat.Nei
            else -> Tillat.Ja
        }
}
