package no.nav.lydia.sykefraversstatistikk.api

import arrow.core.right
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import no.nav.lydia.*
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.integrasjoner.ssb.NæringsRepository
import no.nav.lydia.sykefraversstatistikk.SykefraversstatistikkRepository
import no.nav.lydia.sykefraversstatistikk.api.SykefraversstatistikkVirksomhetDto.Companion.toDto
import no.nav.lydia.tilgangskontroll.Rådgiver.Companion.somBrukerMedLesetilgang
import no.nav.lydia.sykefraversstatistikk.api.geografi.GeografiService
import org.slf4j.LoggerFactory

val SYKEFRAVERSSTATISTIKK_PATH = "sykefraversstatistikk"
val FILTERVERDIER_PATH = "filterverdier"

fun Route.sykefraversstatistikk(
    geografiService: GeografiService,
    sykefraversstatistikkRepository: SykefraversstatistikkRepository,
    næringsRepository: NæringsRepository,
    auditLog: AuditLog,
    fiaRoller: FiaRoller,
) {
    val log = LoggerFactory.getLogger(this.javaClass)
    get("$SYKEFRAVERSSTATISTIKK_PATH/") {
        somBrukerMedLesetilgang(call = call, fiaRoller = fiaRoller) {
            val start = System.currentTimeMillis()
            val søkeparametere = Søkeparametere.from(call.request.queryParameters, geografiService)
            val sykefraværsstatistikkVirksomheter =
                sykefraversstatistikkRepository.hentSykefravær(søkeparametere = søkeparametere)
            log.info("Brukte ${System.currentTimeMillis() - start} ms på å hente virksomheter")
            sykefraværsstatistikkVirksomheter.right()
        }.map { sykefraværsstatistikkVirksomheter ->
            call.respond(sykefraværsstatistikkVirksomheter.toDto()).right()
        }.mapLeft { feil -> call.respond(status = feil.httpStatusCode, message = feil.feilmelding) }
    }

    get("$SYKEFRAVERSSTATISTIKK_PATH/{orgnummer}") {
        val orgnummer = call.parameters["orgnummer"] ?: return@get call.respond(SykefraværsstatistikkError.`ugyldig orgnummer`)
        somBrukerMedLesetilgang(call = call, fiaRoller = fiaRoller) {
            auditLog(auditLog, orgnummer = orgnummer, auditType = AuditType.access, tillat = Tillat.Ja)
            sykefraversstatistikkRepository.hentSykefraværForVirksomhet(orgnummer).right()
        }
            .map { sykefraværsstatistikk -> call.respond(sykefraværsstatistikk.toDto()) }
            .mapLeft { feil -> call.respond(feil.httpStatusCode, feil.feilmelding) }
    }

    get("$SYKEFRAVERSSTATISTIKK_PATH/$FILTERVERDIER_PATH") {
        call.respond(
            FilterverdierDto(
                fylker = geografiService.hentFylkerOgKommuner(),
                neringsgrupper = næringsRepository.hentNæringer()
            )
        )
    }
}


object SykefraværsstatistikkError {
    val `ugyldig orgnummer` = Feil("Ugyldig orgnummer", HttpStatusCode.BadRequest)
}
