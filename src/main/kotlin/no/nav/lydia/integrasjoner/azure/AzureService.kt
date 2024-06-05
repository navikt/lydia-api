package no.nav.lydia.integrasjoner.azure

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.httpGet
import io.ktor.http.HttpHeaders
import io.ktor.http.HttpStatusCode
import kotlinx.coroutines.async
import kotlinx.coroutines.awaitAll
import kotlinx.coroutines.coroutineScope
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import no.nav.lydia.AzureConfig
import no.nav.lydia.Security
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.sykefraværsstatistikk.api.EierDTO
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
    val department: String? = null, // -- mest spesifikk feks "Øst-Viken Arbeidslivssenter Øvre Romerike"
    val city: String? = null, // -- minst spesifikk feks "Øst-Viken Arbeidslivssenter"
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
    private val azureAdProps = "id,givenName,surname,onPremisesSamAccountName,streetAddress,department,city"
    private val deserializer = Json { ignoreUnknownKeys = true }

    fun hentNavenhet(
        objectId: String?,
    ): Either<Feil, NavEnhet> {
        val accessToken = tokenFetcher.clientCredentialsToken()
        val url = "${security.azureConfig.graphDatabaseUrl}/users/${objectId}?\$select=$azureAdProps"
        return hentFraAzure(url, accessToken, AzureType.NAVENHET_FRA_INNLOGGET_BRUKER)
            .map { json -> deserializer.decodeFromString<AzureAdBruker>(json) }
            .map { azureAdBruker ->
                NavEnhet(
                    enhetsnummer = azureAdBruker.streetAddress ?: "Ukjent",
                    enhetsnavn = azureAdBruker.department ?: azureAdBruker.city ?: "Ukjent",
                )
            }
    }

    fun hentNavenhetFraNavIdent(
        navIdent: String?,
    ): Either<Feil, NavEnhet> {
        val accessToken = tokenFetcher.clientCredentialsToken()
        val url = "${security.azureConfig.graphDatabaseUrl}/users?\$search=\"onPremisesSamAccountName:$navIdent\"&\$select=$azureAdProps"
        return hentFraAzure(url, accessToken, AzureType.NAVENHET_FRA_NAVIDENT)
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
            hentFraAzure(url, accessToken, AzureType.BRUKERE_I_GRUPPE)
                .map { json -> deserializer.decodeFromString<AzureResponse>(json) }
                .fold(
                    ifRight = {
                        alleRådgivere.addAll(it.value)
                        url = it.nesteSide?.replace("AZURE_GRAPH_URL", azureConfig.graphDatabaseUrl) ?: ""
                    },
                    ifLeft = {
                        log.error(it.feilmelding)
                        url = ""
                    }
                )
        } while (url.isNotEmpty())

        return alleRådgivere
    }


    enum class AzureType {
        NAVENHET_FRA_INNLOGGET_BRUKER,
        NAVENHET_FRA_NAVIDENT,
        BRUKERE_I_GRUPPE
    }

    private fun hentFraAzure(
        url: String,
        accessToken: String,
        typeSpørring: AzureType,
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
                    feilmelding = "Feilet under henting fra Azure (${typeSpørring.name}): ${it.message} ${it.errorData.toString(Charsets.UTF_8)}",
                    httpStatusCode = HttpStatusCode.InternalServerError
                ).left()
            })
}
