package no.nav.lydia.ia.sak.domene

class IASakshendelse(
    val type: SaksHendelsestype,
    val orgnummer: String,
    val navIdent: String
)

enum class SaksHendelsestype{
    VIRKSOMHET_PRIORITERES,
    VIRKSOMHET_AKSEPTERER_BISTAND,
    VIRKSOMHET_TAKKER_NEI
}