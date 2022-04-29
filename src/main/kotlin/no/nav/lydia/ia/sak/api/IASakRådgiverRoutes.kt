package no.nav.lydia.ia.sak.api

import arrow.core.Either
import arrow.core.right
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import no.nav.lydia.*
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.api.IASakDto.Companion.toDto
import no.nav.lydia.ia.sak.api.IASakshendelseOppsummeringDto.Companion.toDto
import no.nav.lydia.tilgangskontroll.Rådgiver.Companion.somBrukerMedLesetilgang
import no.nav.lydia.tilgangskontroll.Rådgiver.Companion.somBrukerMedSaksbehandlertilgang
import no.nav.lydia.tilgangskontroll.Rådgiver.Companion.somSuperbruker

val IA_SAK_RADGIVER_PATH = "iasak/radgiver"
val SAK_HENDELSE_SUB_PATH = "/hendelse"
val SAK_HENDELSER_SUB_PATH = "/hendelser"

fun Route.IASak_Rådgiver(
    iaSakService: IASakService,
    fiaRoller: FiaRoller,
    auditLog: AuditLog
) {
    post("$IA_SAK_RADGIVER_PATH/{orgnummer}") {
        val orgnummer = call.parameters["orgnummer"] ?: return@post call.respond(IASakError.`ugyldig orgnummer`)
        somSuperbruker(call = call, fiaRoller = fiaRoller) { superbruker ->
            iaSakService.opprettSakOgMerkSomVurdert(orgnummer, superbruker.navIdent).map { it.toDto(superbruker) }
        }.also {
            when (it) {
                is Either.Left -> {
                    when (it.value.httpStatusCode) {
                        HttpStatusCode.Forbidden -> auditLog(
                            auditLog = auditLog,
                            orgnummer = orgnummer, auditType = AuditType.create, tillat = Tillat.Nei
                        )
                    }
                    call.respond(it.value.httpStatusCode)
                }
                is Either.Right -> {
                    auditLog(
                        auditLog = auditLog,
                        orgnummer = orgnummer,
                        auditType = AuditType.create,
                        tillat = Tillat.Ja,
                        saksnummer = it.value.saksnummer
                    )
                    call.respond(HttpStatusCode.Created, it.value)
                }
            }
        }
    }

    get("$IA_SAK_RADGIVER_PATH/{orgnummer}") {
        val orgnummer = call.parameters["orgnummer"] ?: return@get call.respond(IASakError.`ugyldig orgnummer`)
        somBrukerMedLesetilgang(call = call, fiaRoller = fiaRoller) { rådgiver ->
            iaSakService.hentSaker(orgnummer).toDto(rådgiver = rådgiver).right()
        }.map {
            auditLog(auditLog = auditLog, orgnummer = orgnummer, auditType = AuditType.access, tillat = Tillat.Ja)
            call.respond(it).right()
        }.mapLeft {
            call.respond(HttpStatusCode.InternalServerError, "Fikk ikke tak i hendelsene til denne saken")
        }
    }

    get("$IA_SAK_RADGIVER_PATH/$SAK_HENDELSER_SUB_PATH/{saksnummer}") {
        call.parameters["saksnummer"]?.let { saksnummer ->
            val hendelser = iaSakService.hentHendelserForSak(saksnummer)
            hendelser.map { it.orgnummer }.firstOrNull()?.let { orgnummer ->
                auditLog(
                    auditLog = auditLog,
                    orgnummer = orgnummer,
                    auditType = AuditType.access,
                    tillat = Tillat.Ja,
                    saksnummer = saksnummer
                )
            }
            call.respond(hendelser.toDto())
        } ?: call.respond(HttpStatusCode.InternalServerError, "Fikk ikke tak i hendelsene til denne saken")
    }

    post("$IA_SAK_RADGIVER_PATH/$SAK_HENDELSE_SUB_PATH") {
        val hendelseDto = call.receive<IASakshendelseDto>()
        somBrukerMedSaksbehandlertilgang(call = call, fiaRoller = fiaRoller) { rådgiver ->
            iaSakService.behandleHendelse(hendelseDto, rådgiver = rådgiver).map { it.toDto(rådgiver) }
        }.also {
            when (it) {
                is Either.Left -> {
                    when (it.value.httpStatusCode) {
                        HttpStatusCode.Forbidden -> auditLog(
                            auditLog = auditLog,
                            orgnummer = hendelseDto.orgnummer, auditType = AuditType.update, tillat = Tillat.Nei,
                            saksnummer = hendelseDto.saksnummer
                        )
                    }
                    call.respond(it.value.httpStatusCode, it.value.feilmelding)
                }
                is Either.Right -> {
                    auditLog(
                        auditLog = auditLog, orgnummer = hendelseDto.orgnummer, auditType = AuditType.update,
                        tillat = Tillat.Ja, saksnummer = hendelseDto.saksnummer
                    )
                    call.respond(HttpStatusCode.Created, it.value)
                }
            }
        }
    }
}

class Feil(val feilmelding: String, val httpStatusCode: HttpStatusCode)

object IASakError{
    val `prøvde å utføre en ugyldig hendelse` =
        Feil("Denne hendelsen er ugyldig", HttpStatusCode.UnprocessableEntity)
    val `prøvde å legge til en hendelse på en tom sak` =
        Feil("Prøvde å legge til en hendelse på en tom sak", HttpStatusCode.Forbidden)
    val `prøvde å legge til en hendelse på en gammel sak` = Feil(
        "Prøvde å legge til hendelse på gammel sak", HttpStatusCode.Forbidden
    )
    val `fikk ikke oppdatert sak` = Feil("Fikk ikke oppdater sak", HttpStatusCode.Forbidden)
    val `ugyldig orgnummer` = Feil("Ugyldig orgnummer", HttpStatusCode.Forbidden)
}
