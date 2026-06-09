package no.nav.lydia.abc.api

import io.ktor.http.HttpStatusCode
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.get
import no.nav.lydia.ADGrupper
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.abc.dokument.DokumentPubliseringDto
import no.nav.lydia.abc.dokument.DokumentPubliseringService
import no.nav.lydia.abc.samarbeid.IASamarbeidFeil
import no.nav.lydia.abc.samarbeidsperiode.IASakService
import no.nav.lydia.abc.samarbeidsperiode.IA_SAK_RADGIVER_PATH
import no.nav.lydia.abc.samarbeidsplan.tilDtoMedPubliseringStatus
import no.nav.lydia.ia.sak.PlanService
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.extensions.orgnummer
import no.nav.lydia.ia.sak.api.extensions.prosessId
import no.nav.lydia.ia.sak.api.extensions.saksnummer
import no.nav.lydia.ia.sak.api.extensions.sendFeil
import no.nav.lydia.tilgangskontroll.somLesebruker

const val PLAN_BASE_ROUTE = "$IA_SAK_RADGIVER_PATH/plan"

fun Route.iaSakPlan(
    planService: PlanService,
    iaSakService: IASakService,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
    dokumentPubliseringService: DokumentPubliseringService,
) {
    get("$PLAN_BASE_ROUTE/mal") {
        call.somLesebruker(adGrupper = adGrupper) { _ ->
            iaSakService.hentMal()
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    get("$PLAN_BASE_ROUTE/{orgnummer}/{saksnummer}/prosess/{prosessId}") {
        val orgnummer = call.orgnummer ?: return@get call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@get call.sendFeil(IASakError.`ugyldig saksnummer`)
        val samarbeidId = call.prosessId ?: return@get call.sendFeil(IASamarbeidFeil.`ugyldig samarbeidId`)
        call.somLesebruker(adGrupper = adGrupper) { _ ->
            planService.hentPlan(samarbeidId = samarbeidId)
        }.also { planEither ->
            auditLog.auditloggEither(
                call = call,
                either = planEither,
                orgnummer = orgnummer,
                auditType = AuditType.create,
                saksnummer = saksnummer,
            )
        }.map { plan ->
            val publiseringStatus = dokumentPubliseringService.hentPubliseringStatus(plan.id, DokumentPubliseringDto.Type.SAMARBEIDSPLAN)

            call.respond(
                status = HttpStatusCode.OK,
                message = plan.tilDtoMedPubliseringStatus(publiseringStatus),
            )
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }
}
