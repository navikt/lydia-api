package no.nav.lydia

import org.apache.kafka.clients.CommonClientConfigs
import org.apache.kafka.clients.consumer.ConsumerConfig
import org.apache.kafka.clients.producer.ProducerConfig
import org.apache.kafka.common.config.SaslConfigs
import org.apache.kafka.common.config.SslConfigs
import org.apache.kafka.common.serialization.StringSerializer
import java.net.URL

class NaisEnvironment(
    val database: Database = Database(),
    val security: Security = Security(),
    val kafka: Kafka = Kafka(),
    val integrasjoner: Integrasjoner = Integrasjoner(),
    cluster: String = getEnvVar("NAIS_CLUSTER_NAME")
) {
    companion object {
        enum class Environment {
            PROD_GCP, DEV_GCP, LOKALT
        }
    }

    val miljø = when (cluster) {
        "prod-gcp" -> Environment.PROD_GCP
        "dev-gcp" -> Environment.DEV_GCP
        "lokal" -> Environment.LOKALT
        else -> throw IllegalStateException("Ukjent miljø")
    }
}

class Database(
    val host: String = getEnvVar("NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_HOST"),
    val port: String = getEnvVar("NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_PORT"),
    val username: String = getEnvVar("NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_USERNAME"),
    val password: String = getEnvVar("NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_PASSWORD"),
    val name: String = getEnvVar("NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_DATABASE")
)

class Security(
    val azureConfig: AzureConfig = AzureConfig(),
    val fiaRoller: FiaRoller = FiaRoller()
) {
    companion object {
        const val NAV_IDENT_CLAIM = "NAVident"
        const val GROUPS_CLAIM = "groups"
    }
}

class AzureConfig(
    val audience: String = getEnvVar("AZURE_APP_CLIENT_ID"),
    val jwksUri: URL = URL(getEnvVar("AZURE_OPENID_CONFIG_JWKS_URI")),
    val issuer: String = getEnvVar("AZURE_OPENID_CONFIG_ISSUER")
)

class FiaRoller(
    val superbrukerGroupId: String = getEnvVar("FIA_SUPERBRUKER_GROUP_ID"),
    val saksbehandlerGroupId: String = getEnvVar("FIA_SAKSBEHANDLER_GROUP_ID"),
    val lesetilgangGroupId: String = getEnvVar("FIA_LESETILGANG_GROUP_ID"),
    val teamPiaGroupId: String = getEnvVar("TEAM_PIA_GROUP_ID")
)

class Kafka(
    val brokers: String = getEnvVar("KAFKA_BROKERS"),
    val truststoreLocation: String = getEnvVar("KAFKA_TRUSTSTORE_PATH"),
    val keystoreLocation: String = getEnvVar("KAFKA_KEYSTORE_PATH"),
    val credstorePassword: String = getEnvVar("KAFKA_CREDSTORE_PASSWORD"),
    val iaSakHendelseTopic: String = getEnvVar("IA_SAK_HENDELSE_TOPIC"),
    val statistikkTopic: String = getEnvVar("STATISTIKK_TOPIC"),
    val consumerLoopDelay: Long = getEnvVar("CONSUMER_LOOP_DELAY").toLong()
) {
    companion object {
        const val groupId: String = "lydia-api-kafka-group-id"
        const val clientId: String = "lydia-api"
    }

    fun producerProperties(): Map<String, Any> {
        val producerConfigs = mutableMapOf(
            ProducerConfig.BOOTSTRAP_SERVERS_CONFIG to brokers,
            ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG to StringSerializer::class.java,
            ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG to StringSerializer::class.java,
            ProducerConfig.ENABLE_IDEMPOTENCE_CONFIG to true, // Den sikrer rekkefølge
            ProducerConfig.ACKS_CONFIG to "all", // Den sikrer at data ikke mistes
            ProducerConfig.CLIENT_ID_CONFIG to clientId
        )
        if (truststoreLocation.isNotEmpty()) {
            producerConfigs + securityConfigs()
        }
        return producerConfigs.toMap()
    }

    fun securityConfigs() =
        mapOf(
            CommonClientConfigs.SECURITY_PROTOCOL_CONFIG to "SSL",
            SslConfigs.SSL_ENDPOINT_IDENTIFICATION_ALGORITHM_CONFIG to "",
            SslConfigs.SSL_TRUSTSTORE_TYPE_CONFIG to "JKS",
            SslConfigs.SSL_KEYSTORE_TYPE_CONFIG to "PKCS12",
            SslConfigs.SSL_TRUSTSTORE_LOCATION_CONFIG to truststoreLocation,
            SslConfigs.SSL_TRUSTSTORE_PASSWORD_CONFIG to credstorePassword,
            SslConfigs.SSL_KEYSTORE_LOCATION_CONFIG to keystoreLocation,
            SslConfigs.SSL_KEYSTORE_PASSWORD_CONFIG to credstorePassword,
            SslConfigs.SSL_KEY_PASSWORD_CONFIG to credstorePassword
        )

    fun consumerProperties() =
        baseConsumerProperties().apply {
            // TODO: Finn smidigere måte å få tester til å kjøre
            if (truststoreLocation.isBlank()) {
                put(CommonClientConfigs.SECURITY_PROTOCOL_CONFIG, "PLAINTEXT")
                put(SaslConfigs.SASL_MECHANISM, "PLAIN")
            } else {
                putAll(securityConfigs())
            }
        }

    fun baseConsumerProperties() =
        mapOf(
            CommonClientConfigs.BOOTSTRAP_SERVERS_CONFIG to brokers,
            ConsumerConfig.GROUP_ID_CONFIG to groupId,
            ConsumerConfig.CLIENT_ID_CONFIG to clientId,
            ConsumerConfig.AUTO_OFFSET_RESET_CONFIG to "earliest",
            ConsumerConfig.MAX_POLL_RECORDS_CONFIG to "1000"
        ).toProperties()

}

class Integrasjoner(
    val brregUnderEnhetUrl: String = getEnvVar("BRREG_UNDERENHET_URL"),
    val ssbNæringsUrl: String = getEnvVar("SSB_NARINGS_URL")
)

fun getEnvVar(varName: String, defaultValue: String? = null) =
    System.getenv(varName) ?: defaultValue ?: throw RuntimeException("Missing required variable $varName")
