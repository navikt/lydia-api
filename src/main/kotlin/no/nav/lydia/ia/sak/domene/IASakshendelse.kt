package no.nav.lydia.ia.sak.domene

import no.nav.lydia.ia.sak.api.IASakshendelseDto

class IASakshendelse(
    val type: SaksHendelsestype,
    val orgnummer: String,
    val navIdent: String
) {
    companion object {
        fun fromDto(dto: IASakshendelseDto, navIdent: String) =
            IASakshendelse(
                type = SaksHendelsestype.valueOf(dto.hendelsesType),
                orgnummer = dto.orgnummer,
                navIdent = navIdent
            )

    }
}

enum class SaksHendelsestype{
    VIRKSOMHET_PRIORITERES,
    VIRKSOMHET_AKSEPTERER_BISTAND,
    VIRKSOMHET_TAKKER_NEI
}