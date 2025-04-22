package no.nav.lydia.ia.sak.api

import arrow.core.flatMap
import arrow.core.getOrElse
import arrow.core.right
import io.ktor.http.HttpStatusCode
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
import no.nav.lydia.appstatus.Metrics
import no.nav.lydia.ia.sak.IAProsessService
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.api.IASakDto.Companion.toDto
import no.nav.lydia.ia.sak.api.extensions.iaSakLeveranseId
import no.nav.lydia.ia.sak.api.extensions.orgnummer
import no.nav.lydia.ia.sak.api.extensions.saksnummer
import no.nav.lydia.ia.sak.api.extensions.sendFeil
import no.nav.lydia.ia.sak.api.prosess.tilDto
import no.nav.lydia.ia.sak.domene.IATjeneste
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
const val IA_TJENESTER_PATH = "tjenester"
const val IA_MODULER_PATH = "moduler"

fun Route.iaSakRådgiver(
    iaSakService: IASakService,
    iaProsessService: IAProsessService,
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
                ).map { it.toDto(superbruker) }
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
            call.respond(HttpStatusCode.Created, it)
        }.mapLeft {
            call.respond(it.httpStatusCode, it.feilmelding)
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
        val saksnummer = call.saksnummer ?: return@get call.sendFeil(IASakError.`ugyldig saksnummer`)
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
                    sak.addHendelser(hendelser.filter { hendelse -> hendelse.saksnummer == sak.saksnummer })
                }
                .sortedByDescending { it.opprettetTidspunkt }
                .map { sak ->
                    val samarbeid = iaProsessService.hentIAProsesser(sak).getOrElse { emptyList() }
                    sak.tilSakshistorikk(samarbeid.tilDto())
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
                    .map { it.toDto(saksbehandler) }
                    .onRight { Metrics.loggHendelse(hendelseDto.hendelsesType) }
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
            call.respond(HttpStatusCode.Created, it)
        }.mapLeft {
            call.respond(it.httpStatusCode, it.feilmelding)
        }
    }

    get("$IA_SAK_RADGIVER_PATH/$IA_SAK_LEVERANSE_PATH/{orgnummer}/{saksnummer}") {
        val orgnr = call.orgnummer ?: return@get call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@get call.sendFeil(IASakError.`ugyldig saksnummer`)
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

    post("$IA_SAK_RADGIVER_PATH/$IA_SAK_LEVERANSE_PATH/{orgnummer}/{saksnummer}") {
        val orgnr = call.orgnummer ?: return@post call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@post call.sendFeil(IASakError.`ugyldig saksnummer`)
        val leveranse = call.receive<IASakLeveranseOpprettelsesDto>()

        call.somSaksbehandler(adGrupper = adGrupper) { saksbehandler ->
            iaSakService.opprettIASakLeveranse(leveranse = leveranse, saksbehandler = saksbehandler)
        }.also {
            auditLog.auditloggEither(
                call = call,
                either = it,
                orgnummer = orgnr,
                auditType = AuditType.update,
                saksnummer = saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.Created, message = it.tilDto())
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    put("$IA_SAK_RADGIVER_PATH/$IA_SAK_LEVERANSE_PATH/{orgnr}/{saksnummer}/{iaSakLeveranseId}") {
        val orgnr = call.parameters["orgnr"] ?: return@put call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.parameters["saksnummer"] ?: return@put call.sendFeil(IASakError.`ugyldig saksnummer`)
        val iaSakLeveranseId =
            call.parameters["iaSakLeveranseId"] ?: return@put call.sendFeil(IASakError.`ugyldig iaSakLeveranseId`)
        val oppdateringsDto = call.receive<IASakLeveranseOppdateringsDto>()

        call.somSaksbehandler(adGrupper = adGrupper) { saksbehandler ->
            iaSakService.oppdaterIASakLeveranse(
                iaSakLeveranseId = iaSakLeveranseId.toInt(),
                oppdateringsDto = oppdateringsDto,
                saksbehandler = saksbehandler,
            )
        }.also {
            auditLog.auditloggEither(
                call = call,
                either = it,
                orgnummer = orgnr,
                auditType = AuditType.update,
                saksnummer = saksnummer,
            )
        }.map {
            call.respond(it.tilDto())
        }.mapLeft {
            call.respond(message = it.feilmelding, status = it.httpStatusCode)
        }
    }

    delete("$IA_SAK_RADGIVER_PATH/$IA_SAK_LEVERANSE_PATH/{orgnummer}/{saksnummer}/{iaSakLeveranseId}") {
        val orgnr = call.orgnummer ?: return@delete call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@delete call.sendFeil(IASakError.`ugyldig saksnummer`)
        val iaSakLeveranseId =
            call.iaSakLeveranseId ?: return@delete call.sendFeil(IASakError.`ugyldig iaSakLeveranseId`)

        call.somSaksbehandler(adGrupper = adGrupper) { saksbehandler ->
            iaSakService.slettIASakLeveranse(iaSakLeveranseId = iaSakLeveranseId.toInt(), saksbehandler)
        }.also {
            auditLog.auditloggEither(
                call = call,
                either = it,
                orgnummer = orgnr,
                auditType = AuditType.delete,
                saksnummer = saksnummer,
            )
        }.map {
            call.respond(it)
        }.mapLeft {
            call.respond(message = it.feilmelding, status = it.httpStatusCode)
        }
    }

    get("$IA_SAK_RADGIVER_PATH/$IA_SAK_LEVERANSE_PATH/$IA_TJENESTER_PATH") {
        call.somLesebruker(adGrupper = adGrupper) { _ ->
            iaSakService.hentTjenester()
        }.map {
            call.respond(it.map(IATjeneste::tilDto).sorted())
        }.mapLeft {
            call.respond(message = it.feilmelding, status = it.httpStatusCode)
        }
    }

    get("$IA_SAK_RADGIVER_PATH/$IA_SAK_LEVERANSE_PATH/$IA_MODULER_PATH") {
        call.somSaksbehandler(adGrupper = adGrupper) { _ ->
            iaSakService.hentModuler()
        }.map {
            call.respond(it.map { modul -> modul.tilDto() })
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
        fun TilstandsmaskinFeil.tilFeilMedHttpFeilkode() = Feil(this.feilmelding, HttpStatusCode.UnprocessableEntity)
    }
}

object IASakError {
    val `prøvde å legge til en hendelse på en tom sak` =
        Feil("Prøvde å legge til en hendelse på en tom sak", HttpStatusCode.Conflict)
    val `prøvde å legge til en hendelse på en gammel sak` = Feil(
        "Prøvde å legge til hendelse på gammel sak",
        HttpStatusCode.Conflict,
    )
    val `fikk ikke oppdatert sak` = Feil("Fikk ikke oppdatert sak", HttpStatusCode.Conflict)
    val `fikk ikke oppdatert leveranse` = Feil("Fikk ikke oppdatert leveranse", HttpStatusCode.Conflict)
    val `fikk ikke slettet sak` = Feil("Fikk ikke slettet sak", HttpStatusCode.InternalServerError)
    val `ugyldig orgnummer` = Feil("Ugyldig orgnummer", HttpStatusCode.BadRequest)
    val `ugyldig saksnummer` = Feil("Ugyldig saksnummer", HttpStatusCode.BadRequest)
    val `ugyldig iaSakLeveranseId` = Feil("Ugyldig leveranseId", HttpStatusCode.BadRequest)
    val `ugyldig modul` = Feil("Ugyldig modul", HttpStatusCode.BadRequest)
    val `ikke eier av sak` = Feil("Ikke eier av sak", HttpStatusCode.BadRequest)
    val `det finnes flere saker på dette orgnummeret som ikke regnes som avsluttet` = Feil(
        "Det finnes flere saker på dette orgnummeret som ikke regnes som avsluttet",
        HttpStatusCode.NotImplemented,
    )
    val `generell feil under uthenting` = Feil("Generell feil under uthenting", HttpStatusCode.InternalServerError)

    val `kan ikke fullføre med gjenstående leveranser` =
        Feil("Kan ikke fullføre med gjenstående leveranser", HttpStatusCode.BadRequest)

    val `kan ikke fullføre sak med aktive samarbeid` =
        Feil("Kan ikke fullføre sak med aktive samarbeid", HttpStatusCode.BadRequest)
}
