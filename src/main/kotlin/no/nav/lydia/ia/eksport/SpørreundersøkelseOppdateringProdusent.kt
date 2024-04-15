package no.nav.lydia.ia.eksport

import no.nav.lydia.Topic
import no.nav.lydia.integrasjoner.kartlegging.SpørreundersøkelseOppdatering

class SpørreundersøkelseOppdateringProdusent(
    private val produsent: KafkaProdusent,
) {
    fun <T> sendPåKafka(oppdatering: SpørreundersøkelseOppdatering<T>) {
        produsent.sendMelding(
            topic = Topic.SPORREUNDERSOKELSE_OPPDATERING_TOPIC.navn,
            nøkkel = oppdatering.tilNøkkel(),
            verdi = oppdatering.tilMelding(),
        )
    }
}
