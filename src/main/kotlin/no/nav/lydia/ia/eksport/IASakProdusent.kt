package no.nav.lydia.ia.eksport

import no.nav.lydia.Observer
import no.nav.lydia.ia.sak.domene.IASak

class IASakProdusent(private val produsent: KafkaProdusent, private val topic: String) : Observer<IASak> {

    override fun receive(input: IASak) {
        val kafkaMelding = input.tilKafkaMelding()
        produsent.sendMelding(topic, kafkaMelding.first, kafkaMelding.second)
    }

    companion object {
        fun IASak.tilKafkaMelding(): Pair<String, String> {
            return Pair(this.saksnummer, "B")
        }
    }
}
