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
import no.nav.lydia.Security
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.integrasjoner.azure.AzureTokenFetcher
import no.nav.lydia.integrasjoner.ssb.NæringsRepository
import no.nav.lydia.sykefraversstatistikk.SykefraværsstatistikkService
import no.nav.lydia.sykefraversstatistikk.api.VirksomhetsstatistikkSiste4KvartalDto.Companion.toDto
import no.nav.lydia.sykefraversstatistikk.api.VirksomhetsoversiktDto.Companion.toDto
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.søkeparametere
import no.nav.lydia.sykefraversstatistikk.api.geografi.GeografiService
import no.nav.lydia.tilgangskontroll.Rådgiver
import no.nav.lydia.tilgangskontroll.Rådgiver.Companion.somBrukerMedLesetilgang
import no.nav.lydia.veileder.hentVeiledere

val SYKEFRAVERSSTATISTIKK_PATH = "sykefraversstatistikk"
val FILTERVERDIER_PATH = "filterverdier"
val ANTALL_TREFF = "antallTreff"
val SISTE_4_KVARTALER = "siste4kvartaler"
val GJELDENDE_PERIODE_SISTE_4_KVARTALER = "gjeldendeperiodesiste4kvartaler"
val SISTE_TILGJENGELIGE_KVARTAL = "sistetilgjengeligekvartal"

fun Route.sykefraversstatistikk(
    geografiService: GeografiService,
    sykefraværsstatistikkService: SykefraværsstatistikkService,
    næringsRepository: NæringsRepository,
    auditLog: AuditLog,
    naisEnvironment: NaisEnvironment,
    azureTokenFetcher: AzureTokenFetcher,
) {
    val fiaRoller = naisEnvironment.security.fiaRoller
    get("$SYKEFRAVERSSTATISTIKK_PATH/") {
        somBrukerMedLesetilgang(call = call, fiaRoller = fiaRoller) { rådgiver ->
            call.request.søkeparametere(geografiService, rådgiver = rådgiver)
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
            call.request.søkeparametere(geografiService, rådgiver = rådgiver)
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
        }.map { sykefraværsstatistikkListe ->
            call.respond(sykefraværsstatistikkListe.toDto())
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

    get ("$SYKEFRAVERSSTATISTIKK_PATH/$GJELDENDE_PERIODE_SISTE_4_KVARTALER") {
        somBrukerMedLesetilgang(call = call, fiaRoller = fiaRoller) {
            sykefraværsstatistikkService.hentGjeldendePeriodeSiste4Kvartal()
        }.map { kvartalerFraTil ->
            call.respond(kvartalerFraTil.toDto())
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
                    Rådgiver.Rolle.SAKSBEHANDLER,
                    -> listOf(EierDTO(navIdent = rådgiver.navIdent, navn = rådgiver.navn))
                    Rådgiver.Rolle.SUPERBRUKER -> hentEiere(
                        azureTokenFetcher = azureTokenFetcher,
                        security = naisEnvironment.security
                    )
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

suspend fun hentEiere(azureTokenFetcher: AzureTokenFetcher, security: Security) =
    hentVeiledere(
        tokenFetcher = azureTokenFetcher,
        security = security
    ).fold(ifLeft = { emptyList() }, ifRight = { veiledere -> veiledere.map { it.tilEierDTO() }.toList() })

object SykefraværsstatistikkError {
    val `ugyldig orgnummer` = Feil("Ugyldig orgnummer", HttpStatusCode.BadRequest)
}
