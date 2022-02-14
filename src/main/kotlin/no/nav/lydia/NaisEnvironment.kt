package no.nav.lydia

import org.apache.kafka.clients.CommonClientConfigs
import org.apache.kafka.clients.consumer.ConsumerConfig
import org.apache.kafka.common.config.SaslConfigs
import org.apache.kafka.common.config.SslConfigs
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

    val truststoreLocation: String = getEnvVar("KAFKA_TRUSTSTORE_PATH"),
    val keystoreLocation: String = getEnvVar("KAFKA_KEYSTORE_PATH"),
    val credstorePassword: String = getEnvVar("KAFKA_CREDSTORE_PASSWORD"),

    val groupId: String = "lydiaApiStatistikkConsumers",
){
    companion object {
        val statistikkTopic: String = "aura.kafkarator-canary-dev-gcp"
    }
    fun consumerConfig() = mapOf(
        CommonClientConfigs.BOOTSTRAP_SERVERS_CONFIG to brokers,
        ConsumerConfig.GROUP_ID_CONFIG to groupId,
        ConsumerConfig.AUTO_OFFSET_RESET_CONFIG to "earliest",

        CommonClientConfigs.SECURITY_PROTOCOL_CONFIG to "SSL",
        SslConfigs.SSL_ENDPOINT_IDENTIFICATION_ALGORITHM_CONFIG to "",
        SslConfigs.SSL_TRUSTSTORE_TYPE_CONFIG to "JKS",
        SslConfigs.SSL_KEYSTORE_TYPE_CONFIG to "PKCS12",
        SslConfigs.SSL_TRUSTSTORE_LOCATION_CONFIG to truststoreLocation,
        SslConfigs.SSL_TRUSTSTORE_PASSWORD_CONFIG to credstorePassword,
        SslConfigs.SSL_KEYSTORE_LOCATION_CONFIG to keystoreLocation,
        SslConfigs.SSL_KEYSTORE_PASSWORD_CONFIG to credstorePassword,
        SslConfigs.SSL_KEY_PASSWORD_CONFIG to credstorePassword,
    )
}

fun getEnvVar(varName: String, defaultValue: String? = null) =
    System.getenv(varName) ?: defaultValue ?: throw RuntimeException("Missing required variable $varName")
