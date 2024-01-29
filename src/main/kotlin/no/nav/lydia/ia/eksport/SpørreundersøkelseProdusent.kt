package no.nav.lydia.ia.eksport

import java.time.LocalDate.now
import kotlinx.datetime.toKotlinLocalDate
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.ia.sak.api.kartlegging.toDto
import no.nav.lydia.ia.sak.domene.IASakKartlegging
import no.nav.lydia.ia.sak.domene.SpørreundersøkelseDto

class SpørreundersøkelseProdusent(
    private val produsent: KafkaProdusent,
    private val topic: String,
) {
    fun sendPåKafka(iaSakKartlegging: IASakKartlegging) {
        produsent.sendMelding(
            topic = topic,
            nøkkel = iaSakKartlegging.kartleggingId.toString(),
            verdi = Json.encodeToString(iaSakKartlegging.tilSpørreundersøkelse()),
        )
    }

    fun IASakKartlegging.tilSpørreundersøkelse() =
        SpørreundersøkelseDto(
            spørreundersøkelseId = this.kartleggingId.toString(),
            status = this.status,
            type = "kartlegging",
            spørsmålOgSvaralternativer = this.spørsmålOgSvaralternativer.toDto(),
            avslutningsdato = now().toKotlinLocalDate(),
        )
}
