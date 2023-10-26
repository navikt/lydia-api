package no.nav.lydia.integrasjoner.salesforce

import kotlinx.serialization.Serializable


@Serializable
data class SalesforceUrlResponse(val orgnr: String, val url: String)
