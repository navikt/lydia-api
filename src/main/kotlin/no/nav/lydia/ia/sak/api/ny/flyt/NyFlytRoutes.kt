package no.nav.lydia.ia.sak.api.ny.flyt

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import io.ktor.server.application.ApplicationCall
import io.ktor.server.application.log
import io.ktor.server.request.receive
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.application
import io.ktor.server.routing.delete
import io.ktor.server.routing.get
import io.ktor.server.routing.post
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
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringService
import no.nav.lydia.ia.sak.api.extensions.orgnummer
import no.nav.lydia.ia.sak.api.extensions.samarbeidId
import no.nav.lydia.ia.sak.api.extensions.sendFeil
import no.nav.lydia.ia.sak.api.extensions.spørreundersøkelseId
import no.nav.lydia.ia.sak.api.extensions.type
import no.nav.lydia.ia.sak.api.ny.flyt.Hendelse.VurderVirksomhet
import no.nav.lydia.ia.sak.api.plan.PlanMedPubliseringStatusDto
import no.nav.lydia.ia.sak.api.plan.tilDtoMedPubliseringStatus
import no.nav.lydia.ia.sak.api.samarbeid.IASamarbeidDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.IASakSpørreundersøkelseError
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseDto
import no.nav.lydia.ia.sak.domene.plan.Plan
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.integrasjoner.azure.AzureService
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import no.nav.lydia.tilgangskontroll.fia.objectId
import no.nav.lydia.tilgangskontroll.somLesebruker
import no.nav.lydia.tilgangskontroll.somSaksbehandler
import no.nav.lydia.tilgangskontroll.somSuperbruker

const val NY_FLYT_PATH = "iasak/nyflyt"

fun Route.nyFlyt(
    iaSakService: IASakService,
    iASamarbeidService: IASamarbeidService,
    nyFlytService: NyFlytService,
    dokumentPubliseringService: DokumentPubliseringService,
    planService: PlanService,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
    azureService: AzureService,
) {
    fun <T> ApplicationCall.somSuperbrukerMedNavenhet(
        block: (NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker, NavEnhet) -> Either<Feil, T>,
    ): Either<Feil, T> =
        somSuperbruker(adGrupper = adGrupper) { superbruker ->
            azureService.hentNavenhet(objectId()).flatMap { navEnhet ->
                block(superbruker, navEnhet)
            }
        }

    fun <T> ApplicationCall.somSaksbehandlerMedNavenhet(block: (NavAnsatt.NavAnsattMedSaksbehandlerRolle, NavEnhet) -> Either<Feil, T>): Either<Feil, T> =
        somSaksbehandler(adGrupper = adGrupper) { saksbehandler ->
            azureService.hentNavenhet(objectId()).flatMap { navEnhet ->
                block(saksbehandler, navEnhet)
            }
        }

    fun tilstandsmaskin(orgnr: String) =
        TilstandsmaskinBuilder.medKontekst(
            fiaKontekst = FiaKontekst(
                iaSakService = iaSakService,
                iASamarbeidService = iASamarbeidService,
                nyFlytService = nyFlytService,
                dokumentPubliseringService = dokumentPubliseringService,
                planService = planService,
                saksnummer = nyFlytService.hentAktivIASakDto(orgnr)?.saksnummer,
            ),
        ).build(orgnr)

    get("$NY_FLYT_PATH/{orgnummer}") {
        val orgnr = call.orgnummer ?: return@get call.respond(IASakError.`ugyldig orgnummer`)

        call.somLesebruker(adGrupper) {
            nyFlytService.hentAktivIASakDto(orgnr)?.right()
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

    post("$NY_FLYT_PATH/{orgnummer}/vurder") {
        val orgnr = call.orgnummer ?: return@post call.respond(IASakError.`ugyldig orgnummer`)
        call.somSuperbrukerMedNavenhet { superbruker, navEnhet ->
            val hendelse = VurderVirksomhet(
                orgnr = orgnr,
                superbruker = superbruker,
                navEnhet = navEnhet,
            )
            val konsekvens = tilstandsmaskin(orgnr).prosesserHendelse(
                hendelse = hendelse,
            )
            application.log.info("NyTilstand etter hendelse ${hendelse.navn()} er: '${konsekvens.nyTilstand}'")

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

        call.somSuperbruker(adGrupper = adGrupper) {
            val konsekvens = tilstandsmaskin(orgnr).prosesserHendelse(
                hendelse = Hendelse.AngreVurderVirksomhet(orgnr = orgnr),
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

    post("$NY_FLYT_PATH/{orgnummer}/fullfor-vurdering") {
        val orgnr = call.orgnummer ?: return@post call.respond(IASakError.`ugyldig orgnummer`)
        val årsak = call.receive<ValgtÅrsak>()

        call.somSaksbehandlerMedNavenhet { saksbehandler, navEnhet ->
            val konsekvens = tilstandsmaskin(orgnr).prosesserHendelse(
                hendelse = Hendelse.FullførVurdering(
                    orgnr = orgnr,
                    årsak = årsak,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                ),
            )
            konsekvens.endring.map { (it as IASakDto) }
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

    post("$NY_FLYT_PATH/{orgnummer}/opprett-samarbeid") {
        val orgnr = call.orgnummer ?: return@post call.respond(IASakError.`ugyldig orgnummer`)
        val iaSamarbeidDto = call.receive<IASamarbeidDto>()

        call.somSaksbehandlerMedNavenhet { saksbehandler, navEnhet ->
            val konsekvens = tilstandsmaskin(orgnr).prosesserHendelse(
                hendelse = Hendelse.OpprettNyttSamarbeid(
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
        val type = call.type ?: return@post call.respond(IASakSpørreundersøkelseError.`ugyldig type`)

        call.somSaksbehandlerMedNavenhet { saksbehandler, navEnhet ->
            val konsekvens = tilstandsmaskin.prosesserHendelse(
                hendelse = Hendelse.OpprettKartleggingForSamarbeid(
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

        call.somSaksbehandlerMedNavenhet { saksbehandler, navEnhet ->
            val konsekvens = tilstandsmaskin.prosesserHendelse(
                hendelse = Hendelse.StartKartleggingForSamarbeid(
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

        call.somSaksbehandlerMedNavenhet { saksbehandler, navEnhet ->
            val konsekvens = tilstandsmaskin.prosesserHendelse(
                hendelse = Hendelse.FullførKartleggingForSamarbeid(
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

        call.somSaksbehandlerMedNavenhet { saksbehandler, navEnhet ->
            val konsekvens = tilstandsmaskin.prosesserHendelse(
                hendelse = Hendelse.SlettKartleggingForSamarbeid(
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

    post("$NY_FLYT_PATH/{orgnummer}/{samarbeidId}/opprett-samarbeidsplan") {
        val orgnr = call.orgnummer ?: return@post call.respond(IASakError.`ugyldig orgnummer`)
        val samarbeidId = call.samarbeidId ?: return@post call.respond(IASakError.`ugyldig orgnummer`)
        val tilstandsmaskin = tilstandsmaskin(orgnr)
        val plan = call.receive<PlanMalDto>()

        call.somSaksbehandlerMedNavenhet { saksbehandler, navEnhet ->
            val konsekvens = tilstandsmaskin.prosesserHendelse(
                hendelse = Hendelse.OpprettPlanForSamarbeid(
                    orgnr = orgnr,
                    samarbeidId = samarbeidId,
                    plan = plan,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                ),
            )
            konsekvens.endring.map { it as PlanMedPubliseringStatusDto }
        }.also { iaPlanDtoEither ->
            auditLog.auditloggEither(
                call = call,
                either = iaPlanDtoEither,
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

    delete("$NY_FLYT_PATH/{orgnummer}/{samarbeidId}/slett-samarbeidsplan") {
        val orgnr = call.orgnummer ?: return@delete call.sendFeil(IASakError.`ugyldig orgnummer`)
        val samarbeidId = call.samarbeidId ?: return@delete call.sendFeil(IASamarbeidFeil.`ugyldig samarbeidId`)
        val tilstandsmaskin = tilstandsmaskin(orgnr)

        call.somSaksbehandlerMedNavenhet { saksbehandler, navEnhet ->
            val konsekvens = tilstandsmaskin.prosesserHendelse(
                hendelse = Hendelse.SlettPlanForSamarbeid(
                    orgnr = orgnr,
                    samarbeidId = samarbeidId,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                ),
            )
            konsekvens.endring.map { it as Plan }
        }.also { iaPlanDtoEither ->
            auditLog.auditloggEither(
                call = call,
                either = iaPlanDtoEither,
                orgnummer = orgnr,
                auditType = AuditType.delete,
                saksnummer = tilstandsmaskin.saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it.tilDtoMedPubliseringStatus())
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    delete("$NY_FLYT_PATH/{orgnummer}/{samarbeidId}/slett-samarbeid") {
        val orgnr = call.orgnummer ?: return@delete call.sendFeil(IASakError.`ugyldig orgnummer`)
        val samarbeidId = call.samarbeidId ?: return@delete call.sendFeil(IASamarbeidFeil.`ugyldig samarbeidId`)
        val tilstandsmaskin = tilstandsmaskin(orgnr)

        call.somSaksbehandlerMedNavenhet { saksbehandler, navEnhet ->
            val konsekvens = tilstandsmaskin.prosesserHendelse(
                hendelse = Hendelse.SlettSamarbeid(
                    orgnr = orgnr,
                    samarbeidId = samarbeidId,
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
        val tilstandsmaskin = tilstandsmaskin(orgnr)

        call.somSaksbehandlerMedNavenhet { saksbehandler, navEnhet ->
            val konsekvens = tilstandsmaskin.prosesserHendelse(
                hendelse = Hendelse.AvsluttSamarbeid(
                    orgnr = orgnr,
                    samarbeidId = samarbeidId,
                    typeAvslutning = typeAvslutning,
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
                auditType = AuditType.delete,
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
        call.somSaksbehandlerMedNavenhet { saksbehandler, _ ->
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
