package no.nav.lydia.api.v1

import arrow.core.Either
import arrow.core.getOrElse
import arrow.core.right
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.get
import no.nav.lydia.ADGrupper
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.api.orgnummer
import no.nav.lydia.felles.Feil
import no.nav.lydia.samarbeid.tilDto
import no.nav.lydia.samarbeidsperiode.IASakError
import no.nav.lydia.samarbeidsperiode.IASakService
import no.nav.lydia.samarbeidsperiode.SakshistorikkDto
import no.nav.lydia.samarbeidsperiode.tilSakshistorikk
import no.nav.lydia.tilgangskontroll.somLesebruker
import no.nav.lydia.tilstandsmaskin.NyFlytService

const val GAMMEL_NY_FLYT_PATH = "iasak/nyflyt"

fun Route.historikkRoutes(
    iaSakService: IASakService,
    nyFlytService: NyFlytService,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
) {
    // TODO: la gjerne denne gamle ruten ligge til vi har den nye historikken på plass. Den nye historikken utvikles på sti '$NY_FLYT_API_PATH/virksomhet/{orgnummer}/historikk'
    historikkRoute(
        path = "$GAMMEL_NY_FLYT_PATH/virksomhet/{orgnummer}/historikk",
        iaSakService = iaSakService,
        nyFlytService = nyFlytService,
        adGrupper = adGrupper,
        auditLog = auditLog,
    )

    historikkRoute(
        path = "$NY_FLYT_API_PATH/virksomhet/{orgnummer}/historikk",
        iaSakService = iaSakService,
        nyFlytService = nyFlytService,
        adGrupper = adGrupper,
        auditLog = auditLog,
    )
}

private fun Route.historikkRoute(
    path: String,
    iaSakService: IASakService,
    nyFlytService: NyFlytService,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
) {
    get(path) {
        val orgnummer = call.orgnummer ?: return@get call.respond(IASakError.`ugyldig orgnummer`)
        call.somLesebruker(adGrupper = adGrupper) { _ ->
            val hendelser = iaSakService.hentHendelserForOrgnummer(orgnr = orgnummer)
                .groupBy { it.saksnummer }
            val samarbeidshendelser = iaSakService.hentSamarbeidshendelserForOrgnummer(orgnr = orgnummer)
                .groupBy { it.saksnummer }
            iaSakService.hentIASakDtoerForOrgnummer(orgnummer = orgnummer)
                .map { sak ->
                    sak.addHendelser(hendelser = hendelser[sak.saksnummer] ?: emptyList())
                }
                .sortedByDescending { it.opprettetTidspunkt }
                .map { iASakDto ->
                    val samarbeid = nyFlytService.hentSamarbeidSomIkkeErSlettet(iASakDto.saksnummer).getOrElse { emptyList() }
                    iASakDto.tilSakshistorikk(
                        samarbeid = samarbeid.tilDto(),
                        samarbeidshendelser = samarbeidshendelser[iASakDto.saksnummer] ?: emptyList(),
                    )
                }.right()
        }.also { either: Either<Feil, List<SakshistorikkDto>> ->
            if (either.isLeft()) {
                auditLog.auditloggEither(
                    call = call,
                    either = either,
                    orgnummer = orgnummer,
                    auditType = AuditType.access,
                )
            } else {
                val sakshistorikkDtoListe: List<SakshistorikkDto> = either.getOrElse { listOf() }
                sakshistorikkDtoListe.forEach { sakshistorikkDto ->
                    auditLog.auditloggEither(
                        call = call,
                        either = either,
                        orgnummer = orgnummer,
                        auditType = AuditType.access,
                        saksnummer = sakshistorikkDto.saksnummer,
                    )
                }
            }
        }.map { historikk ->
            call.respond(historikk).right()
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }
}
