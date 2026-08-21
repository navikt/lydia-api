package no.nav.lydia.api.v1

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.getOrElse
import arrow.core.left
import arrow.core.raise.either
import arrow.core.right
import io.ktor.http.HttpStatusCode
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.get
import kotlinx.datetime.toKotlinLocalDateTime
import no.nav.lydia.ADGrupper
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.api.orgnummer
import no.nav.lydia.api.saksnummer
import no.nav.lydia.api.samarbeidId
import no.nav.lydia.api.sendFeil
import no.nav.lydia.felles.Feil
import no.nav.lydia.historikk.HistorikkHendelse
import no.nav.lydia.historikk.HistorikkService
import no.nav.lydia.historikk.HistorikkVirksomhetDto
import no.nav.lydia.historikk.Historikkfeil
import no.nav.lydia.historikk.SamarbeidsperiodeHistorikkDto
import no.nav.lydia.historikk.Årsak
import no.nav.lydia.samarbeid.IASamarbeidFeil
import no.nav.lydia.samarbeid.tilDto
import no.nav.lydia.samarbeidsperiode.IASak
import no.nav.lydia.samarbeidsperiode.IASakError
import no.nav.lydia.samarbeidsperiode.IASakService
import no.nav.lydia.samarbeidsperiode.SakshistorikkDto
import no.nav.lydia.samarbeidsperiode.VirksomhetIkkeAktuellHendelse
import no.nav.lydia.samarbeidsperiode.tilSakshistorikk
import no.nav.lydia.tilgangskontroll.somLesebruker
import no.nav.lydia.tilstandsmaskin.NyFlytService

const val GAMMEL_NY_FLYT_PATH = "iasak/nyflyt"

fun Route.historikkRoutes(
    iaSakService: IASakService,
    nyFlytService: NyFlytService,
    historikkService: HistorikkService,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
) {
    // GET
    // TODO: la gjerne denne gamle ruten ligge til vi har den nye historikken på plass. Den nye historikken utvikles på sti '$NY_FLYT_API_PATH/virksomhet/{orgnummer}/historikk'
    get(path = "$GAMMEL_NY_FLYT_PATH/virksomhet/{orgnummer}/historikk") {
        val orgnummer = call.orgnummer ?: return@get call.respond<Feil>(IASakError.`ugyldig orgnummer`)
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
            call.respond<List<SakshistorikkDto>>(historikk).right()
        }.mapLeft {
            call.respond<String>(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    get("$NY_FLYT_API_PATH/virksomhet/{orgnummer}/historikk") {
        either {
            val orgnummer = call.orgnummer ?: Historikkfeil.`ugyldig orgnummer`.left().bind()
            call.somLesebruker(adGrupper = adGrupper) { _ -> Unit.right() }.bind()
            val historikkVirksomhet = historikkService.hentHistorikkForVirksomhet(orgnummer).bind()
            HistorikkVirksomhetDto(historikkVirksomhet)
        }.fold(
            ifLeft = { feil ->
                call.respond(
                    status = feil.httpStatusCode,
                    message = feil.feilmelding,
                )
            },
            ifRight = {
                call.respond(it)
            },
        )
    }

    samarbeidsperiodehistorikkRoute(
        path = "$NY_FLYT_API_PATH/virksomhet/{orgnummer}/samarbeidsperiode/{saksnummer}/historikk",
        iaSakService = iaSakService,
        nyFlytService = nyFlytService,
        adGrupper = adGrupper,
        auditLog = auditLog,
    )

    samarbeidshistorikkRoute(
        path = "$NY_FLYT_API_PATH/virksomhet/{orgnummer}/samarbeidsperiode/{saksnummer}/samarbeid/{samarbeidId}/historikk",
        historikkService = historikkService,
        adGrupper = adGrupper,
        auditLog = auditLog,
    )
}

private fun Route.samarbeidsperiodehistorikkRoute(
    path: String,
    iaSakService: IASakService,
    nyFlytService: NyFlytService,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
) {
    get(path) {
        val orgnr = call.orgnummer ?: return@get call.respond(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@get call.respond(IASakError.`ugyldig saksnummer`)
        call.somLesebruker(adGrupper = adGrupper) {
            val hendelser = iaSakService.hentHendelserForOrgnummer(orgnr = orgnr)
                .groupBy { it.saksnummer }

            iaSakService.hentIASakDto(saksnummer)
                .map { iASakDto ->
                    val iASakDtoMedHendelser = iASakDto.addHendelser(hendelser[saksnummer] ?: emptyList())
                    val samarbeid = nyFlytService.hentSamarbeidSomIkkeErSlettet(saksnummer).getOrElse { emptyList() }
                    listOf(
                        SamarbeidsperiodeHistorikkDto(
                            saksnummer = iASakDtoMedHendelser.saksnummer,
                            opprettet = iASakDtoMedHendelser.opprettetTidspunkt,
                            sistEndret = iASakDtoMedHendelser.endretTidspunkt ?: iASakDtoMedHendelser.opprettetTidspunkt,
                            historikkHendelser = iASakDtoMedHendelser.hendelser.map { hendelse ->
                                HistorikkHendelse(
                                    hendelseId = hendelse.id,
                                    hendelsetype = hendelse.hendelsesType,
                                    resulterendeStatus = hendelse.resulterendeStatus ?: IASak.Status.IKKE_AKTIV,
                                    tidspunkt = hendelse.opprettetTidspunkt
                                        .toKotlinLocalDateTime(),
                                    hendelseOpprettetAv = hendelse.opprettetAv,
                                    årsak = when (hendelse) {
                                        is VirksomhetIkkeAktuellHendelse -> Årsak(
                                            beskrivelse = hendelse.valgtÅrsak.type.navn,
                                            begrunnelser = hendelse.valgtÅrsak.begrunnelser.map { it.navn },
                                        )

                                        else -> null
                                    },
                                )
                            },
                            samarbeid = samarbeid.tilDto(),
                        ),
                    )
                }
        }.also { either: Either<Feil, List<SamarbeidsperiodeHistorikkDto>> ->
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
}

private fun Route.samarbeidshistorikkRoute(
    path: String,
    historikkService: HistorikkService,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
) {
    get(path) {
        val orgnummer = call.orgnummer ?: return@get call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@get call.sendFeil(IASakError.`ugyldig saksnummer`)
        val samarbeidId = call.samarbeidId ?: return@get call.sendFeil(IASamarbeidFeil.`ugyldig samarbeidId`)

        call.somLesebruker(adGrupper = adGrupper) { _ ->
            samarbeidId.right()
        }.flatMap {
            historikkService.hentHistorikkForSamarbeid(
                orgnr = orgnummer,
                saksnummer = saksnummer,
                samarbeidId = samarbeidId,
            )
        }.also { either ->
            auditLog.auditloggEither(
                call = call,
                either = either,
                orgnummer = orgnummer,
                auditType = AuditType.access,
                saksnummer = saksnummer,
            )
        }.map { historikk ->
            call.respond(status = HttpStatusCode.OK, message = historikk)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }
}
