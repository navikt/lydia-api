package no.nav.lydia.ia.sak.api.ny.flyt

import arrow.core.flatMap
import io.ktor.http.HttpStatusCode
import io.ktor.server.application.log
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.application
import io.ktor.server.routing.delete
import io.ktor.server.routing.post
import no.nav.lydia.ADGrupper
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.IASamarbeidService
import no.nav.lydia.ia.sak.api.IASakDto.Companion.toDto
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.extensions.orgnummer
import no.nav.lydia.ia.sak.api.ny.flyt.Hendelse.VurderVirksomhet
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.integrasjoner.azure.AzureService
import no.nav.lydia.tilgangskontroll.fia.objectId
import no.nav.lydia.tilgangskontroll.somSuperbruker

const val NY_FLYT_PATH = "iasak/nyflyt"

fun Route.nyFlyt(
    iaSakService: IASakService,
    iASamarbeidService: IASamarbeidService,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
    azureService: AzureService,
) {


    post("$NY_FLYT_PATH/{orgnummer}/vurder") {
        val orgnr = call.orgnummer ?: return@post call.respond(IASakError.`ugyldig orgnummer`)
        val tilstandsmaskin = TilstandsmaskinBuilder.init(
            fiaKontekst = FiaKontekst(
                iaSakService = iaSakService,
                iASamarbeidService = iASamarbeidService,
            ),
        ).utledFraTilstand(orgnr)

        call.somSuperbruker(adGrupper = adGrupper) { superbruker ->
            azureService.hentNavenhet(call.objectId()).flatMap { navEnhet ->
                val hendelse = VurderVirksomhet(
                    orgnr = orgnr,
                    superbruker = superbruker,
                    navEnhet = navEnhet,
                )
                val konsekvens: Konsekvens =
                    tilstandsmaskin.prosessHendelse(
                        hendelse = hendelse,
                    )
                application.log.info("NyTilstand etter hendelse ${hendelse.navn()} er: '${konsekvens.nyTilstand}'")

                konsekvens.endring.map { (it as IASak).toDto(navAnsatt = superbruker) }
            }
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

    delete("$NY_FLYT_PATH/{orgnummer}/angre-vurdering") {
        call.respond(HttpStatusCode.OK)
    }
}
