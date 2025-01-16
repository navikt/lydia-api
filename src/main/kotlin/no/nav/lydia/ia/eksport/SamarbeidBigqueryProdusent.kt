package no.nav.lydia.ia.eksport

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Observer
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.domene.prosess.IAProsess

class SamarbeidBigqueryProdusent(
    private val produsent: KafkaProdusent,
) : Observer<IAProsess> {
    override fun receive(input: IAProsess) {
        sendTilKafka(samarbeid = input)
    }

    fun reEksporter(input: IAProsess) {
        sendTilKafka(input)
    }

    private fun sendTilKafka(samarbeid: IAProsess) {
        val kafkaMelding = samarbeid.tilKafkaMelding()
        produsent.sendMelding(Topic.SAMARBEID_BIGQUERY_TOPIC.navn, kafkaMelding.first, kafkaMelding.second)
    }

    companion object {
        fun IAProsess.tilKafkaMelding(): Pair<String, String> {
            val key = saksnummer
            val value = SamarbeidValue(
                id = id,
                saksnummer = saksnummer,
                navn = navn,
                status = status?.name,
                opprettet = opprettet,
                sistEndret = sistEndret,
            )
            return key to Json.encodeToString(value)
        }
    }

    @Serializable
    data class SamarbeidValue(
        val id: Int,
        val saksnummer: String,
        val opprettet: LocalDateTime,
        val sistEndret: LocalDateTime? = null,
        val navn: String? = null,
        val status: String? = null,
    )
}
