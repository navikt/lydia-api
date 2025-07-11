package no.nav.lydia.ia.eksport

import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toJavaLocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import no.nav.lydia.Kafka
import no.nav.lydia.Observer
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.api.plan.PlanDto
import no.nav.lydia.ia.sak.api.plan.tilDto
import no.nav.lydia.ia.sak.db.IASamarbeidRepository
import no.nav.lydia.ia.sak.db.PlanRepository
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørsmål
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Svaralternativ
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Tema

class SpørreundersøkelseProdusent(
    kafka: Kafka,
    topic: Topic = Topic.SPORREUNDERSOKELSE_TOPIC,
    private val samarbeidRepository: IASamarbeidRepository,
    private val planRepository: PlanRepository,
) : KafkaProdusent<Spørreundersøkelse>(kafka, topic),
    Observer<Spørreundersøkelse> {
    override fun receive(input: Spørreundersøkelse) = sendPåKafka(input = input)

    override fun tilKafkaMelding(input: Spørreundersøkelse): Pair<String, String> {
        val samarbeidNavn = samarbeidRepository.hentSamarbeid(
            saksnummer = input.saksnummer,
            samarbeidId = input.samarbeidId,
        )?.navn ?: input.virksomhetsNavn

        val plan = when (input.type) {
            Spørreundersøkelse.Type.Evaluering -> planRepository.hentPlan(samarbeidId = input.samarbeidId)?.tilDto()
            else -> null
        }

        val nøkkel = input.id.toString()
        val verdi = SerializableSpørreundersøkelse(
            id = input.id.toString(),
            orgnummer = input.orgnummer,
            virksomhetsNavn = input.virksomhetsNavn,
            samarbeidsNavn = samarbeidNavn,
            status = input.status,
            type = input.type.name,
            plan = plan,
            temaer = input.temaer.map { it.tilKafkaMelding() },
            opprettet = input.opprettetTidspunkt,
            endret = input.endretTidspunkt,
            gyldigTil = input.opprettetTidspunkt.toJavaLocalDateTime().plusDays(1).toKotlinLocalDateTime(),
        )
        return nøkkel to Json.encodeToString(verdi)
    }

    private fun Tema.tilKafkaMelding(): SerializableTema =
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

    private fun Svaralternativ.tilKafkaMelding(): SerializableSvaralternativ =
        SerializableSvaralternativ(
            id = svarId.toString(),
            tekst = svartekst,
        )

    @Serializable
    data class SerializableSpørreundersøkelse(
        val id: String,
        val orgnummer: String,
        val samarbeidsNavn: String,
        val virksomhetsNavn: String,
        val status: Spørreundersøkelse.Status,
        val temaer: List<SerializableTema>,
        val type: String,
        val plan: PlanDto?,
        val opprettet: LocalDateTime,
        val endret: LocalDateTime?,
        val gyldigTil: LocalDateTime,
    )

    @Serializable
    data class SerializableTema(
        val id: Int,
        val navn: String,
        val spørsmål: List<SerializableSpørsmål>,
    )

    @Serializable
    data class SerializableSpørsmål(
        val id: String,
        val tekst: String,
        val flervalg: Boolean,
        val svaralternativer: List<SerializableSvaralternativ>,
        val kategori: String,
    )

    @Serializable
    data class SerializableSvaralternativ(
        val id: String,
        val tekst: String,
    )
}
