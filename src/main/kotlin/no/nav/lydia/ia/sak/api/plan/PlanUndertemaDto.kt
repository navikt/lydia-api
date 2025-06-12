package no.nav.lydia.ia.sak.api.plan

import kotlinx.datetime.LocalDate
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema

@Serializable
data class PlanUndertemaDto(
    val id: Int,
    val navn: String,
    val målsetning: String,
    val inkludert: Boolean,
    val status: PlanUndertema.Status?,
    val startDato: LocalDate?,
    val sluttDato: LocalDate?,
    val harAktiviteterISalesforce: Boolean,
)

fun List<PlanUndertema>.tilDtoer(): List<PlanUndertemaDto> = map { it.tilDto() }

fun PlanUndertema.tilDto(): PlanUndertemaDto =
    PlanUndertemaDto(
        id = id,
        navn = navn,
        målsetning = målsetning,
        inkludert = inkludert,
        status = status,
        startDato = startDato,
        sluttDato = sluttDato,
        harAktiviteterISalesforce = aktiviteterISalesforce.isNotEmpty(),
    )
