package no.nav.lydia

class NaisEnvironment() {
    val database = Database()
}

class Database {
    val jdbcUrl: String
    val username: String
    val password: String
    val name: String

    init {
        val nais_db_prefix = "NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_"
        name = getEnvVar("${nais_db_prefix}DATABASE")
        username = getEnvVar("${nais_db_prefix}USERNAME")
        password = getEnvVar("${nais_db_prefix}PASSWORD")
        jdbcUrl = getEnvVar("${nais_db_prefix}URL")
    }
}

fun getEnvVar(varName: String, defaultValue: String? = null) =
    System.getenv(varName) ?: defaultValue ?: throw RuntimeException("Missing required variable $varName")
