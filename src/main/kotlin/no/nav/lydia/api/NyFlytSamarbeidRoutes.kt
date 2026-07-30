package no.nav.lydia.api

import io.ktor.http.HttpStatusCode
import io.ktor.server.request.receive
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.delete
import io.ktor.server.routing.patch
import io.ktor.server.routing.post
import no.nav.lydia.ADGrupper
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.dokumentpublisering.DokumentPubliseringService
import no.nav.lydia.felles.Feil
import no.nav.lydia.integrasjoner.azure.AzureService
import no.nav.lydia.samarbeid.EndringISamarbeidDto
import no.nav.lydia.samarbeid.IASamarbeid
import no.nav.lydia.samarbeid.IASamarbeidDto
import no.nav.lydia.samarbeid.IASamarbeidFeil
import no.nav.lydia.samarbeid.IASamarbeidService
import no.nav.lydia.samarbeidsperiode.IASakError
import no.nav.lydia.samarbeidsperiode.IASakService
import no.nav.lydia.samarbeidsplan.PlanService
import no.nav.lydia.samarbeidsplan.SamarbeidDto
import no.nav.lydia.tilgangskontroll.somSaksbehandlerMedNavenhet
import no.nav.lydia.tilstandsmaskin.FiaKontekst
import no.nav.lydia.tilstandsmaskin.NyFlytService
import no.nav.lydia.tilstandsmaskin.TilstandVirksomhetRepository
import no.nav.lydia.tilstandsmaskin.TilstandsmaskinBuilder
import no.nav.lydia.tilstandsmaskin.hendelse.AvsluttSamarbeid
import no.nav.lydia.tilstandsmaskin.hendelse.EndreSamarbeidsNavn
import no.nav.lydia.tilstandsmaskin.hendelse.OpprettNyttSamarbeid
import no.nav.lydia.tilstandsmaskin.hendelse.SlettSamarbeid
import java.time.LocalDate

fun Route.nyFlytSamarbeid(
    iaSakService: IASakService,
    iASamarbeidService: IASamarbeidService,
    nyFlytService: NyFlytService,
    dokumentPubliseringService: DokumentPubliseringService,
    planService: PlanService,
    tilstandVirksomhetRepository: TilstandVirksomhetRepository,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
    azureService: AzureService,
) {
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

    // POST
    post("$NY_FLYT_API_PATH/virksomhet/{orgnummer}/samarbeidsperiode/{saksnummer}/samarbeid") {
        val orgnr = call.orgnummer ?: return@post call.respond(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@post call.respond(IASakError.`ugyldig saksnummer`)
        val iaSamarbeidDto = call.receive<IASamarbeidDto>()

        if (saksnummer != iaSamarbeidDto.saksnummer) {
            return@post call.respond(status = HttpStatusCode.BadRequest, message = "Ugyldig saksnummer")
        }

        call.somSaksbehandlerMedNavenhet(adGrupper, azureService) { saksbehandler, navEnhet ->
            val konsekvens = tilstandsmaskin(orgnr).prosesserHendelse(
                hendelse = OpprettNyttSamarbeid(
                    orgnr = orgnr,
                    samarbeidsnavn = iaSamarbeidDto.navn,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                ),
            )
            konsekvens.map { it.verdi as IASamarbeidDto }
        }.also { iaSamarbeidDtoEither ->
            auditLog.auditloggEither(
                call = call,
                either = iaSamarbeidDtoEither,
                orgnummer = orgnr,
                auditType = AuditType.create,
                saksnummer = iaSamarbeidDtoEither.map { iaSamarbeid -> iaSamarbeid.saksnummer }.getOrNull(),
            )
        }.map {
            call.respond(status = HttpStatusCode.Created, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    post("$NY_FLYT_API_PATH/virksomhet/{orgnummer}/samarbeidsperiode/{saksnummer}/samarbeid/{samarbeidId}") {
        val orgnr = call.orgnummer ?: return@post call.sendFeil(IASakError.`ugyldig orgnummer`)
        val samarbeidId = call.samarbeidId ?: return@post call.sendFeil(IASamarbeidFeil.`ugyldig samarbeidId`)
        val samarbeid = call.receive<SamarbeidDto>()
        val typeAvslutning = samarbeid.status
        if (typeAvslutning != IASamarbeid.Status.FULLFØRT && typeAvslutning != IASamarbeid.Status.AVBRUTT) {
            return@post call.sendFeil(Feil(feilmelding = "Ugyldig avslutningstype", httpStatusCode = HttpStatusCode.BadRequest))
        }
        val datoParam = call.request.queryParameters["dato"]
        val dato = datoParam?.let {
            runCatching { LocalDate.parse(it) }.getOrElse {
                return@post call.sendFeil(Feil(feilmelding = "Ugyldig datoformat", httpStatusCode = HttpStatusCode.BadRequest))
            }
        }
        if (dato != null && dato.isBefore(LocalDate.now().plusDays(1))) {
            return@post call.sendFeil(Feil(feilmelding = "Dato må være minst én dag frem i tid", httpStatusCode = HttpStatusCode.BadRequest))
        }
        val tilstandsmaskin = tilstandsmaskin(orgnr)

        call.somSaksbehandlerMedNavenhet(adGrupper, azureService) { saksbehandler, navEnhet ->
            val konsekvens = tilstandsmaskin.prosesserHendelse(
                hendelse = AvsluttSamarbeid(
                    orgnr = orgnr,
                    samarbeidId = samarbeidId,
                    typeAvslutning = typeAvslutning,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                    dato = dato,
                ),
            )
            konsekvens.map { it.verdi as IASamarbeidDto }
        }.also { iaSamarbeidDtoEither ->
            auditLog.auditloggEither(
                call = call,
                either = iaSamarbeidDtoEither,
                orgnummer = orgnr,
                auditType = AuditType.delete,
                saksnummer = tilstandsmaskin.saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    patch("$NY_FLYT_API_PATH/virksomhet/{orgnummer}/samarbeidsperiode/{saksnummer}/samarbeid/{samarbeidId}") {
        val orgnr = call.orgnummer ?: return@patch call.sendFeil(IASakError.`ugyldig orgnummer`)
        val samarbeidId = call.samarbeidId ?: return@patch call.sendFeil(IASakError.`ugyldig orgnummer`)
        val endringISamarbeidDto = call.receive<EndringISamarbeidDto>()
        if (endringISamarbeidDto.typeEndring != "navn") {
            return@patch call.sendFeil(
                Feil(
                    feilmelding = "Feil type endring for samarbeid: '${endringISamarbeidDto.typeEndring}'",
                    httpStatusCode = HttpStatusCode.BadRequest,
                ),
            )
        }

        val tilstandsmaskin = tilstandsmaskin(orgnr)

        call.somSaksbehandlerMedNavenhet(adGrupper, azureService) { saksbehandler, navEnhet ->
            val konsekvens = tilstandsmaskin.prosesserHendelse(
                hendelse = EndreSamarbeidsNavn(
                    orgnr = orgnr,
                    samarbeidId = samarbeidId,
                    navn = endringISamarbeidDto.verdi,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                ),
            )
            konsekvens.map { it.verdi as IASamarbeidDto }
        }.also { iaSamarbeidDtoEither ->
            auditLog.auditloggEither(
                call = call,
                either = iaSamarbeidDtoEither,
                orgnummer = orgnr,
                auditType = AuditType.update,
                saksnummer = tilstandsmaskin.saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    // DELETE
    delete("$NY_FLYT_API_PATH/virksomhet/{orgnummer}/samarbeidsperiode/{saksnummer}/samarbeid/{samarbeidId}") {
        val orgnr = call.orgnummer ?: return@delete call.sendFeil(IASakError.`ugyldig orgnummer`)
        val samarbeidId = call.samarbeidId ?: return@delete call.sendFeil(IASamarbeidFeil.`ugyldig samarbeidId`)
        val datoParam = call.request.queryParameters["dato"]
        val dato = datoParam?.let {
            runCatching { LocalDate.parse(it) }.getOrElse {
                return@delete call.sendFeil(Feil(feilmelding = "Ugyldig datoformat", httpStatusCode = HttpStatusCode.BadRequest))
            }
        }
        if (dato != null && dato.isBefore(LocalDate.now().plusDays(1))) {
            return@delete call.sendFeil(Feil(feilmelding = "Dato må være minst én dag frem i tid", httpStatusCode = HttpStatusCode.BadRequest))
        }
        val tilstandsmaskin = tilstandsmaskin(orgnr)

        call.somSaksbehandlerMedNavenhet(adGrupper, azureService) { saksbehandler, navEnhet ->
            val konsekvens = tilstandsmaskin.prosesserHendelse(
                hendelse = SlettSamarbeid(
                    orgnr = orgnr,
                    samarbeidId = samarbeidId,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                    dato = dato,
                ),
            )
            konsekvens.map { it.verdi as IASamarbeidDto }
        }.also { iaSamarbeidDtoEither ->
            auditLog.auditloggEither(
                call = call,
                either = iaSamarbeidDtoEither,
                orgnummer = orgnr,
                auditType = AuditType.delete,
                saksnummer = tilstandsmaskin.saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }
}
