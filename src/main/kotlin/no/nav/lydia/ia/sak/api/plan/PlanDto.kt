package no.nav.lydia.ia.sak.api.plan

import kotlinx.datetime.LocalDate
import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.api.dokument.DokumentPublisering
import no.nav.lydia.ia.sak.domene.plan.Plan
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid

interface PlanDtoI {
    val id: String
    val sistEndret: LocalDateTime
    val status: IASamarbeid.Status
    val temaer: List<PlanTemaDto>
}

@Serializable
data class PlanDto(
    override val id: String,
    override val sistEndret: LocalDateTime,
    val sistPublisert: LocalDate?,
    override val status: IASamarbeid.Status,
    override val temaer: List<PlanTemaDto>,
) : PlanDtoI

fun Plan.tilDto(): PlanDto =
    PlanDto(
        id = id.toString(),
        sistEndret = sistEndret,
        sistPublisert = sistPublisert,
        status = status,
        temaer = temaer.tilDtoer(),
    )

@Serializable
data class PlanMedPubliseringStatusDto(
    override val id: String,
    override val sistEndret: LocalDateTime,
    override val status: IASamarbeid.Status,
    override val temaer: List<PlanTemaDto>,
    val sistPublisert: LocalDateTime? = null,
    val publiseringStatus: DokumentPublisering.Status? = null,
) : PlanDtoI

fun Plan.tilDtoMedPubliseringStatus(
    publiseringStatus: DokumentPublisering.Status? = null,
    publiseringTidspunkt: LocalDateTime? = null,
): PlanMedPubliseringStatusDto =
    PlanMedPubliseringStatusDto(
        id = id.toString(),
        sistEndret = sistEndret,
        sistPublisert = publiseringTidspunkt,
        status = status,
        temaer = temaer.tilDtoer(),
        publiseringStatus = publiseringStatus,
    )
