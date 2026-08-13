package no.nav.lydia.api.v1

import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import io.ktor.server.request.receive
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.get
import io.ktor.server.routing.post
import kotlinx.serialization.Serializable
import no.nav.lydia.ADGrupper
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.api.orgnummer
import no.nav.lydia.api.saksnummer
import no.nav.lydia.api.sendFeil
import no.nav.lydia.felles.Feil
import no.nav.lydia.integrasjoner.azure.AzureService
import no.nav.lydia.prioritering.sykefraværsstatistikk.api.EierDTO
import no.nav.lydia.samarbeidsperiode.IASakError
import no.nav.lydia.samarbeidsperiode.IASakService
import no.nav.lydia.team.IATeamService
import no.nav.lydia.tilgangskontroll.somLesebruker
import no.nav.lydia.tilgangskontroll.somSaksbehandlerMedNavenhet
import no.nav.lydia.tilstandsmaskin.NyFlytService

@Serializable
data class HendelseAktorDto(
    val hendelseId: String,
    val aktor: EierDTO,
)

fun Route.nyFlytSamarbeidsperiode(
    iaSakService: IASakService,
    iaTeamService: IATeamService,
    nyFlytService: NyFlytService,
    adGrupper: ADGrupper,
    azureService: AzureService,
    auditLog: AuditLog,
) {
    // GET
    get("$NY_FLYT_API_PATH/virksomhet/{orgnummer}/samarbeidsperiode") {
        val orgnr = call.orgnummer ?: return@get call.respond(IASakError.`ugyldig orgnummer`)
        call.somLesebruker(adGrupper) {
            nyFlytService.hentSisteIASakDto(orgnr)?.right()
                ?: Feil(feilmelding = "Fant ingen aktiv sak på virksomheten", httpStatusCode = HttpStatusCode.NoContent).left()
        }.also { iaSakEither ->
            auditLog.auditloggEither(
                call = call,
                either = iaSakEither,
                orgnummer = orgnr,
                auditType = AuditType.access,
                saksnummer = iaSakEither.map { iaSak -> iaSak.saksnummer }.getOrNull(),
            )
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    get("$NY_FLYT_API_PATH/virksomhet/{orgnummer}/samarbeidsperiode/{saksnummer}") {
        val orgnr = call.orgnummer ?: return@get call.respond(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@get call.respond(IASakError.`ugyldig saksnummer`)
        call.somLesebruker(adGrupper = adGrupper) {
            iaSakService.hentIASakDto(saksnummer)
        }.also { either ->
            auditLog.auditloggEither(
                call = call,
                either = either,
                orgnummer = orgnr,
                auditType = AuditType.access,
                saksnummer = saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    // POST
    // -- Dette er tenkt å være en midlertidig løsning frem til vi har utviklet kontaktperson funksjonalitet i samarbeid med Salesforce.
    // -- Dette etterlater ingen hendelser, men skriver kun over eierskap i den akktive saken
    post("$NY_FLYT_API_PATH/virksomhet/{orgnummer}/samarbeidsperiode/{saksnummer}/bli-eier") {
        val orgnr = call.orgnummer ?: return@post call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@post call.sendFeil(IASakError.`ugyldig saksnummer`)

        call.somSaksbehandlerMedNavenhet(adGrupper, azureService) { saksbehandler, _ ->
            nyFlytService.bliEier(orgnr = orgnr, saksnummer = saksnummer, navAnsatt = saksbehandler)
        }.also { iaSamarbeidDtoEither ->
            auditLog.auditloggEither(
                call = call,
                either = iaSamarbeidDtoEither,
                orgnummer = orgnr,
                auditType = AuditType.delete,
                saksnummer = iaSamarbeidDtoEither.getOrNull()?.saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    post("$NY_FLYT_API_PATH/samarbeidsperiode/eiere") {
        val saksnumre = call.receive<Set<String>>()
        call.somLesebruker(adGrupper = adGrupper) { _ ->
            saksnumre.right()
        }.map { numre ->
            call.respond(hentNavn(azureService, iaSakService.hentEiereForSaksnumre(numre).toSet()))
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    post("$NY_FLYT_API_PATH/samarbeidsperiode/radgivere") {
        val saksnumre = call.receive<Set<String>>()
        call.somLesebruker(adGrupper = adGrupper) { _ ->
            saksnumre.right()
        }.map { numre ->
            val radgivere = iaSakService.hentEiereForSaksnumre(numre) + iaTeamService.hentFølgereForSaksnumre(numre)
            call.respond(hentNavn(azureService, radgivere.toSet()))
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    // TODO: For at dette endepunktet skal kunne tas i bruk må hendelseId legges til i SakSnapshotDto og SamarbeidshendelseDto osv.
    post("$NY_FLYT_API_PATH/samarbeidsperiode/{saksnummer}/aktorer") {
        val saksnummer = call.saksnummer ?: return@post call.sendFeil(IASakError.`ugyldig saksnummer`)
        val hendelseIder = call.receive<Set<String>>()
        call.somLesebruker(adGrupper = adGrupper) { _ ->
            hendelseIder.right()
        }.map { ider ->
            val aktørPerHendelse = iaSakService.hentAktørerForHendelser(saksnummer = saksnummer, hendelseIder = ider)
            val navnPerNavIdent = hentNavn(azureService, aktørPerHendelse.map { it.second }.toSet())
                .associateBy { it.navIdent }

            call.respond(
                aktørPerHendelse.mapNotNull { (hendelseId, navIdent) ->
                    navnPerNavIdent[navIdent]?.let { HendelseAktorDto(hendelseId = hendelseId, aktor = it) }
                },
            )
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }
}

private suspend fun hentNavn(
    azureService: AzureService,
    navIdenter: Set<String>,
): List<EierDTO> =
    if (navIdenter.isEmpty()) {
        emptyList()
    } else {
        azureService.hentVeiledere().fold(
            ifLeft = { emptyList() },
            ifRight = { veiledere -> veiledere.filter { it.navIdent in navIdenter }.map { it.tilEierDTO() } },
        )
    }
