package no.nav.lydia.ia.sak.api

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.GyldigHendelse
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.tilgangskontroll.Rådgiver
import java.time.LocalDateTime

@Serializable
data class IASakDto(
    val saksnummer: String,
    val orgnr: String,
    var status: IAProsessStatus,
    val opprettetAv: String,
    @Serializable(with = LocalDateTimeSerializer::class)
    val opprettetTidspunkt: LocalDateTime,
    val endretAv: String?,
    @Serializable(with = LocalDateTimeSerializer::class)
    val endretTidspunkt: LocalDateTime?,
    val eidAv: String?,
    val endretAvHendelseId: String,
    val gyldigeNesteHendelser : List<GyldigHendelse>
) {
    companion object {
        fun List<IASak>.toDto(rådgiver: Rådgiver) = this.map { it.toDto(rådgiver) }

        fun IASak.toDto(rådgiver: Rådgiver) = IASakDto(
            saksnummer = this.saksnummer,
            orgnr = this.orgnr,
            status = this.status,
            opprettetAv = this.opprettetAv,
            opprettetTidspunkt = this.opprettetTidspunkt,
            endretAv = this.endretAv,
            endretTidspunkt = this.endretTidspunkt,
            eidAv = this.eidAv,
            endretAvHendelseId = this.endretAvHendelseId,
            gyldigeNesteHendelser = this.gyldigeNesteHendelser(rådgiver)
        )
    }
}
