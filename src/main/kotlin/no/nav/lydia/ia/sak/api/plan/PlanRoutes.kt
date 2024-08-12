package no.nav.lydia.ia.sak.api.plan

import io.ktor.http.HttpStatusCode
import io.ktor.server.application.call
import io.ktor.server.request.receive
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.get
import io.ktor.server.routing.post
import io.ktor.server.routing.put
import no.nav.lydia.ADGrupper
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.PlanService
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.IA_SAK_RADGIVER_PATH
import no.nav.lydia.ia.sak.api.extensions.orgnummer
import no.nav.lydia.ia.sak.api.extensions.saksnummer
import no.nav.lydia.ia.sak.api.extensions.sendFeil
import no.nav.lydia.ia.sak.api.extensions.temaId
import no.nav.lydia.ia.sak.api.spørreundersøkelse.somEierAvSakIProsess
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema

const val PLAN_BASE_ROUTE = "$IA_SAK_RADGIVER_PATH/plan"

fun Route.iaSakPlan(
    planService: PlanService,
    iaSakService: IASakService,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
) {
    put("$PLAN_BASE_ROUTE/{orgnummer}/{saksnummer}/{temaId}") {
        val orgnummer = call.orgnummer ?: return@put call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@put call.sendFeil(IASakError.`ugyldig saksnummer`)
        val temaId = call.temaId ?: return@put call.sendFeil(
            Feil(
                feilmelding = "Ugyldig temaId",
                httpStatusCode = HttpStatusCode.BadRequest,
            ),
        )

        val undertemaEndring = call.receive<List<EndreUndertemaRequest>>()

        call.somEierAvSakIProsess(iaSakService = iaSakService, adGrupper = adGrupper) { _, iaSak ->
            planService.endreUndertemaerTilTema(
                temaId = temaId,
                iaSak = iaSak,
                endredeUndertemaer = undertemaEndring,
            )
        }.also { planEither ->
            auditLog.auditloggEither(
                call = call,
                either = planEither,
                orgnummer = orgnummer,
                auditType = AuditType.create,
                saksnummer = saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it.tilDto())
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    put("$PLAN_BASE_ROUTE/{orgnummer}/{saksnummer}/{temaId}/{undertemaId}") {
        val orgnummer = call.orgnummer ?: return@put call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@put call.sendFeil(IASakError.`ugyldig saksnummer`)
        val temaId = call.temaId ?: return@put call.sendFeil(
            Feil(
                feilmelding = "Ugyldig temaId",
                httpStatusCode = HttpStatusCode.BadRequest,
            ),
        )
        val undertemaId = call.parameters["undertemaId"]?.toIntOrNull() ?: return@put call.sendFeil(
            Feil(
                feilmelding = "Ugyldig undertemaId",
                httpStatusCode = HttpStatusCode.BadRequest,
            ),
        )

        val nyStatus = call.receive<PlanUndertema.Status>()

        call.somEierAvSakIProsess(iaSakService = iaSakService, adGrupper = adGrupper) { _, iaSak ->
            planService.endreStatus(
                temaId = temaId,
                undertemaId = undertemaId,
                iaSak = iaSak,
                nyStatus = nyStatus,
            )
        }.also { planEither ->
            auditLog.auditloggEither(
                call = call,
                either = planEither,
                orgnummer = orgnummer,
                auditType = AuditType.create,
                saksnummer = saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it.tilDto())
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    put("$PLAN_BASE_ROUTE/{orgnummer}/{saksnummer}") {
        val orgnummer = call.orgnummer ?: return@put call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@put call.sendFeil(IASakError.`ugyldig saksnummer`)

        val endreTemaRequests = call.receive<List<EndreTemaRequest>>()

        call.somEierAvSakIProsess(iaSakService = iaSakService, adGrupper = adGrupper) { _, iaSak ->
            planService.endreFlereTema(
                iaSak = iaSak,
                endredeTema = endreTemaRequests,
            )
        }.also { planEither ->
            auditLog.auditloggEither(
                call = call,
                either = planEither,
                orgnummer = orgnummer,
                auditType = AuditType.create,
                saksnummer = saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it.tilDtoer())
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    post("$PLAN_BASE_ROUTE/{orgnummer}/{saksnummer}") {
        val orgnummer = call.orgnummer ?: return@post call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@post call.sendFeil(IASakError.`ugyldig saksnummer`)
        call.somEierAvSakIProsess(iaSakService = iaSakService, adGrupper = adGrupper) { saksbehandler, iaSak ->
            planService.opprettPlan(
                iaSak = iaSak,
                saksbehandler = saksbehandler,
            )
        }.also { planEither ->
            auditLog.auditloggEither(
                call = call,
                either = planEither,
                orgnummer = orgnummer,
                auditType = AuditType.create,
                saksnummer = saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.Created, message = it.tilDto())
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    get("$PLAN_BASE_ROUTE/{orgnummer}/{saksnummer}") {
        val orgnummer = call.orgnummer ?: return@get call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@get call.sendFeil(IASakError.`ugyldig saksnummer`)
        call.somEierAvSakIProsess(iaSakService = iaSakService, adGrupper = adGrupper) { _, iaSak ->
            planService.hentPlan(
                iaSak = iaSak,
            )
        }.also { planEither ->
            auditLog.auditloggEither(
                call = call,
                either = planEither,
                orgnummer = orgnummer,
                auditType = AuditType.create,
                saksnummer = saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it.tilDto())
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }
}
