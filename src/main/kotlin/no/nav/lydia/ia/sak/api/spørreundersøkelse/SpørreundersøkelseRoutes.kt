package no.nav.lydia.ia.sak.api.spørreundersøkelse

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import ia.felles.integrasjoner.kafkameldinger.SpørreundersøkelseStatus.AVSLUTTET
import ia.felles.integrasjoner.kafkameldinger.SpørreundersøkelseStatus.PÅBEGYNT
import io.ktor.http.HttpStatusCode
import io.ktor.server.application.ApplicationCall
import io.ktor.server.application.call
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
import no.nav.lydia.ia.sak.api.extensions.behovsvurderingId
import no.nav.lydia.ia.sak.api.extensions.kartleggingId
import no.nav.lydia.ia.sak.api.extensions.orgnummer
import no.nav.lydia.ia.sak.api.extensions.prosessId
import no.nav.lydia.ia.sak.api.extensions.saksnummer
import no.nav.lydia.ia.sak.api.extensions.sendFeil
import no.nav.lydia.ia.sak.domene.IAProsessStatus.KARTLEGGES
import no.nav.lydia.ia.sak.domene.IAProsessStatus.VI_BISTÅR
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import no.nav.lydia.tilgangskontroll.somLesebruker
import no.nav.lydia.tilgangskontroll.somSaksbehandler

const val BEHOVSVURDERING_BASE_ROUTE = "$IA_SAK_RADGIVER_PATH/kartlegging"
const val EVALUERING_BASE_ROUTE = "$IA_SAK_RADGIVER_PATH/evaluering"

fun Route.iaSakSpørreundersøkelse(
    iaSakService: IASakService,
    spørreundersøkelseService: SpørreundersøkelseService,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
) {
    post("$BEHOVSVURDERING_BASE_ROUTE/{orgnummer}/{saksnummer}/prosess/{prosessId}") {
        val orgnummer = call.orgnummer ?: return@post call.sendFeil(IASakError.`ugyldig orgnummer`)
        val prosessId = call.prosessId ?: return@post call.sendFeil(IAProsessFeil.`ugyldig prosessId`)

        call.somEierAvSakIProsess(iaSakService = iaSakService, adGrupper = adGrupper) { saksbehandler, iaSak ->
            spørreundersøkelseService.opprettSpørreundersøkelse(
                orgnummer = orgnummer,
                saksbehandler = saksbehandler,
                iaSak = iaSak,
                prosessId = prosessId,
                type = "Behovsvurdering",
            )
        }.also { kartleggingEither ->
            auditLog.auditloggEither(
                call = call,
                either = kartleggingEither,
                orgnummer = orgnummer,
                auditType = AuditType.create,
                saksnummer = kartleggingEither.getOrNull()?.saksnummer,
            )
        }.map {
            call.respond(HttpStatusCode.Created, it.tilDto(true))
        }.mapLeft {
            call.respond(it.httpStatusCode, it.feilmelding)
        }
    }

    get("$BEHOVSVURDERING_BASE_ROUTE/{orgnummer}/{saksnummer}/prosess/{prosessId}") {
        val saksnummer = call.saksnummer ?: return@get call.sendFeil(IASakError.`ugyldig saksnummer`)
        val orgnummer = call.orgnummer ?: return@get call.sendFeil(IASakError.`ugyldig orgnummer`)
        val prosessId = call.prosessId ?: return@get call.sendFeil(IAProsessFeil.`ugyldig prosessId`)

        call.somLesebruker(adGrupper = adGrupper) { _ ->
            iaSakService.hentIASak(saksnummer = saksnummer).flatMap { iaSak ->
                spørreundersøkelseService.hentSpørreundersøkelser(sak = iaSak, prosessId = prosessId, type = "Behovsvurdering")
            }
        }.also { kartleggingerEither ->
            auditLog.auditloggEither(
                call = call,
                either = kartleggingerEither,
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

    get("$BEHOVSVURDERING_BASE_ROUTE/{orgnummer}/{saksnummer}/{kartleggingId}") {
        val kartleggingId =
            call.kartleggingId ?: return@get call.sendFeil(IASakKartleggingError.`ugyldig kartleggingId`)

        call.somLesebruker(adGrupper = adGrupper) { _ ->
            spørreundersøkelseService.hentSpørreundersøkelseResultat(spørreundersøkelseId = kartleggingId)
        }.also { kartlegging ->
            auditLog.auditloggEither(
                call = call,
                either = kartlegging,
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

    post("$BEHOVSVURDERING_BASE_ROUTE/{orgnummer}/{saksnummer}/{kartleggingId}/avslutt") {
        val kartleggingId =
            call.kartleggingId ?: return@post call.sendFeil(IASakKartleggingError.`ugyldig kartleggingId`)

        call.somEierAvSakIProsess(iaSakService = iaSakService, adGrupper = adGrupper) { _, _ ->
            spørreundersøkelseService.endreKartleggingStatus(
                spørreundersøkelseId = kartleggingId,
                statusViSkalEndreTil = AVSLUTTET,
            )
        }.also { kartlegging ->
            auditLog.auditloggEither(
                call = call,
                either = kartlegging,
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

    delete("$BEHOVSVURDERING_BASE_ROUTE/{orgnummer}/{saksnummer}/{kartleggingId}") {
        val kartleggingId =
            call.kartleggingId ?: return@delete call.sendFeil(IASakKartleggingError.`ugyldig kartleggingId`)

        call.somEierAvSakIProsess(iaSakService = iaSakService, adGrupper = adGrupper) { _, _ ->
            spørreundersøkelseService.slettKartlegging(kartleggingId = kartleggingId)
        }.also { kartlegging ->
            auditLog.auditloggEither(
                call = call,
                either = kartlegging,
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

    post("$BEHOVSVURDERING_BASE_ROUTE/{orgnummer}/{saksnummer}/{kartleggingId}/start") {
        val kartleggingId =
            call.kartleggingId ?: return@post call.sendFeil(IASakKartleggingError.`ugyldig kartleggingId`)

        call.somEierAvSakIProsess(iaSakService, adGrupper) { _, _ ->
            spørreundersøkelseService.endreKartleggingStatus(
                spørreundersøkelseId = kartleggingId,
                statusViSkalEndreTil = PÅBEGYNT,
            )
        }.also { kartlegging ->
            auditLog.auditloggEither(
                call = call,
                either = kartlegging,
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

    put("$BEHOVSVURDERING_BASE_ROUTE/{behovsvurderingId}") {
        val behovsvurderingId = call.behovsvurderingId
            ?: return@put call.sendFeil(IASakKartleggingError.`ugyldig kartleggingId`)
        val input = call.receive<OppdaterBehovsvurderingDto>()

        call.somSaksbehandler(adGrupper) {
            spørreundersøkelseService.oppdaterBehovsvurdering(behovsvurderingId, input)
        }.also { kartlegging ->
            auditLog.auditloggEither(
                call = call,
                either = kartlegging,
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

    post("$EVALUERING_BASE_ROUTE/{orgnummer}/{saksnummer}/prosess/{prosessId}") {
        val orgnummer = call.orgnummer ?: return@post call.sendFeil(IASakError.`ugyldig orgnummer`)
        val prosessId = call.prosessId ?: return@post call.sendFeil(IAProsessFeil.`ugyldig prosessId`)

        call.somEierAvSakIProsess(iaSakService = iaSakService, adGrupper = adGrupper) { saksbehandler, iaSak ->
            spørreundersøkelseService.opprettSpørreundersøkelse(
                orgnummer = orgnummer,
                saksbehandler = saksbehandler,
                iaSak = iaSak,
                prosessId = prosessId,
                type = "Evaluering",
            )
        }.also { kartleggingEither ->
            auditLog.auditloggEither(
                call = call,
                either = kartleggingEither,
                orgnummer = orgnummer,
                auditType = AuditType.create,
                saksnummer = kartleggingEither.getOrNull()?.saksnummer,
            )
        }.map {
            call.respond(HttpStatusCode.Created, it.tilDto(true))
        }.mapLeft {
            call.respond(it.httpStatusCode, it.feilmelding)
        }
    }

    get("$EVALUERING_BASE_ROUTE/{orgnummer}/{saksnummer}/prosess/{prosessId}") {
        val saksnummer = call.saksnummer ?: return@get call.sendFeil(IASakError.`ugyldig saksnummer`)
        val orgnummer = call.orgnummer ?: return@get call.sendFeil(IASakError.`ugyldig orgnummer`)
        val prosessId = call.prosessId ?: return@get call.sendFeil(IAProsessFeil.`ugyldig prosessId`)

        call.somLesebruker(adGrupper = adGrupper) { _ ->
            iaSakService.hentIASak(saksnummer = saksnummer).flatMap { iaSak ->
                spørreundersøkelseService.hentSpørreundersøkelser(sak = iaSak, prosessId = prosessId, type = "Evaluering")
            }
        }.also { evalueringEither ->
            auditLog.auditloggEither(
                call = call,
                either = evalueringEither,
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
        IASakKartleggingError.`sak er ikke i kartleggingsstatus`.left()
    } else {
        block(saksbehandler, iaSak)
    }
}

object IASakKartleggingError {
    val `ikke støttet statusendring` =
        Feil("Ikke en støttet statusendring", HttpStatusCode.Forbidden)
    val `kartlegging er ikke i påbegynt` =
        Feil("Kartlegging er ikke i påbegynt status", HttpStatusCode.Forbidden)
    val `kan ikke starte kartlegging` =
        Feil("Kan ikke starte kartlegging", HttpStatusCode.Forbidden)
    val `kartlegging er ikke avsluttet` =
        Feil("Kartlegging er ikke avsluttet", HttpStatusCode.Forbidden)
    val `generell feil under uthenting` =
        Feil("Generell feil under uthenting av kartlegging", HttpStatusCode.InternalServerError)
    val `feil under oppdatering` =
        Feil("Feil under oppdatering av kartlegging", HttpStatusCode.InternalServerError)
    val `sak er ikke i kartleggingsstatus` =
        Feil("Sak må være i kartleggingsstatus for å starte kartlegging", HttpStatusCode.Forbidden)
    val `ugyldig kartleggingId` = Feil("Ugyldig kartlegging", HttpStatusCode.BadRequest)
    val `ugyldig temaId` = Feil("Ugyldig temaId", HttpStatusCode.BadRequest)
}
