package no.nav.lydia.ia.sak.api.prosess

import arrow.core.flatMap
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.get
import no.nav.lydia.ADGrupper
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.ia.sak.IAProsessService
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.IA_SAK_RADGIVER_PATH
import no.nav.lydia.ia.sak.api.extensions.orgnummer
import no.nav.lydia.ia.sak.api.extensions.saksnummer
import no.nav.lydia.ia.sak.api.extensions.sendFeil
import no.nav.lydia.tilgangskontroll.somLesebruker

fun Route.iaProsessApi(
    iaProsessService: IAProsessService,
    iaSakService: IASakService,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
) {
    get("$IA_SAK_RADGIVER_PATH/{orgnummer}/{saksnummer}/prosesser") {
        val orgnummer = call.orgnummer ?: return@get call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@get call.sendFeil(IASakError.`ugyldig saksnummer`)
        call.somLesebruker(adGrupper) {
            iaSakService.hentIASak(saksnummer = saksnummer).flatMap { iaSak ->
                iaProsessService.hentIAProsesser(sak = iaSak)
            }
        }.also {
            auditLog.auditloggEither(
                call = call,
                either = it,
                orgnummer = orgnummer,
                auditType = AuditType.access,
                saksnummer = saksnummer,
            )
        }.map {
            call.respond(it.tilDto())
        }.mapLeft {
            call.respond(message = it.feilmelding, status = it.httpStatusCode)
        }
    }
}
