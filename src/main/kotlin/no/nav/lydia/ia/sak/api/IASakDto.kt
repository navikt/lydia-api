package no.nav.lydia.ia.sak.api

import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakstype
import java.time.LocalDateTime

class IASakDto(
    val saksnummer: String,
    val orgnr: String,
    val type: IASakstype,
    var status: IAProsessStatus,
    val opprettet: LocalDateTime,
    val opprettet_av: String,
    val endret: LocalDateTime?,
    val endretAv: String?,
    val endretAvHendelseId: String?
) {
    companion object {
        fun List<IASak>.toDto() = this.map { iaSak -> iaSak.toDto() }

        fun IASak.toDto() = IASakDto(
            saksnummer = this.saksnummer,
            orgnr = this.orgnr,
            type = this.type,
            status = this.status,
            opprettet = this.opprettet,
            opprettet_av = this.opprettet_av,
            endret = this.endret,
            endretAv = this.endretAv,
            endretAvHendelseId = this.endretAvHendelseId
        )
    }
}