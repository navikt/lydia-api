package no.nav.lydia.integrasjoner.salesforce.http

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import arrow.core.right
import io.ktor.client.HttpClient
import io.ktor.client.engine.cio.CIO
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.client.request.get
import io.ktor.client.request.header
import io.ktor.client.request.parameter
import io.ktor.client.request.url
import io.ktor.client.statement.bodyAsText
import io.ktor.http.isSuccess
import io.ktor.serialization.kotlinx.json.json
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.decodeFromJsonElement
import no.nav.lydia.ia.sak.api.Feil
import org.slf4j.LoggerFactory

private const val QUERY_PATH = "/services/data/v63.0/query"

class SalesforceClient(
    private val tokenFormidler: SalesforceTokenFormidler = SalesforceTokenFormidler(),
) {
    private val logger = LoggerFactory.getLogger(SalesforceClient::class.java)
    private val httpClient = HttpClient(CIO) {
        install(ContentNegotiation) {
            json()
        }
    }

    private val json = Json {
        ignoreUnknownKeys = true
    }

    private suspend fun <T> hentFraSalesforce(
        query: String,
        mapper: (List<JsonElement>, SalesforceAccessToken) -> Either<Feil, T>,
    ): Either<Feil, T> {
        return tokenFormidler.hentGyldigToken().flatMap { token ->
            val response = httpClient.get {
                url("${token.instanceUrl}$QUERY_PATH")
                header("Accept", "application/json")
                header("Authorization", "Bearer ${token.accessToken}")
                parameter(
                    "q",
                    query,
                )
            }
            if (!response.status.isSuccess()) {
                logger.error("Feil ved uthenting av data Salesforce: ${response.status}, ${response.bodyAsText()}")
                return SalesforceFeil.`feil ved uthenting av av data fra salesforce`.left()
            }

            val queryResponseAsText = response.bodyAsText()
            val queryResponse = json.decodeFromString<SalesforceResponse>(queryResponseAsText)
            if (queryResponse.records.isEmpty()) {
                return SalesforceFeil.`fant ingen data i salesforce`.left()
            }

            return mapper(queryResponse.records, token)
        }
    }

    suspend fun hentSamarbeidslenke(samarbeidId: Int) =
        hentFraSalesforce(
            "SELECT id FROM IACooperation__c WHERE CooperationId__c = '$samarbeidId'",
        ) { records, token ->
            val salesforceSamarbeid = records.map { json.decodeFromJsonElement<IACooperation>(it) }
            if (salesforceSamarbeid.size != 1) {
                return@hentFraSalesforce SalesforceFeil.`feil ved uthenting av av data fra salesforce`.left()
            }

            SalesforceSamarbeid(
                samarbeidsId = samarbeidId,
                salesforceLenke = "${token.instanceUrl}/${salesforceSamarbeid.first().Id}",
            ).right()
        }

    suspend fun hentSalesforceInfo(orgnr: String) =
        hentFraSalesforce(
            "SELECT Id, INT_OrganizationNumber__c, TAG_Partner_Status__c FROM Account WHERE INT_OrganizationNumber__c = '$orgnr'",
        ) { records, token ->
            val salesforceAccount = records.map { json.decodeFromJsonElement<Account>(it) }
            if (salesforceAccount.size != 1) {
                return@hentFraSalesforce SalesforceFeil.`feil ved uthenting av av data fra salesforce`.left()
            }
            SalesforceInfo(
                orgnr = salesforceAccount.first().INT_OrganizationNumber__c,
                url = "${token.instanceUrl}/${salesforceAccount.first().Id}",
                partnerStatus = salesforceAccount.first().TAG_Partner_Status__c?.let { status ->
                    if (status.equals("Strategisk Partner", ignoreCase = true)) {
                        status
                    } else {
                        null
                    }
                },
            ).right()
        }
}
