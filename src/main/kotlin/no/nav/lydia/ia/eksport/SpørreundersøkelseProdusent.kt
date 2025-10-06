package no.nav.lydia.ia.eksport

import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toJavaLocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.SerialName
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
import kotlin.collections.flatMap

class SpørreundersøkelseProdusent(
    kafka: Kafka,
    topic: Topic = Topic.SPORREUNDERSOKELSE_TOPIC,
    private val samarbeidRepository: IASamarbeidRepository,
    private val planRepository: PlanRepository,
) : KafkaProdusent<Spørreundersøkelse>(kafka, topic),
    Observer<Spørreundersøkelse> {
    override fun receive(input: Spørreundersøkelse) = sendPåKafka(input = input)

    override fun tilKafkaMelding(input: Spørreundersøkelse): Pair<String, String> {
        val samarbeidsnavn = samarbeidRepository.hentSamarbeid(
            saksnummer = input.saksnummer,
            samarbeidId = input.samarbeidId,
        )?.navn ?: input.virksomhetsNavn

        val plan = when (input.type) {
            Spørreundersøkelse.Type.Evaluering -> planRepository.hentPlan(samarbeidId = input.samarbeidId)?.tilDto()
            else -> null
        }

        val nøkkel = input.id.toString()
        val verdi = SpørreundersøkelseKafkaDto(
            id = input.id.toString(),
            orgnummer = input.orgnummer,
            virksomhetsNavn = input.virksomhetsNavn,
            samarbeidsnavn = samarbeidsnavn,
            status = input.status,
            type = input.type.name,
            plan = plan,
            temaer = input.temaer.map { it.tilKafkaDto() },
            opprettet = input.opprettetTidspunkt,
            endret = input.endretTidspunkt,
            gyldigTil = input.opprettetTidspunkt.toJavaLocalDateTime().plusDays(1).toKotlinLocalDateTime(),
        )
        return nøkkel to Json.encodeToString(verdi)
    }

    private fun Tema.tilKafkaDto(): TemaKafkaDto =
        TemaKafkaDto(
            id = id,
            navn = navn,
            spørsmål = undertemaer.flatMap { it.spørsmål.tilKafkaDto(undertemanavn = it.navn) },
        )

    private fun Spørsmål.tilKafkaDto(undertemanavn: String): SpørsmålKafkaDto =
        SpørsmålKafkaDto(
            id = id.toString(),
            tekst = tekst,
            svaralternativer = svaralternativer.map { it.tilKafkaDto() },
            flervalg = flervalg,
            kategori = undertemanavn,
        )

    private fun Svaralternativ.tilKafkaDto(): SvaralternativKafkaDto =
        SvaralternativKafkaDto(
            id = id.toString(),
            tekst = tekst,
        )

    private fun List<Spørsmål>.tilKafkaDto(undertemanavn: String): List<SpørsmålKafkaDto> = map { it.tilKafkaDto(undertemanavn = undertemanavn) }

    @Serializable
    data class SpørreundersøkelseKafkaDto(
        val id: String,
        val orgnummer: String,
        @SerialName("samarbeidsNavn")
        val samarbeidsnavn: String,
        val virksomhetsNavn: String,
        val status: Spørreundersøkelse.Status,
        val temaer: List<TemaKafkaDto>,
        val type: String,
        val plan: PlanDto?,
        val opprettet: LocalDateTime,
        val endret: LocalDateTime?,
        val gyldigTil: LocalDateTime,
    )

    @Serializable
    data class TemaKafkaDto(
        val id: Int,
        val navn: String,
        val spørsmål: List<SpørsmålKafkaDto>,
    )

    @Serializable
    data class SpørsmålKafkaDto(
        val id: String,
        val tekst: String,
        val flervalg: Boolean,
        val svaralternativer: List<SvaralternativKafkaDto>,
        val kategori: String,
    )

    @Serializable
    data class SvaralternativKafkaDto(
        val id: String,
        val tekst: String,
    )
}
