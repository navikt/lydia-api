package no.nav.lydia

import java.net.URL

class NaisEnvironment() {
    val database = Database()
    val security = Security()
}

class Database {
    val host: String
    val port: String
    val username: String
    val password: String
    val name: String

    init {
        val naisDbPrefix = "NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_"
        host = getEnvVar("${naisDbPrefix}HOST")
        port = getEnvVar("${naisDbPrefix}PORT")
        name = getEnvVar("${naisDbPrefix}DATABASE")
        username = getEnvVar("${naisDbPrefix}USERNAME")
        password = getEnvVar("${naisDbPrefix}PASSWORD")
    }
}

class Security {
    class AzureConfig {
        val audience: String = getEnvVar("AZURE_APP_CLIENT_ID")
        val jwksUri: URL = URL(getEnvVar("AZURE_OPENID_CONFIG_JWKS_URI"))
        val issuer: String = getEnvVar("AZURE_OPENID_CONFIG_ISSUER")
    }

    val azureConfig = AzureConfig()
}

fun getEnvVar(varName: String, defaultValue: String? = null) =
    System.getenv(varName) ?: defaultValue ?: throw RuntimeException("Missing required variable $varName")
