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
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Undertema
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
        val samarbeidNavn = samarbeidRepository.hentSamarbeid(
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
            samarbeidsNavn = samarbeidNavn,
            status = input.status.name,
            type = input.type.name,
            opprettet = input.opprettetTidspunkt,
            gyldigTil = input.opprettetTidspunkt.toJavaLocalDateTime().plusDays(1).toKotlinLocalDateTime(),
            endret = input.endretTidspunkt,
            plan = plan,
            temaer = input.temaer.map { it.tilKafkaDto() },
        )
        return nøkkel to Json.encodeToString(verdi)
    }

    private fun Tema.tilKafkaDto(): TemaKafkaDto =
        TemaKafkaDto(
            id = id,
            navn = navn,
            spørsmål = undertemaer.tilKafkaDto(),
        )

    private fun List<Undertema>.tilKafkaDto(): List<SpørsmålKafkaDto> =
        this.flatMap { undertema -> undertema.spørsmål.tilKafkaDto(undertemanavn = undertema.navn) }

    private fun List<Spørsmål>.tilKafkaDto(undertemanavn: String): List<SpørsmålKafkaDto> = map { it.tilKafkaDto(undertemanavn = undertemanavn) }

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

    @Serializable
    data class SpørreundersøkelseKafkaDto(
        val id: String,
        val orgnummer: String,
        val samarbeidsNavn: String,
        val virksomhetsNavn: String,
        val status: String,
        val type: String,
        val plan: PlanDto?,
        val opprettet: LocalDateTime,
        val endret: LocalDateTime?,
        val gyldigTil: LocalDateTime,
        val temaer: List<TemaKafkaDto>,
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
        val kategori: String,
        val svaralternativer: List<SvaralternativKafkaDto>,
    )

    @Serializable
    data class SvaralternativKafkaDto(
        val id: String,
        val tekst: String,
    )
}
