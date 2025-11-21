package no.nav.lydia.ia.sak.api.ny.flyt

import arrow.core.Either
import arrow.core.flatMap
import io.ktor.http.HttpStatusCode
import io.ktor.server.application.ApplicationCall
import io.ktor.server.application.log
import io.ktor.server.request.receive
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.application
import io.ktor.server.routing.post
import no.nav.lydia.ADGrupper
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.IASamarbeidService
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.IASakDto.Companion.toDto
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.extensions.orgnummer
import no.nav.lydia.ia.sak.api.ny.flyt.Hendelse.VurderVirksomhet
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.integrasjoner.azure.AzureService
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import no.nav.lydia.tilgangskontroll.fia.objectId
import no.nav.lydia.tilgangskontroll.somSaksbehandler
import no.nav.lydia.tilgangskontroll.somSuperbruker

const val NY_FLYT_PATH = "iasak/nyflyt"

fun Route.nyFlyt(
    iaSakService: IASakService,
    iASamarbeidService: IASamarbeidService,
    nyFlytService: NyFlytService,
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

    val tilstandsmaskinBuilder = TilstandsmaskinBuilder.medKontekst(
        fiaKontekst = FiaKontekst(
            iaSakService = iaSakService,
            iASamarbeidService = iASamarbeidService,
            nyFlytService = nyFlytService,
        ),
    )

    post("$NY_FLYT_PATH/{orgnummer}/vurder") {
        val orgnr = call.orgnummer ?: return@post call.respond(IASakError.`ugyldig orgnummer`)
        val tilstandsmaskin = tilstandsmaskinBuilder.build(orgnr)
        call.somSuperbrukerMedNavenhet { superbruker, navEnhet ->
            val hendelse = VurderVirksomhet(
                orgnr = orgnr,
                superbruker = superbruker,
                navEnhet = navEnhet,
            )
            val konsekvens = tilstandsmaskin.prosesserHendelse(
                hendelse = hendelse,
            )
            application.log.info("NyTilstand etter hendelse ${hendelse.navn()} er: '${konsekvens.nyTilstand}'")

            konsekvens.endring.map { (it as IASak).toDto(navAnsatt = superbruker) }
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
        val tilstandsmaskin = tilstandsmaskinBuilder.build(orgnr)

        call.somSuperbruker(adGrupper = adGrupper) {
            val konsekvens = tilstandsmaskin.prosesserHendelse(
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
        val tilstandsmaskin = tilstandsmaskinBuilder.build(orgnr)
        val årsak = call.receive<ValgtÅrsak>()

        call.somSaksbehandlerMedNavenhet { saksbehandler, navEnhet ->
            val konsekvens = tilstandsmaskin.prosesserHendelse(
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
}
