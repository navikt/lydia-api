package no.nav.lydia.veileder

import arrow.core.Either
import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.httpGet
import io.ktor.http.HttpHeaders
import io.ktor.http.HttpStatusCode
import io.ktor.server.application.call
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.get
import kotlinx.coroutines.async
import kotlinx.coroutines.awaitAll
import kotlinx.serialization.Serializable
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json
import no.nav.lydia.NaisEnvironment
import no.nav.lydia.exceptions.AzureException
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.integrasjoner.azure.AzureTokenFetcher
import no.nav.lydia.tilgangskontroll.Rådgiver.Companion.somSuperbruker

@Serializable
data class AzureAdBruker(
    val id: String,
    val onPremisesSamAccountName: String? = null,
    val givenName: String? = null,
    val surname: String? = null,
)

@Serializable
data class Veileder(val id: String, val navIdent: String, val fornavn: String, val etternavn: String)

@Serializable
data class AzureAdBrukere(val value: List<AzureAdBruker>)

private val deserializer = Json { ignoreUnknownKeys = true }

const val VEILEDERE_PATH = "/veiledere"

fun Route.veileder(naisEnvironment: NaisEnvironment, tokenFetcher: AzureTokenFetcher) {
    get(VEILEDERE_PATH) {
        somSuperbruker(call = call, fiaRoller = naisEnvironment.security.fiaRoller) {
            Either.catch {
                val accessToken = tokenFetcher.clientCredentialsToken()
                val gruppeIder = listOf(
                    naisEnvironment.security.fiaRoller.saksbehandlerGroupId,
                    naisEnvironment.security.fiaRoller.superbrukerGroupId
                )
                val veiledere = gruppeIder.map { gruppeId ->
                    async {
                        val json = hentVeiledereFraAzure(naisEnvironment, gruppeId, accessToken)
                        deserializer.decodeFromString<AzureAdBrukere>(json).value
                    }
                }.awaitAll()
                    .flatten()
                    .map {
                        Veileder(
                            id = it.id,
                            fornavn = it.givenName ?: "",
                            etternavn = it.surname ?: "",
                            navIdent = it.onPremisesSamAccountName ?: ""
                        )
                    }
                    .toSet()
                veiledere
            }.mapLeft { Feil(it.message ?: "Ukjent feil under henting av veiledere", HttpStatusCode.InternalServerError) }
        }.fold(ifLeft = {
            call.respond(it.httpStatusCode, it.feilmelding)
        },  ifRight = {
            call.respond(it)
        })
    }
}

private fun hentVeiledereFraAzure(
    naisEnvironment: NaisEnvironment,
    gruppeId: String,
    accessToken: String
) = "${naisEnvironment.security.azureConfig.graphDatabaseUrl}/groups/$gruppeId/members?\$select=id,givenName,surname,onPremisesSamAccountName"
    .httpGet()
    .authentication()
    .bearer(token = accessToken)
    .header(HttpHeaders.Accept to "application/json", HttpHeaders.ContentType to "application/json")
    .response()
    .third
    .fold(success = {
        it.toString(Charsets.UTF_8)
    }, failure = {
        throw AzureException("Feilet under henting av veiledere fra Azure: ${it.message} ${it.errorData.toString(Charsets.UTF_8)}", it)
    })
