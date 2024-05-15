package no.nav.lydia.integrasjoner.salesforce

import kotlinx.serialization.Serializable

@Serializable
data class SalesforceQueryResponse(
    val totalSize: Int,
    val done: Boolean,
    val records: List<Account>
)

@Serializable
data class Account(
    val Id: String,
    val INT_OrganizationNumber__c: String,
    val TAG_Partner_Status__c: String?
)
