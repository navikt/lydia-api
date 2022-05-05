package no.nav.lydia.ia.sak.api


import kotlinx.serialization.Serializable
import no.nav.lydia.ia.begrunnelse.domene.ValgtÅrsak
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.SaksHendelsestype
import no.nav.lydia.ia.sak.domene.VirksomhetIkkeAktuellHendelse
import java.time.LocalDateTime

@Serializable
open class IASakshendelseDto(
    val orgnummer: String,
    val saksnummer: String,
    val hendelsesType: SaksHendelsestype,
    val endretAvHendelseId: String,
    val payload: String? = null
)

@Serializable
open class IASakshendelseOppsummeringDto(
    val id: String,
    val orgnummer: String,
    val saksnummer: String,
    val hendelsestype: SaksHendelsestype,
    val opprettetAv: String,
    @Serializable(with = LocalDateTimeSerializer::class)
    val opprettetTidspunkt: LocalDateTime
    ) {
    companion object {
        fun List<IASakshendelse>.toDto() = this.map { it.toDto() }

        fun IASakshendelse.toDto() = IASakshendelseOppsummeringDto(
            id = this.id,
            orgnummer = this.orgnummer,
            saksnummer = this.saksnummer,
            hendelsestype = this.hendelsesType,
            opprettetAv = this.opprettetAv,
            opprettetTidspunkt = this.opprettetTidspunkt,
        )
    }
}

class VirksomhetIkkeAktuellHendelseOppsummeringDto(
    id: String,
    orgnummer: String,
    saksnummer: String,
    hendelsestype: SaksHendelsestype,
    opprettetAv: String,
    opprettetTidspunkt: LocalDateTime,
    @Serializable
    val valgtÅrsak: ValgtÅrsak
) : IASakshendelseOppsummeringDto(
    id = id,
    orgnummer = orgnummer,
    saksnummer = saksnummer,
    hendelsestype = hendelsestype,
    opprettetAv = opprettetAv,
    opprettetTidspunkt = opprettetTidspunkt
) {
    companion object {
        fun VirksomhetIkkeAktuellHendelse.toDto() = VirksomhetIkkeAktuellHendelseOppsummeringDto(
            id = this.id,
            orgnummer = this.orgnummer,
            saksnummer = this.saksnummer,
            hendelsestype = this.hendelsesType,
            opprettetAv = this.opprettetAv,
            opprettetTidspunkt = this.opprettetTidspunkt,
            valgtÅrsak = this.valgtÅrsak
        )
    }
}

