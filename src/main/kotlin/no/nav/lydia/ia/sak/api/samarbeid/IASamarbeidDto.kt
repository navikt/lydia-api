package no.nav.lydia.ia.sak.api.samarbeid

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid

@Serializable
data class IASamarbeidDto(
    val id: Int,
    val saksnummer: String,
    val navn: String,
    val status: IASamarbeid.Status? = null,
    val opprettet: LocalDateTime? = null,
    val sistEndret: LocalDateTime? = null,
)

fun List<IASamarbeid>.tilDto() = map { it.tilDto() }

fun IASamarbeid.tilDto() =
    IASamarbeidDto(
        id = id,
        saksnummer = saksnummer,
        navn = navn,
        status = status,
        opprettet = opprettet,
        sistEndret = sistEndret,
    )
