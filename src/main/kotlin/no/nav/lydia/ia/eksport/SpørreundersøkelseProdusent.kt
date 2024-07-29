package no.nav.lydia.ia.eksport

import ia.felles.integrasjoner.kafkameldinger.SpørreundersøkelseMelding
import ia.felles.integrasjoner.kafkameldinger.SpørreundersøkelseStatus
import ia.felles.integrasjoner.kafkameldinger.SpørsmålMelding
import ia.felles.integrasjoner.kafkameldinger.SvaralternativMelding
import ia.felles.integrasjoner.kafkameldinger.TemaMelding
import ia.felles.integrasjoner.kafkameldinger.Temanavn
import java.time.LocalDate.now
import kotlinx.datetime.LocalDate
import kotlinx.datetime.toKotlinLocalDate
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
                vertId = this.vertId?.toString() ?: "",
                orgnummer = orgnummer,
                virksomhetsNavn = virksomhetsNavn,
                status = this.status,
                type = "kartlegging",
                temaMedSpørsmålOgSvaralternativer = tema.map { it.tilKafkaMelding() },
                avslutningsdato = now().toKotlinLocalDate(),
            )
            return nøkkel to Json.encodeToString(verdi)
        }

        private fun Tema.tilKafkaMelding() =
            SerializableTema(
                temaId = this.tema.id,
                temanavn = this.tema.navn,
                beskrivelse = this.tema.beskrivelse,
                introtekst = this.tema.introtekst,
                navn = this.tema.beskrivelse,
                spørsmålOgSvaralternativer = this.spørsmål.map { it.tilKafkaMelding() }
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
        override val vertId: String,
        override val orgnummer: String,
        override val virksomhetsNavn: String,
        override val status: SpørreundersøkelseStatus,
        override val type: String,
        override val temaMedSpørsmålOgSvaralternativer: List<SerializableTema>,
        override val avslutningsdato: LocalDate,
    ) : SpørreundersøkelseMelding

    @Serializable
    data class SerializableTema(
        override val temaId: Int,
        override val temanavn: Temanavn?,
        override val beskrivelse: String,
        override val introtekst: String,
        override val spørsmålOgSvaralternativer: List<SerializableSpørsmål>,
        override val navn: String?
    ) : TemaMelding

    @Serializable
    data class SerializableSpørsmål(
        override val id: String,
        override val spørsmål: String,
        override val svaralternativer: List<SerializableSvaralternativ>,
        override val flervalg: Boolean,
    ) : SpørsmålMelding

    @Serializable
    data class SerializableSvaralternativ(
        override val svarId: String,
        override val svartekst: String,
    ) : SvaralternativMelding
}
