package no.nav.lydia.ia.sak.api

import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.VirksomhetIkkeAktuellHendelse

@Serializable
class SakshistorikkDto(
    val saksnummer: String,
    val opprettet: LocalDateTime,
    val sakshendelser: List<SakSnapshotDto>
)

@Serializable
class SakSnapshotDto(
    val status: IAProsessStatus,
    val hendelsestype: IASakshendelseType,
    val tidspunktForSnapshot: LocalDateTime,
    val begrunnelser: List<String>,
    val eier: String?
){
    companion object {
        fun from(iaSakshendelse: IASakshendelse, iaSak: IASak) =
            SakSnapshotDto(
                status = iaSak.status,
                hendelsestype = iaSakshendelse.hendelsesType,
                tidspunktForSnapshot = iaSakshendelse.opprettetTidspunkt.toKotlinLocalDateTime(),
                eier = iaSak.eidAv,
                begrunnelser = when (iaSakshendelse) {
                    is VirksomhetIkkeAktuellHendelse -> iaSakshendelse.valgtÅrsak.begrunnelser.map { it.navn }
                    else -> emptyList()
                }
            )
    }
}

fun IASak.tilSakshistorikk() = SakshistorikkDto(
    saksnummer = this.saksnummer,
    opprettet = this.opprettetTidspunkt.toKotlinLocalDateTime(),
    sakshendelser = hendelser.mapIndexed { index, hendelse ->
        SakSnapshotDto.from(hendelse, IASak.fraHendelser(hendelser.subList(0, index + 1)))
    }.toList()
)

fun List<IASak>.tilSamarbeidshistorikk() = this.map(IASak::tilSakshistorikk)
