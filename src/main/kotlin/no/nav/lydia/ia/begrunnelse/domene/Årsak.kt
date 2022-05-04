package no.nav.lydia.ia.begrunnelse.domene

import no.nav.lydia.ia.begrunnelse.domene.BegrunnelseType.HAR_IKKE_KAPASITET
import no.nav.lydia.ia.sak.domene.SaksHendelsestype

enum class ÅrsakType(val navn: String, val begrunnelser: List<BegrunnelseType>) {
    NAV_IGANGSETTER_IKKE_TILTAK(
        navn = "Arbeidslivssenteret igangsetter ikke tiltak med arbeidsgiver ",
        begrunnelser = listOf(
            BegrunnelseType.IKKE_ETABLERT_PARTSGRUPPE,
            BegrunnelseType.ØNSKER_IKKE_PARTSGRUPPE,
            BegrunnelseType.IKKE_HØYT_SYKEFRAVÆR,
            BegrunnelseType.IKKE_TID,
            BegrunnelseType.BEHOV_UTENFOR_IA_AVTALEN,
            BegrunnelseType.MINDRE_VIRKSOMHET
        )
    ),
    ARBEIDSGIVER_TAKKET_NEI(
        navn = "Arbeidsgiver har takket nei",
        begrunnelser = listOf(
            HAR_IKKE_KAPASITET,
            BegrunnelseType.HAR_IKKE_TID_NÅ,
            BegrunnelseType.GJENNOMFØRER_TILTAK_PÅ_EGENHÅND,
            BegrunnelseType.GJENNOMFØRER_TILTAK_MED_BHT
        )
    )
}

@kotlinx.serialization.Serializable
class Årsak(val type: ÅrsakType, val begrunnelser: List<BegrunnelseType>) {
    companion object {
        fun from(saksHendelsestype: SaksHendelsestype) = when (saksHendelsestype) {
            SaksHendelsestype.VIRKSOMHET_ER_IKKE_AKTUELL -> listOf(
                ÅrsakType.NAV_IGANGSETTER_IKKE_TILTAK,
                ÅrsakType.ARBEIDSGIVER_TAKKET_NEI
            )
            else -> emptyList()
        }
    }
}

enum class BegrunnelseType(val navn: String) {
    IKKE_ETABLERT_PARTSGRUPPE("Arbeidsplassen har ikke etablert partsgruppe"),
    ØNSKER_IKKE_PARTSGRUPPE("Arbeidsplassen ønsker ikke å etablere partsgruppe eller benytte partssamarbeid i arbeidsmiljøutviklingsarbeidet"),
    IKKE_HØYT_SYKEFRAVÆR("Arbeidsplassen har ikke et høyt sykefravær og er derfor ikke i prioritert gruppe iht IA-avtalen"),
    IKKE_TID("Arbeidsplassen ønsker ikke å sette av tilstrekkelig tid til gjennomføring av prosessarbeid (over lenger tid)"),
    BEHOV_UTENFOR_IA_AVTALEN("Bestillingen og behovet fra arbeidsplassen utenfor vårt mandat iht IA-avtalen"),
    MINDRE_VIRKSOMHET("Arbeidsplassen har et høyt sykefravær, men er en mindre virksomhet (færre ansatte) og er derfor ikke prioritert iht IA-avtalen."),

    HAR_IKKE_KAPASITET("Har ikke kapasitet nå til å gjennomføre prosjektet/tiltaket"),
    HAR_IKKE_TID_NÅ("Har ikke tid nå til å gjennomføre prosjektet/tiltaket"),
    GJENNOMFØRER_TILTAK_PÅ_EGENHÅND("Ønsker å gjennomføre tiltak på egenhånd"),
    GJENNOMFØRER_TILTAK_MED_BHT("Ønsker å gjennomføre tiltak med BHT")
}

class Begrunnelse(val id: Int, val navn: String) {

}