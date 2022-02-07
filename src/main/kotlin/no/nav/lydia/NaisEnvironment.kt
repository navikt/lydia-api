package no.nav.lydia

import org.apache.kafka.clients.CommonClientConfigs
import org.apache.kafka.clients.consumer.ConsumerConfig
import org.apache.kafka.common.config.SaslConfigs
import java.net.URL

class NaisEnvironment(
    val database: Database = Database(),
    val security: Security = Security(),
    val kafka: Kafka = Kafka()
)

class Database(
    val host: String = getEnvVar("NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_HOST"),
    val port: String = getEnvVar("NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_PORT"),
    val username: String = getEnvVar("NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_USERNAME"),
    val password: String = getEnvVar("NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_PASSWORD"),
    val name: String = getEnvVar("NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_DATABASE")
)

class Security(val azureConfig: AzureConfig = AzureConfig())
    class AzureConfig(
        val audience: String = getEnvVar("AZURE_APP_CLIENT_ID"),
        val jwksUri: URL = URL(getEnvVar("AZURE_OPENID_CONFIG_JWKS_URI")),
        val issuer: String = getEnvVar("AZURE_OPENID_CONFIG_ISSUER")
    )

class Kafka(
    val brokers: String = getEnvVar("KAFKA_BROKERS"),
    val groupId: String = "lydiaApiStatistikkConsumers",
    val statistikkTopic: String = "statistikkTopic"
){
    fun consumerConfig() = mapOf(
        CommonClientConfigs.BOOTSTRAP_SERVERS_CONFIG to brokers,
        CommonClientConfigs.SECURITY_PROTOCOL_CONFIG to "PLAINTEXT",
        SaslConfigs.SASL_MECHANISM to "PLAIN",
        ConsumerConfig.GROUP_ID_CONFIG to groupId,
        ConsumerConfig.AUTO_OFFSET_RESET_CONFIG to "earliest"
    )
}

fun getEnvVar(varName: String, defaultValue: String? = null) =
    System.getenv(varName) ?: defaultValue ?: throw RuntimeException("Missing required variable $varName")
