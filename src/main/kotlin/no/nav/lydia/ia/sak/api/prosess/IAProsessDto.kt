package no.nav.lydia.ia.sak.api.prosess

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.samarbeid.IAProsess
import no.nav.lydia.ia.sak.domene.samarbeid.IAProsessStatus

@Serializable
data class IAProsessDto(
    val id: Int,
    val saksnummer: String,
    val navn: String,
    val status: IAProsessStatus? = null,
    val opprettet: LocalDateTime? = null,
    val sistEndret: LocalDateTime? = null,
)

fun List<IAProsess>.tilDto() = map { it.tilDto() }

fun IAProsess.tilDto() =
    IAProsessDto(
        id = id,
        saksnummer = saksnummer,
        navn = navn,
        status = status,
        opprettet = opprettet,
        sistEndret = sistEndret,
    )
