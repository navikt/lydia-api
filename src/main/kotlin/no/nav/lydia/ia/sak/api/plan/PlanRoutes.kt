package no.nav.lydia.ia.sak.api.plan

import arrow.core.flatMap
import ia.felles.integrasjoner.kafkameldinger.eksport.InnholdStatus
import io.ktor.http.HttpStatusCode
import io.ktor.server.request.receive
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.delete
import io.ktor.server.routing.get
import io.ktor.server.routing.post
import io.ktor.server.routing.put
import no.nav.lydia.ADGrupper
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.ia.sak.IAProsessFeil
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.PlanService
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.IA_SAK_RADGIVER_PATH
import no.nav.lydia.ia.sak.api.extensions.orgnummer
import no.nav.lydia.ia.sak.api.extensions.prosessId
import no.nav.lydia.ia.sak.api.extensions.saksnummer
import no.nav.lydia.ia.sak.api.extensions.sendFeil
import no.nav.lydia.ia.sak.api.extensions.temaId
import no.nav.lydia.ia.sak.api.spørreundersøkelse.somEierAvSakIProsess
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.tilgangskontroll.somLesebruker

const val PLAN_BASE_ROUTE = "$IA_SAK_RADGIVER_PATH/plan"

fun Route.iaSakPlan(
    planService: PlanService,
    iaSakService: IASakService,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
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
        val samarbeidId = call.prosessId ?: return@get call.sendFeil(IAProsessFeil.`ugyldig prosessId`)
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
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it.tilDto())
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    post("$PLAN_BASE_ROUTE/{orgnummer}/{saksnummer}/prosess/{prosessId}/opprett") {
        val orgnummer = call.orgnummer ?: return@post call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@post call.sendFeil(IASakError.`ugyldig saksnummer`)
        val prosessId = call.prosessId ?: return@post call.sendFeil(IAProsessFeil.`ugyldig prosessId`)
        val planMalDto = call.receive<PlanMalDto>()

        call.somEierAvSakIProsess(iaSakService = iaSakService, adGrupper = adGrupper) { saksbehandler, iaSak ->
            planService.opprettPlan(
                iaSak = iaSak,
                saksbehandler = saksbehandler,
                prosessId = prosessId,
                mal = planMalDto,
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

    delete("$PLAN_BASE_ROUTE/{orgnummer}/{saksnummer}/prosess/{prosessId}") {
        val orgnummer = call.orgnummer ?: return@delete call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@delete call.sendFeil(IASakError.`ugyldig saksnummer`)
        val samarbeidId = call.prosessId ?: return@delete call.sendFeil(IAProsessFeil.`ugyldig prosessId`)

        call.somEierAvSakIProsess(
            iaSakService = iaSakService,
            adGrupper = adGrupper,
        ) { _, _ ->
            planService.slettPlan(samarbeidId)
        }.also { planEither ->
            auditLog.auditloggEither(
                call = call,
                either = planEither,
                orgnummer = orgnummer,
                auditType = AuditType.delete,
                saksnummer = saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.Created, message = it.tilDto())
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    put("$PLAN_BASE_ROUTE/{orgnummer}/{saksnummer}/prosess/{prosessId}") {
        val orgnummer = call.orgnummer ?: return@put call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@put call.sendFeil(IASakError.`ugyldig saksnummer`)
        val samarbeidId = call.prosessId ?: return@put call.sendFeil(IAProsessFeil.`ugyldig prosessId`)
        val endreTemaRequests = call.receive<List<EndreTemaRequest>>()

        call.somEierAvSakIProsess(iaSakService = iaSakService, adGrupper = adGrupper) { _, _ ->
            planService.hentPlan(samarbeidId = samarbeidId).flatMap { lagretPlan ->
                planService.endreFlereTemaer(
                    lagretPlan = lagretPlan,
                    endringAvPlan = endreTemaRequests,
                )
            }
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

    put("$PLAN_BASE_ROUTE/{orgnummer}/{saksnummer}/prosess/{prosessId}/{temaId}") {
        val orgnummer = call.orgnummer ?: return@put call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@put call.sendFeil(IASakError.`ugyldig saksnummer`)
        val prosessId = call.prosessId ?: return@put call.sendFeil(IAProsessFeil.`ugyldig prosessId`)
        val temaId = call.temaId ?: return@put call.sendFeil(
            Feil(
                feilmelding = "Ugyldig temaId",
                httpStatusCode = HttpStatusCode.BadRequest,
            ),
        )

        val nyttInnholdListe = call.receive<List<EndreUndertemaRequest>>()

        call.somEierAvSakIProsess(iaSakService = iaSakService, adGrupper = adGrupper) { _, _ ->
            planService.hentPlan(samarbeidId = prosessId).flatMap { lagretPlan ->
                planService.endreEttTema(
                    lagretPlan = lagretPlan,
                    temaId = temaId,
                    nyttInnholdListe = nyttInnholdListe,
                )
            }
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

    put("$PLAN_BASE_ROUTE/{orgnummer}/{saksnummer}/prosess/{prosessId}/{temaId}/{undertemaId}") {
        val orgnummer = call.orgnummer ?: return@put call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@put call.sendFeil(IASakError.`ugyldig saksnummer`)
        val prosessId = call.prosessId ?: return@put call.sendFeil(IAProsessFeil.`ugyldig prosessId`)
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

        val nyStatus = call.receive<InnholdStatus>()

        call.somEierAvSakIProsess(iaSakService = iaSakService, adGrupper = adGrupper) { _, _ ->
            planService.hentPlan(samarbeidId = prosessId).flatMap { lagretPlan ->
                planService.endreStatus(
                    temaId = temaId,
                    undertemaId = undertemaId,
                    lagretPlan = lagretPlan,
                    nyStatus = nyStatus,
                )
            }
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
