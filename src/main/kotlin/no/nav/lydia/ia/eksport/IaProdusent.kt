package no.nav.lydia.ia.eksport

import no.nav.lydia.Observer
import no.nav.lydia.ia.sak.domene.IASakshendelse
import org.apache.kafka.clients.producer.KafkaProducer

class IaProdusent(private val producer: KafkaProducer<String, String>) : Observer<IASakshendelse> {
    internal fun stop() {
        producer.close()
    }

    override fun receive(input: IASakshendelse) {
        print("Sendte iasak $input")
        //producer.send()
    }
}