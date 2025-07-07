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
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseDomene
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørsmålDomene
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SvaralternativDomene
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.TemaDomene

class SpørreundersøkelseProdusent(
    kafka: Kafka,
    topic: Topic = Topic.SPORREUNDERSOKELSE_TOPIC,
    private val samarbeidRepository: IASamarbeidRepository,
    private val planRepository: PlanRepository,
) : KafkaProdusent<SpørreundersøkelseDomene>(kafka, topic),
    Observer<SpørreundersøkelseDomene> {
    override fun receive(input: SpørreundersøkelseDomene) = sendPåKafka(input = input)

    override fun tilKafkaMelding(input: SpørreundersøkelseDomene): Pair<String, String> {
        val samarbeidNavn = samarbeidRepository.hentSamarbeid(
            saksnummer = input.saksnummer,
            samarbeidId = input.samarbeidId,
        )?.navn ?: input.virksomhetsNavn

        val plan = when (input.type) {
            SpørreundersøkelseDomene.Type.Evaluering -> planRepository.hentPlan(samarbeidId = input.samarbeidId)?.tilDto()
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

    private fun TemaDomene.tilKafkaMelding(): SerializableTema =
        SerializableTema(
            id = this.id,
            navn = this.navn,
            spørsmål = this.undertemaer.flatMap { undertema ->
                undertema.spørsmål.map { spørsmål -> spørsmål.tilKafkaMelding(undertemanavn = undertema.navn) }
            },
        )

    private fun SpørsmålDomene.tilKafkaMelding(undertemanavn: String) =
        SerializableSpørsmål(
            id = id.toString(),
            tekst = tekst,
            svaralternativer = svaralternativer.map { it.tilKafkaMelding() },
            flervalg = flervalg,
            kategori = undertemanavn,
        )

    private fun SvaralternativDomene.tilKafkaMelding(): SerializableSvaralternativ =
        SerializableSvaralternativ(
            id = id.toString(),
            tekst = tekst,
        )

    @Serializable
    data class SerializableSpørreundersøkelse(
        val id: String,
        val orgnummer: String,
        val samarbeidsNavn: String,
        val virksomhetsNavn: String,
        val status: SpørreundersøkelseDomene.Status,
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
