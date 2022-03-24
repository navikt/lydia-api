package no.nav.lydia.ia.sak.api

import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakstype
import kotlinx.serialization.Serializable

@Serializable
data class IASakDto(
    val saksnummer: String,
    val orgnr: String,
    val type: IASakstype,
    var status: IAProsessStatus,
    val opprettetAv: String,
    val endretAv: String?,
    val endretAvHendelseId: String
) {
    companion object {
        fun List<IASak>.toDto() = this.map { it.toDto() }

        fun IASak.toDto() = IASakDto(
            saksnummer = this.saksnummer,
            orgnr = this.orgnr,
            type = this.type,
            status = this.status,
            opprettetAv = this.opprettetAv,
            endretAv = this.endretAv,
            endretAvHendelseId = this.endretAvHendelseId
        )
    }
}