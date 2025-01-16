package no.nav.lydia.ia.sak.api.prosess

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.prosess.IAProsess
import no.nav.lydia.ia.sak.domene.prosess.IAProsessStatus

@Serializable
data class IAProsessDto(
    val id: Int,
    val saksnummer: String,
    val navn: String? = null,
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
