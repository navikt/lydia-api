package no.nav.lydia.ia.eksport

import java.time.LocalDate.now
import kotlinx.datetime.LocalDate
import kotlinx.datetime.toKotlinLocalDate
import kotlinx.serialization.Serializable
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.KartleggingStatus
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørsmål
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Svaralternativ
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Tema
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Temanavn

class SpørreundersøkelseProdusent(
    private val produsent: KafkaProdusent,
) {
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
            val verdi = SpørreundersøkelseKafkaDto(
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
            TemaKafkaDto(
                temaId = this.tema.id,
                temanavn = this.tema.navn,
                beskrivelse = this.tema.beskrivelse,
                introtekst = this.tema.introtekst,
                spørsmålOgSvaralternativer = this.spørsmål.map { it.tilKafkaMelding() }
            )

        private fun Spørsmål.tilKafkaMelding() =
            SpørsmålKafkaDto(
                id = spørsmålId.toString(),
                spørsmål = spørsmåltekst,
                svaralternativer = svaralternativer.map { it.tilKafkaMelding() },
                flervalg = flervalg,
            )

        private fun Svaralternativ.tilKafkaMelding() =
            SvaralternativKafkaDto(
                svarId = svarId.toString(),
                svartekst = svartekst,
            )
    }

    @Serializable
    data class SpørreundersøkelseKafkaDto(
        val spørreundersøkelseId: String,
        val vertId: String,
        val orgnummer: String,
        val virksomhetsNavn: String,
        val status: KartleggingStatus,
        val type: String,
        val temaMedSpørsmålOgSvaralternativer: List<TemaKafkaDto>,
        val avslutningsdato: LocalDate,
    )

    @Serializable
    data class TemaKafkaDto(
        val temaId: Int,
        val temanavn: Temanavn,
        val beskrivelse: String,
        val introtekst: String,
        val spørsmålOgSvaralternativer: List<SpørsmålKafkaDto>,
    )

    @Serializable
    data class SpørsmålKafkaDto(
        val id: String,
        val spørsmål: String,
        val svaralternativer: List<SvaralternativKafkaDto>,
        val flervalg: Boolean,
    )

    @Serializable
    data class SvaralternativKafkaDto(
        val svarId: String,
        val svartekst: String,
    )
}
