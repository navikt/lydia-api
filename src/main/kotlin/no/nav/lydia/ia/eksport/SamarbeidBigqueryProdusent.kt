package no.nav.lydia.ia.eksport

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
            val key = this.saksnummer
            val value = SamarbeidValue(
                id = this.id,
                saksnummer = this.saksnummer,
                navn = this.navn,
                status = this.status?.name,
            )
            return key to Json.encodeToString(value)
        }
    }

    @Serializable
    data class SamarbeidValue(
        val id: Int,
        val saksnummer: String,
        val navn: String? = null,
        val status: String? = null,
    )
}