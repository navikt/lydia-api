package no.nav.lydia

import arrow.core.Either
import com.github.guepardoapps.kulid.ULID
import io.ktor.http.HttpStatusCode
import io.ktor.server.application.ApplicationCall
import io.ktor.server.request.httpMethod
import io.ktor.server.request.uri
import no.nav.lydia.NaisEnvironment.Companion.Environment
import no.nav.lydia.NaisEnvironment.Companion.Environment.`PROD-GCP`
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.tilgangskontroll.fia.innloggetNavIdent
import org.slf4j.LoggerFactory

enum class AuditType {
    @Suppress("ktlint:standard:enum-entry-name-case")
    access,

    @Suppress("ktlint:standard:enum-entry-name-case")
    update,

    @Suppress("ktlint:standard:enum-entry-name-case")
    create,

    @Suppress("ktlint:standard:enum-entry-name-case")
    delete,
}

enum class Tillat(
    val tillat: String,
) {
    Ja("Permit"),
    Nei("Deny"),
}

class AuditLog(
    val miljø: Environment,
) {
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
        severity: String,
        feilkode: String? = null,
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
                        uri.length.coerceAtMost(70),
                    )
                } " +
                "flexString1Label=Decision " +
                "flexString1=${tillat.tillat}" +
                (saksnummer?.let { " flexString2Label=saksnummer flexString2=$it" } ?: "") +
                (melding?.let { " msg=$it" } ?: "") +
                (feilkode?.let { " flexString3Label=feilkode flexString3=$it" })

        when (miljø) {
            `PROD-GCP` -> auditLog.info(logstring)
            Environment.`DEV-GCP` -> Unit
            Environment.LOKAL -> fiaLog.info(logstring)
        }
    }

    fun auditloggEither(
        call: ApplicationCall,
        either: Either<Feil, Any?>,
        orgnummer: String?,
        saksnummer: String? = null,
        melding: String? = null,
        auditType: AuditType,
        severity: String = if (orgnummer.isNullOrEmpty()) "WARN" else "INFO",
    ) {
        val tillat = when (either) {
            is Either.Left -> either.value.httpStatusCode.tilTillat()
            else -> Tillat.Ja
        }
        val feilkode: String? = either.leftOrNull()?.httpStatusCode?.value?.toString()

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
                severity = severity,
                feilkode = feilkode,
            )
        }
    }

    private fun HttpStatusCode.tilTillat() =
        when (this) {
            HttpStatusCode.Forbidden, HttpStatusCode.Unauthorized -> Tillat.Nei
            else -> Tillat.Ja
        }
}
