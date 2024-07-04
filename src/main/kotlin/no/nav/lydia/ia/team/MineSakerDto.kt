package no.nav.lydia.ia.team

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.IAProsessStatus

@Serializable
data class MineSakerDto(
    val saksnummer: String,
    val status: IAProsessStatus,
    val orgnr: String,
    val orgnavn: String,
    val eidAv: String?,
    val endretTidspunkt: LocalDateTime?,
)