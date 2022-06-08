package no.nav.lydia.ia.eksport

import no.nav.lydia.Observer
import no.nav.lydia.ia.sak.domene.IASakshendelse
import org.apache.kafka.clients.producer.KafkaProducer
import org.apache.kafka.clients.producer.ProducerRecord

class IaProdusent(private val producer: KafkaProducer<String, String>, private val topic: String) : Observer<IASakshendelse> {
    internal fun stop() {
        producer.close()
    }

    override fun receive(input: IASakshendelse) {
        val kafkaMelding = input.tilKafkaMelding()
        val melding = ProducerRecord(topic, kafkaMelding.first, kafkaMelding.second)
        producer.send(melding)
    }
}