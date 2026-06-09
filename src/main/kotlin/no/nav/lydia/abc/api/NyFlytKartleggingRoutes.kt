package no.nav.lydia.abc.api

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import io.ktor.http.HttpStatusCode
import io.ktor.server.application.ApplicationCall
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.delete
import io.ktor.server.routing.post
import no.nav.lydia.ADGrupper
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.abc.dokument.DokumentPubliseringService
import no.nav.lydia.abc.kartlegging.Spørreundersøkelse
import no.nav.lydia.abc.kartlegging.SpørreundersøkelseDto
import no.nav.lydia.abc.samarbeid.IASamarbeidService
import no.nav.lydia.abc.samarbeidsperiode.IASakService
import no.nav.lydia.abc.tilstandsmaskin.FiaKontekst
import no.nav.lydia.abc.tilstandsmaskin.NyFlytService
import no.nav.lydia.abc.tilstandsmaskin.TilstandVirksomhetRepository
import no.nav.lydia.abc.tilstandsmaskin.TilstandsmaskinBuilder
import no.nav.lydia.abc.tilstandsmaskin.hendelse.FullførKartleggingForSamarbeid
import no.nav.lydia.abc.tilstandsmaskin.hendelse.OpprettKartleggingForSamarbeid
import no.nav.lydia.abc.tilstandsmaskin.hendelse.SlettKartleggingForSamarbeid
import no.nav.lydia.abc.tilstandsmaskin.hendelse.StartKartleggingForSamarbeid
import no.nav.lydia.ia.sak.PlanService
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.extensions.kartleggingId
import no.nav.lydia.ia.sak.api.extensions.orgnummer
import no.nav.lydia.ia.sak.api.extensions.saksnummer
import no.nav.lydia.ia.sak.api.extensions.samarbeidId
import no.nav.lydia.ia.sak.api.extensions.sendFeil
import no.nav.lydia.ia.team.IATeamService
import no.nav.lydia.integrasjoner.azure.AzureService
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import no.nav.lydia.tilgangskontroll.fia.objectId
import no.nav.lydia.tilgangskontroll.somSaksbehandler

const val NY_FLYT_API_KARTLEGGING_BASE_PATH = "${NY_FLYT_API_PATH}/virksomhet/{orgnummer}/samarbeidsperiode/{saksnummer}/samarbeid/{samarbeidId}/kartlegging"

fun Route.nyFlytKartlegging(
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

    post("$NY_FLYT_API_KARTLEGGING_BASE_PATH/{type}") {
        val samarbeidId = call.samarbeidId ?: return@post call.sendFeil(IASakSpørreundersøkelseError.`ugyldig id`)
        val type = call.parameters["type"]?.let { param ->
            Spørreundersøkelse.Type.entries.firstOrNull { it.name.equals(param, ignoreCase = true) }
        } ?: return@post call.sendFeil(IASakSpørreundersøkelseError.`ugyldig type`)

        call.somEierEllerFølgerAvSakMedNavenhet { saksbehandler, navEnhet, orgnr, _ ->
            val konsekvens = tilstandsmaskin(orgnr).prosesserHendelse(
                hendelse = OpprettKartleggingForSamarbeid(
                    orgnr = orgnr,
                    samarbeidId = samarbeidId,
                    type = type,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                ),
            )
            konsekvens.endring.map { it as SpørreundersøkelseDto }
        }.also { kartleggingEither ->
            auditLog.auditloggEither(
                call = call,
                either = kartleggingEither,
                orgnummer = call.orgnummer ?: "",
                auditType = AuditType.create,
                saksnummer = call.saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.Created, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    post("$NY_FLYT_API_KARTLEGGING_BASE_PATH/{kartleggingId}/start") {
        val kartleggingId = call.kartleggingId ?: return@post call.sendFeil(IASakSpørreundersøkelseError.`ugyldig id`)

        call.somEierEllerFølgerAvSakMedNavenhet { saksbehandler, navEnhet, orgnr, _ ->
            val konsekvens = tilstandsmaskin(orgnr).prosesserHendelse(
                hendelse = StartKartleggingForSamarbeid(
                    orgnr = orgnr,
                    spørreundersøkelseId = kartleggingId,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                ),
            )
            konsekvens.endring.map { it as SpørreundersøkelseDto }
        }.also { kartleggingEither ->
            auditLog.auditloggEither(
                call = call,
                either = kartleggingEither,
                orgnummer = call.orgnummer ?: "",
                auditType = AuditType.update,
                saksnummer = call.saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    post("$NY_FLYT_API_KARTLEGGING_BASE_PATH/{kartleggingId}/fullfor") {
        val kartleggingId = call.kartleggingId ?: return@post call.sendFeil(IASakSpørreundersøkelseError.`ugyldig id`)

        call.somEierEllerFølgerAvSakMedNavenhet { saksbehandler, navEnhet, orgnr, _ ->
            val konsekvens = tilstandsmaskin(orgnr).prosesserHendelse(
                hendelse = FullførKartleggingForSamarbeid(
                    orgnr = orgnr,
                    spørreundersøkelseId = kartleggingId,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                ),
            )
            konsekvens.endring.map { it as SpørreundersøkelseDto }
        }.also { kartleggingEither ->
            auditLog.auditloggEither(
                call = call,
                either = kartleggingEither,
                orgnummer = call.orgnummer ?: "",
                auditType = AuditType.update,
                saksnummer = call.saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    delete("$NY_FLYT_API_KARTLEGGING_BASE_PATH/{kartleggingId}") {
        val kartleggingId = call.kartleggingId ?: return@delete call.sendFeil(IASakSpørreundersøkelseError.`ugyldig id`)

        call.somEierEllerFølgerAvSakMedNavenhet { saksbehandler, navEnhet, orgnr, _ ->
            val konsekvens = tilstandsmaskin(orgnr).prosesserHendelse(
                hendelse = SlettKartleggingForSamarbeid(
                    orgnr = orgnr,
                    spørreundersøkelseId = kartleggingId,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                ),
            )
            konsekvens.endring.map { it as SpørreundersøkelseDto }
        }.also { kartleggingEither ->
            auditLog.auditloggEither(
                call = call,
                either = kartleggingEither,
                orgnummer = call.orgnummer ?: "",
                auditType = AuditType.delete,
                saksnummer = call.saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }
}
