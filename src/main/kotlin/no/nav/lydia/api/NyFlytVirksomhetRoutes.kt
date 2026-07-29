package no.nav.lydia.api

import arrow.core.Either
import arrow.core.getOrElse
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import io.ktor.server.request.receive
import io.ktor.server.request.receiveNullable
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.get
import io.ktor.server.routing.post
import kotlinx.datetime.toJavaLocalDate
import no.nav.lydia.ADGrupper
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.dokumentpublisering.DokumentPubliseringService
import no.nav.lydia.felles.Feil
import no.nav.lydia.integrasjoner.azure.AzureService
import no.nav.lydia.prioritering.virksomhet.VirksomhetService
import no.nav.lydia.prioritering.virksomhet.toDto
import no.nav.lydia.samarbeid.IASamarbeidService
import no.nav.lydia.samarbeid.tilDto
import no.nav.lydia.samarbeidsperiode.IASakDto
import no.nav.lydia.samarbeidsperiode.IASakError
import no.nav.lydia.samarbeidsperiode.IASakService
import no.nav.lydia.samarbeidsperiode.SakshistorikkDto
import no.nav.lydia.samarbeidsperiode.ValgtÅrsak
import no.nav.lydia.samarbeidsperiode.tilSakshistorikk
import no.nav.lydia.samarbeidsperiode.validerBegrunnelserForVurdering
import no.nav.lydia.samarbeidsperiode.validerBegrunnelserForVurderingAvVirksomhet
import no.nav.lydia.samarbeidsplan.PlanService
import no.nav.lydia.tilgangskontroll.somLesebruker
import no.nav.lydia.tilgangskontroll.somSaksbehandlerMedNavenhet
import no.nav.lydia.tilgangskontroll.somSuperbrukerMedNavenhet
import no.nav.lydia.tilstandsmaskin.FiaKontekst
import no.nav.lydia.tilstandsmaskin.NyFlytService
import no.nav.lydia.tilstandsmaskin.TilstandVirksomhetRepository
import no.nav.lydia.tilstandsmaskin.TilstandsmaskinBuilder
import no.nav.lydia.tilstandsmaskin.VirksomhetIATilstand
import no.nav.lydia.tilstandsmaskin.VirksomhetTilstandDto
import no.nav.lydia.tilstandsmaskin.hendelse.AngreVurderVirksomhet
import no.nav.lydia.tilstandsmaskin.hendelse.AvsluttVurdering
import no.nav.lydia.tilstandsmaskin.hendelse.VurderVirksomhet
import java.time.LocalDate
import kotlin.collections.List
import kotlin.collections.forEach

fun Route.nyFlytVirksomhet(
    iaSakService: IASakService,
    iASamarbeidService: IASamarbeidService,
    nyFlytService: NyFlytService,
    dokumentPubliseringService: DokumentPubliseringService,
    planService: PlanService,
    virksomhetService: VirksomhetService,
    tilstandVirksomhetRepository: TilstandVirksomhetRepository,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
    azureService: AzureService,
) {
    fun tilstandsmaskin(orgnr: String) =
        TilstandsmaskinBuilder.medKontekst(
            fiaKontekst = FiaKontekst(
                iaSakService = iaSakService,
                iASamarbeidService = iASamarbeidService,
                nyFlytService = nyFlytService,
                dokumentPubliseringService = dokumentPubliseringService,
                planService = planService,
                tilstandVirksomhetRepository = tilstandVirksomhetRepository,
                saksnummer = nyFlytService.hentSisteIASakDto(orgnr)?.saksnummer,
            ),
        ).build(orgnr)

    // GET
    get("$NY_FLYT_API_PATH/virksomhet/{orgnummer}") {
        val orgnummer = call.parameters["orgnummer"] ?: return@get call.respond(SykefraværsstatistikkError.`ugyldig orgnummer`)
        call.somLesebruker(adGrupper = adGrupper) {
            val aktivSakDto = nyFlytService.hentSisteIASakDto(orgnummer)
            virksomhetService.hentVirksomhet(orgnr = orgnummer)?.toDto(saksnummer = aktivSakDto?.saksnummer)
                ?.right() ?: VirksomhetFeil.`fant ikke virksomhet`.left()
        }.also {
            auditLog.auditloggEither(call = call, either = it, orgnummer = orgnummer, auditType = AuditType.access)
        }.map {
            call.respond(HttpStatusCode.OK, it)
        }.mapLeft {
            call.respond(it.httpStatusCode, it.feilmelding)
        }
    }

    get("$NY_FLYT_API_PATH/virksomhet/{orgnummer}/historikk") {
        val orgnummer = call.orgnummer ?: return@get call.respond(IASakError.`ugyldig orgnummer`)
        call.somLesebruker(adGrupper = adGrupper) { _ ->
            val hendelser = iaSakService.hentHendelserForOrgnummer(orgnr = orgnummer)
            iaSakService.hentIASakDtoerForOrgnummer(orgnummer = orgnummer)
                .map { sak ->
                    sak.addHendelser(hendelser = hendelser.filter { hendelse -> hendelse.saksnummer == sak.saksnummer })
                }
                .sortedByDescending { it.opprettetTidspunkt }
                .map { iASakDto ->
                    val samarbeid = nyFlytService.hentSamarbeidSomIkkeErSlettet(iASakDto.saksnummer).getOrElse { emptyList() }
                    iASakDto.tilSakshistorikk(samarbeid = samarbeid.tilDto())
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

    get("$NY_FLYT_API_PATH/virksomhet/{orgnummer}/tilstand") {
        val orgnr = call.orgnummer ?: return@get call.respond(IASakError.`ugyldig orgnummer`)

        call.somLesebruker(adGrupper) {
            tilstandsmaskin(orgnr).hentTilstandForVirksomhet(orgnr = orgnr).right()
        }.also { tilstandEither ->
            auditLog.auditloggEither(
                call = call,
                either = tilstandEither,
                orgnummer = orgnr,
                auditType = AuditType.access,
            )
        }.map { virksomhetTilstandDto: VirksomhetTilstandDto? ->
            if (virksomhetTilstandDto == null) {
                val virksomhetFinnes = virksomhetService.hentVirksomhet(orgnr) != null
                if (!virksomhetFinnes) {
                    call.respond(
                        status = HttpStatusCode.NotFound,
                        message = "Virksomheten finnes ikke for orgnr $orgnr",
                    )
                } else {
                    call.respond(
                        status = HttpStatusCode.OK,
                        message = VirksomhetTilstandDto(
                            orgnr = orgnr,
                            tilstand = VirksomhetIATilstand.VirksomhetKlarTilVurdering,
                        ),
                    )
                }
            } else {
                call.respond(status = HttpStatusCode.OK, message = virksomhetTilstandDto)
            }
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    // POST
    post("$NY_FLYT_API_PATH/virksomhet/{orgnummer}/vurder") {
        val orgnr = call.orgnummer ?: return@post call.respond(IASakError.`ugyldig orgnummer`)
        val valgtÅrsak = runCatching { call.receiveNullable<ValgtÅrsak>() }.getOrNull()

        if (valgtÅrsak == null) {
            return@post call.respond(
                status = HttpStatusCode.BadRequest,
                message = "Mangler årsak og begrunnelse for vurdering av virksomhet",
            )
        }

        if (!valgtÅrsak.validerBegrunnelserForVurderingAvVirksomhet()) {
            return@post call.respond(
                status = HttpStatusCode.BadRequest,
                message = "Ugyldig årsak eller begrunnelse for vurdering av virksomhet",
            )
        }

        call.somSuperbrukerMedNavenhet(adGrupper, azureService) { superbruker, navEnhet ->
            val hendelse = VurderVirksomhet(
                orgnr = orgnr,
                superbruker = superbruker,
                navEnhet = navEnhet,
                valgtÅrsak = valgtÅrsak,
            )
            val konsekvens = tilstandsmaskin(orgnr).prosesserHendelse(
                hendelse = hendelse,
            )

            konsekvens.map { it.verdi as IASakDto }
        }.also { iaSakEither ->
            auditLog.auditloggEither(
                call = call,
                either = iaSakEither,
                orgnummer = orgnr,
                auditType = AuditType.create,
                saksnummer = iaSakEither.map { iaSak -> iaSak.saksnummer }.getOrNull(),
            )
        }.map {
            call.respond(status = HttpStatusCode.Created, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    post("$NY_FLYT_API_PATH/virksomhet/{orgnummer}/angre-vurdering") {
        val orgnr = call.orgnummer ?: return@post call.respond(IASakError.`ugyldig orgnummer`)

        call.somSuperbrukerMedNavenhet(adGrupper, azureService) { superbruker, enhet ->
            val konsekvens = tilstandsmaskin(orgnr).prosesserHendelse(
                hendelse = AngreVurderVirksomhet(
                    orgnr = orgnr,
                    superbruker = superbruker,
                    navEnhet = enhet,
                ),
            )
            konsekvens.map { it.verdi as IASakDto }
        }.also { iaSakEither ->
            auditLog.auditloggEither(
                call = call,
                either = iaSakEither,
                orgnummer = orgnr,
                auditType = AuditType.delete,
                saksnummer = iaSakEither.map { iaSak -> iaSak.saksnummer }.getOrNull(),
            )
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    post("$NY_FLYT_API_PATH/virksomhet/{orgnummer}/avslutt-vurdering") {
        val orgnr = call.orgnummer ?: return@post call.respond(IASakError.`ugyldig orgnummer`)
        val årsak = call.receive<ValgtÅrsak>()

        if (!årsak.validerBegrunnelserForVurdering()) {
            return@post call.respond(
                status = HttpStatusCode.BadRequest,
                message = "Ugyldig årsak eller begrunnelse for avslutting av vurdering",
            )
        }

        if (årsak.dato == null || årsak.dato.toJavaLocalDate().isBefore(LocalDate.now().plusDays(1))) {
            return@post call.respond(
                status = HttpStatusCode.BadRequest,
                message = "Dato for avslutting av vurdering må oppgis",
            )
        }

        call.somSaksbehandlerMedNavenhet(adGrupper = adGrupper, azureService = azureService) { saksbehandler, navEnhet ->
            val konsekvens = tilstandsmaskin(orgnr).prosesserHendelse(
                hendelse = AvsluttVurdering(
                    orgnr = orgnr,
                    årsak = årsak,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                ),
            )
            konsekvens.map { (it.verdi as IASakDto) }
        }.also { iaSakEither ->
            auditLog.auditloggEither(
                call = call,
                either = iaSakEither,
                orgnummer = orgnr,
                auditType = AuditType.update,
                saksnummer = iaSakEither.map { iaSak -> iaSak.saksnummer }.getOrNull(),
            )
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }
}
