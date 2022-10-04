package no.nav.lydia.veileder

import arrow.core.Either
import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.httpGet
import io.ktor.http.HttpStatusCode
import io.ktor.server.application.call
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.get
import kotlinx.coroutines.async
import kotlinx.coroutines.awaitAll
import kotlinx.serialization.ExperimentalSerializationApi
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.decodeFromStream
import no.nav.lydia.NaisEnvironment
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.integrasjoner.azure.AzureTokenFetcher
import no.nav.lydia.tilgangskontroll.Rådgiver.Companion.somSuperbruker

@Serializable
data class AzureAdBruker(
    val id: String,
    val userPrincipalName: String? = null,
    val onPremisesSamAccountName: String? = null,
    val givenName: String? = null,
    val surname: String? = null,
)

@Serializable
data class AzureAdBrukere(val value: List<AzureAdBruker>)

@OptIn(ExperimentalSerializationApi::class)
fun Route.veileder(naisEnvironment: NaisEnvironment, tokenFetcher: AzureTokenFetcher) {
    get("/veiledere") {
        somSuperbruker(call = call, fiaRoller = naisEnvironment.security.fiaRoller) {
            Either.catch {
                val accessToken = tokenFetcher.clientCredentialsToken()
                val gruppeIder = listOf(naisEnvironment.security.fiaRoller.saksbehandlerGroupId, naisEnvironment.security.fiaRoller.superbrukerGroupId)
                val veiledere = gruppeIder.map { gruppeId ->
                    async {
                        Json.decodeFromStream<AzureAdBrukere>("${naisEnvironment.security.azureConfig.graphDatabaseUrl}/groups/$gruppeId/members?\$select=id,givenName,surname"
                            .httpGet()
                            .authentication()
                            .bearer(token = accessToken)
                            .response()
                            .second
                            .body()
                            .toStream()).value
                    }
                }.awaitAll()
                    .flatten()
                    .toSet()
                veiledere
            }.mapLeft { VeilederFeil.`Klarte ikke hente veiledere` }
        }.fold(ifLeft = {
            call.respond(it.httpStatusCode, it.feilmelding)
        },  ifRight = {
            call.respond(it)
        })
    }
}

object VeilederFeil {
    val `Klarte ikke hente veiledere` = Feil("Klarte ikke hente veiledere", HttpStatusCode.InternalServerError)
}