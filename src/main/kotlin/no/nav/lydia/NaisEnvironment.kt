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
            @Suppress("ktlint:standard:enum-entry-name-case")
            `PROD-GCP`,

            @Suppress("ktlint:standard:enum-entry-name-case")
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
    val teamPiaGruppe: String = getEnvVar("TEAM_PIA_GROUP_ID"),
)

class Kafka(
    val brokers: String = getEnvVar("KAFKA_BROKERS"),
    val truststoreLocation: String = getEnvVar("KAFKA_TRUSTSTORE_PATH"),
    val keystoreLocation: String = getEnvVar("KAFKA_KEYSTORE_PATH"),
    val credstorePassword: String = getEnvVar("KAFKA_CREDSTORE_PASSWORD"),
    val consumerLoopDelay: Long = getEnvVar("CONSUMER_LOOP_DELAY").toLong(),
) {
    fun producerProperties(clientId: String): Map<String, Any> {
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
            ConsumerConfig.CLIENT_ID_CONFIG to consumerGroupId,
            ConsumerConfig.AUTO_OFFSET_RESET_CONFIG to "earliest",
            ConsumerConfig.MAX_POLL_RECORDS_CONFIG to "1000",
            ConsumerConfig.ENABLE_AUTO_COMMIT_CONFIG to "false",
        ).toProperties()
}

class Salesforce(
    val tokenBaseUrl: String = getEnvVar("SALESFORCE_TOKEN_BASE_URL"),
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
    val konsumentGruppe: String,
) {
    IA_SAK_TOPIC(
        navn = "pia.ia-sak-v1",
        konsumentGruppe = "lydia-api-ia-sak-producer",
    ),
    IA_SAK_STATISTIKK_TOPIC(
        navn = "pia.ia-sak-statistikk-v1",
        konsumentGruppe = "lydia-api-ia-sak-statistikk-producer",
    ),
    IA_SAK_STATUS_TOPIC(
        navn = "pia.ia-sak-status-v1",
        konsumentGruppe = "lydia-api-ia-sak-status-producer",
    ),
    IA_SAK_LEVERANSE_TOPIC(
        navn = "pia.ia-sak-leveranse-v1",
        konsumentGruppe = "lydia-api-ia-sak-leveranse-producer",
    ),
    SPORREUNDERSOKELSE_TOPIC(
        navn = "pia.sporreundersokelse-v1",
        konsumentGruppe = "lydia-api-sporreundersokelse-consumer",
    ),
    FULLFØRT_BEHOVSVURDERING_TOPIC(
        navn = "pia.fullfort-behovsvurdering-v1",
        konsumentGruppe = "lydia-api-fullfort-behovsvurdering-producer",
    ),
    SPØRREUNDERSØKELSE_BIGQUERY_TOPIC(
        navn = "pia.behovsvurdering-bigquery-v1",
        konsumentGruppe = "lydia-api-behovsvurdering-bigquery-producer",
    ),
    SAMARBEID_BIGQUERY_TOPIC(
        navn = "pia.samarbeid-bigquery-v1",
        konsumentGruppe = "lydia-api-samarbeid-bigquery-producer",
    ),
    SAMARBEIDSPLAN_BIGQUERY_TOPIC(
        navn = "pia.samarbeidsplan-bigquery-v1",
        konsumentGruppe = "lydia-api-samarbeidsplan-bigquery-producer",
    ),
    SAMARBEIDSPLAN_TOPIC(
        navn = "pia.samarbeidsplan-v1",
        konsumentGruppe = "lydia-api-samarbeidsplan",
    ),
    SPORREUNDERSOKELSE_HENDELSE_TOPIC(
        navn = "pia.sporreundersokelse-hendelse-v1",
        konsumentGruppe = "lydia-api-sporreundersokelse-hendelse-consumer",
    ),
    SPORREUNDERSOKELSE_OPPDATERING_TOPIC(
        navn = "pia.sporreundersokelse-oppdatering-v1",
        konsumentGruppe = "lydia-api-sporreundersokelse-oppdatering-consumer",
    ),
    BRREG_OPPDATERING_TOPIC(
        navn = "pia.brreg-oppdatering",
        konsumentGruppe = "lydia-api-brreg-oppdatering-consumer",
    ),
    BRREG_ALLE_VIRKSOMHETER_TOPIC(
        navn = "pia.brreg-alle-virksomheter",
        konsumentGruppe = "lydia-api-brreg-alle-virksomheter-consumer",
    ),
    STATISTIKK_METADATA_VIRKSOMHET_TOPIC(
        navn = "pia.sykefravarsstatistikk-metadata-virksomhet-v1",
        konsumentGruppe = "lydia-api-statistikk-metadata-virksomhet-consumer",
    ),
    STATISTIKK_LAND_TOPIC(
        navn = "pia.sykefravarsstatistikk-land-v1",
        konsumentGruppe = "lydia-api-statistikk-land-consumer",
    ),
    STATISTIKK_SEKTOR_TOPIC(
        navn = "pia.sykefravarsstatistikk-sektor-v1",
        konsumentGruppe = "lydia-api-statistikk-sektor-consumer",
    ),
    STATISTIKK_BRANSJE_TOPIC(
        navn = "pia.sykefravarsstatistikk-bransje-v1",
        konsumentGruppe = "lydia-api-statistikk-bransje-consumer",
    ),
    STATISTIKK_NARING_TOPIC(
        navn = "pia.sykefravarsstatistikk-naring-v1",
        konsumentGruppe = "lydia-api-statistikk-naring-consumer",
    ),
    STATISTIKK_NARINGSKODE_TOPIC(
        navn = "pia.sykefravarsstatistikk-naringskode-v1",
        konsumentGruppe = "lydia-api-statistikk-naringskode-consumer",
    ),
    STATISTIKK_VIRKSOMHET_TOPIC(
        navn = "pia.sykefravarsstatistikk-virksomhet-v1",
        konsumentGruppe = "lydia-api-statistikk-virksomhet-consumer",
    ),
    STATISTIKK_VIRKSOMHET_GRADERING_TOPIC(
        navn = "pia.sykefravarsstatistikk-virksomhet-gradert-v1",
        konsumentGruppe = "lydia-api-statistikk-virksomhet-gradering-consumer",
    ),
    JOBBLYTTER_TOPIC(
        navn = "pia.jobblytter-v1",
        konsumentGruppe = "lydia-api-jobblytter-consumer",
    ),
    SALESFORCE_AKTIVITET_TOPIC(
        navn = "team-dialog.employer-activity",
        konsumentGruppe = "lydia-api-salesforce-aktivitet-consumer",
    ),
    DOKUMENT_PUBLISERING_TOPIC(
        navn = "pia.dokument-publisering-v1",
        konsumentGruppe = "dokument-publisering-producer",
    ),

    @Deprecated("Bruk SPORREUNDERSOKELSE_HENDELSE_TOPIC")
    SPORREUNDERSOKELSE_SVAR_TOPIC(
        navn = "pia.sporreundersokelse-svar-v1",
        konsumentGruppe = "lydia-api-sporreundersokelse-svar-consumer",
    ),
}

fun getEnvVar(
    varName: String,
    defaultValue: String? = null,
) = System.getenv(varName) ?: defaultValue ?: throw RuntimeException("Missing required variable $varName")
