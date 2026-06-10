package no.nav.lydia.api

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import io.ktor.http.HttpStatusCode
import io.ktor.server.application.ApplicationCall
import io.ktor.server.request.receive
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.delete
import io.ktor.server.routing.post
import io.ktor.server.routing.put
import no.nav.lydia.ADGrupper
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.dokumentpublisering.DokumentPubliseringService
import no.nav.lydia.felles.Feil
import no.nav.lydia.integrasjoner.azure.AzureService
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.samarbeid.IASamarbeidFeil
import no.nav.lydia.samarbeid.IASamarbeidService
import no.nav.lydia.samarbeidsperiode.IASakError
import no.nav.lydia.samarbeidsperiode.IASakService
import no.nav.lydia.samarbeidsplan.EndreTemaRequest
import no.nav.lydia.samarbeidsplan.EndreUndertemaRequest
import no.nav.lydia.samarbeidsplan.Plan
import no.nav.lydia.samarbeidsplan.PlanDto
import no.nav.lydia.samarbeidsplan.PlanMalDto
import no.nav.lydia.samarbeidsplan.PlanService
import no.nav.lydia.samarbeidsplan.PlanUndertema
import no.nav.lydia.samarbeidsplan.tilDtoMedPubliseringStatus
import no.nav.lydia.team.IATeamService
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import no.nav.lydia.tilgangskontroll.fia.objectId
import no.nav.lydia.tilgangskontroll.somSaksbehandler
import no.nav.lydia.tilstandsmaskin.FiaKontekst
import no.nav.lydia.tilstandsmaskin.NyFlytService
import no.nav.lydia.tilstandsmaskin.TilstandVirksomhetRepository
import no.nav.lydia.tilstandsmaskin.TilstandsmaskinBuilder
import no.nav.lydia.tilstandsmaskin.hendelse.EndreStatusPåUndertemaISamarbeidsplan
import no.nav.lydia.tilstandsmaskin.hendelse.OppdaterPlanForSamarbeid
import no.nav.lydia.tilstandsmaskin.hendelse.OppdaterTemaIPlanForSamarbeid
import no.nav.lydia.tilstandsmaskin.hendelse.OpprettPlanForSamarbeid
import no.nav.lydia.tilstandsmaskin.hendelse.SlettPlanForSamarbeid
import java.util.UUID

const val NY_FLYT_API_PATH = "api/v1"

fun Route.nyFlytSamarbeidsplan(
    iaSakService: IASakService,
    iASamarbeidService: IASamarbeidService,
    iaTeamService: IATeamService,
    nyFlytService: NyFlytService,
    dokumentPubliseringService: DokumentPubliseringService,
    planService: PlanService,
    tilstandVirksomhetRepository: TilstandVirksomhetRepository,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
    azureService: AzureService,
) {
    fun <T> ApplicationCall.somEierEllerFølgerAvSakMedNavenhet(
        iaSakService: IASakService,
        iaTeamService: IATeamService,
        adGrupper: ADGrupper,
        block: (NavAnsatt.NavAnsattMedSaksbehandlerRolle, NavEnhet, String, String) -> Either<Feil, T>,
    ) = somSaksbehandler(adGrupper) { saksbehandler ->
        val orgnummer = orgnummer ?: return@somSaksbehandler IASakError.`ugyldig orgnummer`.left()
        val saksnummer = saksnummer ?: return@somSaksbehandler IASakError.`ugyldig saksnummer`.left()
        val iaSak = iaSakService.hentIASakDto(saksnummer = saksnummer).getOrNull()
            ?: return@somSaksbehandler IASakError.`ugyldig saksnummer`.left()

        if (iaSak.orgnr != orgnummer) {
            IASakError.`ugyldig orgnummer`.left()
        } else if (!iaTeamService.erEierEllerFølgerAvSak(
                saksnummer = iaSak.saksnummer,
                eierAvSak = iaSak.eidAv,
                saksbehandler = saksbehandler,
            )
        ) {
            IASakError.`er ikke følger eller eier av sak`.left()
        } else {
            azureService.hentNavenhet(objectId()).flatMap { navEnhet ->
                block(saksbehandler, navEnhet, orgnummer, saksnummer)
            }
        }
    }

    fun tilstandsmaskin(orgnr: String) =
        TilstandsmaskinBuilder.medKontekst(
            fiaKontekst = FiaKontekst(
                iaSakService = iaSakService,
                iASamarbeidService = iASamarbeidService,
                nyFlytService = nyFlytService,
                dokumentPubliseringService = dokumentPubliseringService,
                planService = planService,
                tilstandVirksomhetRepository = tilstandVirksomhetRepository,
                saksnummer = nyFlytService.hentSisteIASakDto(orgnr)?.saksnummer,
            ),
        ).build(orgnr)

    // Opprett samarbeidsplan
    post("$NY_FLYT_API_PATH/virksomhet/{orgnummer}/samarbeidsperiode/{saksnummer}/samarbeid/{samarbeidId}/plan") {
        val orgnrUrlParameter = call.orgnummer ?: return@post call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummerUrlParameter = call.saksnummer ?: return@post call.sendFeil(IASakError.`ugyldig orgnummer`)
        val samarbeidId = call.samarbeidId ?: return@post call.sendFeil(IASamarbeidFeil.`ugyldig samarbeidId`)
        val planMalDto = call.receive<PlanMalDto>()

        call.somEierEllerFølgerAvSakMedNavenhet(
            iaSakService = iaSakService,
            iaTeamService = iaTeamService,
            adGrupper = adGrupper,
        ) { saksbehandler, navEnhet, orgnr, _ ->
            val konsekvens = tilstandsmaskin(orgnr).prosesserHendelse(
                hendelse = OpprettPlanForSamarbeid(
                    orgnr = orgnr,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                    plan = planMalDto,
                    samarbeidId = samarbeidId,
                ),
            )
            konsekvens.endring.map { (it as PlanDto) }
        }.also { planMedPlubliseringStatusDtoEither: Either<Feil, PlanDto> ->
            auditLog.auditloggEither(
                call = call,
                either = planMedPlubliseringStatusDtoEither,
                orgnummer = orgnrUrlParameter,
                auditType = AuditType.update,
                saksnummer = saksnummerUrlParameter,
            )
        }.map { planDto: PlanDto ->
            call.respond(status = HttpStatusCode.OK, message = planDto)
        }.mapLeft { feil: Feil ->
            call.respond(status = feil.httpStatusCode, message = feil.feilmelding)
        }
    }

    // Oppdater hele samarbeidsplan (dvs oppdaterer alle tema og undertema i planen)
    put("$NY_FLYT_API_PATH/virksomhet/{orgnummer}/samarbeidsperiode/{saksnummer}/samarbeid/{samarbeidId}/plan/{planId}") {
        val orgnrUrlParameter = call.orgnummer ?: return@put call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummerUrlParameter = call.saksnummer ?: return@put call.sendFeil(IASakError.`ugyldig orgnummer`)
        val samarbeidId = call.samarbeidId ?: return@put call.sendFeil(IASamarbeidFeil.`ugyldig samarbeidId`)
        val planId: UUID = call.planId ?: return@put call.sendFeil(Feil(feilmelding = "Ugyldig planId", httpStatusCode = HttpStatusCode.BadRequest))
        val endringer = call.receive<List<EndreTemaRequest>>()

        call.somEierEllerFølgerAvSakMedNavenhet(
            iaSakService = iaSakService,
            iaTeamService = iaTeamService,
            adGrupper = adGrupper,
        ) { saksbehandler, navEnhet, orgnr, _ ->
            val konsekvens = tilstandsmaskin(orgnr).prosesserHendelse(
                hendelse = OppdaterPlanForSamarbeid(
                    orgnr = orgnr,
                    saksnummer = saksnummerUrlParameter,
                    samarbeidId = samarbeidId,
                    planId = planId,
                    endringer = endringer,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                ),
            )
            konsekvens.endring.map { (it as PlanDto) }
        }.also { planMedPlubliseringStatusDtoEither: Either<Feil, PlanDto> ->
            auditLog.auditloggEither(
                call = call,
                either = planMedPlubliseringStatusDtoEither,
                orgnummer = orgnrUrlParameter,
                auditType = AuditType.update,
                saksnummer = saksnummerUrlParameter,
            )
        }.map { planDto: PlanDto ->
            call.respond(status = HttpStatusCode.OK, message = planDto)
        }.mapLeft { feil: Feil ->
            call.respond(status = feil.httpStatusCode, message = feil.feilmelding)
        }
    }

    // Oppdater et tema i samarbeidsplan
    put("$NY_FLYT_API_PATH/virksomhet/{orgnummer}/samarbeidsperiode/{saksnummer}/samarbeid/{samarbeidId}/plan/{planId}/tema/{temaId}") {
        val orgnrUrlParameter = call.orgnummer ?: return@put call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummerUrlParameter = call.saksnummer ?: return@put call.sendFeil(IASakError.`ugyldig orgnummer`)
        val samarbeidId = call.samarbeidId ?: return@put call.sendFeil(IASamarbeidFeil.`ugyldig samarbeidId`)
        val planId: UUID = call.planId ?: return@put call.sendFeil(Feil(feilmelding = "Ugyldig planId", httpStatusCode = HttpStatusCode.BadRequest))
        val temaId = call.temaId ?: return@put call.sendFeil(
            Feil(
                feilmelding = "Ugyldig temaId",
                httpStatusCode = HttpStatusCode.BadRequest,
            ),
        )
        val endringer = call.receive<List<EndreUndertemaRequest>>()

        call.somEierEllerFølgerAvSakMedNavenhet(
            iaSakService = iaSakService,
            iaTeamService = iaTeamService,
            adGrupper = adGrupper,
        ) { saksbehandler, navEnhet, orgnr, _ ->
            val konsekvens = tilstandsmaskin(orgnr).prosesserHendelse(
                hendelse = OppdaterTemaIPlanForSamarbeid(
                    orgnr = orgnr,
                    saksnummer = saksnummerUrlParameter,
                    samarbeidId = samarbeidId,
                    planId = planId,
                    temaId = temaId,
                    endringer = endringer,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                ),
            )
            konsekvens.endring.map { (it as PlanDto) }
        }.also { planMedPlubliseringStatusDtoEither: Either<Feil, PlanDto> ->
            auditLog.auditloggEither(
                call = call,
                either = planMedPlubliseringStatusDtoEither,
                orgnummer = orgnrUrlParameter,
                auditType = AuditType.update,
                saksnummer = saksnummerUrlParameter,
            )
        }.map { planDto: PlanDto ->
            call.respond(status = HttpStatusCode.OK, message = planDto)
        }.mapLeft { feil: Feil ->
            call.respond(status = feil.httpStatusCode, message = feil.feilmelding)
        }
    }

    // Oppdater status til et undertema i samarbeidsplan
    put(
        "$NY_FLYT_API_PATH/virksomhet/{orgnummer}/samarbeidsperiode/{saksnummer}/samarbeid/{samarbeidId}/plan/{planId}/tema/{temaId}/undertema/{undertemaId}/status",
    ) {
        val orgnrUrlParameter = call.orgnummer ?: return@put call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummerUrlParameter = call.saksnummer ?: return@put call.sendFeil(IASakError.`ugyldig orgnummer`)
        val samarbeidId = call.samarbeidId ?: return@put call.sendFeil(IASamarbeidFeil.`ugyldig samarbeidId`)
        val planId: UUID = call.planId ?: return@put call.sendFeil(Feil(feilmelding = "Ugyldig planId", httpStatusCode = HttpStatusCode.BadRequest))
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

        call.somEierEllerFølgerAvSakMedNavenhet(
            iaSakService = iaSakService,
            iaTeamService = iaTeamService,
            adGrupper = adGrupper,
        ) { saksbehandler, navEnhet, orgnr, _ ->
            val konsekvens = tilstandsmaskin(orgnr).prosesserHendelse(
                hendelse = EndreStatusPåUndertemaISamarbeidsplan(
                    orgnr = orgnr,
                    saksnummer = saksnummerUrlParameter,
                    samarbeidId = samarbeidId,
                    planId = planId,
                    temaId = temaId,
                    undertemaId = undertemaId,
                    nyStatus = nyStatus,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                ),
            )
            konsekvens.endring.map { (it as PlanDto) }
        }.also { planMedPlubliseringStatusDtoEither: Either<Feil, PlanDto> ->
            auditLog.auditloggEither(
                call = call,
                either = planMedPlubliseringStatusDtoEither,
                orgnummer = orgnrUrlParameter,
                auditType = AuditType.update,
                saksnummer = saksnummerUrlParameter,
            )
        }.map { planDto: PlanDto ->
            call.respond(status = HttpStatusCode.OK, message = planDto)
        }.mapLeft { feil: Feil ->
            call.respond(status = feil.httpStatusCode, message = feil.feilmelding)
        }
    }

    // Slett samarbeidsplan
    delete("$NY_FLYT_API_PATH/virksomhet/{orgnummer}/samarbeidsperiode/{saksnummer}/samarbeid/{samarbeidId}/plan/{planId}") {
        val orgnrUrlParameter = call.orgnummer ?: return@delete call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummerUrlParameter = call.saksnummer ?: return@delete call.sendFeil(IASakError.`ugyldig orgnummer`)
        val samarbeidId = call.samarbeidId ?: return@delete call.sendFeil(IASamarbeidFeil.`ugyldig samarbeidId`)

        call.somEierEllerFølgerAvSakMedNavenhet(
            iaSakService = iaSakService,
            iaTeamService = iaTeamService,
            adGrupper = adGrupper,
        ) { saksbehandler, navEnhet, orgnr, _ ->
            val konsekvens = tilstandsmaskin(orgnr).prosesserHendelse(
                hendelse = SlettPlanForSamarbeid(
                    orgnr = orgnr,
                    samarbeidId = samarbeidId,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                ),
            )
            konsekvens.endring.map { (it as Plan).tilDtoMedPubliseringStatus() }
        }.also { planMedPlubliseringStatusDtoEither: Either<Feil, PlanDto> ->
            auditLog.auditloggEither(
                call = call,
                either = planMedPlubliseringStatusDtoEither,
                orgnummer = orgnrUrlParameter,
                auditType = AuditType.delete,
                saksnummer = saksnummerUrlParameter,
            )
        }.map { planDto: PlanDto ->
            call.respond(status = HttpStatusCode.OK, message = planDto)
        }.mapLeft { feil: Feil ->
            call.respond(status = feil.httpStatusCode, message = feil.feilmelding)
        }
    }
}
