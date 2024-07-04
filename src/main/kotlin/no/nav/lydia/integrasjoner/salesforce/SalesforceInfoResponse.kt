package no.nav.lydia.integrasjoner.salesforce

import kotlinx.serialization.Serializable


@Serializable
data class SalesforceInfoResponse(
    val orgnr: String,
    val url: String,
    val partnerStatus: String?
)
