package no.nav.lydia.ia.sak.domene

import com.github.guepardoapps.kulid.ULID
import no.nav.lydia.ia.sak.api.IASakshendelseDto
import java.time.LocalDateTime

open class NyIASakshendelse(
    val saksnummer: String,
    val type: SaksHendelsestype,
    val orgnummer: String,
    val opprettetAv: String,
    val forrigeHendelseId: String? = null,
) {
    companion object {
        fun fromDto(dto: IASakshendelseDto, navIdent: String, saksnummer: String) =
            NyIASakshendelse(
                type = dto.hendelsesType,
                orgnummer = dto.orgnummer,
                opprettetAv = navIdent,
                saksnummer = saksnummer,
            )
    }
}

class IASakshendelse(
    val id : String,
    val opprettetTidspunkt: LocalDateTime,
    forrigeHendelseId: String?,
    saksnummer: String,
    type: SaksHendelsestype,
    orgnummer: String,
    opprettetAv: String,
) : NyIASakshendelse(
    saksnummer = saksnummer,
    type = type,
    orgnummer = orgnummer,
    opprettetAv = opprettetAv,
    forrigeHendelseId = forrigeHendelseId
)

enum class SaksHendelsestype{
    VIRKSOMHET_PRIORITERES,
    VIRKSOMHET_AKSEPTERER_BISTAND,
    VIRKSOMHET_TAKKER_NEI
}