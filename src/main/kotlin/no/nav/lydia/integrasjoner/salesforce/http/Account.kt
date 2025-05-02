package no.nav.lydia.integrasjoner.salesforce.http

import kotlinx.serialization.Serializable

@Serializable
data class Account(
    val Id: String,
    val INT_OrganizationNumber__c: String,
    val TAG_Partner_Status__c: String?,
)
