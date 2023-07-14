package no.nav.lydia.integrasjoner.salesforce

import java.net.URI

data class SalesforceAccessToken(
    val accessToken: String,
    val instanceUrl: URI,
    val id: URI,
    val tokenType: String,
    val issuedAt: Long,
    val signature: String
)
