package no.nav.lydia.ia.eksport

import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseMelding
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørsmålMelding
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SvaralternativMelding
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.TemaMelding
import kotlinx.serialization.Serializable
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Observer
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.api.plan.PlanDto
import no.nav.lydia.ia.sak.api.plan.tilDto
import no.nav.lydia.ia.sak.db.PlanRepository
import no.nav.lydia.ia.sak.db.ProsessRepository
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørsmål
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Svaralternativ
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Tema

class SpørreundersøkelseProdusent(
    private val produsent: KafkaProdusent,
    private val iaProsessRepository: ProsessRepository,
    private val planRepository: PlanRepository,
) : Observer<Spørreundersøkelse> {
    override fun receive(input: Spørreundersøkelse) {
        sendPåKafka(spørreundersøkelse = input)
    }

    fun sendPåKafka(spørreundersøkelse: Spørreundersøkelse) {
        val samarbeidNavn = iaProsessRepository.hentProsess(
            saksnummer = spørreundersøkelse.saksnummer,
            prosessId = spørreundersøkelse.samarbeidId,
        )?.navn ?: spørreundersøkelse.virksomhetsNavn
        val plan = when (spørreundersøkelse.type) {
            "Evaluering" -> planRepository.hentPlan(spørreundersøkelse.samarbeidId)
            else -> null
        }
        val (nøkkel, verdi) = spørreundersøkelse.tilKafkaMelding(samarbeidNavn, plan?.tilDto())
        produsent.sendMelding(
            topic = Topic.SPORREUNDERSOKELSE_TOPIC.navn,
            nøkkel = nøkkel,
            verdi = verdi,
        )
    }

    companion object {
        fun Spørreundersøkelse.tilKafkaMelding(
            samarbeidsnavn: String,
            plan: PlanDto?,
        ): Pair<String, String> {
            val nøkkel = this.id.toString()
            val verdi = SerializableSpørreundersøkelse(
                id = this.id.toString(),
                orgnummer = orgnummer,
                virksomhetsNavn = virksomhetsNavn,
                samarbeidsNavn = samarbeidsnavn,
                status = this.status,
                type = this.type,
                plan = plan,
                temaer = temaer.map { it.tilKafkaMelding() },
            )
            return nøkkel to Json.encodeToString(verdi)
        }

        private fun Tema.tilKafkaMelding() =
            SerializableTema(
                id = this.tema.id,
                navn = this.tema.navn,
                spørsmål = this.spørsmål.map { it.tilKafkaMelding() },
            )

        private fun Spørsmål.tilKafkaMelding() =
            SerializableSpørsmål(
                id = spørsmålId.toString(),
                tekst = spørsmåltekst,
                svaralternativer = svaralternativer.map { it.tilKafkaMelding() },
                flervalg = flervalg,
                kategori = undertemanavn,
            )

        private fun Svaralternativ.tilKafkaMelding() =
            SerializableSvaralternativ(
                id = svarId.toString(),
                tekst = svartekst,
            )
    }

    @Serializable
    data class SerializableSpørreundersøkelse(
        override val id: String,
        override val orgnummer: String,
        override val samarbeidsNavn: String,
        override val virksomhetsNavn: String,
        override val status: SpørreundersøkelseStatus,
        override val temaer: List<SerializableTema>,
        override val type: String,
        val plan: PlanDto?,
    ) : SpørreundersøkelseMelding

    @Serializable
    data class SerializableTema(
        override val id: Int,
        override val navn: String,
        override val spørsmål: List<SerializableSpørsmål>,
    ) : TemaMelding

    @Serializable
    data class SerializableSpørsmål(
        override val id: String,
        override val tekst: String,
        override val flervalg: Boolean,
        override val svaralternativer: List<SerializableSvaralternativ>,
        val kategori: String,
    ) : SpørsmålMelding

    @Serializable
    data class SerializableSvaralternativ(
        override val id: String,
        override val tekst: String,
    ) : SvaralternativMelding
}
