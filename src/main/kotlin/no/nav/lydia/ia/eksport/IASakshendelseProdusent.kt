package no.nav.lydia.ia.eksport

import no.nav.lydia.Observer
import no.nav.lydia.ia.sak.domene.IASakshendelse

class IASakshendelseProdusent(private val produsent: KafkaProdusent, private val topic: String) : Observer<IASakshendelse> {

    override fun receive(input: IASakshendelse) {
        val kafkaMelding = input.tilKeyValueJsonPair()
        produsent.sendMelding(topic, kafkaMelding.first, kafkaMelding.second)
    }
}
