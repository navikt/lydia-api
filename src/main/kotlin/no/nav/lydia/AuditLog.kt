package no.nav.lydia

import com.github.guepardoapps.kulid.ULID
import no.nav.lydia.NaisEnvironment.Companion.Environment
import no.nav.lydia.NaisEnvironment.Companion.Environment.PROD_GCP
import org.slf4j.LoggerFactory


enum class AuditType {
    access, update, create
}

enum class Tilgang(val tilgang: String) {
    Ja("Permit"), Nei("Deny")
}

class AuditLog(val miljø: Environment) {
    private val auditLog = LoggerFactory.getLogger("auditLog")
    private val fiaLog = LoggerFactory.getLogger(this::class.java)

    private fun auditLog(
        navIdent: String,
        uri: String,
        method: String,
        orgnr: String,
        auditType: AuditType,
        tilgang: Tilgang,
        sakId: String?
    ) {
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

        when (miljø) {
            PROD_GCP -> auditLog.info(logstring)
            else -> fiaLog.info(logstring)
        }
    }

}
