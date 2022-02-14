package no.nav.lydia.container.kafka

import no.nav.lydia.helper.TestContainerHelper
import org.apache.kafka.clients.producer.ProducerRecord
import kotlin.test.Test

class KafkaContainerTest {
    private val kafkaContainer = TestContainerHelper.kafkaContainerHelper

    @Test
    fun `Kan koble til kafka brokers`() {
        val kafkaProducer = kafkaContainer.producer()

        kafkaProducer.send(ProducerRecord(kafkaContainer.statistikkTopic, "testValue")).get()
    }
}