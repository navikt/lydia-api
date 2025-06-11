package no.nav.lydia.ia.eksport

import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import no.nav.lydia.Kafka
import no.nav.lydia.Observer
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.domene.IASak

class IASakStatusProdusent(
    kafka: Kafka,
    topic: Topic = Topic.IA_SAK_STATUS_TOPIC,
    private val iaSakRepository: IASakRepository,
) : KafkaProdusent<IASak>(kafka, topic),
    Observer<IASak> {
    override fun receive(input: IASak) {
        sendPåKafka(input = input)

        if (input.status == IASak.Status.SLETTET) {
            iaSakRepository.hentSaker(input.orgnr)
                .lastOrNull { it.status != IASak.Status.SLETTET }
                ?.let { aktivSak -> sendPåKafka(input = aktivSak) }
        }
    }

    override fun tilKafkaMelding(input: IASak): Pair<String, String> {
        val nøkkel = input.orgnr
        val verdi = IASakStatus(
            orgnr = input.orgnr,
            saksnummer = input.saksnummer,
            status = input.status,
            sistOppdatert = input.endretTidspunkt?.toKotlinLocalDateTime() ?: input.opprettetTidspunkt.toKotlinLocalDateTime(),
        )

        return nøkkel to Json.encodeToString(verdi)
    }

    @Serializable
    data class IASakStatus(
        val orgnr: String,
        val saksnummer: String,
        val status: IASak.Status,
        val sistOppdatert: LocalDateTime,
    )
}
