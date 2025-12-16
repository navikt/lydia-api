package no.nav.lydia.ia.sak.api.samarbeid

import arrow.core.flatMap
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.get
import no.nav.lydia.ADGrupper
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.IASamarbeidFeil
import no.nav.lydia.ia.sak.IASamarbeidService
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.IA_SAK_RADGIVER_PATH
import no.nav.lydia.ia.sak.api.extensions.orgnummer
import no.nav.lydia.ia.sak.api.extensions.prosessId
import no.nav.lydia.ia.sak.api.extensions.saksnummer
import no.nav.lydia.ia.sak.api.extensions.sendFeil
import no.nav.lydia.tilgangskontroll.somLesebruker
import no.nav.lydia.tilgangskontroll.somSaksbehandler

fun Route.iaSamarbeid(
    samarbeidService: IASamarbeidService,
    iaSakService: IASakService,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
) {
    get("$IA_SAK_RADGIVER_PATH/{orgnummer}/{saksnummer}/{prosessId}/kan/{status}") {
        val saksnummer = call.saksnummer ?: return@get call.sendFeil(IASakError.`ugyldig saksnummer`)
        val samarbeid = call.prosessId ?: return@get call.sendFeil(IASamarbeidFeil.`ugyldig samarbeidId`)
        val statusEndring = call.parameters["status"] ?: return@get call.sendFeil(Feil("mangler status", HttpStatusCode.BadRequest))

        call.somSaksbehandler(adGrupper) {
            iaSakService.hentIASak(saksnummer = saksnummer).flatMap { iaSak ->
                when (statusEndring) {
                    "fullfores" -> samarbeidService.kanFullføreSamarbeid(saksnummer = iaSak.saksnummer, samarbeidId = samarbeid).right()
                    "slettes" -> samarbeidService.kanSletteSamarbeid(saksnummer = iaSak.saksnummer, samarbeidId = samarbeid).right()
                    "avbrytes" -> samarbeidService.kanAvbryteSamarbeid(saksnummer = iaSak.saksnummer, samarbeidId = samarbeid).right()
                    else -> Feil(feilmelding = "ugyldig statusendring", httpStatusCode = HttpStatusCode.BadRequest).left()
                }
            }
        }.map { kanGjennomføres ->
            call.respond(kanGjennomføres)
        }.mapLeft {
            call.respond(message = it.feilmelding, status = it.httpStatusCode)
        }
    }

    get("$IA_SAK_RADGIVER_PATH/{orgnummer}/{saksnummer}/prosesser") {
        val orgnummer = call.orgnummer ?: return@get call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@get call.sendFeil(IASakError.`ugyldig saksnummer`)
        call.somLesebruker(adGrupper) {
            samarbeidService.hentSamarbeid(saksnummer = saksnummer)
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
