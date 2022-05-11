package no.nav.lydia.ia.årsak.domene

import no.nav.lydia.ia.sak.domene.SaksHendelsestype
import no.nav.lydia.ia.årsak.domene.GyldigBegrunnelse.Companion.somGyldigeBegrunnelser

@kotlinx.serialization.Serializable
class GyldigÅrsak(val type: ÅrsakType, val navn: String = type.navn, val begrunnelser: List<GyldigBegrunnelse>) {
    companion object {
        fun from(saksHendelsestype: SaksHendelsestype) = when (saksHendelsestype) {
            SaksHendelsestype.VIRKSOMHET_ER_IKKE_AKTUELL -> listOf(
                GyldigÅrsak(
                    type = ÅrsakType.NAV_IGANGSETTER_IKKE_TILTAK,
                    begrunnelser = listOf(
                        BegrunnelseType.MANGLER_PARTSGRUPPE,
                        BegrunnelseType.IKKE_TILFREDSSTILLENDE_SAMARBEID,
                        BegrunnelseType.FOR_LAVT_SYKEFRAVÆR,
                        BegrunnelseType.IKKE_TID,
                        BegrunnelseType.MINDRE_VIRKSOMHET
                    ).somGyldigeBegrunnelser()
                ),
                GyldigÅrsak(
                    type = ÅrsakType.VIRKSOMHETEN_TAKKET_NEI,
                    begrunnelser = listOf(
                        BegrunnelseType.HAR_IKKE_KAPASITET,
                        BegrunnelseType.GJENNOMFØRER_TILTAK_PÅ_EGENHÅND,
                        BegrunnelseType.GJENNOMFØRER_TILTAK_MED_BHT
                    ).somGyldigeBegrunnelser()
                )
            )
            else -> emptyList()
        }
    }
}

@kotlinx.serialization.Serializable
class GyldigBegrunnelse(val type: BegrunnelseType, val navn: String = type.navn){
    companion object{
        fun List<BegrunnelseType>.somGyldigeBegrunnelser() = this.map { GyldigBegrunnelse(type = it) }
        fun List<GyldigBegrunnelse>.somBegrunnelseType() = this.map { it.type }
    }
}

enum class ÅrsakType(val navn: String) {
    NAV_IGANGSETTER_IKKE_TILTAK(navn = "NAV har besluttet å ikke starte samarbeid"),
    VIRKSOMHETEN_TAKKET_NEI(navn = "Virksomheten har takket nei");
}

enum class BegrunnelseType(val navn: String) {
    MANGLER_PARTSGRUPPE(navn = "Virksomheten mangler partsgruppe"),
    IKKE_TILFREDSSTILLENDE_SAMARBEID(navn = "Virksomheten har ikke tilfredsstillende samarbeid med partsgruppen"),
    FOR_LAVT_SYKEFRAVÆR(navn = "Virksomheten er vurdert til å ha for lavt sykefravær"),
    MINDRE_VIRKSOMHET(navn = "Virksomheten har et høyt sykefravær, men er en mindre virksomhet (færre ansatte)"),
    IKKE_TID(navn = "NAV vurderer at virksomheten ikke ønsker å sette av tilstrekkelig tid til samarbeidet"),

    HAR_IKKE_KAPASITET(navn = "Virksomheten har ikke tid eller kapasitet nå til å samarbeide med NAV"),
    GJENNOMFØRER_TILTAK_PÅ_EGENHÅND(navn = "Virksomheten vil gjøre tiltak på egen hånd"),
    GJENNOMFØRER_TILTAK_MED_BHT(navn = "Virksomheten vil gjennomføre tiltak sammen med BHT")
}
