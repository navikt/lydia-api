package no.nav.lydia.ia.sak.api

import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakstype
import kotlinx.serialization.Serializable
import java.time.LocalDateTime

@Serializable
data class IASakDto(
    val saksnummer: String,
    val orgnr: String,
    val type: IASakstype,
    var status: IAProsessStatus,
    val opprettetAv: String,
    @Serializable(with = LocalDateTimeSerializer::class)
    val opprettetTidspunkt: LocalDateTime,
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
            opprettetTidspunkt = this.opprettet,
            endretAv = this.endretAv,
            endretAvHendelseId = this.endretAvHendelseId
        )
    }
}
