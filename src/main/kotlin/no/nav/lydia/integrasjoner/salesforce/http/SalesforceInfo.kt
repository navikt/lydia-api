package no.nav.lydia.integrasjoner.salesforce.http

import kotlinx.serialization.Serializable

@Serializable
data class SalesforceInfo(
    val orgnr: String,
    val url: String,
    val partnerStatus: String?,
)
