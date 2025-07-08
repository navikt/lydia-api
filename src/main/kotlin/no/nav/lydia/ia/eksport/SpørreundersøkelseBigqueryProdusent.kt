package no.nav.lydia.ia.eksport

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import no.nav.lydia.Kafka
import no.nav.lydia.Observer
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseDomene

class SpørreundersøkelseBigqueryProdusent(
    kafka: Kafka,
    topic: Topic = Topic.SPØRREUNDERSØKELSE_BIGQUERY_TOPIC,
) : KafkaProdusent<SpørreundersøkelseDomene>(kafka, topic),
    Observer<SpørreundersøkelseDomene> {
    override fun receive(input: SpørreundersøkelseDomene) = sendPåKafka(input = input)

    override fun tilKafkaMelding(input: SpørreundersøkelseDomene): Pair<String, String> {
        val nøkkel = input.saksnummer
        val verdi = SpørreundersøkelseEksport(
            id = input.id.toString(),
            orgnr = input.orgnummer,
            status = input.status,
            type = input.type.name,
            samarbeidId = input.samarbeidId,
            saksnummer = input.saksnummer,
            opprettetAv = input.opprettetAv,
            opprettet = input.opprettetTidspunkt,
            harMinstEttSvar = input.harMinstEttResultat(),
            endret = input.endretTidspunkt,
            påbegynt = input.påbegyntTidspunkt,
            fullført = input.fullførtTidspunkt,
        )

        return nøkkel to Json.encodeToString(verdi)
    }

    @Serializable
    data class SpørreundersøkelseEksport(
        val id: String,
        val orgnr: String,
        val type: String,
        val status: SpørreundersøkelseDomene.Status,
        val samarbeidId: Int,
        val saksnummer: String,
        val opprettetAv: String,
        val opprettet: LocalDateTime,
        val harMinstEttSvar: Boolean,
        val endret: LocalDateTime?,
        val påbegynt: LocalDateTime?,
        val fullført: LocalDateTime?,
    )
}
