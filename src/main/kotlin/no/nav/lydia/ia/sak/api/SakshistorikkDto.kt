package no.nav.lydia.ia.sak.api

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.SaksHendelsestype
import no.nav.lydia.ia.sak.domene.VirksomhetIkkeAktuellHendelse
import no.nav.lydia.ia.årsak.domene.BegrunnelseType
import java.time.LocalDateTime

@Serializable
class SakshistorikkDto(
    val saksnummer: String,
    @Serializable(with = LocalDateTimeSerializer::class)
    val opprettet: LocalDateTime,
    val sakshendelser: List<SakSnapshotDto>
)

@Serializable
class SakSnapshotDto(
    val status: IAProsessStatus,
    val hendelsestype: SaksHendelsestype,
    @Serializable(with = LocalDateTimeSerializer::class)
    val tidspunktForSnapshot: LocalDateTime,
    val begrunnelser: List<BegrunnelseType>,
    val eier: String?
)

fun IASak.tilSakshistorikk(): SakshistorikkDto {
    val førsteHendelse = hendelser.first()
    val resterendeHendelser = hendelser.minus(førsteHendelse)
    val sak = IASak.fraFørsteHendelse(førsteHendelse)
    val sakSnapshotDtos = mutableListOf<SakSnapshotDto>()
    resterendeHendelser.forEach { hendelse ->
        sak.behandleHendelse(hendelse)
        sakSnapshotDtos.add(
            SakSnapshotDto(
                status = sak.status,
                hendelsestype = hendelse.hendelsesType,
                tidspunktForSnapshot = hendelse.opprettetTidspunkt,
                eier = sak.eidAv,
                begrunnelser = when (hendelse) {
                    is VirksomhetIkkeAktuellHendelse -> hendelse.valgtÅrsak.begrunnelser
                    else -> emptyList()
            })
        )
    }

    return SakshistorikkDto(
        saksnummer = this.saksnummer,
        opprettet = this.opprettetTidspunkt,
        sakshendelser = sakSnapshotDtos.toList())
}

fun List<IASak>.tilSamarbeidshistorikk() = this.map(IASak::tilSakshistorikk)