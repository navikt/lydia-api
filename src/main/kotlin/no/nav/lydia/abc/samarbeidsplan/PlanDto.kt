package no.nav.lydia.abc.samarbeidsplan

import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toJavaLocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.abc.samarbeid.IASamarbeid
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringDto
import no.nav.lydia.ia.sak.api.dokument.PubliseringStatus
import no.nav.lydia.ia.sak.domene.plan.Plan

fun Plan.tilDto(): PlanDto =
    PlanDto(
        id = id.toString(),
        sistEndret = sistEndret,
        status = status,
        temaer = temaer.tilDtoer(),
    )

@Serializable
data class PlanDto(
    val id: String,
    val sistEndret: LocalDateTime,
    val status: IASamarbeid.Status,
    val temaer: List<PlanTemaDto>,
    val sistPublisert: LocalDateTime? = null,
    val publiseringStatus: DokumentPubliseringDto.Status? = null,
    val harEndringerSidenSistPublisert: Boolean = false,
)

fun Plan.tilDtoMedPubliseringStatus(publiseringStatus: PubliseringStatus? = null): PlanDto =
    PlanDto(
        id = id.toString(),
        sistEndret = sistEndret,
        sistPublisert = publiseringStatus?.publiseringTidspunkt,
        status = status,
        temaer = temaer.tilDtoer(),
        publiseringStatus = publiseringStatus?.status,
        harEndringerSidenSistPublisert = when (publiseringStatus?.status) {
            DokumentPubliseringDto.Status.PUBLISERT -> {
                sistEndret.erEtter(publiseringStatus.publiseringTidspunkt)
            }

            else -> {
                false
            }
        },
    )

fun LocalDateTime.erEtter(dato: LocalDateTime?) =
    if (dato == null) {
        false
    } else {
        this.toJavaLocalDateTime().isAfter(dato.toJavaLocalDateTime())
    }
