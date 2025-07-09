package no.nav.lydia.ia.sak.api.spørreundersøkelse

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import io.ktor.http.HttpStatusCode
import io.ktor.server.application.ApplicationCall
import io.ktor.server.application.log
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
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.IASamarbeidFeil
import no.nav.lydia.ia.sak.SpørreundersøkelseService
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.IA_SAK_RADGIVER_PATH
import no.nav.lydia.ia.sak.api.extensions.orgnummer
import no.nav.lydia.ia.sak.api.extensions.prosessId
import no.nav.lydia.ia.sak.api.extensions.saksnummer
import no.nav.lydia.ia.sak.api.extensions.sendFeil
import no.nav.lydia.ia.sak.api.extensions.spørreundersøkelseId
import no.nav.lydia.ia.sak.api.extensions.type
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.ia.team.IATeamService
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import no.nav.lydia.tilgangskontroll.somLesebruker
import no.nav.lydia.tilgangskontroll.somSaksbehandler

const val SPØRREUNDERSØKELSE_BASE_ROUTE = "$IA_SAK_RADGIVER_PATH/kartlegging"

fun Route.iaSakSpørreundersøkelse(
    iaSakService: IASakService,
    spørreundersøkelseService: SpørreundersøkelseService,
    iaTeamService: IATeamService,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
) {
    post("$SPØRREUNDERSØKELSE_BASE_ROUTE/{orgnummer}/{saksnummer}/prosess/{prosessId}/type/{type}") {
        // Opprett spørreundersøkelse av en gitt type
        val orgnummer = call.orgnummer ?: return@post call.sendFeil(IASakError.`ugyldig orgnummer`)
        val prosessId = call.prosessId ?: return@post call.sendFeil(IASamarbeidFeil.`ugyldig samarbeidId`)
        val type = call.type ?: return@post call.sendFeil(IASakSpørreundersøkelseError.`ugyldig type`)

        call.somFølgerAvSakIProsess(iaSakService = iaSakService, iaTeamService = iaTeamService, adGrupper = adGrupper) { saksbehandler, iaSak ->
            spørreundersøkelseService.opprettSpørreundersøkelse(
                orgnummer = orgnummer,
                saksbehandler = saksbehandler,
                iaSak = iaSak,
                prosessId = prosessId,
                type = type,
            )
        }.also { spørreundersøkelseEither ->
            auditLog.auditloggEither(
                call = call,
                either = spørreundersøkelseEither,
                orgnummer = orgnummer,
                auditType = AuditType.create,
                saksnummer = spørreundersøkelseEither.getOrNull()?.saksnummer,
            )
        }.map {
            call.respond(HttpStatusCode.Created, it.tilDto())
        }.mapLeft {
            call.respond(it.httpStatusCode, it.feilmelding)
        }
    }

    get("$SPØRREUNDERSØKELSE_BASE_ROUTE/{orgnummer}/{saksnummer}/prosess/{prosessId}/type/{type}") {
        // hent alle spørreundersøkelser av en gitt type
        val saksnummer = call.saksnummer ?: return@get call.sendFeil(IASakError.`ugyldig saksnummer`)
        val orgnummer = call.orgnummer ?: return@get call.sendFeil(IASakError.`ugyldig orgnummer`)
        val prosessId = call.prosessId ?: return@get call.sendFeil(IASamarbeidFeil.`ugyldig samarbeidId`)
        val type = call.type ?: return@get call.sendFeil(IASakSpørreundersøkelseError.`ugyldig type`)

        call.somLesebruker(adGrupper = adGrupper) { _ ->
            iaSakService.hentIASak(saksnummer = saksnummer).flatMap { iaSak ->
                spørreundersøkelseService.hentSpørreundersøkelser(
                    sak = iaSak,
                    prosessId = prosessId,
                    type = type,
                )
            }
        }.also { spørreundersøkelseEither ->
            auditLog.auditloggEither(
                call = call,
                either = spørreundersøkelseEither,
                orgnummer = orgnummer,
                auditType = AuditType.access,
                saksnummer = saksnummer,
            )
        }.map {
            call.respond(HttpStatusCode.OK, it.tilMetaDto())
        }.mapLeft {
            call.respond(it.httpStatusCode, it.feilmelding)
        }
    }

    get("$SPØRREUNDERSØKELSE_BASE_ROUTE/{orgnummer}/{saksnummer}/prosess/{prosessId}/type/{type}/{sporreundersokelseId}") {
        val id = call.spørreundersøkelseId ?: return@get call.sendFeil(IASakSpørreundersøkelseError.`ugyldig id`)
        val saksnummer = call.saksnummer ?: return@get call.sendFeil(IASakError.`ugyldig saksnummer`)
        val orgnummer = call.orgnummer ?: return@get call.sendFeil(IASakError.`ugyldig orgnummer`)
        call.type ?: return@get call.sendFeil(IASakSpørreundersøkelseError.`ugyldig type`)

        call.somLesebruker(adGrupper = adGrupper) { _ ->
            iaSakService.hentIASak(saksnummer = saksnummer).flatMap { _ ->
                spørreundersøkelseService.hentSpørreundersøkelse(spørreundersøkelseId = id)
            }
        }.also { spørreundersøkelseEither ->
            auditLog.auditloggEither(
                call = call,
                either = spørreundersøkelseEither,
                orgnummer = orgnummer,
                auditType = AuditType.access,
                saksnummer = saksnummer,
            )
        }.map {
            call.respond(HttpStatusCode.OK, it.tilDto())
        }.mapLeft {
            call.respond(it.httpStatusCode, it.feilmelding)
        }
    }

    get("$SPØRREUNDERSØKELSE_BASE_ROUTE/{orgnummer}/{saksnummer}/{sporreundersokelseId}") {
        val id = call.spørreundersøkelseId ?: return@get call.sendFeil(IASakSpørreundersøkelseError.`ugyldig id`)

        call.somLesebruker(adGrupper = adGrupper) { _ ->
            spørreundersøkelseService.hentSpørreundersøkelseResultat(spørreundersøkelseId = id)
        }.also { spørreundersøkelseResultatEither ->
            auditLog.auditloggEither(
                call = call,
                either = spørreundersøkelseResultatEither,
                orgnummer = call.orgnummer,
                auditType = AuditType.access,
                saksnummer = call.saksnummer,
            )
        }.map {
            call.respond(HttpStatusCode.OK, it)
        }.mapLeft {
            call.respond(it.httpStatusCode, it.feilmelding)
        }
    }

    post("$SPØRREUNDERSØKELSE_BASE_ROUTE/{orgnummer}/{saksnummer}/{sporreundersokelseId}/avslutt") {
        val id = call.spørreundersøkelseId ?: return@post call.sendFeil(IASakSpørreundersøkelseError.`ugyldig id`)

        call.somFølgerAvSakIProsess(iaSakService = iaSakService, iaTeamService = iaTeamService, adGrupper = adGrupper) { _, _ ->
            spørreundersøkelseService.endreSpørreundersøkelseStatus(
                spørreundersøkelseId = id,
                statusViSkalEndreTil = Spørreundersøkelse.Status.AVSLUTTET,
            )
        }.also { spørreundersøkelseEither ->
            auditLog.auditloggEither(
                call = call,
                either = spørreundersøkelseEither,
                orgnummer = call.orgnummer,
                auditType = AuditType.access,
                saksnummer = call.saksnummer,
            )
        }.map {
            call.respond(it.tilDto())
        }.mapLeft {
            call.application.log.error(it.feilmelding)
            call.sendFeil(it)
        }
    }

    delete("$SPØRREUNDERSØKELSE_BASE_ROUTE/{orgnummer}/{saksnummer}/{sporreundersokelseId}") {
        val id = call.spørreundersøkelseId ?: return@delete call.sendFeil(IASakSpørreundersøkelseError.`ugyldig id`)

        call.somFølgerAvSakIProsess(iaSakService = iaSakService, iaTeamService, adGrupper = adGrupper) { _, _ ->
            spørreundersøkelseService.slettSpørreundersøkelse(spørreundersøkelseId = id)
        }.also { spørreundersøkelseEither ->
            auditLog.auditloggEither(
                call = call,
                either = spørreundersøkelseEither,
                orgnummer = call.orgnummer,
                auditType = AuditType.delete,
                saksnummer = call.saksnummer,
            )
        }.map {
            call.respond(it.tilDto())
        }.mapLeft {
            call.application.log.error(it.feilmelding)
            call.sendFeil(it)
        }
    }

    post("$SPØRREUNDERSØKELSE_BASE_ROUTE/{orgnummer}/{saksnummer}/{sporreundersokelseId}/start") {
        val id = call.spørreundersøkelseId ?: return@post call.sendFeil(IASakSpørreundersøkelseError.`ugyldig id`)

        call.somFølgerAvSakIProsess(iaSakService = iaSakService, iaTeamService, adGrupper = adGrupper) { _, _ ->
            spørreundersøkelseService.endreSpørreundersøkelseStatus(
                spørreundersøkelseId = id,
                statusViSkalEndreTil = Spørreundersøkelse.Status.PÅBEGYNT,
            )
        }.also { spørreundersøkelse ->
            auditLog.auditloggEither(
                call = call,
                either = spørreundersøkelse,
                orgnummer = call.orgnummer,
                auditType = AuditType.access,
                saksnummer = call.saksnummer,
            )
        }.map {
            call.respond(it.tilDto())
        }.mapLeft {
            call.sendFeil(it)
        }
    }

    put("$SPØRREUNDERSØKELSE_BASE_ROUTE/{sporreundersokelseId}") {
        val id = call.spørreundersøkelseId ?: return@put call.sendFeil(IASakSpørreundersøkelseError.`ugyldig id`)
        val input = call.receive<OppdaterBehovsvurderingDto>()

        call.somSaksbehandler(adGrupper) { saksbehandler ->
            val iaSak = iaSakService.hentIASak(saksnummer = input.saksnummer).getOrNull()
                ?: return@somSaksbehandler IASakError.`ugyldig saksnummer`.left()

            if (!iaTeamService.erEierEllerFølgerAvSak(iaSak = iaSak, saksbehandler = saksbehandler)) {
                return@somSaksbehandler IASakError.`er ikke følger eller eier av sak`.left()
            }
            spørreundersøkelseService.oppdaterSamarbeidIdIBehovsvurdering(
                behovsvurderingId = id,
                oppdaterBehovsvurderingDto = input,
            )
        }.also { spørreundersøkelseEither ->
            auditLog.auditloggEither(
                call = call,
                either = spørreundersøkelseEither,
                orgnummer = input.orgnummer,
                auditType = AuditType.update,
                saksnummer = input.saksnummer,
            )
        }.map {
            call.respond(it.tilDto())
        }.mapLeft {
            call.sendFeil(it)
        }
    }
}

fun <T> ApplicationCall.somFølgerAvSakIProsess(
    iaSakService: IASakService,
    iaTeamService: IATeamService,
    adGrupper: ADGrupper,
    block: (NavAnsatt.NavAnsattMedSaksbehandlerRolle, IASak) -> Either<Feil, T>,
) = somSaksbehandler(adGrupper) { saksbehandler ->
    val saksnummer = saksnummer ?: return@somSaksbehandler IASakError.`ugyldig saksnummer`.left()
    val orgnummer = orgnummer ?: return@somSaksbehandler IASakError.`ugyldig orgnummer`.left()
    val iaSak = iaSakService.hentIASak(saksnummer = saksnummer).getOrNull()
        ?: return@somSaksbehandler IASakError.`ugyldig saksnummer`.left()
    if (iaSak.orgnr != orgnummer) {
        IASakError.`ugyldig orgnummer`.left()
    } else if (!iaTeamService.erEierEllerFølgerAvSak(iaSak = iaSak, saksbehandler = saksbehandler)) {
        IASakError.`er ikke følger eller eier av sak`.left()
    } else if (iaSak.status != IASak.Status.KARTLEGGES && iaSak.status != IASak.Status.VI_BISTÅR) {
        IASakSpørreundersøkelseError.`sak ikke i rett status`.left()
    } else {
        block(saksbehandler, iaSak)
    }
}

object IASakSpørreundersøkelseError {
    val `ikke støttet statusendring` =
        Feil("Ikke en støttet statusendring", HttpStatusCode.Forbidden)
    val `ikke påbegynt` =
        Feil("Spørreundersøkelse er ikke i status '${Spørreundersøkelse.Status.PÅBEGYNT.name}', kan ikke avslutte", HttpStatusCode.Forbidden)
    val `feil status kan ikke starte` =
        Feil("Kan ikke starte spørreundersøkelse, feil status", HttpStatusCode.Forbidden)
    val `ikke avsluttet` =
        Feil(
            "Spørreundersøkelse er ikke i status '${Spørreundersøkelse.Status.AVSLUTTET.name}', kan ikke hente resultat",
            HttpStatusCode.Forbidden,
        )
    val `ikke avsluttet, kan ikke bytte samarbeid` =
        Feil(
            "Spørreundersøkelse er ikke i status '${Spørreundersøkelse.Status.AVSLUTTET.name}', kan ikke bytte samarbeid",
            HttpStatusCode.BadRequest,
        )
    val `generell feil under uthenting` =
        Feil("Generell feil under uthenting av en spørreundersøkelse", HttpStatusCode.InternalServerError)
    val `feil under oppdatering` =
        Feil("Feil under oppdatering av spørreundersøkelse", HttpStatusCode.InternalServerError)
    val `sak ikke i rett status` =
        Feil("Sak er ikke i rett status", HttpStatusCode.Forbidden)
    val `ugyldig id` = Feil("Ugyldig spørreundersøkelse", HttpStatusCode.BadRequest)
    val `ugyldig temaId` = Feil("Ugyldig tema", HttpStatusCode.BadRequest)
    val `ugyldig type` = Feil("Ugyldig type spørreundersøkelse", HttpStatusCode.BadRequest)
}
