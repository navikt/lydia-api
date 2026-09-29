package no.nav.lydia.api.v1

import arrow.core.left
import arrow.core.raise.either
import arrow.core.right
import io.ktor.http.HttpStatusCode
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.get
import no.nav.lydia.ADGrupper
import no.nav.lydia.api.featureToggle
import no.nav.lydia.api.sendFeil
import no.nav.lydia.featureToggle.FeatureToggleEnvironment
import no.nav.lydia.featureToggle.FeatureToggleFeil
import no.nav.lydia.featureToggle.ToggleVerdi
import no.nav.lydia.integrasjoner.azure.AzureService
import no.nav.lydia.tilgangskontroll.somSaksbehandler
import no.nav.lydia.tilgangskontroll.somSaksbehandlerMedNavenhet
import no.nav.lydia.tilgangskontroll.somSuperbrukerMedNavenhet

fun Route.featureToggleRoutes(
    adGrupper: ADGrupper,
    featureToggleEnvironment: FeatureToggleEnvironment,
    azureService: AzureService,
) {
    get("$NY_FLYT_API_PATH/feature-toggling/{featureToggle}/{verdi}") {
        val toggle: String = call.featureToggle ?: return@get call.respond(HttpStatusCode.BadRequest, "Mangler navn på feature toggle")
        val verdi = call.pathParameters["verdi"] ?: return@get call.respond(HttpStatusCode.BadRequest, "Mangler verdi for feature toggle")
        call.somSaksbehandler(adGrupper) {
            featureToggleEnvironment.erSkruddPå(
                togglenavn = toggle,
                verdi = verdi,
            )?.right() ?: FeatureToggleFeil.`feature toggle finnes ikke`.left()
        }.map {
            call.respond(ToggleVerdi(erPå = it))
        }.mapLeft {
            call.sendFeil(it)
        }
    }

    get("$NY_FLYT_API_PATH/feature-toggling/nav-enhet/{featureToggle}") {
        val toggle: String = call.featureToggle ?: return@get call.respond(HttpStatusCode.BadRequest, "Mangler navn på feature toggle")
        call.somSaksbehandlerMedNavenhet(adGrupper, azureService) { _, navEnhet ->
            featureToggleEnvironment.erSkruddPå(
                togglenavn = toggle,
                verdi = navEnhet.enhetsnummer,
            )?.right() ?: FeatureToggleFeil.`feature toggle finnes ikke`.left()
        }.map {
            call.respond(ToggleVerdi(erPå = it))
        }.mapLeft { call.sendFeil(it) }
    }

    get("$NY_FLYT_API_PATH/feature-toggling/{featureToggle}") {
        val toggle: String = call.featureToggle ?: return@get call.respond(HttpStatusCode.BadRequest, "Mangler navn på feature toggle")
        call.somSuperbrukerMedNavenhet(adGrupper, azureService) { _, _ ->
            either {
                val verdier = featureToggleEnvironment.hentVerdier(toggle) ?: FeatureToggleFeil.`feature toggle finnes ikke`.left().bind()
                mapOf("verdier" to verdier)
            }
        }.map { call.respond(it) }
            .mapLeft { call.sendFeil(it) }
    }
}
