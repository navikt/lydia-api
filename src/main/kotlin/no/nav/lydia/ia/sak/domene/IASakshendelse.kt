package no.nav.lydia.ia.sak.domene

import com.github.guepardoapps.kulid.ULID
import no.nav.lydia.ia.sak.api.IASakshendelseDto
import java.time.LocalDateTime

class IASakshendelse(
    val id : String,
    val opprettetTidspunkt: LocalDateTime,
    val saksnummer: String,
    val type: SaksHendelsestype,
    val orgnummer: String,
    val opprettetAv: String,
){
    companion object {
        fun fromDto(dto: IASakshendelseDto, navIdent: String): IASakshendelse {
            val id = ULID.random()
            return IASakshendelse(
                id = id,
                opprettetTidspunkt = LocalDateTime.now(),
                saksnummer = dto.saksnummer,
                type = dto.hendelsesType,
                orgnummer = dto.orgnummer,
                opprettetAv = navIdent,
            )

        }
    }
}

enum class SaksHendelsestype{
    OPPRETT_SAK_FOR_VIRKSOMHET,
    VIRKSOMHET_PRIORITERES,
    VIRKSOMHET_AKSEPTERER_BISTAND,
    VIRKSOMHET_TAKKER_NEI
}