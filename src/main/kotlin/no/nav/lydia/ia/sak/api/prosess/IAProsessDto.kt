package no.nav.lydia.ia.sak.api.prosess

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.prosess.IAProsess
import no.nav.lydia.ia.sak.domene.prosess.IAProsessStatus

@Serializable
data class IAProsessDto(
    val id: Int,
    val saksnummer: String,
    val navn: String? = null,
    val status: IAProsessStatus? = null,
)

fun List<IAProsess>.tilDto() = map { it.tilDto() }
fun IAProsess.tilDto() = IAProsessDto(
    id = id,
    saksnummer = saksnummer,
    navn = navn,
    status = status
)
