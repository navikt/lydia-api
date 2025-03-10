package no.nav.lydia.ia.eksport

import kotlinx.datetime.LocalDate
import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import no.nav.lydia.Kafka
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.api.plan.PlanDto
import no.nav.lydia.ia.sak.api.plan.PlanTemaDto
import no.nav.lydia.ia.sak.api.plan.PlanUndertemaDto
import no.nav.lydia.ia.sak.domene.prosess.IAProsessStatus

class SamarbeidsplanProdusent(
    kafka: Kafka,
    topic: Topic = Topic.SAMARBEIDSPLAN_TOPIC,
    clientId: String = "${topic.konsumentGruppe}-samarbeidsplan-producer",
) : KafkaProdusent<SamarbeidsplanKafkaMelding>(kafka = kafka, topic = topic, clientId = clientId) {
    // TODO: burde ikke denne ta i mot domene og gjøre om til KAFKA melding?
    override fun tilKafkaMelding(input: SamarbeidsplanKafkaMelding): Pair<String, String> {
        val key = "${input.saksnummer}-${input.samarbeid.id}-${input.plan.id}"
        val value = Json.encodeToString<SamarbeidsplanKafkaMelding>(input)
        return key to value
    }
}

@Serializable
data class SamarbeidsplanKafkaMelding(
    val orgnr: String,
    val saksnummer: String,
    val samarbeid: SamarbeidDto,
    val plan: PlanKafkaMeldingDto,
)

@Serializable
data class PlanKafkaMeldingDto(
    val id: String,
    val sistEndret: LocalDateTime,
    val sistPublisert: LocalDate?,
    val temaer: List<PlanTemaKafkaMeldingDto>,
)

@Serializable
data class PlanTemaKafkaMeldingDto(
    val id: Int,
    val navn: String,
    val inkludert: Boolean,
    val undertemaer: List<PlanUndertemaDto>,
)

@Serializable
data class SamarbeidDto(
    val id: Int,
    val navn: String? = null,
    val status: IAProsessStatus? = null,
    val startDato: LocalDate? = null,
    val sluttDato: LocalDate? = null,
    val endretTidspunkt: LocalDateTime? = null,
)

fun PlanDto.tilPlanKafkaMeldingDto() =
    PlanKafkaMeldingDto(
        id = this.id,
        sistEndret = this.sistEndret,
        sistPublisert = this.sistPublisert,
        temaer = this.temaer.tilPlanTemaKafkaMeldingDtoer(),
    )

fun List<PlanTemaDto>.tilPlanTemaKafkaMeldingDtoer() = this.map { it.tilPlanTemaKafkaMeldingDto() }

fun PlanTemaDto.tilPlanTemaKafkaMeldingDto() =
    PlanTemaKafkaMeldingDto(
        id = this.id,
        navn = this.navn,
        inkludert = this.inkludert,
        undertemaer = this.undertemaer,
    )
