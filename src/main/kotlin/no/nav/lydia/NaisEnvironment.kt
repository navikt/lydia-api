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
    cluster: String = getEnvVar("NAIS_CLUSTER_NAME"),
) {
    companion object {
        enum class Environment {
            `PROD-GCP`,
            `DEV-GCP`,
            LOKAL,
        }

        fun hentMiljø(cluster: String) =
            Environment.entries.find { it.name.lowercase() == cluster }
                ?: throw IllegalStateException("Ukjent miljø $cluster")
    }

    val miljø = hentMiljø(cluster)
}

class Database(
    val host: String = getEnvVar("NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_HOST"),
    val port: String = getEnvVar("NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_PORT"),
    val username: String = getEnvVar("NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_USERNAME"),
    val password: String = getEnvVar("NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_PASSWORD"),
    val name: String = getEnvVar("NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_DATABASE"),
)

class Security(
    val azureConfig: AzureConfig = AzureConfig(),
    val adGrupper: ADGrupper = ADGrupper(),
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
    val clientSecret: String = getEnvVar("AZURE_APP_CLIENT_SECRET"),
    val jwksUri: URL = URL(getEnvVar("AZURE_OPENID_CONFIG_JWKS_URI")),
    val issuer: String = getEnvVar("AZURE_OPENID_CONFIG_ISSUER"),
    val tokenEndpoint: String = getEnvVar("AZURE_OPENID_CONFIG_TOKEN_ENDPOINT"),
    val privateJwk: String = getEnvVar("AZURE_APP_JWK"),
    val graphDatabaseUrl: String = getEnvVar("AZURE_GRAPH_URL", "https://graph.microsoft.com/beta"),
) {
    override fun toString() = "AzureConfig(audience='$clientId', jwksUri=$jwksUri, issuer='$issuer', tokenEndpoint='$tokenEndpoint')"
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
    val consumerLoopDelay: Long = getEnvVar("CONSUMER_LOOP_DELAY").toLong(),
) {
    companion object {
        const val clientId: String = "lydia-api"
    }

    fun producerProperties(): Map<String, Any> {
        val producerConfigs = mutableMapOf(
            ProducerConfig.BOOTSTRAP_SERVERS_CONFIG to brokers,
            ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG to StringSerializer::class.java,
            ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG to StringSerializer::class.java,
            ProducerConfig.ENABLE_IDEMPOTENCE_CONFIG to true, // Den sikrer rekkefølge
            ProducerConfig.ACKS_CONFIG to "all", // Den sikrer at data ikke mistes
            ProducerConfig.CLIENT_ID_CONFIG to clientId,
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
            SslConfigs.SSL_KEY_PASSWORD_CONFIG to credstorePassword,
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
            ConsumerConfig.ENABLE_AUTO_COMMIT_CONFIG to "false",
        ).toProperties()
}

class Salesforce(
    val tokenHost: String = getEnvVar("SALESFORCE_TOKEN_HOST"),
    val clientId: String = getEnvVar("SALESFORCE_CLIENT_ID"),
    val clientSecret: String = getEnvVar("SALESFORCE_CLIENT_SECRET"),
    val username: String = getEnvVar("SALESFORCE_USERNAME"),
    val password: String = getEnvVar("SALESFORCE_PASSWORD"),
    val securityToken: String = getEnvVar("SALESFORCE_SECURITY_TOKEN"),
)

class Integrasjoner(
    val ssbNæringsUrl: String = getEnvVar("SSB_NARINGS_URL"),
    val piaPdfgenUrl: String = getEnvVar("PIA_PDFGEN_URL"),
    val journalpostUrl: String = getEnvVar("JOURNALPOST_V1_URL"),
    val journalpostScope: String = getEnvVar("JOURNALPOST_SCOPE"),
    val salesforce: Salesforce = Salesforce(),
)

enum class Topic(
    val navn: String,
    private val consumerGroupId: String? = null,
) {
    IA_SAK_TOPIC("pia.ia-sak-v1"),
    IA_SAK_STATISTIKK_TOPIC("pia.ia-sak-statistikk-v1"),
    IA_SAK_STATUS_TOPIC("pia.ia-sak-status-v1"),
    IA_SAK_LEVERANSE_TOPIC("pia.ia-sak-leveranse-v1"),
    SPORREUNDERSOKELSE_TOPIC("pia.sporreundersokelse-v1", consumerGroupId = "lydia-api-sporreundersokelse-comsumer"),
    FULLFØRT_BEHOVSVURDERING_TOPIC("pia.fullfort-behovsvurdering-v1", "lydia-api-fullfort-behovsvurdering"),
    BEHOVSVURDERING_BIGQUERY_TOPIC("pia.behovsvurdering-bigquery-v1"),

    @Deprecated("Bruk SPORREUNDERSOKELSE_HENDELSE_TOPIC")
    SPORREUNDERSOKELSE_SVAR_TOPIC("pia.sporreundersokelse-svar-v1", "lydia-api-sporreundersokelse-svar-consumer"),

    SPORREUNDERSOKELSE_HENDELSE_TOPIC(
        "pia.sporreundersokelse-hendelse-v1",
        "lydia-api-sporreundersokelse-hendelse-consumer",
    ),
    SPORREUNDERSOKELSE_OPPDATERING_TOPIC(
        "pia.sporreundersokelse-oppdatering-v1",
        "lydia-api-sporreundersokelse-oppdatering-consumer",
    ),
    BRREG_OPPDATERING_TOPIC("pia.brreg-oppdatering", "lydia-api-brreg-oppdatering-consumer"),
    BRREG_ALLE_VIRKSOMHETER_TOPIC("pia.brreg-alle-virksomheter", "lydia-api-brreg-alle-virksomheter-consumer"),
    STATISTIKK_METADATA_VIRKSOMHET_TOPIC(
        "arbeidsgiver.sykefravarsstatistikk-metadata-virksomhet-v1",
        "lydia-api-statistikk-metadata-virksomhet-consumer",
    ),
    STATISTIKK_LAND_TOPIC("arbeidsgiver.sykefravarsstatistikk-land-v1", "lydia-api-statistikk-land-consumer"),
    STATISTIKK_SEKTOR_TOPIC("arbeidsgiver.sykefravarsstatistikk-sektor-v1", "lydia-api-statistikk-sektor-consumer"),
    STATISTIKK_BRANSJE_TOPIC("arbeidsgiver.sykefravarsstatistikk-bransje-v1", "lydia-api-statistikk-bransje-consumer"),
    STATISTIKK_NARING_TOPIC("arbeidsgiver.sykefravarsstatistikk-naring-v1", "lydia-api-statistikk-naring-consumer"),
    STATISTIKK_NARINGSKODE_TOPIC(
        "arbeidsgiver.sykefravarsstatistikk-naringskode-v1",
        "lydia-api-statistikk-naringskode-consumer",
    ),
    STATISTIKK_VIRKSOMHET_TOPIC(
        "arbeidsgiver.sykefravarsstatistikk-virksomhet-v1",
        "lydia-api-statistikk-virksomhet-consumer",
    ),
    STATISTIKK_VIRKSOMHET_GRADERING_TOPIC(
        "arbeidsgiver.sykefravarsstatistikk-virksomhet-gradert-v1",
        "lydia-api-statistikk-virksomhet-gradering-consumer",
    ),
    JOBBLYTTER_TOPIC("pia.jobblytter-v1", "lydia-api-jobblytter-consumer"),
    ;

    val konsumentGruppe
        get() = consumerGroupId ?: throw RuntimeException("Topic $navn mangler consumerGroupId")
}

fun getEnvVar(
    varName: String,
    defaultValue: String? = null,
) = System.getenv(varName) ?: defaultValue ?: throw RuntimeException("Missing required variable $varName")
