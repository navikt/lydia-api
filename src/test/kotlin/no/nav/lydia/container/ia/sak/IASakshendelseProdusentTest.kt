package no.nav.lydia.container.ia.sak

import io.kotest.matchers.shouldBe
import kotlinx.coroutines.isActive
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.time.withTimeout
import no.nav.lydia.Kafka
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.SaksHendelsestype
import org.apache.kafka.clients.consumer.KafkaConsumer
import org.apache.kafka.common.serialization.StringDeserializer
import java.time.Duration
import kotlin.test.Ignore
import kotlin.test.Test

@Ignore
class IASakshendelseProdusentTest {
    val mockOAuth2Server = TestContainerHelper.oauth2ServerContainer
    val postgresContainer = TestContainerHelper.postgresContainer

    @Test
    fun `en ny hendelse på en iasak skal produsere en melding på kafka`() {
        runBlocking {
            val kafkacontainerEnvVars = TestContainerHelper.kafkaContainerHelper.envVars()
            val topic = TestContainerHelper.kafkaContainerHelper.iaSakHendelseTopic
            val konsument = KafkaConsumer(Kafka(
                brokers = kafkacontainerEnvVars["KAFKA_BROKERS"]!!,
                iaSakHendelseTopic = topic,
                statistikkTopic = TestContainerHelper.kafkaContainerHelper.statistikkTopic,
                consumerLoopDelay = 1,
                credstorePassword = "",
                keystoreLocation = "",
                truststoreLocation = ""
            ).consumerProperties(), StringDeserializer(), StringDeserializer())
            konsument.subscribe(listOf(topic))
            withTimeout(Duration.ofSeconds(30)) {
                launch {
                    while (this.isActive) {
                        val records = konsument.poll(Duration.ofMillis(100))
                        if (records.count() > 0) {
                            print("Hello here")
                            break;
                        }
                    }
                }
            }

            SakHelper.opprettSakForVirksomhet(orgnummer = VirksomhetHelper.nyttOrgnummer())
                .nyHendelse(SaksHendelsestype.TA_EIERSKAP_I_SAK)
                .nyHendelse(SaksHendelsestype.VIRKSOMHET_SKAL_KONTAKTES)
                .also {
                    it.status shouldBe IAProsessStatus.KONTAKTES
                }
        }


    }
}