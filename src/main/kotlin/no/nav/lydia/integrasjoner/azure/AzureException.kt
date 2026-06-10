package no.nav.lydia.integrasjoner.azure

class AzureException(
    message: String?,
    e: Exception,
) : RuntimeException(message, e)
