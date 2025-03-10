package no.nav.lydia.ia.eksport

import no.nav.lydia.Kafka
import no.nav.lydia.Topic
import org.apache.kafka.clients.producer.KafkaProducer
import org.apache.kafka.clients.producer.ProducerRecord

abstract class KafkaProdusent<T>(
    protected val kafka: Kafka,
    protected val topic: Topic,
    protected val clientId: String = topic.konsumentGruppe,
) {
    private val produsent: KafkaProducer<String, String> = KafkaProducer(kafka.producerProperties(clientId = clientId))

    init {
        Runtime.getRuntime().addShutdownHook(
            Thread {
                produsent.close()
            },
        )
    }

    fun sendMelding(
        nøkkel: String,
        verdi: String,
    ) {
        produsent.send(
            ProducerRecord(
                topic.navn,
                nøkkel,
                verdi,
            ),
        )
    }

    protected abstract fun tilKafkaMelding(input: T): Pair<String, String>

    fun sendPåKafka(input: T) {
        val (key, value) = tilKafkaMelding(input)
        sendMelding(key, value)
    }
}
