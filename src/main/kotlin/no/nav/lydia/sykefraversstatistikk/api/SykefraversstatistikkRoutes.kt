package no.nav.lydia.sykefraversstatistikk.api

import arrow.core.right
import ia.felles.definisjoner.bransjer.Bransjer
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.FiaRoller
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.integrasjoner.ssb.NæringsRepository
import no.nav.lydia.sykefraversstatistikk.SykefraværsstatistikkService
import no.nav.lydia.sykefraversstatistikk.api.SykefraversstatistikkVirksomhetDto.Companion.toDto
import no.nav.lydia.sykefraversstatistikk.api.SykefraværsstatistikkListResponse.Companion.toDto
import no.nav.lydia.sykefraversstatistikk.api.geografi.GeografiService
import no.nav.lydia.tilgangskontroll.Rådgiver
import no.nav.lydia.tilgangskontroll.Rådgiver.Companion.somBrukerMedLesetilgang

val SYKEFRAVERSSTATISTIKK_PATH = "sykefraversstatistikk"
val FILTERVERDIER_PATH = "filterverdier"

fun Route.sykefraversstatistikk(
    geografiService: GeografiService,
    sykefraværsstatistikkService: SykefraværsstatistikkService,
    næringsRepository: NæringsRepository,
    auditLog: AuditLog,
    fiaRoller: FiaRoller,
) {
    get("$SYKEFRAVERSSTATISTIKK_PATH/") {
        somBrukerMedLesetilgang(call = call, fiaRoller = fiaRoller) { rådgiver ->
            val søkeparametere = Søkeparametere.from(call, geografiService, rådgiver = rådgiver)
            val sykefraværsstatistikkVirksomheter =
                sykefraværsstatistikkService.hentSykefravær(søkeparametere = søkeparametere)
            sykefraværsstatistikkVirksomheter.right()
        }.map { sykefraværsstatistikkVirksomheter ->
            call.respond(sykefraværsstatistikkVirksomheter.toDto()).right()
        }.mapLeft { feil -> call.respond(status = feil.httpStatusCode, message = feil.feilmelding) }
    }

    get("$SYKEFRAVERSSTATISTIKK_PATH/{orgnummer}") {
        val orgnummer =
            call.parameters["orgnummer"] ?: return@get call.respond(SykefraværsstatistikkError.`ugyldig orgnummer`)
        somBrukerMedLesetilgang(call = call, fiaRoller = fiaRoller) {
            sykefraværsstatistikkService.hentSykefraværForVirksomhet(orgnummer).right()
        }.also {
            auditLog.auditloggEither(call = call, either = it, orgnummer = orgnummer, auditType = AuditType.access)
        }.map { sykefraværsstatistikk ->
            call.respond(sykefraværsstatistikk.toDto())
        }.mapLeft { feil ->
            call.respond(status = feil.httpStatusCode, message = feil.feilmelding)
        }
    }

    get("$SYKEFRAVERSSTATISTIKK_PATH/$FILTERVERDIER_PATH") {
        Rådgiver.from(call = call, fiaRoller = fiaRoller)
            .mapLeft { feil ->
                call.respond(status = feil.httpStatusCode, message = feil.feilmelding)
            }.map { rådgiver ->
                val brukerenSelv = EierDTO(rådgiver.navIdent, rådgiver.navIdent)
                val filtrerbareEiere = when (rådgiver.rolle) {
                    Rådgiver.Rolle.LESE,
                    Rådgiver.Rolle.SAKSBEHANDLER -> listOf(brukerenSelv)
                    Rådgiver.Rolle.SUPERBRUKER -> setOf(brukerenSelv, *sykefraværsstatistikkService.hentAlleSaksbehandlere().toTypedArray()).toList()
                }
                return@get call.respond(
                    FilterverdierDto(
                        fylker = geografiService.hentFylkerOgKommuner(),
                        neringsgrupper = næringsRepository.hentNæringer(),
                        bransjeprogram = Bransjer.values().asList(),
                        filtrerbareEiere = filtrerbareEiere,
                    )
                )
            }
    }
}


object SykefraværsstatistikkError {
    val `ugyldig orgnummer` = Feil("Ugyldig orgnummer", HttpStatusCode.BadRequest)
}
