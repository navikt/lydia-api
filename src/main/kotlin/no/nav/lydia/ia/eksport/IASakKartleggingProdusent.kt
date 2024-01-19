package no.nav.lydia.ia.eksport

import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.ia.sak.api.kartlegging.toDto
import no.nav.lydia.ia.sak.domene.IASakKartlegging

class IASakKartleggingProdusent (
    private val produsent: KafkaProdusent,
    private val topic: String,
) {

    fun sendPåKafka(iaSakKartlegging: IASakKartlegging) {
        produsent.sendMelding(
            topic = topic,
            nøkkel = iaSakKartlegging.id.toString(),
            verdi = Json.encodeToString(iaSakKartlegging.toDto())
        )
    }

}