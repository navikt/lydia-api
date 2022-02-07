package no.nav.lydia.container.kafka

import no.nav.lydia.helper.KafkaContainerHelper
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
    val kafkaContainer = KafkaContainerHelper()

    @Test
    fun `Kan koble til kafka brokers`() {
        val TEST_TOPIC = "testTopic"

        val kafkaProducer = kafkaContainer.producer()

        kafkaProducer.send(ProducerRecord(TEST_TOPIC, "testValue")).get()

        val kafkaConsumer = KafkaConsumer(
            mapOf(
                CommonClientConfigs.BOOTSTRAP_SERVERS_CONFIG to kafkaContainer.kafkaContainer.bootstrapServers,
                CommonClientConfigs.SECURITY_PROTOCOL_CONFIG to "PLAINTEXT",
                SaslConfigs.SASL_MECHANISM to "PLAIN",
                ConsumerConfig.GROUP_ID_CONFIG to "integration-test",
                ConsumerConfig.AUTO_OFFSET_RESET_CONFIG to "earliest"
            ),
            StringDeserializer(),
            StringDeserializer()
        ).apply { subscribe(listOf(TEST_TOPIC)) }


//        var i = 0
//        while (true) {
//            println(i++)
//            val result = kafkaProducer.send(ProducerRecord(TEST_TOPIC, "testValue")).get()
//
//            kafkaConsumer.poll(Duration.of(100, ChronoUnit.MILLIS)).forEach {
//                   println("Record key: ${it.value()}")
//                }
//            kafkaConsumer.commitSync()
//
//            Thread.sleep(1000)
//        }
    }
}