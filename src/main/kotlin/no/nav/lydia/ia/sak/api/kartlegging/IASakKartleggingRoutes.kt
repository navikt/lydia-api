package no.nav.lydia.ia.sak.api.kartlegging

import arrow.core.Either
import arrow.core.left
import io.ktor.http.HttpStatusCode
import io.ktor.server.application.ApplicationCall
import io.ktor.server.application.call
import io.ktor.server.application.log
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.delete
import io.ktor.server.routing.get
import io.ktor.server.routing.post
import no.nav.lydia.ADGrupper
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.IA_SAK_RADGIVER_PATH
import no.nav.lydia.ia.sak.api.sendFeil
import no.nav.lydia.ia.sak.domene.IAProsessStatus.KARTLEGGES
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.KartleggingStatus
import no.nav.lydia.integrasjoner.kartlegging.KartleggingService
import no.nav.lydia.tilgangskontroll.NavAnsatt
import no.nav.lydia.tilgangskontroll.somLesebruker
import no.nav.lydia.tilgangskontroll.somSaksbehandler

const val KARTLEGGING_BASE_ROUTE = "$IA_SAK_RADGIVER_PATH/kartlegging"

fun Route.iaSakKartlegging(
    iaSakService: IASakService,
    kartleggingService: KartleggingService,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
) {
    post("$KARTLEGGING_BASE_ROUTE/{orgnummer}/{saksnummer}/opprett") {
        val orgnummer = call.orgnummer ?: return@post call.sendFeil(IASakError.`ugyldig orgnummer`)

        call.somEierAvSakIKartlegges(iaSakService = iaSakService, adGrupper = adGrupper) { saksbehandler, iaSak ->
            val spørsmål = kartleggingService.hentAlleSpørsmål()
            kartleggingService.opprettKartlegging(
                orgnummer = orgnummer,
                saksnummer = iaSak.saksnummer,
                saksbehandler = saksbehandler,
                spørsmål = spørsmål
            )
        }.also { kartleggingEither ->
            auditLog.auditloggEither(
                call = call,
                either = kartleggingEither,
                orgnummer = orgnummer,
                auditType = AuditType.create,
                saksnummer = kartleggingEither.getOrNull()?.saksnummer
            )
        }.map {
            call.respond(HttpStatusCode.Created, it.toDto(true))
        }.mapLeft {
            call.respond(it.httpStatusCode, it.feilmelding)
        }
    }

    get("$KARTLEGGING_BASE_ROUTE/{orgnummer}/{saksnummer}") {
        val saksnummer = call.saksnummer ?: return@get call.sendFeil(IASakError.`ugyldig saksnummer`)
        val orgnummer = call.orgnummer ?: return@get call.sendFeil(IASakError.`ugyldig orgnummer`)
        var erEier = false

        call.somLesebruker(adGrupper = adGrupper) { lesebruker ->
            val iaSak = iaSakService.hentIASak(saksnummer = saksnummer).getOrNull()
                ?: return@somLesebruker IASakError.`ugyldig saksnummer`.left()
            erEier = iaSak.eidAv == lesebruker.navIdent
            kartleggingService.hentKartlegginger(saksnummer = saksnummer)
        }.also { kartleggingerEither ->
            auditLog.auditloggEither(
                call = call,
                either = kartleggingerEither,
                orgnummer = orgnummer,
                auditType = AuditType.access,
                saksnummer = saksnummer
            )
        }.map {
            call.respond(HttpStatusCode.OK, it.toDto(erEier))
        }.mapLeft {
            call.respond(it.httpStatusCode, it.feilmelding)
        }
    }

    get("$KARTLEGGING_BASE_ROUTE/{orgnummer}/{saksnummer}/{kartleggingId}") {
        val kartleggingId =
            call.kartleggingId ?: return@get call.sendFeil(IASakKartleggingError.`ugyldig kartleggingId`)
        val saksnummer =
            call.saksnummer ?: return@get call.sendFeil(IASakError.`ugyldig saksnummer`)

        call.somSaksbehandler(adGrupper = adGrupper) { saksbehandler ->
            iaSakService.somEierAvSak(saksnummer = saksnummer, saksbehandler = saksbehandler) { _ ->
                kartleggingService.hentKartleggingMedSvar(kartleggingId = kartleggingId)
            }
        }.also { kartlegging ->
            auditLog.auditloggEither(
                call = call,
                either = kartlegging,
                orgnummer = call.orgnummer,
                auditType = AuditType.access,
                saksnummer = call.saksnummer
            )
        }.map {
            call.respond(HttpStatusCode.OK, it)
        }.mapLeft {
            call.respond(it.httpStatusCode, it.feilmelding)
        }
    }

    post("$KARTLEGGING_BASE_ROUTE/{orgnummer}/{saksnummer}/{kartleggingId}/avslutt") {
        val saksnummer = call.saksnummer ?: return@post call.sendFeil(IASakError.`ugyldig saksnummer`)
        val kartleggingId =
            call.kartleggingId ?: return@post call.sendFeil(IASakKartleggingError.`ugyldig kartleggingId`)

        call.somEierAvSakIKartlegges(iaSakService = iaSakService, adGrupper = adGrupper) { _, _ ->
            val kartlegging = kartleggingService.hentKartlegginger(saksnummer = saksnummer)

            if (kartlegging.getOrNull()
                    ?.firstOrNull { it.kartleggingId.toString() == kartleggingId }?.status != KartleggingStatus.PÅBEGYNT
            )
                return@somEierAvSakIKartlegges IASakKartleggingError.`kartlegging er ikke i påbegynt`.left()

            kartleggingService.endreKartleggingStatus(
                kartleggingId = kartleggingId,
                status = KartleggingStatus.AVSLUTTET
            )
        }.also { kartlegging ->
            auditLog.auditloggEither(
                call = call,
                either = kartlegging,
                orgnummer = call.orgnummer,
                auditType = AuditType.access,
                saksnummer = call.saksnummer
            )
        }.map {
            call.respond(it.toDto(true))
        }.mapLeft {
            call.application.log.error(it.feilmelding)
            call.sendFeil(it)
        }
    }

    delete("$KARTLEGGING_BASE_ROUTE/{orgnummer}/{saksnummer}/{kartleggingId}") {
        val kartleggingId =
            call.kartleggingId ?: return@delete call.sendFeil(IASakKartleggingError.`ugyldig kartleggingId`)

        call.somEierAvSakIKartlegges(iaSakService = iaSakService, adGrupper = adGrupper) { _, _ ->
            kartleggingService.slettKartlegging(kartleggingId = kartleggingId)
        }.also { kartlegging ->
            auditLog.auditloggEither(
                call = call,
                either = kartlegging,
                orgnummer = call.orgnummer,
                auditType = AuditType.delete,
                saksnummer = call.saksnummer
            )
        }.map {
            call.respond(it.toDto(erEier = false))
        }.mapLeft {
            call.application.log.error(it.feilmelding)
            call.sendFeil(it)
        }
    }

    post("$KARTLEGGING_BASE_ROUTE/{orgnummer}/{saksnummer}/{kartleggingId}/start") {
        val kartleggingId =
            call.kartleggingId ?: return@post call.sendFeil(IASakKartleggingError.`ugyldig kartleggingId`)

        call.somEierAvSakIKartlegges(iaSakService, adGrupper) { _, _ ->
            kartleggingService.endreKartleggingStatus(
                kartleggingId = kartleggingId,
                status = KartleggingStatus.PÅBEGYNT
            )
        }.also { kartlegging ->
            auditLog.auditloggEither(
                call = call,
                either = kartlegging,
                orgnummer = call.orgnummer,
                auditType = AuditType.access,
                saksnummer = call.saksnummer
            )
        }.map {
            call.respond(it.toDto(true))
        }.mapLeft {
            call.sendFeil(it)
        }
    }
}

private fun <T> ApplicationCall.somEierAvSakIKartlegges(
    iaSakService: IASakService,
    adGrupper: ADGrupper,
    block: (NavAnsatt.NavAnsattMedSaksbehandlerRolle, IASak) -> Either<Feil, T>
) =
    somSaksbehandler(adGrupper) { saksbehandler ->
        val saksnummer = saksnummer ?: return@somSaksbehandler IASakError.`ugyldig saksnummer`.left()
        val orgnummer = orgnummer ?: return@somSaksbehandler IASakError.`ugyldig orgnummer`.left()
        val iaSak = iaSakService.hentIASak(saksnummer = saksnummer).getOrNull()
            ?: return@somSaksbehandler IASakError.`ugyldig saksnummer`.left()
        if (iaSak.orgnr != orgnummer)
            IASakError.`ugyldig orgnummer`.left()
        else if (iaSak.eidAv != saksbehandler.navIdent)
            IASakError.`ikke eier av sak`.left()
        else if (iaSak.status != KARTLEGGES)
            IASakKartleggingError.`sak er ikke i kartleggingsstatus`.left()
        else
            block(saksbehandler, iaSak)
    }

private val ApplicationCall.orgnummer
    get() = parameters["orgnummer"]
private val ApplicationCall.saksnummer
    get() = parameters["saksnummer"]
private val ApplicationCall.kartleggingId
    get() = parameters["kartleggingId"]

object IASakKartleggingError {
    val `kartlegging er ikke i påbegynt` =
        Feil("Kartlegging er ikke i påbegynt status", HttpStatusCode.Forbidden)
    val `generell feil under uthenting` =
        Feil("Generell feil under uthenting av kartlegging", HttpStatusCode.InternalServerError)
    val `feil under oppdatering` =
        Feil("Feil under oppdatering av kartlegging", HttpStatusCode.InternalServerError)
    val `sak er ikke i kartleggingsstatus` =
        Feil("Sak må være i kartleggingsstatus for å starte kartlegging", HttpStatusCode.Forbidden)
    val `ugyldig kartleggingId` = Feil("Ugyldig kartlegging", HttpStatusCode.BadRequest)
}
