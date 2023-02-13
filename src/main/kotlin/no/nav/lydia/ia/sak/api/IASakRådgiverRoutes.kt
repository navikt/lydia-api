package no.nav.lydia.ia.sak.api

import arrow.core.Either
import arrow.core.getOrElse
import arrow.core.right
import io.ktor.http.HttpStatusCode
import io.ktor.server.application.*
import io.ktor.server.request.receive
import io.ktor.server.response.respond
import io.ktor.server.routing.*
import io.ktor.server.routing.post
import kotlinx.datetime.toKotlinLocalDate
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.FiaRoller
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.api.IASakDto.Companion.toDto
import no.nav.lydia.ia.sak.domene.*
import no.nav.lydia.tilgangskontroll.Rådgiver.Companion.somBrukerMedLesetilgang
import no.nav.lydia.tilgangskontroll.Rådgiver.Companion.somBrukerMedSaksbehandlertilgang
import no.nav.lydia.tilgangskontroll.Rådgiver.Companion.somSuperbruker

val IA_SAK_RADGIVER_PATH = "iasak/radgiver"
val SAK_HENDELSE_SUB_PATH = "hendelse"
val SAMARBEIDSHISTORIKK_PATH = "historikk"
val IA_SAK_LEVERANSE_PATH = "leveranse"
val IA_TJENESTER_PATH = "tjenester"
val IA_MODULER_PATH = "moduler"

fun Route.iaSakRådgiver(
    iaSakService: IASakService,
    fiaRoller: FiaRoller,
    auditLog: AuditLog
) {
    post("$IA_SAK_RADGIVER_PATH/{orgnummer}") {
        val orgnummer = call.parameters["orgnummer"] ?: return@post call.respond(IASakError.`ugyldig orgnummer`)
        somSuperbruker(call = call, fiaRoller = fiaRoller) { superbruker ->
            iaSakService.opprettSakOgMerkSomVurdert(orgnummer, superbruker).map { it.toDto(superbruker) }
        }.also { iaSakEither ->
            auditLog.auditloggEither(
                call = call,
                either = iaSakEither,
                orgnummer = orgnummer,
                auditType = AuditType.create,
                saksnummer = iaSakEither.map { iaSak -> iaSak.saksnummer }.orNull()
            )
        }.also { iaSakEither ->
            when (iaSakEither) {
                is Either.Left -> call.respond(iaSakEither.value.httpStatusCode, iaSakEither.value.feilmelding)
                is Either.Right -> call.respond(HttpStatusCode.Created, iaSakEither.value)
            }
        }
    }

    get("$IA_SAK_RADGIVER_PATH/{orgnummer}") {
        val orgnummer = call.parameters["orgnummer"] ?: return@get call.respond(IASakError.`ugyldig orgnummer`)
        somBrukerMedLesetilgang(call = call, fiaRoller = fiaRoller) { rådgiver ->
            iaSakService.hentSakerForOrgnummer(orgnummer).sortedByDescending { it.opprettetTidspunkt }.toDto(rådgiver = rådgiver).right()
        }.also { either ->
            auditLog.auditloggEither(
                call = call,
                either = either,
                orgnummer = orgnummer,
                auditType = AuditType.access,
            )
        }.fold(
            ifRight = { call.respond(it) },
            ifLeft = {
                call.respond(
                    status = it.httpStatusCode,
                    message = it.feilmelding
                )
            })
    }

    get("$IA_SAK_RADGIVER_PATH/$SAMARBEIDSHISTORIKK_PATH/{orgnummer}") {
        val orgnummer = call.parameters["orgnummer"] ?: return@get call.respond(IASakError.`ugyldig orgnummer`)
        somBrukerMedLesetilgang(call = call, fiaRoller = fiaRoller) {
            iaSakService.hentHendelserForOrgnummer(orgnr = orgnummer)
                .groupBy { it.saksnummer }
                .map { IASak.fraHendelser(it.value) }
                .sortedByDescending { it.opprettetTidspunkt }
                .right()
        }. also { either ->
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
                        saksnummer = iaSak.saksnummer
                    )
                }
            }

        }.map { iaSaker ->
            call.respond(iaSaker.tilSamarbeidshistorikk()).right()
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    post("$IA_SAK_RADGIVER_PATH/$SAK_HENDELSE_SUB_PATH") {
        val hendelseDto = call.receive<IASakshendelseDto>()
        somBrukerMedSaksbehandlertilgang(call = call, fiaRoller = fiaRoller) { rådgiver ->
            iaSakService.behandleHendelse(hendelseDto, rådgiver = rådgiver).map { it.toDto(rådgiver) }
        }.also {
            auditLog.auditloggEither(
                call = call,
                either = it,
                orgnummer = hendelseDto.orgnummer,
                auditType = AuditType.update,
                saksnummer = hendelseDto.saksnummer
            )
        }.also {
            when (it) {
                is Either.Left -> call.respond(it.value.httpStatusCode, it.value.feilmelding)
                is Either.Right -> call.respond(HttpStatusCode.Created, it.value)
            }
        }
    }

    get("$IA_SAK_RADGIVER_PATH/$IA_SAK_LEVERANSE_PATH/{orgnr}/{saksnummer}") {
        val orgnr = call.parameters["orgnr"] ?: return@get call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.parameters["saksnummer"] ?: return@get call.sendFeil(IASakError.`ugyldig saksnummer`)
        somBrukerMedLesetilgang(call = call, fiaRoller = fiaRoller) { _ ->
            iaSakService.hentIASakLeveranser(saksnummer = saksnummer)
        }.also {
            auditLog.auditloggEither(
                call = call,
                either = it,
                orgnummer = orgnr,
                auditType = AuditType.access,
                saksnummer = saksnummer
            )
        }.map {
            call.respond(it.tilDto())
        }.mapLeft {
            call.respond(message = it.feilmelding, status = it.httpStatusCode)
        }
    }

    post("$IA_SAK_RADGIVER_PATH/$IA_SAK_LEVERANSE_PATH/{orgnr}/{saksnummer}") {
        val orgnr = call.parameters["orgnr"] ?: return@post call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.parameters["saksnummer"] ?: return@post call.sendFeil(IASakError.`ugyldig saksnummer`)
        val leveranse = call.receive<IASakLeveranseOpprettelsesDto>()

        somBrukerMedSaksbehandlertilgang(call = call, fiaRoller = fiaRoller) { rådgiver ->
            iaSakService.opprettIASakLeveranse(leveranse = leveranse, rådgiver = rådgiver)
        }.also {
            auditLog.auditloggEither(
                call = call,
                either = it,
                orgnummer = orgnr,
                auditType = AuditType.update,
                saksnummer = saksnummer
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
        val iaSakLeveranseId = call.parameters["iaSakLeveranseId"] ?: return@put call.sendFeil(IASakError.`ugyldig iaSakLeveranseId`)
        val oppdateringsDto = call.receive<IASakLeveranseOppdateringsDto>()

        somBrukerMedSaksbehandlertilgang(call = call, fiaRoller = fiaRoller) { rådgiver ->
            iaSakService.oppdaterIASakLeveranse(iaSakLeveranseId = iaSakLeveranseId.toInt(), oppdateringsDto = oppdateringsDto, rådgiver = rådgiver)
        }.also {
            auditLog.auditloggEither(
                call = call,
                either = it,
                orgnummer = orgnr,
                auditType = AuditType.update,
                saksnummer = saksnummer
            )
        }.map {
            call.respond(it.tilDto())
        }.mapLeft {
            call.respond(message = it.feilmelding, status = it.httpStatusCode)
        }

        call.respond(HttpStatusCode.OK, IASakLeveranseDto(
            id= 1,
            saksnummer = saksnummer,
            modul = Modul(id = 1, navn = "", iaTjeneste = IATjeneste(id = 1, navn = "")),
            status = IASakLeveranseStatus.LEVERT,
            frist = java.time.LocalDate.now().toKotlinLocalDate()
        ))
    }

    delete("$IA_SAK_RADGIVER_PATH/$IA_SAK_LEVERANSE_PATH/{orgnr}/{saksnummer}/{iaSakLeveranseId}") {
        val orgnr = call.parameters["orgnr"] ?: return@delete call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.parameters["saksnummer"] ?: return@delete call.sendFeil(IASakError.`ugyldig saksnummer`)
        val iaSakLeveranseId = call.parameters["iaSakLeveranseId"] ?: return@delete call.sendFeil(IASakError.`ugyldig iaSakLeveranseId`)

        somBrukerMedSaksbehandlertilgang(call = call, fiaRoller = fiaRoller) { rådgiver ->
            iaSakService.slettIASakLeveranse(iaSakLeveranseId = iaSakLeveranseId.toInt(), rådgiver)
        }.also {
            auditLog.auditloggEither(
                call = call,
                either = it,
                orgnummer = orgnr,
                auditType = AuditType.delete,
                saksnummer = saksnummer
            )
        }.map {
            call.respond(it)
        }.mapLeft {
            call.respond(message = it.feilmelding, status = it.httpStatusCode)
        }
    }

    get("$IA_SAK_RADGIVER_PATH/$IA_SAK_LEVERANSE_PATH/$IA_TJENESTER_PATH") {
        somBrukerMedLesetilgang(call = call, fiaRoller = fiaRoller) { _ ->
            iaSakService.hentTjenester()
        }.map {
            call.respond(it)
        }.mapLeft {
            call.respond(message = it.feilmelding, status = it.httpStatusCode)
        }
    }

    get("$IA_SAK_RADGIVER_PATH/$IA_SAK_LEVERANSE_PATH/$IA_MODULER_PATH") {
        somBrukerMedLesetilgang(call = call, fiaRoller = fiaRoller) { _ ->
            iaSakService.hentModuler()
        }.map {
            call.respond(it)
        }.mapLeft {
            call.respond(message = it.feilmelding, status = it.httpStatusCode)
        }
    }
}

private suspend fun ApplicationCall.sendFeil(feil: Feil) = respond(feil.httpStatusCode, feil.feilmelding)

class Feil(val feilmelding: String, val httpStatusCode: HttpStatusCode) {
    companion object {
        fun TilstandsmaskinFeil.tilFeilMedHttpFeilkode() = Feil(this.feilmelding, HttpStatusCode.UnprocessableEntity)
    }
}

object IASakError {
    val `prøvde å legge til en hendelse på en tom sak` =
        Feil("Prøvde å legge til en hendelse på en tom sak", HttpStatusCode.Conflict)
    val `prøvde å legge til en hendelse på en gammel sak` = Feil(
        "Prøvde å legge til hendelse på gammel sak", HttpStatusCode.Conflict
    )
    val `fikk ikke oppdatert sak` = Feil("Fikk ikke oppdatert sak", HttpStatusCode.Conflict)
    val `fikk ikke slettet sak` = Feil("Fikk ikke slettet sak", HttpStatusCode.InternalServerError)
    val `ugyldig orgnummer` = Feil("Ugyldig orgnummer", HttpStatusCode.BadRequest)
    val `ugyldig saksnummer` = Feil("Ugyldig saksnummer", HttpStatusCode.BadRequest)
    val `ugyldig iaSakLeveranseId` = Feil("Ugyldig leveranseId", HttpStatusCode.BadRequest)
    val `ugyldig modul` = Feil("Ugyldig modul", HttpStatusCode.BadRequest)
    val `ikke eier av sak` = Feil("Ikke eier av sak", HttpStatusCode.BadRequest)
    val `det finnes flere saker på dette orgnummeret som ikke anses som avsluttet` = Feil(
        "Det finnes flere saker på dette orgnummeret som ikke anses som avsluttet", HttpStatusCode.NotImplemented
    )
    val `generell feil under uthenting` = Feil("Generell feil under uthenting", HttpStatusCode.InternalServerError)
}
