package no.nav.lydia.integrasjoner.salesforce.http

import kotlinx.serialization.Serializable

@Serializable
data class SalesforceSamarbeid(
    val samarbeidsId: Int,
    val salesforceLenke: String,
)
