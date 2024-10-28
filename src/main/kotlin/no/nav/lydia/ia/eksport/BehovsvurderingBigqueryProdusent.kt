package no.nav.lydia.ia.eksport

import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Observer
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse

class BehovsvurderingBigqueryProdusent(
    private val produsent: KafkaProdusent,
) : Observer<Spørreundersøkelse> {
    override fun receive(input: Spørreundersøkelse) {
        if (input.type == "Behovsvurdering") {
            sendTilKafka(spørreundersøkelse = input)
        }
    }

    fun reEksporter(input: Spørreundersøkelse) {
        sendTilKafka(input)
    }

    private fun sendTilKafka(spørreundersøkelse: Spørreundersøkelse) {
        val kafkaMelding = spørreundersøkelse.tilKafkaMelding()
        produsent.sendMelding(Topic.BEHOVSVURDERING_BIGQUERY_TOPIC.navn, kafkaMelding.first, kafkaMelding.second)
    }

    companion object {
        fun Spørreundersøkelse.tilKafkaMelding(): Pair<String, String> {
            val key = this.saksnummer
            val value = BehovsvurderingUtenSvarValue(
                id = this.id.toString(),
                orgnr = this.orgnummer,
                status = this.status.name,
                opprettetAv = this.opprettetAv,
                opprettet = this.opprettetTidspunkt.toKotlinLocalDateTime(),
                endret = this.endretTidspunkt?.toKotlinLocalDateTime() ?: this.opprettetTidspunkt.toKotlinLocalDateTime(),
                samarbeidId = this.prosessId,
            )
            return key to Json.encodeToString(value)
        }
    }

    @Serializable
    data class BehovsvurderingUtenSvarValue(
        val id: String,
        val orgnr: String,
        val status: String,
        val opprettetAv: String,
        val opprettet: LocalDateTime,
        val endret: LocalDateTime,
        val samarbeidId: Int,
    )
}
