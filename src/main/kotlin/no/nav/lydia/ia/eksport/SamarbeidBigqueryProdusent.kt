package no.nav.lydia.ia.eksport

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import no.nav.lydia.Kafka
import no.nav.lydia.Observer
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid

class SamarbeidBigqueryProdusent(
    kafka: Kafka,
    topic: Topic = Topic.SAMARBEID_BIGQUERY_TOPIC,
) : KafkaProdusent<IASamarbeid>(kafka, topic),
    Observer<IASamarbeid> {
    override fun receive(input: IASamarbeid) = sendPåKafka(input = input)

    override fun tilKafkaMelding(input: IASamarbeid): Pair<String, String> {
        val nøkkel = input.saksnummer
        val verdi = SamarbeidValue(
            id = input.id,
            saksnummer = input.saksnummer,
            navn = input.navn,
            status = input.status?.name,
            opprettet = input.opprettet,
            avbrutt = input.avbrutt,
            fullført = input.fullført,
            sistEndret = input.sistEndret,
        )
        return nøkkel to Json.encodeToString(verdi)
    }

    @Serializable
    data class SamarbeidValue(
        val id: Int,
        val saksnummer: String,
        val opprettet: LocalDateTime,
        val avbrutt: LocalDateTime? = null,
        val fullført: LocalDateTime? = null,
        val sistEndret: LocalDateTime? = null,
        val navn: String? = null,
        val status: String? = null,
    )
}
