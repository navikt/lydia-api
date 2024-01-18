package no.nav.lydia.ia.sak.api.kartlegging

import arrow.core.Either.Left
import arrow.core.flatMap
import io.ktor.http.HttpStatusCode
import io.ktor.server.application.call
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.post
import no.nav.lydia.ADGrupper
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.IA_SAK_RADGIVER_PATH
import no.nav.lydia.ia.sak.api.sendFeil
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.integrasjoner.azure.AzureService
import no.nav.lydia.tilgangskontroll.objectId
import no.nav.lydia.tilgangskontroll.somSaksbehandler

fun Route.iaSakKartlegging(
    iaSakService: IASakService,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
    azureService: AzureService,
    ) {
    post("$IA_SAK_RADGIVER_PATH/{orgnummer}/{saksnummer}/kartlegging") {
        val saksnummer = call.parameters["saksnummer"] ?: return@post call.sendFeil(IASakError.`ugyldig saksnummer`)
        val iaSak = iaSakService.hentIASak(saksnummer).getOrNull() ?: return@post call.sendFeil(IASakError.`ugyldig saksnummer`)
        val orgnummer = call.parameters["orgnummer"] ?: return@post call.sendFeil(IASakError.`ugyldig orgnummer`)
        if (orgnummer != iaSak.orgnr) return@post call.sendFeil(IASakError.`ugyldig orgnummer`)
        if (iaSak.status != IAProsessStatus.KARTLEGGES) return@post call.sendFeil(IASakKartleggingError.`sak er ikke i kartleggingsstatus`)
        call.somSaksbehandler(adGrupper = adGrupper) { saksbehandler ->
            if (saksbehandler.navIdent != iaSak.eidAv) return@somSaksbehandler Left(IASakError.`ikke eier av sak`)
            azureService . hentNavenhet (call.objectId()).flatMap { navEnhet ->
                iaSakService.opprettKartlegging(
                    orgnummer = orgnummer,
                    saksnummer = saksnummer,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet
                ).map { it.toDto() }
            }
        }.also { iaSakEither ->
            auditLog.auditloggEither(
                call = call,
                either = iaSakEither,
                orgnummer = orgnummer,
                auditType = AuditType.create,
                saksnummer = saksnummer
            )
        }.map {
            call.respond(HttpStatusCode.Created, it)
        }.mapLeft {
            call.respond(it.httpStatusCode, it.feilmelding)
        }
    }
}

object IASakKartleggingError {
    val `sak er ikke i kartleggingsstatus` =
        Feil("Sak må være i kartleggingsstatus for å starte kartlegging", HttpStatusCode.Forbidden)
}
