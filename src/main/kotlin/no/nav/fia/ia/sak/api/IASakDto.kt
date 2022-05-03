package no.nav.fia.ia.sak.api

import no.nav.fia.ia.sak.domene.IAProsessStatus
import no.nav.fia.ia.sak.domene.IASak
import no.nav.fia.ia.sak.domene.IASakstype
import kotlinx.serialization.Serializable
import no.nav.fia.ia.sak.domene.SaksHendelsestype
import no.nav.fia.tilgangskontroll.Rådgiver
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
    @Serializable(with = LocalDateTimeSerializer::class)
    val endretTidspunkt: LocalDateTime?,
    val eidAv: String?,
    val endretAvHendelseId: String,
    val gyldigeNesteHendelser : List<SaksHendelsestype>
) {
    companion object {
        fun List<IASak>.toDto(rådgiver: Rådgiver) = this.map { it.toDto(rådgiver) }

        fun IASak.toDto(rådgiver: Rådgiver) = IASakDto(
            saksnummer = this.saksnummer,
            orgnr = this.orgnr,
            type = this.type,
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
