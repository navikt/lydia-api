package no.nav.lydia.sykefraversstatistikk.api

import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.Tillat
import no.nav.lydia.auditLog
import no.nav.lydia.integrasjoner.ssb.NæringsRepository
import no.nav.lydia.sykefraversstatistikk.SykefraversstatistikkRepository
import no.nav.lydia.sykefraversstatistikk.api.SykefraversstatistikkVirksomhetDto.Companion.toDto
import no.nav.lydia.sykefraversstatistikk.api.geografi.GeografiService
import org.slf4j.LoggerFactory

val SYKEFRAVERSSTATISTIKK_PATH = "sykefraversstatistikk"
val FILTERVERDIER_PATH = "filterverdier"

fun Route.sykefraversstatistikk(
    geografiService: GeografiService,
    sykefraversstatistikkRepository: SykefraversstatistikkRepository,
    næringsRepository: NæringsRepository,
    auditLog: AuditLog
) {
    val log = LoggerFactory.getLogger(this.javaClass)
    get("$SYKEFRAVERSSTATISTIKK_PATH/") {
        val start = System.currentTimeMillis()
        val søkeparametere = Søkeparametere.from(call.request.queryParameters, geografiService)
        val virksomheter = sykefraversstatistikkRepository.hentSykefravær(søkeparametere = søkeparametere).toDto()
        log.info("Brukte ${System.currentTimeMillis() - start} ms på å hente virksomheter")
        call.respond(virksomheter)
    }

    get("$SYKEFRAVERSSTATISTIKK_PATH/{orgnummer}") {
        call.parameters["orgnummer"]?.let { orgnummer ->
            auditLog(auditLog, orgnummer = orgnummer, auditType = AuditType.access, tillat = Tillat.Ja)
            call.respond(sykefraversstatistikkRepository.hentSykefraværForVirksomhet(orgnummer).toDto())
        } ?: call.respond(HttpStatusCode.InternalServerError, "Fikk ikke tak i orgnummer")
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