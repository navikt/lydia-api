package no.nav.lydia.integrasjoner.azure

import arrow.core.Either
import arrow.core.left
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
import kotlinx.serialization.json.Json
import no.nav.lydia.AzureConfig
import no.nav.lydia.Security
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.sykefraversstatistikk.api.EierDTO
import no.nav.lydia.tilgangskontroll.innloggetNavIdent
import org.slf4j.LoggerFactory

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
    val streetAddress: String? = null,
    val department: String? = null,
)

@Serializable
data class NavEnhet(
    val enhetsnummer: String,
    val enhetsnavn: String,
)


@Serializable
data class VeilederDTO(val id: String, val navIdent: String, val fornavn: String, val etternavn: String) {
    fun tilEierDTO() = EierDTO(navIdent = navIdent, navn = fulltNavn)
    private val fulltNavn get() = "$fornavn $etternavn"
}


class AzureService(
    val tokenFetcher: AzureTokenFetcher,
    val security: Security,
) {
    private val log = LoggerFactory.getLogger(this::class.java)
    private val azureAdProps = "id,givenName,surname,onPremisesSamAccountName,streetAddress,department"
    private val deserializer = Json { ignoreUnknownKeys = true }

    fun hentNavenhet(
        objectId: String?,
    ): Either<Feil, NavEnhet> {
        val accessToken = tokenFetcher.clientCredentialsToken()
        val url = "${security.azureConfig.graphDatabaseUrl}/users/${objectId}?\$select=$azureAdProps"
        return hentFraAzure(url, accessToken)
            // -- TODO Fjern dette
            .onRight { r -> log.info(r) }
            .onLeft { l -> log.info(l.feilmelding) }
            // -- END TODO
            .map { json -> deserializer.decodeFromString<AzureAdBruker>(json) }
            .map { azureAdBruker ->
                NavEnhet(
                    enhetsnummer = azureAdBruker.streetAddress ?: "Ukjent",
                    enhetsnavn = azureAdBruker.department ?: "Ukjent",
                )
            }
    }

    fun hentNavenhetFraNavIdent(
        navIdent: String?,
    ): Either<Feil, NavEnhet> {
        val accessToken = tokenFetcher.clientCredentialsToken()
        val url = "${security.azureConfig.graphDatabaseUrl}/users?\$search=\"onPremisesSamAccountName:$navIdent\"&\$select=$azureAdProps"
        return hentFraAzure(url, accessToken)
            .map { json -> deserializer.decodeFromString<AzureResponse>(json) }
            .map { azureResponse -> azureResponse.value.firstOrNull() }
            .map { azureAdBruker ->
                NavEnhet(
                    enhetsnummer = azureAdBruker?.streetAddress ?: "Ukjent",
                    enhetsnavn = azureAdBruker?.department ?: "Ukjent",
                )
            }
    }

    suspend fun hentVeiledere(): Either<Feil, Set<VeilederDTO>> = coroutineScope {
        Either.catch {
            val accessToken = tokenFetcher.clientCredentialsToken()
            val gruppeIder = listOf(
                security.adGrupper.saksbehandlerGruppe,
                security.adGrupper.superbrukerGruppe
            )
            val veiledere = gruppeIder.map { gruppeId ->
                async {
                    hentBrukereForGruppe(security.azureConfig, gruppeId, accessToken)
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


    private fun hentBrukereForGruppe(
        azureConfig: AzureConfig,
        gruppeId: String,
        accessToken: String
    ): List<AzureAdBruker> {
        val antallVeilederePerSide = 800
        val alleRådgivere = mutableListOf<AzureAdBruker>()
        var url = "${azureConfig.graphDatabaseUrl}/groups/$gruppeId/members?\$select=$azureAdProps&\$top=$antallVeilederePerSide"

        do {
            hentFraAzure(url, accessToken)
                .map { json -> deserializer.decodeFromString<AzureResponse>(json) }
                .fold(
                    ifRight = {
                        alleRådgivere.addAll(it.value)
                        url = it.nesteSide?.replace("AZURE_GRAPH_URL", azureConfig.graphDatabaseUrl) ?: ""
                    },
                    ifLeft = {
                        log.error(it.feilmelding)
                    }
                )
        } while (url.isNotEmpty())

        return alleRådgivere
    }


    private fun hentFraAzure(
        url: String,
        accessToken: String
    ) =
        url.httpGet()
            .authentication()
            .bearer(token = accessToken)
            .header(
                HttpHeaders.Accept to "application/json", HttpHeaders.ContentType to "application/json",
                "ConsistencyLevel" to "eventual"
            )
            .response()
            .third
            .fold(success = {
                it.toString(Charsets.UTF_8).right()
            }, failure = {
                Feil(
                    feilmelding = "Feilet under henting av veiledere fra Azure: ${it.message} ${it.errorData.toString(Charsets.UTF_8)}",
                    httpStatusCode = HttpStatusCode.InternalServerError
                ).left()
            })
}

fun Route.navEnhet(azureService: AzureService) {
    get("nav-enhet") {
        val navIdent = call.innloggetNavIdent() ?: return@get call.respond(HttpStatusCode.BadRequest, "mangler nav-ident")
        azureService.hentNavenhetFraNavIdent(navIdent).map {
            call.respond(it)
        }.mapLeft {
            call.respond(it.httpStatusCode, it.feilmelding)
        }
    }
}