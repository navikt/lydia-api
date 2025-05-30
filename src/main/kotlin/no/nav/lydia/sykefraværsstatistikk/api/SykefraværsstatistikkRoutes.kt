package no.nav.lydia.sykefraværsstatistikk.api

import arrow.core.flatMap
import arrow.core.getOrElse
import arrow.core.right
import ia.felles.definisjoner.bransjer.Bransje
import io.ktor.http.HttpStatusCode
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.get
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.NaisEnvironment
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.integrasjoner.azure.AzureService
import no.nav.lydia.integrasjoner.ssb.NæringsRepository
import no.nav.lydia.sykefraværsstatistikk.SistePubliseringService
import no.nav.lydia.sykefraværsstatistikk.SykefraværsstatistikkService
import no.nav.lydia.sykefraværsstatistikk.api.Søkeparametere.Companion.søkeparametere
import no.nav.lydia.sykefraværsstatistikk.api.VirksomhetsoversiktDto.Companion.toDto
import no.nav.lydia.sykefraværsstatistikk.api.VirksomhetsstatistikkSiste4KvartalDto.Companion.toDto
import no.nav.lydia.sykefraværsstatistikk.api.geografi.GeografiService
import no.nav.lydia.tilgangskontroll.fia.innloggetNavIdent
import no.nav.lydia.tilgangskontroll.fia.innloggetNavn
import no.nav.lydia.tilgangskontroll.somHøyestTilgang
import no.nav.lydia.tilgangskontroll.somLesebruker
import no.nav.lydia.tilgangskontroll.superbruker

const val SYKEFRAVÆRSSTATISTIKK_PATH = "sykefravarsstatistikk"
const val FILTERVERDIER_PATH = "filterverdier"
const val ANTALL_TREFF = "antallTreff"
const val SISTE_4_KVARTALER = "siste4kvartaler"
const val PUBLISERINGSINFO = "publiseringsinfo"
const val SISTE_TILGJENGELIGE_KVARTAL = "sistetilgjengeligekvartal"
const val HISTORISK_STATISTIKK = "historiskstatistikk"

fun Route.sykefraværsstatistikk(
    sistePubliseringService: SistePubliseringService,
    geografiService: GeografiService,
    sykefraværsstatistikkService: SykefraværsstatistikkService,
    næringsRepository: NæringsRepository,
    auditLog: AuditLog,
    naisEnvironment: NaisEnvironment,
    azureService: AzureService,
) {
    val adGrupper = naisEnvironment.security.adGrupper
    get("$SYKEFRAVÆRSSTATISTIKK_PATH/") {
        call.somHøyestTilgang(adGrupper = adGrupper) { navAnsatt ->
            call.request.søkeparametere(geografiService, navAnsatt = navAnsatt)
        }.also {
            auditLog.auditloggEither(
                call = call,
                either = it,
                orgnummer = null,
                auditType = AuditType.access,
                melding = it.getOrNull()?.toLogString(),
                severity = "INFO",
            )
        }.map { søkeparametere ->
            sykefraværsstatistikkService.søkEtterVirksomheter(søkeparametere = søkeparametere)
        }.map { sykefraværsstatistikkVirksomheter ->
            call.respond(VirksomhetsoversiktResponsDto(data = sykefraværsstatistikkVirksomheter.toDto())).right()
        }.mapLeft { feil -> call.respond(status = feil.httpStatusCode, message = feil.feilmelding) }
    }

    get("$SYKEFRAVÆRSSTATISTIKK_PATH/$ANTALL_TREFF") {
        call.somHøyestTilgang(adGrupper = adGrupper) { navAnsatt ->
            call.request.søkeparametere(geografiService, navAnsatt = navAnsatt)
        }.flatMap { søkeparametere ->
            sykefraværsstatistikkService.hentTotaltAntallVirksomheter(søkeparametere = søkeparametere)
        }.map {
            call.respond(it)
        }.mapLeft {
            call.respond(it.httpStatusCode, it.feilmelding)
        }
    }

    get("$SYKEFRAVÆRSSTATISTIKK_PATH/{orgnummer}/$SISTE_4_KVARTALER") {
        val orgnummer =
            call.parameters["orgnummer"] ?: return@get call.respond(SykefraværsstatistikkError.`ugyldig orgnummer`)
        call.somLesebruker(adGrupper = adGrupper) { _ ->
            sykefraværsstatistikkService.hentSykefraværForVirksomhetSiste4Kvartal(orgnummer)
        }.also {
            auditLog.auditloggEither(call = call, either = it, orgnummer = orgnummer, auditType = AuditType.access)
        }.map { virksomhetsstatistikkSiste4Kvartal ->
            call.respond(virksomhetsstatistikkSiste4Kvartal.toDto())
        }.mapLeft { feil ->
            call.respond(status = feil.httpStatusCode, message = feil.feilmelding)
        }
    }

    get("$SYKEFRAVÆRSSTATISTIKK_PATH/{orgnummer}/$SISTE_TILGJENGELIGE_KVARTAL") {
        val orgnummer =
            call.parameters["orgnummer"] ?: return@get call.respond(SykefraværsstatistikkError.`ugyldig orgnummer`)

        call.somLesebruker(adGrupper = adGrupper) { _ ->
            sykefraværsstatistikkService.hentVirksomhetsstatistikkSisteKvartal(orgnummer)
        }.also {
            auditLog.auditloggEither(call = call, either = it, orgnummer = orgnummer, auditType = AuditType.access)
        }.map { sykefraværsstatistikk ->
            call.respond(sykefraværsstatistikk)
        }.mapLeft { feil ->
            call.respond(status = feil.httpStatusCode, message = feil.feilmelding)
        }
    }

    get("$SYKEFRAVÆRSSTATISTIKK_PATH/{orgnummer}/$HISTORISK_STATISTIKK") {
        val orgnummer =
            call.parameters["orgnummer"] ?: return@get call.respond(SykefraværsstatistikkError.`ugyldig orgnummer`)

        call.somLesebruker(adGrupper = adGrupper) { _ ->
            sykefraværsstatistikkService.hentHistoriskStatistikk(orgnummer)
        }.also {
            auditLog.auditloggEither(call = call, either = it, orgnummer = orgnummer, auditType = AuditType.access)
        }.map { sykefraværsstatistikk ->
            call.respond(sykefraværsstatistikk)
        }.mapLeft { feil ->
            call.respond(status = feil.httpStatusCode, message = feil.feilmelding)
        }
    }

    get("$SYKEFRAVÆRSSTATISTIKK_PATH/naring/{næring}") {
        val næringskode =
            call.parameters["næring"] ?: return@get call.respond(SykefraværsstatistikkError.`ugyldig næring`)
        call.somLesebruker(adGrupper = adGrupper) { _ ->
            sykefraværsstatistikkService.hentNæringsstatistikk(næringskode)
        }.map { sykefraværsstatistikk ->
            call.respond(sykefraværsstatistikk)
        }.mapLeft { feil ->
            call.respond(status = feil.httpStatusCode, message = feil.feilmelding)
        }
    }

    get("$SYKEFRAVÆRSSTATISTIKK_PATH/bransje/{bransje}") {
        val bransje =
            call.parameters["bransje"] ?: return@get call.respond(SykefraværsstatistikkError.`ugyldig bransje`)
        call.somLesebruker(adGrupper = adGrupper) { _ ->
            sykefraværsstatistikkService.hentBransjestatistikk(bransje)
        }.map { sykefraværsstatistikk ->
            call.respond(sykefraværsstatistikk)
        }.mapLeft { feil ->
            call.respond(status = feil.httpStatusCode, message = feil.feilmelding)
        }
    }

    get("$SYKEFRAVÆRSSTATISTIKK_PATH/$PUBLISERINGSINFO") {
        call.somLesebruker(adGrupper = adGrupper) { _ ->
            sistePubliseringService.hentPubliseringsinfo()
        }.map { publiseringsinfo ->
            call.respond(publiseringsinfo)
        }.mapLeft { feil ->
            call.respond(status = feil.httpStatusCode, message = feil.feilmelding)
        }
    }

    get("$SYKEFRAVÆRSSTATISTIKK_PATH/$FILTERVERDIER_PATH") {
        val filtrerbareEiere = call.superbruker(adGrupper = adGrupper).map {
            hentEiere(azureService)
        }.getOrElse {
            listOf(
                EierDTO(
                    navIdent = call.innloggetNavIdent() ?: "",
                    navn = call.innloggetNavn() ?: "",
                ),
            )
        }

        call.respond(
            FilterverdierDto(
                fylker = geografiService.hentFylkerOgKommuner(),
                naringsgrupper = næringsRepository.hentNæringer(),
                bransjeprogram = Bransje.entries,
                filtrerbareEiere = filtrerbareEiere,
            ),
        )
    }
}

suspend fun hentEiere(azureService: AzureService) =
    azureService.hentVeiledere()
        .fold(ifLeft = { emptyList() }, ifRight = { veiledere -> veiledere.map { it.tilEierDTO() }.toList() })

object SykefraværsstatistikkError {
    val `ugyldig orgnummer` = Feil("Ugyldig orgnummer", HttpStatusCode.BadRequest)
    val `ugyldig næring` = Feil("Ugyldig næring", HttpStatusCode.BadRequest)
    val `ugyldig bransje` = Feil("Ugyldig bransje", HttpStatusCode.BadRequest)
}
