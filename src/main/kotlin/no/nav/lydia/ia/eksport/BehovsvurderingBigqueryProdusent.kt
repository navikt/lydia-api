package no.nav.lydia.ia.eksport

import ia.felles.integrasjoner.kafkameldinger.eksport.BehovsvurderingMelding
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus
import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Observer
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseSvar
import no.nav.lydia.ia.sak.db.SpørreundersøkelseRepository
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse

class BehovsvurderingBigqueryProdusent(
    private val produsent: KafkaProdusent,
    private val spørreundersøkelseRepository: SpørreundersøkelseRepository,
) : Observer<Spørreundersøkelse> {
    override fun receive(input: Spørreundersøkelse) {
        if (input.type == "Behovsvurdering") {
            sendTilKafka(spørreundersøkelse = input)
        }
    }

    fun reEksporter(input: Spørreundersøkelse) {
        sendTilKafka(input)
    }

    private fun sendTilKafka(spørreundersøkelse: Spørreundersøkelse) {
        val alleSvar = spørreundersøkelseRepository.hentAlleSvar(spørreundersøkelseId = spørreundersøkelse.id.toString())
        val kafkaMelding = spørreundersøkelse.tilKafkaMelding(alleSvar)
        produsent.sendMelding(Topic.BEHOVSVURDERING_BIGQUERY_TOPIC.navn, kafkaMelding.first, kafkaMelding.second)
    }

    companion object {
        fun Spørreundersøkelse.tilKafkaMelding(alleSvar: List<SpørreundersøkelseSvar>): Pair<String, String> {
            val key = this.saksnummer
            val value = BehovsvurderingKafkamelding(
                id = this.id.toString(),
                orgnr = this.orgnummer,
                status = this.status,
                samarbeidId = this.samarbeidId,
                saksnummer = this.saksnummer,
                opprettetAv = this.opprettetAv,
                opprettet = this.opprettetTidspunkt,
                harMinstEttSvar = alleSvar.isNotEmpty(),
                endret = this.endretTidspunkt,
                påbegynt = this.påbegyntTidspunkt,
                fullført = this.fullførtTidspunkt,
                førsteSvarMotatt = alleSvar.tidForFørsteSvar(),
                sisteSvarMottatt = alleSvar.tidForSisteSvar(),
            )
            return key to Json.encodeToString(value)
        }

        private fun List<SpørreundersøkelseSvar>.tidForFørsteSvar(): LocalDateTime? = this.minOfOrNull { it.opprettet }

        private fun List<SpørreundersøkelseSvar>.tidForSisteSvar(): LocalDateTime? = this.maxOfOrNull { it.endret ?: it.opprettet }
        // TODO: test at tidForSisteSvar blir satt rett om man svarer på nytt på et spørsmål (oppdaterer endret)
    }

    @Serializable
    data class BehovsvurderingKafkamelding(
        override val id: String,
        override val orgnr: String,
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
    ) : BehovsvurderingMelding
}
