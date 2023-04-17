package no.nav.lydia.veileder

import arrow.core.Either
import arrow.core.getOrElse
import arrow.core.right
import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.httpGet
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import kotlinx.coroutines.async
import kotlinx.coroutines.awaitAll
import kotlinx.coroutines.coroutineScope
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json
import no.nav.lydia.AzureConfig
import no.nav.lydia.NaisEnvironment
import no.nav.lydia.Security
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.integrasjoner.azure.AzureTokenFetcher
import no.nav.lydia.sykefraversstatistikk.api.EierDTO
import no.nav.lydia.tilgangskontroll.Rådgiver.Companion.somSuperbruker
import java.io.IOException

@Serializable
private data class AzureResponse(
    @SerialName("@odata.nextLink")
    val nesteSide: String? = null,
    val value: List<AzureAdBruker>
)

@Serializable
private data class AzureAdBruker(
    val id: String,
    val onPremisesSamAccountName: String? = null,
    val givenName: String? = null,
    val surname: String? = null,
)

private val deserializer = Json { ignoreUnknownKeys = true }

const val VEILEDERE_PATH = "/veiledere"

@Serializable
data class VeilederDTO(val id: String, val navIdent: String, val fornavn: String, val etternavn: String) {
    fun tilEierDTO() = EierDTO(navIdent = navIdent, navn = fulltNavn)
    private val fulltNavn get() = "$fornavn $etternavn"
}

fun Route.veileder(naisEnvironment: NaisEnvironment, tokenFetcher: AzureTokenFetcher) {
    get(VEILEDERE_PATH) {
        somSuperbruker(call = call, fiaRoller = naisEnvironment.security.fiaRoller) {
            hentVeiledere(tokenFetcher = tokenFetcher, security = naisEnvironment.security)
        }.fold(ifLeft = {
            call.respond(it.httpStatusCode, it.feilmelding)
        }, ifRight = {
            call.respond(it)
        })
    }
}

suspend fun hentVeiledere(
    tokenFetcher: AzureTokenFetcher,
    security: Security
): Either<Feil, Set<VeilederDTO>> = coroutineScope {
    Either.catch {
        val accessToken = tokenFetcher.clientCredentialsToken()
        val gruppeIder = listOf(
            security.fiaRoller.saksbehandlerGroupId,
            security.fiaRoller.superbrukerGroupId
        )
        val veiledere = gruppeIder.map { gruppeId ->
            async {
                hentVeiledereFraAzure(security.azureConfig, gruppeId, accessToken)
            }
        }.awaitAll()
        .flatMap { list ->
            list.map {
                VeilederDTO(
                    id = it.id,
                    fornavn = it.givenName ?: "",
                    etternavn = it.surname ?: "",
                    navIdent = it.onPremisesSamAccountName ?: ""
                )
            }
        }.toSet()

        veiledere
    }.mapLeft { Feil(it.message ?: "Ukjent feil under henting av veiledere", HttpStatusCode.InternalServerError) }
}

val antallVeilederePerSide = 800

private fun hentVeiledereFraAzure(
    azureConfig: AzureConfig,
    gruppeId: String,
    accessToken: String
): List<AzureAdBruker> {
    val alleRådgivere = mutableListOf<AzureAdBruker>()
    var url = "${azureConfig.graphDatabaseUrl}/groups/$gruppeId/members?\$select=id,givenName,surname,onPremisesSamAccountName&\$top=$antallVeilederePerSide"

    do {
        val response = hentEnSideFraAzure(url, accessToken).map { json -> deserializer.decodeFromString<AzureResponse>(json) }
        alleRådgivere.addAll(response.map { it.value }.getOrElse { emptyList() })
        url = response.map { it.nesteSide }.getOrElse { "" } ?: ""
    } while (url.isNotEmpty())

    return alleRådgivere
}

private fun hentEnSideFraAzure(
    url: String,
    accessToken: String
) =
    url.httpGet()
        .authentication()
        .bearer(token = accessToken)
        .header(HttpHeaders.Accept to "application/json", HttpHeaders.ContentType to "application/json")
        .response()
        .third
        .fold(success = {
            it.toString(Charsets.UTF_8).right()
        }, failure = {
            throw IOException("Feilet under henting av veiledere fra Azure: ${it.message} ${it.errorData.toString(Charsets.UTF_8)}")
        })