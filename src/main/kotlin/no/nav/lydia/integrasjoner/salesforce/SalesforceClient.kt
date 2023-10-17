package no.nav.lydia.integrasjoner.salesforce

import arrow.core.Either
import arrow.core.getOrElse
import arrow.core.left
import arrow.core.right
import com.github.kittinunf.fuel.core.Request
import com.github.kittinunf.fuel.httpGet
import com.github.kittinunf.fuel.httpPost
import com.google.gson.GsonBuilder
import io.ktor.http.HttpStatusCode
import no.nav.lydia.NaisEnvironment
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.virksomhet.domene.Virksomhet
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.io.IOException
import java.util.*

class SalesforceClient(private val naisEnvironment: NaisEnvironment) {
    private val log: Logger = LoggerFactory.getLogger(this.javaClass)
    private var tokenTimeout = 3600000 // One hour
    private var token: SalesforceAccessToken? = null

    fun hentUrlTilSalesforce(virksomhet: Virksomhet): String? {
        return try {
            querySalesforce("SELECT Id FROM Account WHERE INT_OrganizationNumber__c = ${virksomhet.orgnr}").getOrNull()
        } catch (e: IOException) {
            log.warn(e.message, e)
            return null
        }
    }

    private fun getToken(): Either<Feil, SalesforceAccessToken> {
        val endpointUri = naisEnvironment.integrasjoner.salesforce.tokenUrl
        log.info("Making request to: $endpointUri")
        val parameters = listOf(
            "grant_type" to "password",
            "client_id" to naisEnvironment.integrasjoner.salesforce.clientId,
            "client_secret" to naisEnvironment.integrasjoner.salesforce.clientSecret,
            "username" to naisEnvironment.integrasjoner.salesforce.username,
            "password" to naisEnvironment.integrasjoner.salesforce.password + naisEnvironment.integrasjoner.salesforce.usertoken,
        )
        return sendTokenRequest(endpointUri, parameters)
    }

    private fun sendTokenRequest(endpointUri: String, parameters: List<Pair<String, String>>) =
        endpointUri.httpPost(parameters = parameters)
            .header("Content-Type", "application/x-www-form-urlencoded")
            .response()
            .third
            .fold(
            success = { bytes ->
                val gson = GsonBuilder().serializeNulls().create()

                try {
                    gson.fromJson(bytes.toString(Charsets.UTF_8), SalesforceAccessToken::class.java).right()
                } catch (e: Exception) {
                    Feil(
                        feilmelding = "Noe gikk galt under nedlasting av salesforce url: ${e.message}",
                        httpStatusCode = HttpStatusCode.InternalServerError
                    ).left()

                }
            },
            failure = {
                Feil(
                    feilmelding = "Noe gikk galt under nedlasting av salesforce url: ${it.message} ${it.errorData.toString(Charsets.UTF_8)}",
                    httpStatusCode = HttpStatusCode.InternalServerError
                ).left()
            })

    private fun getCachedToken(): SalesforceAccessToken {
        if (token == null || tokenIsOld(token!!)) {
            token = getToken().getOrElse {
                log.warn(it.feilmelding, it)
                throw IOException(it.feilmelding) }

        }
        return token ?: throw IOException("No valid Salesforce authentication found!")
    }

    private fun tokenIsOld(token: SalesforceAccessToken): Boolean {
        val currentTime: Long = Calendar.getInstance().timeInMillis
        return (currentTime > token.issuedAt + tokenTimeout)
    }

    private fun createAuthorizedRequest(endpointPath: String): Request {
        val token = getCachedToken()
        val endpointUri = token.instanceUrl.toString() + endpointPath
        log.info("Making request: $endpointUri")
        return endpointUri.httpGet()
            .header("Authorization", token.tokenType + " " + token.accessToken)
            .header("Content-Type", "application/json;charset=UTF-8")
    }

    // curl https://yourInstance.salesforce.com/services/data/v20.0/query/?q=SELECT+name+from+Account -H "Authorization: Bearer token"
    private fun querySalesforce(sosql: String): Either<Feil, String> {
        val request = createAuthorizedRequest(naisEnvironment.integrasjoner.salesforce.queryUrl + "?q=$sosql")
        return request.response()
            .third
            .fold(success = {
                it.toString(Charsets.UTF_8).right()
            }, failure = {
                Feil(
                    feilmelding = "Feilet under spørring mot Salesforce: ${it.message} ${it.errorData.toString(Charsets.UTF_8)}",
                    httpStatusCode = HttpStatusCode.InternalServerError
                ).left()
            })
    }
}
