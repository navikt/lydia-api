package no.nav.lydia.ia.eksport

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import no.nav.lydia.Kafka
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.db.IASamarbeidRepository.SamarbeidIVirksomhetDto

class SamarbeidProdusent(
    kafka: Kafka,
    topic: Topic = Topic.SAMARBEIDSPLAN_TOPIC,
    clientId: String = "${topic.konsumentGruppe}-samarbeid-producer",
) : KafkaProdusent<SamarbeidIVirksomhetDto>(kafka = kafka, topic = topic, clientId = clientId) {
    override fun tilKafkaMelding(input: SamarbeidIVirksomhetDto): Pair<String, String> {
        val nøkkel = "${input.saksnummer}-${input.samarbeid.id}"
        val verdi = SamarbeidKafkaMeldingValue(
            orgnr = input.orgnr,
            saksnummer = input.saksnummer,
            samarbeid = input.samarbeid,
        )
        return nøkkel to Json.encodeToString(verdi)
    }

    @Serializable
    data class SamarbeidKafkaMeldingValue(
        val orgnr: String,
        val saksnummer: String,
        val samarbeid: SamarbeidDto,
    )
}
