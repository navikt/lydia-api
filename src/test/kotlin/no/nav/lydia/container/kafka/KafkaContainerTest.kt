package no.nav.lydia.container.kafka

import no.nav.lydia.Kafka
import no.nav.lydia.helper.KafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper
import org.apache.kafka.clients.CommonClientConfigs
import org.apache.kafka.clients.consumer.ConsumerConfig
import org.apache.kafka.clients.consumer.KafkaConsumer
import org.apache.kafka.clients.producer.KafkaProducer
import org.apache.kafka.clients.producer.ProducerConfig
import org.apache.kafka.clients.producer.ProducerRecord
import org.apache.kafka.common.config.SaslConfigs
import org.apache.kafka.common.serialization.StringDeserializer
import org.apache.kafka.common.serialization.StringSerializer
import java.time.Duration
import java.time.temporal.ChronoUnit
import kotlin.test.Test

class KafkaContainerTest {
    private val kafkaContainer = TestContainerHelper.kafkaContainerHelper

    @Test
    fun `Kan koble til kafka brokers`() {
        val kafkaProducer = kafkaContainer.producer()

        kafkaProducer.send(ProducerRecord(Kafka.statistikkTopic, "testValue")).get()
    }
}