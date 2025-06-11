package no.nav.lydia.ia.eksport

import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import no.nav.lydia.Kafka
import no.nav.lydia.Observer
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.domene.IASak

class IASakProdusent(
    kafka: Kafka,
    topic: Topic = Topic.IA_SAK_TOPIC,
) : KafkaProdusent<IASak>(kafka, topic),
    Observer<IASak> {
    override fun receive(input: IASak) = sendPåKafka(input = input)

    override fun tilKafkaMelding(input: IASak): Pair<String, String> {
        val nøkkel = input.saksnummer
        val verdi = IASakValue(
            saksnummer = input.saksnummer,
            orgnr = input.orgnr,
            eierAvSak = input.eidAv,
            endretAvHendelseId = input.endretAvHendelseId,
            status = input.status,
            opprettetTidspunkt = input.opprettetTidspunkt.toKotlinLocalDateTime(),
            endretTidspunkt = input.endretTidspunkt?.toKotlinLocalDateTime()
                ?: input.opprettetTidspunkt.toKotlinLocalDateTime(),
        )
        return nøkkel to Json.encodeToString(verdi)
    }

    @Serializable
    private data class IASakValue(
        val saksnummer: String,
        val orgnr: String,
        val eierAvSak: String?,
        val endretAvHendelseId: String,
        val status: IASak.Status,
        val opprettetTidspunkt: LocalDateTime,
        val endretTidspunkt: LocalDateTime,
    )
}
