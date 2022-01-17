package no.nav.lydia

enum class NaisCluster(val value: String) {
    DEV("dev-fss"),
    PROD("prod-fss"),
    LOCAL("local");

    override fun toString() = value

    companion object {
        fun fromString(value: String) =
            when (value) {
                "dev-fss" -> DEV
                "prod-fss" -> PROD
                "local" -> LOCAL
                else -> throw IllegalArgumentException()
            }
    }
}

class NaisEnvironment(val naisCluster: NaisCluster) {
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
