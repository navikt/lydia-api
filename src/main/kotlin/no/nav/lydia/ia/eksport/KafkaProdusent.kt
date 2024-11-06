package no.nav.lydia.ia.eksport

import no.nav.lydia.Kafka
import org.apache.kafka.clients.producer.KafkaProducer
import org.apache.kafka.clients.producer.ProducerRecord

class KafkaProdusent(
    kafkaConfig: Kafka,
) {
    private val producer: KafkaProducer<String, String> = KafkaProducer(kafkaConfig.producerProperties())

    init {
        Runtime.getRuntime().addShutdownHook(
            Thread {
                producer.close()
            },
        )
    }

    fun sendMelding(
        topic: String,
        nøkkel: String,
        verdi: String,
    ) {
        producer.send(ProducerRecord(topic, nøkkel, verdi))
    }
}
