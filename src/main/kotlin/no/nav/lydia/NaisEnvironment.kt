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
            `PROD-GCP`, `DEV-GCP`, LOKAL
        }

        fun hentMiljø(cluster: String) =
            Environment.entries.find { it.name.lowercase() == cluster } ?: throw IllegalStateException("Ukjent miljø $cluster")
    }

    val miljø = hentMiljø(cluster)
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
    val adGrupper: ADGrupper = ADGrupper()
) {
    companion object {
        const val NAV_IDENT_CLAIM = "NAVident"
        const val GROUPS_CLAIM = "groups"
        const val NAME_CLAIM = "name"
        const val OBJECT_ID_CLAIM = "oid"
    }
}

class AzureConfig(
    val clientId: String = getEnvVar("AZURE_APP_CLIENT_ID"),
    val jwksUri: URL = URL(getEnvVar("AZURE_OPENID_CONFIG_JWKS_URI")),
    val issuer: String = getEnvVar("AZURE_OPENID_CONFIG_ISSUER"),
    val tokenEndpoint: String = getEnvVar("AZURE_OPENID_CONFIG_TOKEN_ENDPOINT"),
    val privateJwk: String = getEnvVar("AZURE_APP_JWK"),
    val graphDatabaseUrl: String = getEnvVar("AZURE_GRAPH_URL", "https://graph.microsoft.com/beta")
) {


    override fun toString() =
        "AzureConfig(audience='$clientId', jwksUri=$jwksUri, issuer='$issuer', tokenEndpoint='$tokenEndpoint')"
}

class ADGrupper(
    val superbrukerGruppe: String = getEnvVar("FIA_SUPERBRUKER_GROUP_ID"),
    val saksbehandlerGruppe: String = getEnvVar("FIA_SAKSBEHANDLER_GROUP_ID"),
    val lesebrukerGruppe: String = getEnvVar("FIA_LESETILGANG_GROUP_ID"),
)

class Kafka(
    val brokers: String = getEnvVar("KAFKA_BROKERS"),
    val truststoreLocation: String = getEnvVar("KAFKA_TRUSTSTORE_PATH"),
    val keystoreLocation: String = getEnvVar("KAFKA_KEYSTORE_PATH"),
    val credstorePassword: String = getEnvVar("KAFKA_CREDSTORE_PASSWORD"),
    val iaSakTopic: String = getEnvVar("IA_SAK_TOPIC"),
    val iaSakStatistikkTopic: String = getEnvVar("IA_SAK_STATISTIKK_TOPIC"),
    val iaSakStatusTopic: String = getEnvVar("IA_SAK_STATUS_TOPIC"),
    val iaSakLeveranseTopic: String = getEnvVar("IA_SAK_LEVERANSE_TOPIC"),
    val iaSakKartleggingTopic: String = getEnvVar("IA_SAK_KARTLEGGING_TOPIC"),
    val brregOppdateringTopic: String = getEnvVar("BRREG_OPPDATERING_TOPIC"),
    val brregAlleVirksomheterTopic: String = getEnvVar("BRREG_ALLE_VIRKSOMHETER_TOPIC"),
    val statistikkMetadataVirksomhetTopic: String = getEnvVar("STATISTIKK_METADATA_VIRKSOMHET_TOPIC"),
    val statistikkLandTopic: String = getEnvVar("STATISTIKK_LAND_TOPIC"),
    val statistikkSektorTopic: String = getEnvVar("STATISTIKK_SEKTOR_TOPIC"),
    val statistikkBransjeTopic: String = getEnvVar("STATISTIKK_BRANSJE_TOPIC"),
    val statistikkNæringTopic: String = getEnvVar("STATISTIKK_NARING_TOPIC"),
    val statistikkNæringskodeTopic: String = getEnvVar("STATISTIKK_NARINGSKODE_TOPIC"),
    val statistikkVirksomhetTopic: String = getEnvVar("STATISTIKK_VIRKSOMHET_TOPIC"),
    val statistikkVirksomhetGraderingTopic: String = getEnvVar("STATISTIKK_VIRKSOMHET_GRADERING_TOPIC"),
    val jobblytterTopic: String = getEnvVar("JOBBLYTTER_TOPIC"),
    val consumerLoopDelay: Long = getEnvVar("CONSUMER_LOOP_DELAY").toLong()
) {
    companion object {
        const val statistikkLandGroupId = "lydia-api-statistikk-land-consumer"
        const val statistikkSektorGroupId = "lydia-api-statistikk-sektor-consumer"
        const val statistikkBransjeGroupId = "lydia-api-statistikk-bransje-consumer"
        const val statistikkNæringGroupId = "lydia-api-statistikk-naring-consumer"
        const val statistikkNæringskodeGroupId = "lydia-api-statistikk-naringskode-consumer"
        const val statistikkVirksomhetGroupId = "lydia-api-statistikk-virksomhet-consumer"
        const val statistikkVirksomhetGraderingGroupId = "lydia-api-statistikk-virksomhet-gradering-consumer"
        const val statistikkMetadataVirksomhetGroupId = "lydia-api-statistikk-metadata-virksomhet-consumer"
        const val brregConsumerGroupId = "lydia-api-brreg-oppdatering-consumer"
        const val jobblytterConsumerGroupId = "lydia-api-jobblytter-consumer"
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
            producerConfigs.putAll(securityConfigs())
        }
        return producerConfigs.toMap()
    }

    private fun securityConfigs() =
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

    fun consumerProperties(consumerGroupId: String) =
        baseConsumerProperties(consumerGroupId).apply {
            // TODO: Finn smidigere måte å få tester til å kjøre
            if (truststoreLocation.isBlank()) {
                put(CommonClientConfigs.SECURITY_PROTOCOL_CONFIG, "PLAINTEXT")
                put(SaslConfigs.SASL_MECHANISM, "PLAIN")
            } else {
                putAll(securityConfigs())
            }
        }

    private fun baseConsumerProperties(consumerGroupId: String) =
        mapOf(
            CommonClientConfigs.BOOTSTRAP_SERVERS_CONFIG to brokers,
            ConsumerConfig.GROUP_ID_CONFIG to consumerGroupId,
            ConsumerConfig.CLIENT_ID_CONFIG to clientId,
            ConsumerConfig.AUTO_OFFSET_RESET_CONFIG to "earliest",
            ConsumerConfig.MAX_POLL_RECORDS_CONFIG to "1000",
            ConsumerConfig.ENABLE_AUTO_COMMIT_CONFIG to "false"
        ).toProperties()

}

class Salesforce (
    val tokenHost: String = getEnvVar("SALESFORCE_TOKEN_HOST"),
    val clientId: String = getEnvVar("SALESFORCE_CLIENT_ID"),
    val clientSecret: String = getEnvVar("SALESFORCE_CLIENT_SECRET"),
    val username: String = getEnvVar("SALESFORCE_USERNAME"),
    val password: String = getEnvVar("SALESFORCE_PASSWORD"),
    val securityToken: String = getEnvVar("SALESFORCE_SECURITY_TOKEN"),
)

class Integrasjoner(
    val ssbNæringsUrl: String = getEnvVar("SSB_NARINGS_URL"),
    val salesforce: Salesforce = Salesforce(),
)

fun getEnvVar(varName: String, defaultValue: String? = null) =
    System.getenv(varName) ?: defaultValue ?: throw RuntimeException("Missing required variable $varName")
