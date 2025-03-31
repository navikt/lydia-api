package no.nav.lydia.ia.sak.api.prosess

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
import no.nav.lydia.ia.sak.IAProsessFeil
import no.nav.lydia.ia.sak.IAProsessService
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.IA_SAK_RADGIVER_PATH
import no.nav.lydia.ia.sak.api.KanFullføreSamarbeidDto
import no.nav.lydia.ia.sak.api.KanSletteSamarbeidDto
import no.nav.lydia.ia.sak.api.extensions.orgnummer
import no.nav.lydia.ia.sak.api.extensions.prosessId
import no.nav.lydia.ia.sak.api.extensions.saksnummer
import no.nav.lydia.ia.sak.api.extensions.sendFeil
import no.nav.lydia.tilgangskontroll.somLesebruker
import no.nav.lydia.tilgangskontroll.somSaksbehandler

fun Route.iaProsessApi(
    iaProsessService: IAProsessService,
    iaSakService: IASakService,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
) {
    get("$IA_SAK_RADGIVER_PATH/{orgnummer}/{saksnummer}/{prosessId}/kan/{status}") {
        val saksnummer = call.saksnummer ?: return@get call.sendFeil(IASakError.`ugyldig saksnummer`)
        val samarbeid = call.prosessId ?: return@get call.sendFeil(IAProsessFeil.`ugyldig prosessId`)
        val statusEndring = call.parameters["status"] ?: return@get call.sendFeil(Feil("mangler status", HttpStatusCode.BadRequest))

        call.somSaksbehandler(adGrupper) {
            iaSakService.hentIASak(saksnummer = saksnummer).flatMap { iaSak ->
                when (statusEndring) {
                    "fullfores" -> iaProsessService.kanFullføreProsess(sak = iaSak, samarbeidsId = samarbeid).right()
                    "slettes" -> iaProsessService.kanSletteProsess(sak = iaSak, samarbeidsId = samarbeid).right()
                    else -> Feil(feilmelding = "ugyldig statusendring", httpStatusCode = HttpStatusCode.BadRequest).left()
                }
            }
        }.map { kanGjennomføres ->
            call.respond(kanGjennomføres)
        }.mapLeft {
            call.respond(message = it.feilmelding, status = it.httpStatusCode)
        }
    }

    get("$IA_SAK_RADGIVER_PATH/{orgnummer}/{saksnummer}/{prosessId}/kanfullfores") {
        val saksnummer = call.saksnummer ?: return@get call.sendFeil(IASakError.`ugyldig saksnummer`)
        val samarbeid = call.prosessId ?: return@get call.sendFeil(IAProsessFeil.`ugyldig prosessId`)
        call.somSaksbehandler(adGrupper) {
            iaSakService.hentIASak(saksnummer = saksnummer).map { iaSak ->
                iaProsessService.kanFullføreProsess(iaSak, samarbeid)
            }
        }.map { kanGjennomføres ->
            call.respond(
                KanFullføreSamarbeidDto(
                    kanFullføres = kanGjennomføres.kanGjennomføres,
                    begrunnelser = kanGjennomføres.blokkerende + kanGjennomføres.advarsler,
                ),
            )
        }.mapLeft {
            call.respond(message = it.feilmelding, status = it.httpStatusCode)
        }
    }
    get("$IA_SAK_RADGIVER_PATH/{orgnummer}/{saksnummer}/{prosessId}/kanslettes") {
        val saksnummer = call.saksnummer ?: return@get call.sendFeil(IASakError.`ugyldig saksnummer`)
        val samarbeid = call.prosessId ?: return@get call.sendFeil(IAProsessFeil.`ugyldig prosessId`)

        call.somSaksbehandler(adGrupper) {
            iaSakService.hentIASak(saksnummer = saksnummer).map { iaSak ->
                iaProsessService.kanSletteProsess(iaSak, samarbeid)
            }
        }.map { kanGjennomføres ->
            call.respond(
                KanSletteSamarbeidDto(
                    kanSlettes = kanGjennomføres.kanGjennomføres,
                    begrunnelser = kanGjennomføres.blokkerende + kanGjennomføres.advarsler,
                ),
            )
        }.mapLeft {
            call.respond(message = it.feilmelding, status = it.httpStatusCode)
        }
    }
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
