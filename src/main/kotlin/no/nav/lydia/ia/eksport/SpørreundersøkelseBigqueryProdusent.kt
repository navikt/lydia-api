package no.nav.lydia.ia.eksport

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import no.nav.lydia.Kafka
import no.nav.lydia.Observer
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse.Companion.harMinstEttResultat

class SpørreundersøkelseBigqueryProdusent(
    kafka: Kafka,
    topic: Topic = Topic.SPØRREUNDERSØKELSE_BIGQUERY_TOPIC,
) : KafkaProdusent<Spørreundersøkelse>(kafka, topic),
    Observer<Spørreundersøkelse> {
    override fun receive(input: Spørreundersøkelse) = sendPåKafka(input = input)

    override fun tilKafkaMelding(input: Spørreundersøkelse): Pair<String, String> {
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
            harMinstEttSvar = harMinstEttResultat(input),
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
        val status: Spørreundersøkelse.Status,
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
