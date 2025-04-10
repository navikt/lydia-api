package no.nav.lydia.ia.eksport

import ia.felles.integrasjoner.kafkameldinger.eksport.SpørreundersøkelseEksportMelding
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus
import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import no.nav.lydia.Kafka
import no.nav.lydia.Observer
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.db.SpørreundersøkelseRepository
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse

class SpørreundersøkelseBigqueryProdusent(
    kafka: Kafka,
    topic: Topic = Topic.SPØRREUNDERSØKELSE_BIGQUERY_TOPIC,
    private val spørreundersøkelseRepository: SpørreundersøkelseRepository,
) : KafkaProdusent<Spørreundersøkelse>(kafka, topic),
    Observer<Spørreundersøkelse> {
    override fun receive(input: Spørreundersøkelse) = sendPåKafka(input = input)

    override fun tilKafkaMelding(input: Spørreundersøkelse): Pair<String, String> {
        val alleSvar = spørreundersøkelseRepository.hentAlleSvar(spørreundersøkelseId = input.id.toString())

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
            harMinstEttSvar = alleSvar.isNotEmpty(),
            endret = input.endretTidspunkt,
            påbegynt = input.påbegyntTidspunkt,
            fullført = input.fullførtTidspunkt,
            førsteSvarMotatt = alleSvar.minOfOrNull { it.opprettet },
            sisteSvarMottatt = alleSvar.maxOfOrNull { it.endret ?: it.opprettet },
            // TODO: test at tidForSisteSvar blir satt rett om man svarer på nytt på et spørsmål (oppdaterer endret)
        )

        return nøkkel to Json.encodeToString(verdi)
    }

    @Serializable
    data class SpørreundersøkelseEksport(
        override val id: String,
        override val orgnr: String,
        override val type: String,
        override val status: SpørreundersøkelseStatus,
        override val samarbeidId: Int,
        override val saksnummer: String,
        override val opprettetAv: String,
        override val opprettet: LocalDateTime,
        override val harMinstEttSvar: Boolean,
        override val endret: LocalDateTime?,
        override val påbegynt: LocalDateTime?,
        override val fullført: LocalDateTime?,
        override val førsteSvarMotatt: LocalDateTime?,
        override val sisteSvarMottatt: LocalDateTime?,
    ) : SpørreundersøkelseEksportMelding
}
