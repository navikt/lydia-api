package no.nav.lydia.ia.sak.api.plan

import arrow.core.flatMap
import io.ktor.http.HttpStatusCode
import io.ktor.server.application.application
import io.ktor.server.application.call
import io.ktor.server.application.log
import io.ktor.server.request.receive
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.get
import io.ktor.server.routing.post
import io.ktor.server.routing.put
import kotlinx.datetime.LocalDate
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
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema
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

    post("$PLAN_BASE_ROUTE/{orgnummer}/{saksnummer}/prosess/{prosessId}/opprett") {
        val orgnummer = call.orgnummer ?: return@post call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@post call.sendFeil(IASakError.`ugyldig saksnummer`)
        val prosessId = call.prosessId ?: return@post call.sendFeil(IAProsessFeil.`ugyldig prosessId`)
        val planMalDto = call.receive<PlanMalDto>()

        if (!planMalDto.erPlanGyldig()) {
            application.log.info("Plan er ikke gyldig")
            return@post call.sendFeil(IASakError.`ugyldig plan`)
        }

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

        val undertemaEndring = call.receive<List<EndreUndertemaRequest>>()

        if (!undertemaEndring.erDatoGyldigForInnhold()) {
            application.log.info("Plan er ikke gyldig")
            return@put call.sendFeil(IASakError.`ugyldig plan`)
        }

        call.somEierAvSakIProsess(iaSakService = iaSakService, adGrupper = adGrupper) { _, iaSak ->
            planService.endreUndertemaerTilTema(
                temaId = temaId,
                iaSak = iaSak,
                prosessId = prosessId,
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

        val nyStatus = call.receive<PlanUndertema.Status>()

        call.somEierAvSakIProsess(iaSakService = iaSakService, adGrupper = adGrupper) { _, iaSak ->
            planService.endreStatus(
                temaId = temaId,
                undertemaId = undertemaId,
                iaSak = iaSak,
                prosessId = prosessId,
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

    put("$PLAN_BASE_ROUTE/{orgnummer}/{saksnummer}/prosess/{prosessId}") {
        val orgnummer = call.orgnummer ?: return@put call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@put call.sendFeil(IASakError.`ugyldig saksnummer`)
        val prosessId = call.prosessId ?: return@put call.sendFeil(IAProsessFeil.`ugyldig prosessId`)

        val endreTemaRequests = call.receive<List<EndreTemaRequest>>()

        if (!endreTemaRequests.erEndretTemaGyldig()) {
            application.log.info("Plan er ikke gyldig")
            return@put call.sendFeil(IASakError.`ugyldig plan`)
        }

        call.somEierAvSakIProsess(iaSakService = iaSakService, adGrupper = adGrupper) { _, iaSak ->
            planService.endreFlereTema(
                iaSak = iaSak,
                prosessId = prosessId,
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

    get("$PLAN_BASE_ROUTE/{orgnummer}/{saksnummer}/prosess/{prosessId}") {
        val orgnummer = call.orgnummer ?: return@get call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@get call.sendFeil(IASakError.`ugyldig saksnummer`)
        val prosessId = call.prosessId ?: return@get call.sendFeil(IAProsessFeil.`ugyldig prosessId`)
        call.somLesebruker(adGrupper = adGrupper) { _ ->
            iaSakService.hentIASak(saksnummer = saksnummer).flatMap { iaSak ->
                planService.hentPlan(
                    iaSak = iaSak,
                    prosessId = prosessId
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

private fun PlanMalDto.erPlanGyldig(): Boolean =
    tema.all {
        it.innhold.all { innhold -> erDatoerIGyldigPeriode(sluttDato = innhold.sluttDato, startDato = innhold.startDato) }
    } &&
        tema.all {
            it.inkludert ||
                it.innhold.all { innhold ->
                    innhold.sluttDato == null && innhold.startDato == null && !innhold.inkludert
                }
        }

private fun List<EndreUndertemaRequest>.erDatoGyldigForInnhold(): Boolean =
    this.all { innhold ->
        erDatoerIGyldigPeriode(sluttDato = innhold.sluttDato, startDato = innhold.startDato)
    }

private fun List<EndreTemaRequest>.erEndretTemaGyldig(): Boolean =
    this.all { it.undertemaer.erDatoGyldigForInnhold() } &&
        this.all { tema ->
            if (tema.inkludert) {
                true
            } else {
                tema.undertemaer.all { innhold ->
                    innhold.sluttDato == null && innhold.startDato == null && !innhold.inkludert
                }
            }
        }

private fun erDatoerIGyldigPeriode(
    sluttDato: LocalDate?,
    startDato: LocalDate?,
) = if (sluttDato == null || startDato == null) {
    true
} else {
    sluttDato > startDato
}
