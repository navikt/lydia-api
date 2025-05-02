package no.nav.lydia.integrasjoner.salesforce.http

import kotlinx.serialization.ExperimentalSerializationApi
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonNames

@OptIn(ExperimentalSerializationApi::class)
@Serializable
data class SalesforceAccessToken(
    @JsonNames("access_token")
    val accessToken: String,
    @JsonNames("instance_url")
    val instanceUrl: String,
    val id: String,
    @JsonNames("token_type")
    val tokenType: String,
    @JsonNames("issued_at")
    val issuedAt: Long,
    val signature: String,
)
