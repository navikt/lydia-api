package no.nav.lydia.ia.sak.api.prosess

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid

@Serializable
data class IAProsessDto(
    val id: Int,
    val saksnummer: String,
    val navn: String,
    val status: IASamarbeid.Status? = null,
    val opprettet: LocalDateTime? = null,
    val sistEndret: LocalDateTime? = null,
)

fun List<IASamarbeid>.tilDto() = map { it.tilDto() }

fun IASamarbeid.tilDto() =
    IAProsessDto(
        id = id,
        saksnummer = saksnummer,
        navn = navn,
        status = status,
        opprettet = opprettet,
        sistEndret = sistEndret,
    )
