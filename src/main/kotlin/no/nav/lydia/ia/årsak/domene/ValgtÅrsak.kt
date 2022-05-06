package no.nav.lydia.ia.årsak.domene

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.SaksHendelsestype

enum class ÅrsakType(val navn: String, val begrunnelser: List<BegrunnelseType>) {
    NAV_IGANGSETTER_IKKE_TILTAK(
        navn = "NAV starter ikke samarbeid med virksomheten fordi",
        begrunnelser = listOf(
            BegrunnelseType.MANGLER_PARTSGRUPPE,
            BegrunnelseType.IKKE_TILFREDSSTILLENDE_SAMARBEID,
            BegrunnelseType.FOR_LAVT_SYKEFRAVÆR,
            BegrunnelseType.IKKE_TID,
            BegrunnelseType.BEHOV_UTENFOR_IA_AVTALEN,
            BegrunnelseType.MINDRE_VIRKSOMHET
        )
    ),
    VIRKSOMHETEN_TAKKET_NEI(
        navn = "Virksomheten har takket nei",
        begrunnelser = listOf(
            BegrunnelseType.HAR_IKKE_KAPASITET,
            BegrunnelseType.GJENNOMFØRER_TILTAK_PÅ_EGENHÅND,
            BegrunnelseType.GJENNOMFØRER_TILTAK_MED_BHT
        )
    );

    companion object {
        fun from(saksHendelsestype: SaksHendelsestype) = when (saksHendelsestype) {
            SaksHendelsestype.VIRKSOMHET_ER_IKKE_AKTUELL -> listOf(
                NAV_IGANGSETTER_IKKE_TILTAK,
                VIRKSOMHETEN_TAKKET_NEI
            )
            else -> emptyList()
        }
    }
}

enum class BegrunnelseType(val navn: String) {
    MANGLER_PARTSGRUPPE("Virksomheten mangler partsgruppe"),
    IKKE_TILFREDSSTILLENDE_SAMARBEID("Virksomheten har ikke tilfredstillende samarbeid med partsgruppen"),
    FOR_LAVT_SYKEFRAVÆR("Virksomheten er vurdert til å ha for lavt sykefravær"),
    MINDRE_VIRKSOMHET("Virksomheten har et høyt sykefravær, men er en mindre virksomhet (færre ansatte)"),
    IKKE_TID("NAV vurderer at virksomheten ikke ønsker å sette av tilstrekkelig tid til samarbeidet"),
    BEHOV_UTENFOR_IA_AVTALEN("Bestillingen og behovet fra virksomheten er utenfor vårt mandat iht IA-avtalen"),

    HAR_IKKE_KAPASITET("Har ikke tid, eller kapasitet nå til å gjennomføre samarbeidet med NAV"),
    GJENNOMFØRER_TILTAK_PÅ_EGENHÅND("Virksomheten vil gjøre tiltak på egenhånd"),
    GJENNOMFØRER_TILTAK_MED_BHT("Virksomheten vil gjennomføre tiltak sammen med BHT")
}

@Serializable
class ValgtÅrsak(val type: ÅrsakType, val begrunnelser: List<BegrunnelseType>)
