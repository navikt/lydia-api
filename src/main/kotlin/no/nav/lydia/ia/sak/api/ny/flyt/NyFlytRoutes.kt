package no.nav.lydia.ia.sak.api.ny.flyt

import arrow.core.Either
import arrow.core.getOrElse
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import io.ktor.server.application.log
import io.ktor.server.request.receive
import io.ktor.server.request.receiveNullable
import java.time.LocalDate
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.application
import io.ktor.server.routing.delete
import io.ktor.server.routing.get
import io.ktor.server.routing.post
import io.ktor.server.routing.put
import kotlinx.datetime.toJavaLocalDate
import no.nav.lydia.ADGrupper
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.ia.eksport.SamarbeidDto
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.IASamarbeidFeil
import no.nav.lydia.ia.sak.IASamarbeidService
import no.nav.lydia.ia.sak.PlanService
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.SakshistorikkDto
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringService
import no.nav.lydia.ia.sak.api.extensions.orgnummer
import no.nav.lydia.ia.sak.api.extensions.saksnummer
import no.nav.lydia.ia.sak.api.extensions.samarbeidId
import no.nav.lydia.ia.sak.api.extensions.sendFeil
import no.nav.lydia.ia.sak.api.extensions.spørreundersøkelseId
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.TilstandsmaskinBuilder
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.AngreVurderVirksomhet
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.AvsluttSamarbeid
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.EndrePlanlagtDatoForNesteTilstand
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.EndreSamarbeidsNavn
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.FullførKartleggingForSamarbeid
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.OpprettKartleggingForSamarbeid
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.OpprettNyttSamarbeid
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.SlettKartleggingForSamarbeid
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.SlettSamarbeid
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.StartKartleggingForSamarbeid
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.VurderVirksomhet
import no.nav.lydia.ia.sak.api.samarbeid.IASamarbeidDto
import no.nav.lydia.ia.sak.api.samarbeid.tilDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.IASakSpørreundersøkelseError
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseDto
import no.nav.lydia.ia.sak.api.tilSakshistorikk
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.ia.årsak.domene.validerBegrunnelserForVurderingAvVirksomhet
import no.nav.lydia.integrasjoner.azure.AzureService
import no.nav.lydia.sykefraværsstatistikk.api.SykefraværsstatistikkError
import no.nav.lydia.tilgangskontroll.somLesebruker
import no.nav.lydia.tilgangskontroll.somSaksbehandlerMedNavenhet
import no.nav.lydia.tilgangskontroll.somSuperbrukerMedNavenhet
import no.nav.lydia.virksomhet.VirksomhetService
import no.nav.lydia.virksomhet.api.VirksomhetFeil
import no.nav.lydia.virksomhet.api.toDto

const val NY_FLYT_PATH = "iasak/nyflyt"

fun Route.nyFlyt(
    iaSakService: IASakService,
    iASamarbeidService: IASamarbeidService,
    nyFlytService: NyFlytService,
    dokumentPubliseringService: DokumentPubliseringService,
    planService: PlanService,
    tilstandVirksomhetRepository: TilstandVirksomhetRepository,
    virksomhetService: VirksomhetService,
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

    get("$NY_FLYT_PATH/{orgnummer}/tilstand") {
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

    get("$NY_FLYT_PATH/virksomhet/{orgnummer}") {
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

    // TODO: Fjern denne når frontend er oppdatert til å bruke /virksomhet/{orgnummer}/samarbeidsperiode istedet
    get("$NY_FLYT_PATH/{orgnummer}") {
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

    get("$NY_FLYT_PATH/virksomhet/{orgnummer}/samarbeidsperiode") {
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

    get("$NY_FLYT_PATH/virksomhet/{orgnummer}/samarbeidsperiode/{saksnummer}") {
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

    get("$NY_FLYT_PATH/virksomhet/{orgnummer}/historikk") {
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

    post("$NY_FLYT_PATH/{orgnummer}/vurder") {
        val orgnr = call.orgnummer ?: return@post call.respond(IASakError.`ugyldig orgnummer`)
        val valgtÅrsak = runCatching { call.receiveNullable<ValgtÅrsak>() }.getOrNull()

        if (valgtÅrsak != null && !valgtÅrsak.validerBegrunnelserForVurderingAvVirksomhet()) {
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
            application.log.info("NyTilstand etter hendelse ${hendelse.navn()} er: '${konsekvens.nyTilstand.navn()}'")

            konsekvens.endring.map { it as IASakDto }
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

    post("$NY_FLYT_PATH/{orgnummer}/angre-vurdering") {
        val orgnr = call.orgnummer ?: return@post call.respond(IASakError.`ugyldig orgnummer`)

        call.somSuperbrukerMedNavenhet(adGrupper, azureService) { superbruker, enhet ->
            val konsekvens = tilstandsmaskin(orgnr).prosesserHendelse(
                hendelse = AngreVurderVirksomhet(
                    orgnr = orgnr,
                    superbruker = superbruker,
                    navEnhet = enhet,
                ),
            )
            konsekvens.endring.map { it as IASakDto }
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

    post("$NY_FLYT_PATH/{orgnummer}/opprett-samarbeid") {
        val orgnr = call.orgnummer ?: return@post call.respond(IASakError.`ugyldig orgnummer`)
        val iaSamarbeidDto = call.receive<IASamarbeidDto>()

        call.somSaksbehandlerMedNavenhet(adGrupper, azureService) { saksbehandler, navEnhet ->
            val konsekvens = tilstandsmaskin(orgnr).prosesserHendelse(
                hendelse = OpprettNyttSamarbeid(
                    orgnr = orgnr,
                    samarbeidsnavn = iaSamarbeidDto.navn,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                ),
            )
            konsekvens.endring.map { it as IASamarbeidDto }
        }.also { iaSamarbeidDtoEither ->
            auditLog.auditloggEither(
                call = call,
                either = iaSamarbeidDtoEither,
                orgnummer = orgnr,
                auditType = AuditType.create,
                saksnummer = iaSamarbeidDtoEither.map { iaSamarbeid -> iaSamarbeid.saksnummer }.getOrNull(),
            )
        }.map {
            call.respond(status = HttpStatusCode.Created, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    post("$NY_FLYT_PATH/{orgnummer}/{samarbeidId}/opprett-kartlegging/{type}") {
        val orgnr = call.orgnummer ?: return@post call.respond(IASakError.`ugyldig orgnummer`)
        val samarbeidId = call.samarbeidId ?: return@post call.respond(IASakError.`ugyldig orgnummer`)
        val tilstandsmaskin = tilstandsmaskin(orgnr)
        val type = call.parameters["type"]?.let { param ->
            Spørreundersøkelse.Type.entries.firstOrNull { it.name.equals(param, ignoreCase = true) }
        } ?: return@post call.sendFeil(IASakSpørreundersøkelseError.`ugyldig type`)

        call.somSaksbehandlerMedNavenhet(adGrupper, azureService) { saksbehandler, navEnhet ->
            val konsekvens = tilstandsmaskin.prosesserHendelse(
                hendelse = OpprettKartleggingForSamarbeid(
                    orgnr = orgnr,
                    samarbeidId = samarbeidId,
                    type = type,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                ),
            )
            konsekvens.endring.map { it as SpørreundersøkelseDto }
        }.also { spørreundersøkelseDtoEither ->
            auditLog.auditloggEither(
                call = call,
                either = spørreundersøkelseDtoEither,
                orgnummer = orgnr,
                auditType = AuditType.create,
                saksnummer = tilstandsmaskin.saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.Created, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    post("$NY_FLYT_PATH/{orgnummer}/{samarbeidId}/start-kartlegging/{sporreundersokelseId}") {
        val orgnr = call.orgnummer ?: return@post call.respond(IASakError.`ugyldig orgnummer`)
        val tilstandsmaskin = tilstandsmaskin(orgnr)
        val spørreundersøkelseId = call.spørreundersøkelseId ?: return@post call.respond(IASakSpørreundersøkelseError.`ugyldig id`)

        call.somSaksbehandlerMedNavenhet(adGrupper, azureService) { saksbehandler, navEnhet ->
            val konsekvens = tilstandsmaskin.prosesserHendelse(
                hendelse = StartKartleggingForSamarbeid(
                    orgnr = orgnr,
                    spørreundersøkelseId = spørreundersøkelseId,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                ),
            )
            konsekvens.endring.map { it as SpørreundersøkelseDto }
        }.also { spørreundersøkelseDtoEither ->
            auditLog.auditloggEither(
                call = call,
                either = spørreundersøkelseDtoEither,
                orgnummer = orgnr,
                auditType = AuditType.update,
                saksnummer = tilstandsmaskin.saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    post("$NY_FLYT_PATH/{orgnummer}/{samarbeidId}/fullfor-kartlegging/{sporreundersokelseId}") {
        val orgnr = call.orgnummer ?: return@post call.respond(IASakError.`ugyldig orgnummer`)
        val tilstandsmaskin = tilstandsmaskin(orgnr)
        val spørreundersøkelseId = call.spørreundersøkelseId ?: return@post call.respond(IASakSpørreundersøkelseError.`ugyldig id`)

        call.somSaksbehandlerMedNavenhet(adGrupper, azureService) { saksbehandler, navEnhet ->
            val konsekvens = tilstandsmaskin.prosesserHendelse(
                hendelse = FullførKartleggingForSamarbeid(
                    orgnr = orgnr,
                    spørreundersøkelseId = spørreundersøkelseId,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                ),
            )
            konsekvens.endring.map { it as SpørreundersøkelseDto }
        }.also { spørreundersøkelseDtoEither ->
            auditLog.auditloggEither(
                call = call,
                either = spørreundersøkelseDtoEither,
                orgnummer = orgnr,
                auditType = AuditType.update,
                saksnummer = tilstandsmaskin.saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    delete("$NY_FLYT_PATH/{orgnummer}/{samarbeidId}/slett-kartlegging/{sporreundersokelseId}") {
        val orgnr = call.orgnummer ?: return@delete call.respond(IASakError.`ugyldig orgnummer`)
        val tilstandsmaskin = tilstandsmaskin(orgnr)
        val spørreundersøkelseId = call.spørreundersøkelseId ?: return@delete call.respond(IASakSpørreundersøkelseError.`ugyldig id`)

        call.somSaksbehandlerMedNavenhet(adGrupper, azureService) { saksbehandler, navEnhet ->
            val konsekvens = tilstandsmaskin.prosesserHendelse(
                hendelse = SlettKartleggingForSamarbeid(
                    orgnr = orgnr,
                    spørreundersøkelseId = spørreundersøkelseId,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                ),
            )
            konsekvens.endring.map { it as SpørreundersøkelseDto }
        }.also { spørreundersøkelseDtoEither ->
            auditLog.auditloggEither(
                call = call,
                either = spørreundersøkelseDtoEither,
                orgnummer = orgnr,
                auditType = AuditType.delete,
                saksnummer = tilstandsmaskin.saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    delete("$NY_FLYT_PATH/{orgnummer}/{samarbeidId}/slett-samarbeid") {
        val orgnr = call.orgnummer ?: return@delete call.sendFeil(IASakError.`ugyldig orgnummer`)
        val samarbeidId = call.samarbeidId ?: return@delete call.sendFeil(IASamarbeidFeil.`ugyldig samarbeidId`)
        val datoParam = call.request.queryParameters["dato"]
        val dato = datoParam?.let {
            runCatching { LocalDate.parse(it) }.getOrElse {
                return@delete call.sendFeil(Feil(feilmelding = "Ugyldig datoformat", httpStatusCode = HttpStatusCode.BadRequest))
            }
        }
        if (dato != null && dato.isBefore(LocalDate.now().plusDays(1))) {
            return@delete call.sendFeil(Feil(feilmelding = "Dato må være minst én dag frem i tid", httpStatusCode = HttpStatusCode.BadRequest))
        }
        val tilstandsmaskin = tilstandsmaskin(orgnr)

        call.somSaksbehandlerMedNavenhet(adGrupper, azureService) { saksbehandler, navEnhet ->
            val konsekvens = tilstandsmaskin.prosesserHendelse(
                hendelse = SlettSamarbeid(
                    orgnr = orgnr,
                    samarbeidId = samarbeidId,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                    dato = dato,
                ),
            )
            konsekvens.endring.map { it as IASamarbeidDto }
        }.also { iaSamarbeidDtoEither ->
            auditLog.auditloggEither(
                call = call,
                either = iaSamarbeidDtoEither,
                orgnummer = orgnr,
                auditType = AuditType.delete,
                saksnummer = tilstandsmaskin.saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    post("$NY_FLYT_PATH/{orgnummer}/{samarbeidId}/avslutt-samarbeid") {
        val orgnr = call.orgnummer ?: return@post call.sendFeil(IASakError.`ugyldig orgnummer`)
        val samarbeidId = call.samarbeidId ?: return@post call.sendFeil(IASamarbeidFeil.`ugyldig samarbeidId`)
        val samarbeid = call.receive<SamarbeidDto>()
        val typeAvslutning = samarbeid.status
        if (typeAvslutning != IASamarbeid.Status.FULLFØRT && typeAvslutning != IASamarbeid.Status.AVBRUTT) {
            return@post call.sendFeil(Feil(feilmelding = "Ugyldig avslutningstype", httpStatusCode = HttpStatusCode.BadRequest))
        }
        val datoParam = call.request.queryParameters["dato"]
        val dato = datoParam?.let {
            runCatching { LocalDate.parse(it) }.getOrElse {
                return@post call.sendFeil(Feil(feilmelding = "Ugyldig datoformat", httpStatusCode = HttpStatusCode.BadRequest))
            }
        }
        if (dato != null && dato.isBefore(LocalDate.now().plusDays(1))) {
            return@post call.sendFeil(Feil(feilmelding = "Dato må være minst én dag frem i tid", httpStatusCode = HttpStatusCode.BadRequest))
        }
        val tilstandsmaskin = tilstandsmaskin(orgnr)

        call.somSaksbehandlerMedNavenhet(adGrupper, azureService) { saksbehandler, navEnhet ->
            val konsekvens = tilstandsmaskin.prosesserHendelse(
                hendelse = AvsluttSamarbeid(
                    orgnr = orgnr,
                    samarbeidId = samarbeidId,
                    typeAvslutning = typeAvslutning,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                    dato = dato,
                ),
            )
            konsekvens.endring.map { it as IASamarbeidDto }
        }.also { iaSamarbeidDtoEither ->
            auditLog.auditloggEither(
                call = call,
                either = iaSamarbeidDtoEither,
                orgnummer = orgnr,
                auditType = AuditType.delete,
                saksnummer = tilstandsmaskin.saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    put("$NY_FLYT_PATH/virksomhet/{orgnummer}/samarbeid/{samarbeidId}/oppdater") {
        val orgnr = call.orgnummer ?: return@put call.sendFeil(IASakError.`ugyldig orgnummer`)
        val samarbeidId = call.samarbeidId ?: return@put call.sendFeil(IASakError.`ugyldig orgnummer`)
        val iaSamarbeidDto = call.receive<IASamarbeidDto>()
        val tilstandsmaskin = tilstandsmaskin(orgnr)

        call.somSaksbehandlerMedNavenhet(adGrupper, azureService) { saksbehandler, navEnhet ->
            val konsekvens = tilstandsmaskin.prosesserHendelse(
                hendelse = EndreSamarbeidsNavn(
                    orgnr = orgnr,
                    samarbeidId = samarbeidId,
                    navn = iaSamarbeidDto.navn,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                ),
            )
            konsekvens.endring.map { it as IASamarbeidDto }
        }.also { iaSamarbeidDtoEither ->
            auditLog.auditloggEither(
                call = call,
                either = iaSamarbeidDtoEither,
                orgnummer = orgnr,
                auditType = AuditType.update,
                saksnummer = tilstandsmaskin.saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    put("$NY_FLYT_PATH/virksomhet/{orgnummer}/endre-planlagt-dato") {
        val orgnr = call.orgnummer ?: return@put call.sendFeil(IASakError.`ugyldig orgnummer`)
        val virksomhetTilstandAutomatiskOppdateringDto = call.receive<VirksomhetTilstandAutomatiskOppdateringDto>()
        val tilstandsmaskin = tilstandsmaskin(orgnr)

        call.somSaksbehandlerMedNavenhet(adGrupper, azureService) { saksbehandler, navEnhet ->
            val konsekvens = tilstandsmaskin.prosesserHendelse(
                hendelse = EndrePlanlagtDatoForNesteTilstand(
                    orgnr = orgnr,
                    nyPlanlagtDato = virksomhetTilstandAutomatiskOppdateringDto.planlagtDato.toJavaLocalDate(),
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                ),
            )
            konsekvens.endring.map { it as VirksomhetTilstandAutomatiskOppdateringDto }
        }.also { either ->
            auditLog.auditloggEither(
                call = call,
                either = either,
                orgnummer = orgnr,
                auditType = AuditType.update,
                saksnummer = tilstandsmaskin.saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    // -- Dette er tenkt å være en midlertidig løsning frem til vi har utviklet kontaktperson funksjonalitet i samarbeid med Salesforce.
    // -- Dette etterlater ingen hendelser, men skriver kun over eierskap i den akktive saken
    post("$NY_FLYT_PATH/{orgnummer}/bli-eier") {
        val orgnr = call.orgnummer ?: return@post call.sendFeil(IASakError.`ugyldig orgnummer`)
        call.somSaksbehandlerMedNavenhet(adGrupper, azureService) { saksbehandler, _ ->
            nyFlytService.bliEier(orgnr, saksbehandler)
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
}
