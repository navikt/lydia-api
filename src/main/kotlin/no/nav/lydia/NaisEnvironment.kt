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
    val database = Database(naisCluster)

    }

    class Database(naisCluster: NaisCluster) {
        private val host: String
        private val port: String
        val username: String
        val password: String
        val name: String
        val jdbcUrl: String

        init {
            val nais_db_prefix = "NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_"
            when (naisCluster) {
                NaisCluster.DEV, NaisCluster.PROD -> {
                    host = getEnvVar("${nais_db_prefix}HOST")
                    port = getEnvVar("${nais_db_prefix}PORT")
                    name = getEnvVar("${nais_db_prefix}DATABASE")
                    username = getEnvVar("${nais_db_prefix}USERNAME")
                    password = getEnvVar("${nais_db_prefix}PASSWORD")
                }
                NaisCluster.LOCAL -> {
                    host = getEnvVar(varName = "${nais_db_prefix}HOST", defaultValue = "localhost")
                    port = "5432"
                    name =  getEnvVar(varName = "POSTGRES_DB") // Hentes fra PostgreSQLContainer
                    username = getEnvVar(varName = "POSTGRES_USER")
                    password = getEnvVar(varName = "POSTGRES_PASSWORD")
                }
            }
            jdbcUrl = String.format("jdbc:postgresql://%s:%s/%s", host, port, name)
        }
    }

fun getEnvVar(varName: String, defaultValue: String? = null) =
    System.getenv(varName) ?: defaultValue ?: throw RuntimeException("Missing required variable $varName")
