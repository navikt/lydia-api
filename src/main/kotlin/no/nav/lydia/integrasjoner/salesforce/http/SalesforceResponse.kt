package no.nav.lydia.integrasjoner.salesforce.http

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonElement

@Serializable
data class SalesforceResponse(
    val totalSize: Int,
    val done: Boolean,
    val records: List<JsonElement>,
)
