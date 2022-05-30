package no.nav.lydia.ia.eksport

import org.apache.kafka.clients.producer.KafkaProducer

class IaProdusent(private val producer: KafkaProducer<String, String>) {
    internal fun stop() {
        producer.close()
    }
}