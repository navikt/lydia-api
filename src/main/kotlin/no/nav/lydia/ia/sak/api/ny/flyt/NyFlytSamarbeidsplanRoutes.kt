package no.nav.lydia.ia.sak.api.ny.flyt

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import io.ktor.http.HttpStatusCode
import io.ktor.server.application.ApplicationCall
import io.ktor.server.request.receive
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.post
import io.ktor.server.routing.put
import no.nav.lydia.ADGrupper
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.IASamarbeidFeil
import no.nav.lydia.ia.sak.IASamarbeidService
import no.nav.lydia.ia.sak.PlanService
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringService
import no.nav.lydia.ia.sak.api.extensions.orgnummer
import no.nav.lydia.ia.sak.api.extensions.planId
import no.nav.lydia.ia.sak.api.extensions.saksnummer
import no.nav.lydia.ia.sak.api.extensions.samarbeidId
import no.nav.lydia.ia.sak.api.extensions.sendFeil
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.TilstandsmaskinBuilder
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.OppdaterPlanForSamarbeid
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.OpprettPlanForSamarbeid
import no.nav.lydia.ia.sak.api.plan.EndreTemaRequest
import no.nav.lydia.ia.sak.api.plan.PlanMedPubliseringStatusDto
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.ia.team.IATeamService
import no.nav.lydia.integrasjoner.azure.AzureService
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import no.nav.lydia.tilgangskontroll.fia.objectId
import no.nav.lydia.tilgangskontroll.somSaksbehandler
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
            konsekvens.endring.map { (it as PlanMedPubliseringStatusDto) }
        }.also { planMedPlubliseringStatusDtoEither: Either<Feil, PlanMedPubliseringStatusDto> ->
            auditLog.auditloggEither(
                call = call,
                either = planMedPlubliseringStatusDtoEither,
                orgnummer = orgnrUrlParameter,
                auditType = AuditType.update,
                saksnummer = saksnummerUrlParameter,
            )
        }.map { planMedPubliseringStatusDto: PlanMedPubliseringStatusDto ->
            call.respond(status = HttpStatusCode.OK, message = planMedPubliseringStatusDto)
        }.mapLeft { feil: Feil ->
            call.respond(status = feil.httpStatusCode, message = feil.feilmelding)
        }
    }

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
            konsekvens.endring.map { (it as PlanMedPubliseringStatusDto) }
        }.also { planMedPlubliseringStatusDtoEither: Either<Feil, PlanMedPubliseringStatusDto> ->
            auditLog.auditloggEither(
                call = call,
                either = planMedPlubliseringStatusDtoEither,
                orgnummer = orgnrUrlParameter,
                auditType = AuditType.update,
                saksnummer = saksnummerUrlParameter,
            )
        }.map { planMedPubliseringStatusDto: PlanMedPubliseringStatusDto ->
            call.respond(status = HttpStatusCode.OK, message = planMedPubliseringStatusDto)
        }.mapLeft { feil: Feil ->
            call.respond(status = feil.httpStatusCode, message = feil.feilmelding)
        }
    }
}
