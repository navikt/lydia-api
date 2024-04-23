package no.nav.lydia.ia.eksport

import java.time.LocalDate.now
import kotlinx.datetime.toKotlinLocalDate
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.IASakKartlegging
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseDto
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.toDto

class SpørreundersøkelseProdusent(
    private val produsent: KafkaProdusent,
) {
    fun sendPåKafka(iaSakKartlegging: IASakKartlegging) {
        produsent.sendMelding(
            topic = Topic.SPORREUNDERSOKELSE_TOPIC.navn,
            nøkkel = iaSakKartlegging.kartleggingId.toString(),
            verdi = Json.encodeToString(iaSakKartlegging.tilSpørreundersøkelse()),
        )
    }

    fun IASakKartlegging.tilSpørreundersøkelse() =
        SpørreundersøkelseDto(
            spørreundersøkelseId = this.kartleggingId.toString(),
            vertId = this.vertId?.toString() ?: "",
            orgnummer = orgnummer,
            virksomhetsNavn = virksomhetsNavn,
            status = this.status,
            type = "kartlegging",
            temaMedSpørsmålOgSvaralternativer = temaMedSpørsmålOgSvaralternativer.map { it.toDto() },
            avslutningsdato = now().toKotlinLocalDate(),
        )
}
