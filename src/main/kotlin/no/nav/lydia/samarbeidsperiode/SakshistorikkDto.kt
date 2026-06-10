package no.nav.lydia.samarbeidsperiode

import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.samarbeid.IASamarbeidDto

@Serializable
class SakshistorikkDto(
    val saksnummer: String,
    val opprettet: LocalDateTime,
    val sistEndret: LocalDateTime,
    val sakshendelser: List<SakSnapshotDto>,
    val samarbeid: List<IASamarbeidDto>,
)

@Serializable
class SakSnapshotDto(
    val status: IASak.Status,
    val hendelsestype: IASakshendelseType,
    val tidspunktForSnapshot: LocalDateTime,
    val begrunnelser: List<String>,
    val eier: String?,
    val hendelseOpprettetAv: String,
) {
    companion object {
        fun from(iaSakshendelse: IASakshendelse) =
            SakSnapshotDto(
                status = iaSakshendelse.resulterendeStatus ?: IASak.Status.IKKE_AKTIV,
                hendelsestype = iaSakshendelse.hendelsesType,
                tidspunktForSnapshot = iaSakshendelse.opprettetTidspunkt.toKotlinLocalDateTime(),
                eier = iaSakshendelse.opprettetAv,
                begrunnelser = when (iaSakshendelse) {
                    is VirksomhetIkkeAktuellHendelse -> iaSakshendelse.valgtÅrsak.begrunnelser.map { it.navn }
                    else -> emptyList()
                },
                hendelseOpprettetAv = iaSakshendelse.opprettetAv,
            )
    }
}

fun IASak.tilSakshistorikk(samarbeid: List<IASamarbeidDto>): SakshistorikkDto =
    SakshistorikkDto(
        saksnummer = this.saksnummer,
        opprettet = this.opprettetTidspunkt.toKotlinLocalDateTime(),
        sistEndret = this.endretTidspunkt?.toKotlinLocalDateTime()
            ?: this.opprettetTidspunkt.toKotlinLocalDateTime(),
        sakshendelser = hendelser.mapIndexed { _, hendelse: IASakshendelse ->
            SakSnapshotDto.from(hendelse)
        }.toList(),
        samarbeid = samarbeid,
    )

fun IASakDto.tilSakshistorikk(samarbeid: List<IASamarbeidDto>): SakshistorikkDto =
    SakshistorikkDto(
        saksnummer = this.saksnummer,
        opprettet = this.opprettetTidspunkt,
        sistEndret = this.endretTidspunkt ?: this.opprettetTidspunkt,
        sakshendelser = hendelser.mapIndexed { _, hendelse: IASakshendelse ->
            SakSnapshotDto.from(hendelse)
        }.toList(),
        samarbeid = samarbeid,
    )
