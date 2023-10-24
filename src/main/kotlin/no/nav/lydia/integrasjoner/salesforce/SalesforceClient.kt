package no.nav.lydia.integrasjoner.salesforce

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import arrow.core.right
import io.ktor.client.HttpClient
import io.ktor.client.engine.cio.CIO
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.client.request.forms.formData
import io.ktor.client.request.get
import io.ktor.client.request.header
import io.ktor.client.request.parameter
import io.ktor.client.request.post
import io.ktor.client.request.url
import io.ktor.client.statement.bodyAsText
import io.ktor.http.HttpStatusCode
import io.ktor.http.isSuccess
import io.ktor.serialization.kotlinx.json.json
import kotlinx.datetime.Clock
import kotlinx.serialization.json.Json
import no.nav.lydia.Salesforce
import no.nav.lydia.ia.sak.api.Feil
import org.slf4j.LoggerFactory.getLogger

private const val QUERY_PATH = "/services/data/v59.0/query"
private const val TOKEN_TIMEOUT_MS = 50 * 60 * 1000 // 50 min i ms

class SalesforceClient(private val salesforce: Salesforce) {
    private val logger = getLogger(SalesforceClient::class.java)
    private var token: SalesforceAccessToken? = null
    private val httpClient = HttpClient(CIO) {
        install(ContentNegotiation) {
            json()
        }
    }

    private val json = Json {
        ignoreUnknownKeys = true
    }

    suspend fun hentSalesforceUrl(orgnr: String): Either<Feil, SalesforceUrlResponse> {
        logger.info("Henter salesforce-url for orgnr: $orgnr")

        return hentGyldigToken().flatMap { gyldigToken ->
            logger.info(gyldigToken.toString())
            val response = httpClient.get {
                url("${gyldigToken.instanceUrl}$QUERY_PATH")
                header("Accept", "application/json")
                header("Authorization", "Bearer ${gyldigToken.accessToken}")
                parameter("q", "SELECT Id FROM Account WHERE INT_OrganizationNumber__c = '$orgnr'")
            }

            if (!response.status.isSuccess()) {
                logger.error(response.toString())
                logger.error("Feil ved henting av salesforce account id: ${response.status}")
                logger.error("Feil ved henting av salesforce account id: ${response.bodyAsText()}")
                SalesforceFeil.`feil ved uthenting av av data fra salesforce`.left()
            }

            val queryResponseAsText = response.bodyAsText()
            logger.info(queryResponseAsText)
            val queryResponse = json.decodeFromString<SalesforceQueryResponse>(queryResponseAsText)
            logger.info(queryResponse.toString())
            if (queryResponse.records.isEmpty()) {
                logger.error("Fant ikke account id for orgnr: $orgnr")
                SalesforceFeil.`fant ikke salesforce account for orgnummer`.left()
            }

            SalesforceUrlResponse(
                orgnr = orgnr,
                url = "${gyldigToken.instanceUrl}/${queryResponse.records.first().Id}"
            ).right()
        }
    }

    private suspend fun hentGyldigToken() =
        if (måOppdatereToken(token)) {
            logger.info("Oppdaterer token")
            getToken().onRight { token = it }
        } else {
            token!!.right()
        }

    private suspend fun getToken(): Either<Feil, SalesforceAccessToken> {
        val tokenUrl = "${salesforce.tokenHost}/services/oauth2/token"
        val response = httpClient.post {
            url(tokenUrl)
            header("Content-Type", "application/x-www-form-urlencoded")
            formData {
                append("grant_type", "password")
                append("client_id", salesforce.clientId)
                append("client_secret", salesforce.clientSecret)
                append("username", salesforce.username)
                append("password", salesforce.password)
            }
        }

        if (!response.status.isSuccess()) {
            logger.error("Feil ved henting av token mot url $tokenUrl: status: ${response.status} responsebody: ${response.bodyAsText()}")
            return SalesforceFeil.`feil ved uthenting av token`.left()
        }

        return mapToken(response.bodyAsText())
    }

    private fun mapToken(tokenJson: String) =
        Either.catch {
            Json.decodeFromString<SalesforceAccessToken>(tokenJson)
        }.mapLeft {
            logger.error("Klarte ikke deserialisere token: $tokenJson", it)
            SalesforceFeil.`feil ved parsing av token`
        }

    private fun måOppdatereToken(token: SalesforceAccessToken?) =
        token?.let {
            val nå = Clock.System.now().toEpochMilliseconds()
            (nå > token.issuedAt + TOKEN_TIMEOUT_MS)
        } ?: true
}

object SalesforceFeil {
    val `feil ved uthenting av token` =
        Feil("Feil ved uthenting av token", httpStatusCode = HttpStatusCode.InternalServerError)
    val `feil ved parsing av token` =
        Feil("Feil ved parsing av token", httpStatusCode = HttpStatusCode.InternalServerError)
    val `feil ved uthenting av av data fra salesforce` =
        Feil("Feil ved uthenting av av data fra salesforce", httpStatusCode = HttpStatusCode.InternalServerError)
    val `fant ikke salesforce account for orgnummer` =
        Feil("Fant ikke salesforce account for orgnummer", httpStatusCode = HttpStatusCode.NotFound)
}