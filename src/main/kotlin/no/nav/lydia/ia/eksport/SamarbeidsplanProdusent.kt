package no.nav.lydia.ia.eksport

import kotlinx.datetime.LocalDate
import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.api.plan.PlanDto
import no.nav.lydia.ia.sak.api.plan.PlanTemaDto
import no.nav.lydia.ia.sak.api.plan.PlanUndertemaDto
import no.nav.lydia.ia.sak.domene.prosess.IAProsessStatus

class SamarbeidsplanProdusent(
    private val produsent: KafkaProdusent,
) {
    fun sendPåKafka(samarbeidsplan: SamarbeidsplanKafkaMelding) {
        val (nøkkel, melding) = samarbeidsplan.tilKeyValue()
        produsent.sendMelding(
            topic = Topic.SAMARBEIDSPLAN_TOPIC.navn,
            nøkkel = nøkkel,
            verdi = melding,
        )
    }

    private fun SamarbeidsplanKafkaMelding.tilKeyValue() =
        "${this.saksnummer}-${this.samarbeid.id}-${this.plan.id}" to Json.encodeToString<SamarbeidsplanKafkaMelding>(this)
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
