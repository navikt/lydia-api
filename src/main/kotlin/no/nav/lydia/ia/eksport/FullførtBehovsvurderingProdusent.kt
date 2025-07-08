package no.nav.lydia.ia.eksport

import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import no.nav.lydia.Kafka
import no.nav.lydia.Observer
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse

class FullførtBehovsvurderingProdusent(
    kafka: Kafka,
    topic: Topic = Topic.FULLFØRT_BEHOVSVURDERING_TOPIC,
) : KafkaProdusent<Spørreundersøkelse>(kafka, topic),
    Observer<Spørreundersøkelse> {
    override fun receive(input: Spørreundersøkelse) {
        if (input.type == Spørreundersøkelse.Type.Behovsvurdering && input.status == Spørreundersøkelse.Status.AVSLUTTET) sendPåKafka(input)
    }

    override fun tilKafkaMelding(input: Spørreundersøkelse): Pair<String, String> {
        val nøkkel = input.id.toString()
        val verdi = FullførtBehovsvurdering(
            behovsvurderingId = input.id.toString(),
            saksnummer = input.saksnummer,
            prosessId = input.samarbeidId.toString(),
            fullførtTidspunkt = input.endretTidspunkt ?: java.time.LocalDateTime.now().toKotlinLocalDateTime(),
        )
        return nøkkel to Json.encodeToString(verdi)
    }

    @Serializable
    data class FullførtBehovsvurdering(
        val behovsvurderingId: String,
        val saksnummer: String,
        val prosessId: String,
        val fullførtTidspunkt: LocalDateTime,
    )
}
