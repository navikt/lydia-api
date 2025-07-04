package no.nav.lydia.ia.sak.api.dokument

import arrow.core.flatMap
import io.ktor.http.HttpStatusCode
import io.ktor.server.application.log
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.get
import io.ktor.server.routing.post
import no.nav.lydia.ADGrupper
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IA_SAK_RADGIVER_PATH
import no.nav.lydia.ia.sak.api.extensions.dokumentReferanseId
import no.nav.lydia.ia.sak.api.extensions.dokumentType
import no.nav.lydia.ia.sak.api.extensions.sendFeil
import no.nav.lydia.integrasjoner.azure.AzureService
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.objectId
import no.nav.lydia.tilgangskontroll.somLesebruker
import no.nav.lydia.tilgangskontroll.somSaksbehandler

const val DOKUMENT_PUBLISERING_BASE_ROUTE = "$IA_SAK_RADGIVER_PATH/dokument"

fun Route.dokumentPublisering(
    adGrupper: ADGrupper,
    azureService: AzureService,
    dokumentPubliseringService: DokumentPubliseringService,
) {
    get(path = "$DOKUMENT_PUBLISERING_BASE_ROUTE/type/{dokumentType}/ref/{dokumentReferanseId}") {
        val dokumentType = call.dokumentType ?: return@get call.sendFeil(DokumentPubliseringError.`ugyldig type`)
        val dokumentReferanseId = call.dokumentReferanseId ?: return@get call.sendFeil(DokumentPubliseringError.`ugyldig id`)

        call.somLesebruker(adGrupper = adGrupper) { _ ->
            dokumentPubliseringService.hentDokumentPublisering(dokumentReferanseId = dokumentReferanseId, dokumentType = dokumentType)
        }.onRight {
            call.respond(status = HttpStatusCode.OK, message = it)
        }.onLeft {
            call.application.log.warn(it.feilmelding)
            call.sendFeil(feil = it)
        }
    }

    post(path = "$DOKUMENT_PUBLISERING_BASE_ROUTE/type/{dokumentType}/ref/{dokumentReferanseId}") {
        val dokumentType = call.dokumentType ?: return@post call.sendFeil(DokumentPubliseringError.`ugyldig type`)
        val dokumentReferanseId = call.dokumentReferanseId ?: return@post call.sendFeil(DokumentPubliseringError.`ugyldig id`)

        call.somSaksbehandler(adGrupper = adGrupper) { saksbehandler ->
            azureService.hentNavenhet(objectId = call.objectId()).flatMap { navEnhet: NavEnhet ->
                dokumentPubliseringService.opprettOgSendTilPublisering(
                    dokumentReferanseId = dokumentReferanseId,
                    dokumentType = dokumentType,
                    opprettetAv = saksbehandler,
                    navEnhet = navEnhet,
                )
            }
        }.onRight {
            call.respond(status = HttpStatusCode.Created, message = it)
        }.onLeft {
            call.application.log.warn(it.feilmelding)
            call.sendFeil(feil = it)
        }
    }
}

object DokumentPubliseringError {
    val `ugyldig id` = Feil(feilmelding = "Ugyldig dokumentReferanseId", httpStatusCode = HttpStatusCode.BadRequest)
    val `ugyldig type` = Feil(feilmelding = "Ugyldig type dokument", httpStatusCode = HttpStatusCode.BadRequest)
}
