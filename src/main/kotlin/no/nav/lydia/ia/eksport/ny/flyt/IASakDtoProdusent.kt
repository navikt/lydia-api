package no.nav.lydia.ia.eksport.ny.flyt

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import no.nav.lydia.Kafka
import no.nav.lydia.Observer
import no.nav.lydia.Topic
import no.nav.lydia.ia.eksport.KafkaProdusent
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.domene.IASak

class IASakDtoProdusent(
    kafka: Kafka,
    topic: Topic = Topic.IA_SAK_TOPIC,
) : KafkaProdusent<IASakDto>(kafka, topic),
    Observer<IASakDto> {
    override fun receive(input: IASakDto) = sendPåKafka(input = input)

    override fun tilKafkaMelding(input: IASakDto): Pair<String, String> {
        val nøkkel = input.saksnummer
        val verdi = IASakDtoValue(
            saksnummer = input.saksnummer,
            orgnr = input.orgnr,
            eierAvSak = input.eidAv,
            endretAvHendelseId = input.endretAvHendelseId,
            status = input.status,
            opprettetTidspunkt = input.opprettetTidspunkt,
            endretTidspunkt = input.endretTidspunkt
                ?: input.opprettetTidspunkt,
        )
        return nøkkel to Json.encodeToString(verdi)
    }

    @Serializable
    private data class IASakDtoValue(
        val saksnummer: String,
        val orgnr: String,
        val eierAvSak: String?,
        val endretAvHendelseId: String,
        val status: IASak.Status,
        val opprettetTidspunkt: LocalDateTime,
        val endretTidspunkt: LocalDateTime,
    )
}
