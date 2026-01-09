package no.nav.lydia.ia.sak.api

import arrow.core.flatMap
import arrow.core.getOrElse
import arrow.core.right
import io.ktor.http.HttpStatusCode
import io.ktor.server.request.receive
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.get
import io.ktor.server.routing.post
import no.nav.lydia.ADGrupper
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.appstatus.Metrics
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.IASamarbeidService
import no.nav.lydia.ia.sak.api.IASakDto.Companion.toDto
import no.nav.lydia.ia.sak.api.extensions.orgnummer
import no.nav.lydia.ia.sak.api.extensions.saksnummer
import no.nav.lydia.ia.sak.api.extensions.sendFeil
import no.nav.lydia.ia.sak.api.samarbeid.tilDto
import no.nav.lydia.ia.sak.domene.TilstandsmaskinFeil
import no.nav.lydia.integrasjoner.azure.AzureService
import no.nav.lydia.tilgangskontroll.fia.objectId
import no.nav.lydia.tilgangskontroll.somHøyestTilgang
import no.nav.lydia.tilgangskontroll.somLesebruker
import no.nav.lydia.tilgangskontroll.somSaksbehandler
import no.nav.lydia.tilgangskontroll.somSuperbruker

const val IA_SAK_RADGIVER_PATH = "iasak/radgiver"
const val SAK_HENDELSE_SUB_PATH = "hendelse"
const val SAMARBEIDSHISTORIKK_PATH = "historikk"
const val IA_SAK_LEVERANSE_PATH = "leveranse"

fun Route.iaSakRådgiver(
    iaSakService: IASakService,
    samarbeidService: IASamarbeidService,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
    azureService: AzureService,
) {
    post("$IA_SAK_RADGIVER_PATH/{orgnummer}") {
        val orgnummer = call.orgnummer ?: return@post call.respond(IASakError.`ugyldig orgnummer`)
        call.somSuperbruker(adGrupper = adGrupper) { superbruker ->
            azureService.hentNavenhet(call.objectId()).flatMap { navEnhet ->
                iaSakService.opprettSakOgMerkSomVurdert(
                    orgnummer = orgnummer,
                    superbruker = superbruker,
                    navEnhet = navEnhet,
                ).map { it.toDto(navAnsatt = superbruker) }
            }
        }.also { iaSakEither ->
            auditLog.auditloggEither(
                call = call,
                either = iaSakEither,
                orgnummer = orgnummer,
                auditType = AuditType.create,
                saksnummer = iaSakEither.map { iaSak -> iaSak.saksnummer }.getOrNull(),
            )
        }.map {
            call.respond(status = HttpStatusCode.Created, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    get("$IA_SAK_RADGIVER_PATH/{orgnummer}/{saksnummer}") {
        val orgnummer = call.orgnummer ?: return@get call.respond(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@get call.respond(IASakError.`ugyldig saksnummer`)
        call.somHøyestTilgang(adGrupper = adGrupper) { navAnsatt ->
            if (saksnummer == "aktiv") {
                iaSakService.hentAktivSak(orgnummer = orgnummer, navAnsatt = navAnsatt).right()
            } else {
                iaSakService.hentIASak(saksnummer).map { it.toDto(navAnsatt) }
            }
        }.also { either ->
            auditLog.auditloggEither(
                call = call,
                either = either,
                orgnummer = orgnummer,
                auditType = AuditType.access,
            )
        }.map {
            val response = it ?: HttpStatusCode.NoContent
            call.respond(response)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    get("$IA_SAK_RADGIVER_PATH/{orgnummer}/{saksnummer}/status") {
        val saksnummer = call.saksnummer ?: return@get call.sendFeil(feil = IASakError.`ugyldig saksnummer`)
        call.somLesebruker(adGrupper = adGrupper) { navAnsatt ->
            iaSakService.hentSaksStatus(saksnummer)
        }.map {
            call.respond(it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    get("$IA_SAK_RADGIVER_PATH/$SAMARBEIDSHISTORIKK_PATH/{orgnummer}") {
        val orgnummer = call.orgnummer ?: return@get call.respond(IASakError.`ugyldig orgnummer`)
        call.somLesebruker(adGrupper = adGrupper) { _ ->
            val hendelser = iaSakService.hentHendelserForOrgnummer(orgnr = orgnummer)
            iaSakService.hentSakerForOrgnummer(orgnummer = orgnummer)
                .map { sak ->
                    sak.addHendelser(hendelser = hendelser.filter { hendelse -> hendelse.saksnummer == sak.saksnummer })
                }
                .sortedByDescending { it.opprettetTidspunkt }
                .map { sak ->
                    val samarbeid = samarbeidService.hentSamarbeid(sak.saksnummer).getOrElse { emptyList() }
                    sak.tilSakshistorikk(samarbeid = samarbeid.tilDto())
                }
                .right()
        }.also { either ->
            if (either.isLeft()) {
                auditLog.auditloggEither(
                    call = call,
                    either = either,
                    orgnummer = orgnummer,
                    auditType = AuditType.access,
                )
            } else {
                val iaSaker = either.getOrElse { listOf() }
                iaSaker.forEach { iaSak ->
                    auditLog.auditloggEither(
                        call = call,
                        either = either,
                        orgnummer = orgnummer,
                        auditType = AuditType.access,
                        saksnummer = iaSak.saksnummer,
                    )
                }
            }
        }.map { historikk ->
            call.respond(historikk).right()
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    post("$IA_SAK_RADGIVER_PATH/$SAK_HENDELSE_SUB_PATH") {
        val hendelseDto = call.receive<IASakshendelseDto>()
        call.somSaksbehandler(adGrupper = adGrupper) { saksbehandler ->
            azureService.hentNavenhet(call.objectId()).flatMap { navEnhet ->
                iaSakService.behandleHendelse(hendelseDto = hendelseDto, saksbehandler = saksbehandler, navEnhet = navEnhet)
                    .map { it.toDto(navAnsatt = saksbehandler) }
                    .onRight { Metrics.loggHendelse(hendelsesType = hendelseDto.hendelsesType) }
            }
        }.also {
            auditLog.auditloggEither(
                call = call,
                either = it,
                orgnummer = hendelseDto.orgnummer,
                auditType = AuditType.update,
                saksnummer = hendelseDto.saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.Created, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    get("$IA_SAK_RADGIVER_PATH/$IA_SAK_LEVERANSE_PATH/{orgnummer}/{saksnummer}") {
        val orgnr = call.orgnummer ?: return@get call.sendFeil(feil = IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@get call.sendFeil(feil = IASakError.`ugyldig saksnummer`)
        call.somLesebruker(adGrupper = adGrupper) { _ ->
            iaSakService.hentIASakLeveranser(saksnummer = saksnummer)
        }.also {
            auditLog.auditloggEither(
                call = call,
                either = it,
                orgnummer = orgnr,
                auditType = AuditType.access,
                saksnummer = saksnummer,
            )
        }.map {
            call.respond(it.tilIASakLeveranserPerTjenesteDto().sorted())
        }.mapLeft {
            call.respond(message = it.feilmelding, status = it.httpStatusCode)
        }
    }
}

class Feil(
    val feilmelding: String,
    val httpStatusCode: HttpStatusCode,
) {
    companion object {
        fun TilstandsmaskinFeil.tilFeilMedHttpFeilkode(): Feil = Feil(feilmelding = this.feilmelding, httpStatusCode = HttpStatusCode.UnprocessableEntity)
    }
}

object IASakError {
    val `prøvde å legge til en hendelse på en tom sak` =
        Feil(feilmelding = "Prøvde å legge til en hendelse på en tom sak", httpStatusCode = HttpStatusCode.Conflict)
    val `prøvde å legge til en hendelse på en gammel sak` =
        Feil(feilmelding = "Prøvde å legge til hendelse på gammel sak", httpStatusCode = HttpStatusCode.Conflict)
    val `fikk ikke oppdatert sak` =
        Feil(feilmelding = "Fikk ikke oppdatert sak", httpStatusCode = HttpStatusCode.Conflict)
    val `fikk ikke slettet sak` =
        Feil(feilmelding = "Fikk ikke slettet sak", httpStatusCode = HttpStatusCode.InternalServerError)
    val `ugyldig orgnummer` =
        Feil(feilmelding = "Ugyldig orgnummer", httpStatusCode = HttpStatusCode.BadRequest)
    val `ugyldig saksnummer` =
        Feil(feilmelding = "Ugyldig saksnummer", httpStatusCode = HttpStatusCode.BadRequest)
    val `er ikke følger eller eier av sak` =
        Feil(feilmelding = "Er ikke følger eller eier av sak", httpStatusCode = HttpStatusCode.Forbidden)
    val `det finnes flere saker på dette orgnummeret som ikke regnes som avsluttet` =
        Feil(feilmelding = "Det finnes flere saker på dette orgnummeret som ikke regnes som avsluttet", httpStatusCode = HttpStatusCode.NotImplemented)
    val `generell feil under uthenting` =
        Feil(feilmelding = "Generell feil under uthenting", httpStatusCode = HttpStatusCode.InternalServerError)
    val `kan ikke fullføre sak med aktive samarbeid` =
        Feil(feilmelding = "Kan ikke avslutte sak med aktive samarbeid", httpStatusCode = HttpStatusCode.BadRequest)
    val `kan ikke ta eierskap da det ikke finnes noen aktiv sak` =
        Feil(feilmelding = "kan ikke ta eierskap da det ikke finnes noen aktiv sak", httpStatusCode = HttpStatusCode.BadRequest)
}
