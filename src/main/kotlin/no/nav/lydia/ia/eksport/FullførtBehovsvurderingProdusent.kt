package no.nav.lydia.ia.eksport

import ia.felles.integrasjoner.kafkameldinger.SpørreundersøkelseStatus.AVSLUTTET
import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Observer
import no.nav.lydia.Topic.FULLFØRT_BEHOVSVURDERING_TOPIC
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse

class FullførtBehovsvurderingProdusent(
    private val produsent: KafkaProdusent,
) : Observer<Spørreundersøkelse> {
    override fun receive(input: Spørreundersøkelse) {
        if (input.status == AVSLUTTET)
            sendPåKafka(input)
    }

    private fun sendPåKafka(spørreundersøkelse: Spørreundersøkelse) {
        val (nøkkel, melding) = spørreundersøkelse.tilKafkamelding()
        produsent.sendMelding(
            topic = FULLFØRT_BEHOVSVURDERING_TOPIC.navn,
            nøkkel = nøkkel,
            verdi = melding
        )
    }

    private fun Spørreundersøkelse.tilKafkamelding() =
        this.id.toString() to Json.encodeToString<FullførtBehovsvurdering>(
            FullførtBehovsvurdering(
                behovsvurderingId = this.id.toString(),
                saksnummer = this.saksnummer,
                prosessId = this.prosessId.toString(),
                fullførtTidspunkt = this.endretTidspunkt?.toKotlinLocalDateTime() ?: java.time.LocalDateTime.now()
                    .toKotlinLocalDateTime()
            )
        )
}

@Serializable
data class FullførtBehovsvurdering(
    val behovsvurderingId: String,
    val saksnummer: String,
    val prosessId: String,
    val fullførtTidspunkt: LocalDateTime,
)