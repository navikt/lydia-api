package no.nav.lydia.ia.sak.api

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.*
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
    val begrunnelser: List<String>,
    val eier: String?
){
    companion object {
        fun from(iaSakshendelse: IASakshendelse, iaSak: IASak) =
            SakSnapshotDto(
                status = iaSak.status,
                hendelsestype = iaSakshendelse.hendelsesType,
                tidspunktForSnapshot = iaSakshendelse.opprettetTidspunkt,
                eier = iaSak.eidAv,
                begrunnelser = when (iaSakshendelse) {
                    is VirksomhetIkkeAktuellHendelse -> iaSakshendelse.valgtÅrsak.begrunnelser.map { it.navn }
                    else -> emptyList()
                }
            )
    }
}

fun IASak.tilSakshistorikk(): SakshistorikkDto {
    val førsteHendelse = hendelser.first()
    val resterendeHendelser = hendelser.minus(førsteHendelse)
    val sak = IASak.fraFørsteHendelse(førsteHendelse)
    val sakSnapshotDtos = mutableListOf<SakSnapshotDto>()
    sakSnapshotDtos.add(SakSnapshotDto.from(iaSakshendelse = førsteHendelse, iaSak = sak))
    resterendeHendelser.forEach { hendelse ->
        sak.behandleHendelse(hendelse)
        sakSnapshotDtos.add(SakSnapshotDto.from(iaSakshendelse = hendelse, iaSak = sak))
    }

    return SakshistorikkDto(
        saksnummer = this.saksnummer,
        opprettet = this.opprettetTidspunkt,
        sakshendelser = sakSnapshotDtos.toList())
}

fun List<IASak>.tilSamarbeidshistorikk() = this.map(IASak::tilSakshistorikk)
