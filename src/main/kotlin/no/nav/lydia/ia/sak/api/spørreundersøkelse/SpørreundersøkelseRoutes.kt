package no.nav.lydia.ia.sak.api.spørreundersøkelse

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus.AVSLUTTET
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus.PÅBEGYNT
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
import no.nav.lydia.ia.sak.IAProsessFeil
import no.nav.lydia.ia.sak.IASakService
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
import no.nav.lydia.ia.sak.domene.IAProsessStatus.KARTLEGGES
import no.nav.lydia.ia.sak.domene.IAProsessStatus.VI_BISTÅR
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import no.nav.lydia.tilgangskontroll.somLesebruker
import no.nav.lydia.tilgangskontroll.somSaksbehandler

const val SPØRREUNDERSØKELSE_BASE_ROUTE = "$IA_SAK_RADGIVER_PATH/kartlegging"

fun Route.iaSakSpørreundersøkelse(
    iaSakService: IASakService,
    spørreundersøkelseService: SpørreundersøkelseService,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
) {
    post("$SPØRREUNDERSØKELSE_BASE_ROUTE/{orgnummer}/{saksnummer}/prosess/{prosessId}/type/{type}") {
        // Opprett spørreundersøkelse av en gitt type
        val orgnummer = call.orgnummer ?: return@post call.sendFeil(IASakError.`ugyldig orgnummer`)
        val prosessId = call.prosessId ?: return@post call.sendFeil(IAProsessFeil.`ugyldig prosessId`)
        val type = call.type ?: return@post call.sendFeil(IASakSpørreundersøkelseError.`ugyldig type`)

        if (type != "Evaluering" && type != "Behovsvurdering") {
            return@post call.sendFeil(IASakSpørreundersøkelseError.`ugyldig type`)
        }

        call.somEierAvSakIProsess(iaSakService = iaSakService, adGrupper = adGrupper) { saksbehandler, iaSak ->
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
            call.respond(HttpStatusCode.Created, it.tilDto(true))
        }.mapLeft {
            call.respond(it.httpStatusCode, it.feilmelding)
        }
    }

    get("$SPØRREUNDERSØKELSE_BASE_ROUTE/{orgnummer}/{saksnummer}/prosess/{prosessId}/type/{type}") {
        // hent alle spørreundersøkelser av en gitt type
        val saksnummer = call.saksnummer ?: return@get call.sendFeil(IASakError.`ugyldig saksnummer`)
        val orgnummer = call.orgnummer ?: return@get call.sendFeil(IASakError.`ugyldig orgnummer`)
        val prosessId = call.prosessId ?: return@get call.sendFeil(IAProsessFeil.`ugyldig prosessId`)
        val type = call.type ?: return@get call.sendFeil(IASakSpørreundersøkelseError.`ugyldig type`)

        if (type != "Evaluering" && type != "Behovsvurdering") {
            return@get call.sendFeil(IASakSpørreundersøkelseError.`ugyldig type`)
        }

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

        call.somEierAvSakIProsess(iaSakService = iaSakService, adGrupper = adGrupper) { _, _ ->
            spørreundersøkelseService.endreSpørreundersøkelseStatus(
                spørreundersøkelseId = id,
                statusViSkalEndreTil = AVSLUTTET,
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
            call.respond(it.tilDto(true))
        }.mapLeft {
            call.application.log.error(it.feilmelding)
            call.sendFeil(it)
        }
    }

    delete("$SPØRREUNDERSØKELSE_BASE_ROUTE/{orgnummer}/{saksnummer}/{sporreundersokelseId}") {
        val id = call.spørreundersøkelseId ?: return@delete call.sendFeil(IASakSpørreundersøkelseError.`ugyldig id`)

        call.somEierAvSakIProsess(iaSakService = iaSakService, adGrupper = adGrupper) { _, _ ->
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
            call.respond(it.tilDto(erEier = false))
        }.mapLeft {
            call.application.log.error(it.feilmelding)
            call.sendFeil(it)
        }
    }

    post("$SPØRREUNDERSØKELSE_BASE_ROUTE/{orgnummer}/{saksnummer}/{sporreundersokelseId}/start") {
        val id = call.spørreundersøkelseId ?: return@post call.sendFeil(IASakSpørreundersøkelseError.`ugyldig id`)

        call.somEierAvSakIProsess(iaSakService, adGrupper) { _, _ ->
            spørreundersøkelseService.endreSpørreundersøkelseStatus(
                spørreundersøkelseId = id,
                statusViSkalEndreTil = PÅBEGYNT,
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
            call.respond(it.tilDto(true))
        }.mapLeft {
            call.sendFeil(it)
        }
    }

    put("$SPØRREUNDERSØKELSE_BASE_ROUTE/{sporreundersokelseId}") {
        val id = call.spørreundersøkelseId ?: return@put call.sendFeil(IASakSpørreundersøkelseError.`ugyldig id`)
        val input = call.receive<OppdaterBehovsvurderingDto>()

        call.somSaksbehandler(adGrupper) {
            spørreundersøkelseService.oppdaterBehovsvurdering(id, input)
        }.also { spørreundersøkelseEither ->
            auditLog.auditloggEither(
                call = call,
                either = spørreundersøkelseEither,
                orgnummer = input.orgnummer,
                auditType = AuditType.update,
                saksnummer = input.saksnummer,
            )
        }.map {
            call.respond(it.tilDto(true))
        }.mapLeft {
            call.sendFeil(it)
        }
    }
}

// TODO: bør endres til å returnere IASak og IAProsess i call-block?
fun <T> ApplicationCall.somEierAvSakIProsess(
    iaSakService: IASakService,
    adGrupper: ADGrupper,
    block: (NavAnsatt.NavAnsattMedSaksbehandlerRolle, IASak) -> Either<Feil, T>,
) = somSaksbehandler(adGrupper) { saksbehandler ->
    val saksnummer = saksnummer ?: return@somSaksbehandler IASakError.`ugyldig saksnummer`.left()
    val orgnummer = orgnummer ?: return@somSaksbehandler IASakError.`ugyldig orgnummer`.left()
    val iaSak = iaSakService.hentIASak(saksnummer = saksnummer).getOrNull()
        ?: return@somSaksbehandler IASakError.`ugyldig saksnummer`.left()
    if (iaSak.orgnr != orgnummer) {
        IASakError.`ugyldig orgnummer`.left()
    } else if (iaSak.eidAv != saksbehandler.navIdent) {
        IASakError.`ikke eier av sak`.left()
    } else if (iaSak.status != KARTLEGGES && iaSak.status != VI_BISTÅR) {
        IASakSpørreundersøkelseError.`sak ikke i rett status`.left()
    } else {
        block(saksbehandler, iaSak)
    }
}

object IASakSpørreundersøkelseError {
    val `ikke støttet statusendring` =
        Feil("Ikke en støttet statusendring", HttpStatusCode.Forbidden)
    val `ikke påbegynt` =
        Feil("Spørreundersøkelse er ikke i status '${PÅBEGYNT.name}', kan ikke avslutte", HttpStatusCode.Forbidden)
    val `feil status kan ikke starte` =
        Feil("Kan ikke starte spørreundersøkelse, feil status", HttpStatusCode.Forbidden)
    val `ikke avsluttet` =
        Feil("Spørreundersøkelse er ikke i status '${AVSLUTTET.name}', kan ikke hente resultat", HttpStatusCode.Forbidden)
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
