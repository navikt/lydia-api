package no.nav.lydia

import org.apache.kafka.clients.CommonClientConfigs
import org.apache.kafka.clients.consumer.ConsumerConfig
import org.apache.kafka.common.config.SaslConfigs
import org.apache.kafka.common.config.SslConfigs
import java.net.URL

class NaisEnvironment(
    val database: Database = Database(),
    val security: Security = Security(),
    val kafka: Kafka = Kafka(),
    val brreg: Brreg = Brreg()
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
    val groupId: String = "lydia-api-kafka-group-id",
    val clientId: String = "lydia-api",
    val statistikkTopic: String = getEnvVar("STATISTIKK_TOPIC"),
    val consumerLoopDelay: Long = getEnvVar("CONSUMER_LOOP_DELAY").toLong()
) {
    fun consumerProperties() =
        baseConsumerProperties().apply {
            // TODO: Finn smidigere måte å få tester til å kjøre
            if (truststoreLocation.isNullOrBlank()) {
                put(CommonClientConfigs.SECURITY_PROTOCOL_CONFIG, "PLAINTEXT")
                put(SaslConfigs.SASL_MECHANISM, "PLAIN")
            } else {
                put(CommonClientConfigs.SECURITY_PROTOCOL_CONFIG, "SSL")
                put(SslConfigs.SSL_ENDPOINT_IDENTIFICATION_ALGORITHM_CONFIG, "")
                put(SslConfigs.SSL_TRUSTSTORE_TYPE_CONFIG, "JKS")
                put(SslConfigs.SSL_KEYSTORE_TYPE_CONFIG, "PKCS12")
                put(SslConfigs.SSL_TRUSTSTORE_LOCATION_CONFIG, truststoreLocation)
                put(SslConfigs.SSL_TRUSTSTORE_PASSWORD_CONFIG, credstorePassword)
                put(SslConfigs.SSL_KEYSTORE_LOCATION_CONFIG, keystoreLocation)
                put(SslConfigs.SSL_KEYSTORE_PASSWORD_CONFIG, credstorePassword)
                put(SslConfigs.SSL_KEY_PASSWORD_CONFIG, credstorePassword)
            }
        }

    fun baseConsumerProperties() =
        mapOf(
            CommonClientConfigs.BOOTSTRAP_SERVERS_CONFIG to brokers,
            ConsumerConfig.GROUP_ID_CONFIG to groupId,
            ConsumerConfig.CLIENT_ID_CONFIG to clientId,
            ConsumerConfig.AUTO_OFFSET_RESET_CONFIG to "earliest",
        ).toProperties()

}

class Brreg(val underEnhetUrl: String = getEnvVar("BRREG_UNDERENHET_URL"))

fun getEnvVar(varName: String, defaultValue: String? = null) =
    System.getenv(varName) ?: defaultValue ?: throw RuntimeException("Missing required variable $varName")
