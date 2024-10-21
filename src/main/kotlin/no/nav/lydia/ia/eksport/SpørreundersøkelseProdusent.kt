package no.nav.lydia.ia.eksport

import ia.felles.integrasjoner.kafkameldinger.SpørreundersøkelseMelding
import ia.felles.integrasjoner.kafkameldinger.SpørreundersøkelseStatus
import ia.felles.integrasjoner.kafkameldinger.SpørsmålMelding
import ia.felles.integrasjoner.kafkameldinger.SvaralternativMelding
import ia.felles.integrasjoner.kafkameldinger.TemaMelding
import kotlinx.serialization.Serializable
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Observer
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørsmål
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Svaralternativ
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Tema

class SpørreundersøkelseProdusent(
    private val produsent: KafkaProdusent,
) : Observer<Spørreundersøkelse> {
    override fun receive(input: Spørreundersøkelse) {
        sendPåKafka(spørreundersøkelse = input)
    }

    fun sendPåKafka(spørreundersøkelse: Spørreundersøkelse) {
        val (nøkkel, verdi) = spørreundersøkelse.tilKafkaMelding()
        produsent.sendMelding(
            topic = Topic.SPORREUNDERSOKELSE_TOPIC.navn,
            nøkkel = nøkkel,
            verdi = verdi,
        )
    }

    companion object {
        fun Spørreundersøkelse.tilKafkaMelding(): Pair<String, String> {
            val nøkkel = this.id.toString()
            val verdi = SerializableSpørreundersøkelse(
                spørreundersøkelseId = this.id.toString(),
                orgnummer = orgnummer,
                virksomhetsNavn = virksomhetsNavn,
                status = this.status,
                type = this.type,
                temaMedSpørsmålOgSvaralternativer = tema.map { it.tilKafkaMelding() },
            )
            return nøkkel to Json.encodeToString(verdi)
        }

        private fun Tema.tilKafkaMelding() =
            SerializableTema(
                temaId = this.tema.id,
                navn = this.tema.navn,
                spørsmålOgSvaralternativer = this.spørsmål.map { it.tilKafkaMelding() },
            )

        private fun Spørsmål.tilKafkaMelding() =
            SerializableSpørsmål(
                id = spørsmålId.toString(),
                spørsmål = spørsmåltekst,
                svaralternativer = svaralternativer.map { it.tilKafkaMelding() },
                flervalg = flervalg,
            )

        private fun Svaralternativ.tilKafkaMelding() =
            SerializableSvaralternativ(
                svarId = svarId.toString(),
                svartekst = svartekst,
            )
    }

    @Serializable
    data class SerializableSpørreundersøkelse(
        override val spørreundersøkelseId: String,
        override val orgnummer: String,
        override val virksomhetsNavn: String,
        override val status: SpørreundersøkelseStatus,
        override val temaMedSpørsmålOgSvaralternativer: List<SerializableTema>,
        override val type: String,
    ) : SpørreundersøkelseMelding

    @Serializable
    data class SerializableTema(
        override val temaId: Int,
        override val navn: String,
        override val spørsmålOgSvaralternativer: List<SerializableSpørsmål>,
    ) : TemaMelding

    @Serializable
    data class SerializableSpørsmål(
        override val id: String,
        override val spørsmål: String,
        override val flervalg: Boolean,
        override val svaralternativer: List<SerializableSvaralternativ>,
    ) : SpørsmålMelding

    @Serializable
    data class SerializableSvaralternativ(
        override val svarId: String,
        override val svartekst: String,
    ) : SvaralternativMelding
}
