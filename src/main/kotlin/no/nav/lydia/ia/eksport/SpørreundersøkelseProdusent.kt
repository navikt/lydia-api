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
                temaer = tema.map { it.tilKafkaMelding() },
                spørreundersøkelseId = this.id.toString(), // TODO: Deprecate this
                temaMedSpørsmålOgSvaralternativer = tema.map { it.tilKafkaMelding() }, // TODO: Deprecate this
            )
            return nøkkel to Json.encodeToString(verdi)
        }

        private fun Tema.tilKafkaMelding() =
            SerializableTema(
                id = this.tema.id,
                temaId = this.tema.id, // TODO: Deprecate this
                navn = this.tema.navn,
                spørsmål = this.spørsmål.map { it.tilKafkaMelding() },
                spørsmålOgSvaralternativer = this.spørsmål.map { it.tilKafkaMelding() }, // TODO: Deprecate this
            )

        private fun Spørsmål.tilKafkaMelding() =
            SerializableSpørsmål(
                id = spørsmålId.toString(),
                tekst = spørsmåltekst,
                spørsmål = spørsmåltekst, // TODO: Deprecate this
                svaralternativer = svaralternativer.map { it.tilKafkaMelding() },
                flervalg = flervalg,
            )

        private fun Svaralternativ.tilKafkaMelding() =
            SerializableSvaralternativ(
                id = svarId.toString(),
                svarId = svarId.toString(), // TODO: Deprecate this
                tekst = svartekst,
                svartekst = svartekst, // TODO: Deprecate this
            )
    }

    @Serializable
    data class SerializableSpørreundersøkelse(
        override val id: String,
        @Deprecated("Bruk id")
        override val spørreundersøkelseId: String,
        override val orgnummer: String,
        override val samarbeidsNavn: String,
        override val virksomhetsNavn: String,
        override val status: SpørreundersøkelseStatus,
        override val temaer: List<SerializableTema>,
        @Deprecated("Bruk temaer")
        override val temaMedSpørsmålOgSvaralternativer: List<SerializableTema>,
        override val type: String,
        val plan: PlanDto?,
    ) : SpørreundersøkelseMelding

    @Serializable
    data class SerializableTema(
        override val id: Int,
        @Deprecated("Bruk id")
        override val temaId: Int,
        override val navn: String,
        override val spørsmål: List<SerializableSpørsmål>,
        @Deprecated("Bruk spørsmål")
        override val spørsmålOgSvaralternativer: List<SerializableSpørsmål>,
    ) : TemaMelding

    @Serializable
    data class SerializableSpørsmål(
        override val id: String,
        override val tekst: String,
        @Deprecated("Bruk tekst")
        override val spørsmål: String,
        override val flervalg: Boolean,
        override val svaralternativer: List<SerializableSvaralternativ>,
    ) : SpørsmålMelding

    @Serializable
    data class SerializableSvaralternativ(
        override val id: String,
        @Deprecated("Bruk id")
        override val svarId: String,
        override val tekst: String,
        @Deprecated("Bruk tekst")
        override val svartekst: String,
    ) : SvaralternativMelding
}
