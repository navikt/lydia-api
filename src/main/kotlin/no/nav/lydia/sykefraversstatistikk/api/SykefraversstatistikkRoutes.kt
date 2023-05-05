package no.nav.lydia.sykefraversstatistikk.api

import arrow.core.flatMap
import arrow.core.right
import ia.felles.definisjoner.bransjer.Bransjer
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.NaisEnvironment
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.integrasjoner.ssb.NæringsRepository
import no.nav.lydia.sykefraversstatistikk.SistePubliseringService
import no.nav.lydia.sykefraversstatistikk.SykefraværsstatistikkService
import no.nav.lydia.sykefraversstatistikk.api.VirksomhetsstatistikkSiste4KvartalDto.Companion.toDto
import no.nav.lydia.sykefraversstatistikk.api.VirksomhetsoversiktDto.Companion.toDto
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.søkeparametere
import no.nav.lydia.sykefraversstatistikk.api.geografi.GeografiService
import no.nav.lydia.tilgangskontroll.Rådgiver
import no.nav.lydia.tilgangskontroll.Rådgiver.Companion.somBrukerMedLesetilgang
import no.nav.lydia.integrasjoner.azure.AzureService

const val SYKEFRAVERSSTATISTIKK_PATH = "sykefraversstatistikk"
const val FILTERVERDIER_PATH = "filterverdier"
const val ANTALL_TREFF = "antallTreff"
const val SISTE_4_KVARTALER = "siste4kvartaler"
const val PUBLISERINGSINFO = "publiseringsinfo"
const val SISTE_TILGJENGELIGE_KVARTAL = "sistetilgjengeligekvartal"

fun Route.sykefraversstatistikk(
    sistePubliseringService: SistePubliseringService,
    geografiService: GeografiService,
    sykefraværsstatistikkService: SykefraværsstatistikkService,
    næringsRepository: NæringsRepository,
    auditLog: AuditLog,
    naisEnvironment: NaisEnvironment,
    azureService: AzureService,
) {
    val fiaRoller = naisEnvironment.security.fiaRoller
    get("$SYKEFRAVERSSTATISTIKK_PATH/") {
        somBrukerMedLesetilgang(call = call, fiaRoller = fiaRoller) { rådgiver ->
            val gjeldendePeriode = sistePubliseringService.hentGjelendePeriode()
            call.request.søkeparametere(gjeldendePeriode, geografiService, rådgiver = rådgiver)
        }.also {
            auditLog.auditloggEither(call = call, either = it, orgnummer = null, auditType = AuditType.access,
                melding = it.orNull()?.toLogString(), severity = "INFO")
        }.map { søkeparametere ->
            sykefraværsstatistikkService.søkEtterVirksomheter(søkeparametere = søkeparametere)
        }.map { sykefraværsstatistikkVirksomheter ->
            call.respond(VirksomhetsoversiktResponsDto(data = sykefraværsstatistikkVirksomheter.toDto())).right()
        }.mapLeft { feil -> call.respond(status = feil.httpStatusCode, message = feil.feilmelding) }
    }

    get("$SYKEFRAVERSSTATISTIKK_PATH/$ANTALL_TREFF") {
        somBrukerMedLesetilgang(call = call, fiaRoller = fiaRoller) { rådgiver ->
            val gjeldendePeriode = sistePubliseringService.hentGjelendePeriode()
            call.request.søkeparametere(gjeldendePeriode, geografiService, rådgiver = rådgiver)
        }.flatMap { søkeparametere ->
            sykefraværsstatistikkService.hentTotaltAntallVirksomheter(søkeparametere = søkeparametere)
        }.fold(
            ifLeft = { feil -> call.respond(status = feil.httpStatusCode, message = feil.feilmelding) },
            ifRight = { totaltAntallTreff -> call.respond(totaltAntallTreff) }
        )
    }

     get("$SYKEFRAVERSSTATISTIKK_PATH/{orgnummer}/$SISTE_4_KVARTALER") {
        val orgnummer =
            call.parameters["orgnummer"] ?: return@get call.respond(SykefraværsstatistikkError.`ugyldig orgnummer`)
        somBrukerMedLesetilgang(call = call, fiaRoller = fiaRoller) {
            sykefraværsstatistikkService.hentSykefraværForVirksomhetSiste4Kvartal(orgnummer)
        }.also {
            auditLog.auditloggEither(call = call, either = it, orgnummer = orgnummer, auditType = AuditType.access)
        }.map { virksomhetsstatistikkSiste4Kvartal ->
            call.respond(virksomhetsstatistikkSiste4Kvartal.toDto())
        }.mapLeft { feil ->
            call.respond(status = feil.httpStatusCode, message = feil.feilmelding)
        }
    }

    get("$SYKEFRAVERSSTATISTIKK_PATH/{orgnummer}/$SISTE_TILGJENGELIGE_KVARTAL") {
        val orgnummer =
            call.parameters["orgnummer"] ?: return@get call.respond(SykefraværsstatistikkError.`ugyldig orgnummer`)

        somBrukerMedLesetilgang(call = call, fiaRoller = fiaRoller) {
            sykefraværsstatistikkService.hentVirksomhetsstatistikkSisteKvartal(orgnummer)
        }.also {
            auditLog.auditloggEither(call = call, either = it, orgnummer = orgnummer, auditType = AuditType.access)
        }.map { sykefraværsstatistikk ->
            call.respond(sykefraværsstatistikk)
        }.mapLeft { feil ->
            call.respond(status = feil.httpStatusCode, message = feil.feilmelding)
        }
    }

    get ("$SYKEFRAVERSSTATISTIKK_PATH/$PUBLISERINGSINFO") {
        somBrukerMedLesetilgang(call = call, fiaRoller = fiaRoller) {
            sistePubliseringService.hentPubliseringsinfo()
        }.map { publiseringsinfo ->
            call.respond(publiseringsinfo)
        }.mapLeft { feil ->
            call.respond(status = feil.httpStatusCode, message = feil.feilmelding)
        }
    }

    get("$SYKEFRAVERSSTATISTIKK_PATH/$FILTERVERDIER_PATH") {
        Rådgiver.from(call = call, fiaRoller = fiaRoller)
            .mapLeft { feil ->
                call.respond(status = feil.httpStatusCode, message = feil.feilmelding)
            }.map { rådgiver ->
                val filtrerbareEiere = when (rådgiver.rolle) {
                    Rådgiver.Rolle.LESE,
                    Rådgiver.Rolle.SAKSBEHANDLER -> listOf(EierDTO(navIdent = rådgiver.navIdent, navn = rådgiver.navn))
                    Rådgiver.Rolle.SUPERBRUKER -> hentEiere(azureService = azureService)
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

suspend fun hentEiere(azureService: AzureService) =
    azureService.hentVeiledere()
        .fold(ifLeft = { emptyList() }, ifRight = { veiledere -> veiledere.map { it.tilEierDTO() }.toList() })

object SykefraværsstatistikkError {
    val `ugyldig orgnummer` = Feil("Ugyldig orgnummer", HttpStatusCode.BadRequest)
}
