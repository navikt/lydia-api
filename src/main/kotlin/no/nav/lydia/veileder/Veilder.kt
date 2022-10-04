package no.nav.lydia.veileder

import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.httpGet
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
import no.nav.lydia.integrasjoner.azure.AzureTokenFetcher

@Serializable
private data class AzureAdBruker(
    val id: String,
    val userPrincipalName: String?,
    val onPremisesSamAccountName: String?,
    val givenName: String?,
    val surname: String?,
)

private data class AzureAdBrukere(val value: List<AzureAdBruker>)

@OptIn(ExperimentalSerializationApi::class)
fun Route.veileder(tokenFetcher: AzureTokenFetcher) {
    get("/veiledere") {
        val accessToken = tokenFetcher.clientCredentialsToken()
        val gruppeIder = listOf("", "")
        val veiledere = gruppeIder.map { gruppeId ->
            async {
                Json.decodeFromStream<AzureAdBrukere>("https://graph.microsoft.com/v1.0/groups/$gruppeId/members?\$select=id,givenName,surname"
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
        call.respond(veiledere)
    }
}