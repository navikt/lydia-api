package no.nav.lydia.api

import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.get
import io.ktor.server.routing.post
import no.nav.lydia.ADGrupper
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.felles.Feil
import no.nav.lydia.integrasjoner.azure.AzureService
import no.nav.lydia.samarbeidsperiode.IASakError
import no.nav.lydia.samarbeidsperiode.IASakService
import no.nav.lydia.tilgangskontroll.somLesebruker
import no.nav.lydia.tilgangskontroll.somSaksbehandlerMedNavenhet
import no.nav.lydia.tilstandsmaskin.NyFlytService

fun Route.nyFlytSamarbeidsperiode(
    iaSakService: IASakService,
    nyFlytService: NyFlytService,
    adGrupper: ADGrupper,
    azureService: AzureService,
    auditLog: AuditLog,
) {
    // GET
    get("$NY_FLYT_API_PATH/virksomhet/{orgnummer}/samarbeidsperiode") {
        val orgnr = call.orgnummer ?: return@get call.respond(IASakError.`ugyldig orgnummer`)
        call.somLesebruker(adGrupper) {
            nyFlytService.hentSisteIASakDto(orgnr)?.right()
                ?: Feil(feilmelding = "Fant ingen aktiv sak på virksomheten", httpStatusCode = HttpStatusCode.NoContent).left()
        }.also { iaSakEither ->
            auditLog.auditloggEither(
                call = call,
                either = iaSakEither,
                orgnummer = orgnr,
                auditType = AuditType.access,
                saksnummer = iaSakEither.map { iaSak -> iaSak.saksnummer }.getOrNull(),
            )
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    get("$NY_FLYT_API_PATH/virksomhet/{orgnummer}/samarbeidsperiode/{saksnummer}") {
        val orgnr = call.orgnummer ?: return@get call.respond(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@get call.respond(IASakError.`ugyldig saksnummer`)
        call.somLesebruker(adGrupper = adGrupper) {
            iaSakService.hentIASakDto(saksnummer)
        }.also { either ->
            auditLog.auditloggEither(
                call = call,
                either = either,
                orgnummer = orgnr,
                auditType = AuditType.access,
                saksnummer = saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    // POST
    // -- Dette er tenkt å være en midlertidig løsning frem til vi har utviklet kontaktperson funksjonalitet i samarbeid med Salesforce.
    // -- Dette etterlater ingen hendelser, men skriver kun over eierskap i den akktive saken
    post("$NY_FLYT_API_PATH/virksomhet/{orgnummer}/samarbeidsperiode/{saksnummer}/bli-eier") {
        val orgnr = call.orgnummer ?: return@post call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@post call.sendFeil(IASakError.`ugyldig saksnummer`)

        call.somSaksbehandlerMedNavenhet(adGrupper, azureService) { saksbehandler, _ ->
            nyFlytService.bliEier(orgnr = orgnr, saksnummer = saksnummer, navAnsatt = saksbehandler)
        }.also { iaSamarbeidDtoEither ->
            auditLog.auditloggEither(
                call = call,
                either = iaSamarbeidDtoEither,
                orgnummer = orgnr,
                auditType = AuditType.delete,
                saksnummer = iaSamarbeidDtoEither.getOrNull()?.saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }
}
