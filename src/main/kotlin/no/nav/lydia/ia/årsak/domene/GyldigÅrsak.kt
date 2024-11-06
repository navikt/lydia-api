package no.nav.lydia.ia.årsak.domene

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.årsak.domene.GyldigBegrunnelse.Companion.somGyldigeBegrunnelser

@Serializable
class GyldigÅrsak(
    val type: ÅrsakType,
    val navn: String = type.navn,
    val begrunnelser: List<GyldigBegrunnelse>,
) {
    companion object {
        val GYLDIGE_ÅRSAKER_FOR_IKKE_AKTUELL = listOf(
            GyldigÅrsak(
                type = ÅrsakType.NAV_IGANGSETTER_IKKE_TILTAK,
                begrunnelser = listOf(
                    BegrunnelseType.IKKE_DIALOG_MELLOM_PARTENE,
                    BegrunnelseType.FOR_FÅ_TAPTE_DAGSVERK,
                    BegrunnelseType.SAKEN_ER_FEILREGISTRERT,
                ).somGyldigeBegrunnelser(),
            ),
            GyldigÅrsak(
                type = ÅrsakType.VIRKSOMHETEN_TAKKET_NEI,
                begrunnelser = listOf(
                    BegrunnelseType.VIRKSOMHETEN_ØNSKER_IKKE_SAMARBEID,
                    BegrunnelseType.VIRKSOMHETEN_HAR_IKKE_RESPONDERT,
                ).somGyldigeBegrunnelser(),
            ),
        )

        fun from(sakshendelseType: IASakshendelseType) =
            when (sakshendelseType) {
                IASakshendelseType.VIRKSOMHET_ER_IKKE_AKTUELL -> GYLDIGE_ÅRSAKER_FOR_IKKE_AKTUELL
                else -> emptyList()
            }
    }
}

@Serializable
class GyldigBegrunnelse(
    val type: BegrunnelseType,
    val navn: String = type.navn,
) {
    companion object {
        fun List<BegrunnelseType>.somGyldigeBegrunnelser() = this.map { GyldigBegrunnelse(type = it) }

        fun List<GyldigBegrunnelse>.somBegrunnelseType() = this.map { it.type }
    }
}

enum class ÅrsakType(
    val navn: String,
) {
    NAV_IGANGSETTER_IKKE_TILTAK(navn = "NAV har besluttet å ikke starte samarbeid"),
    VIRKSOMHETEN_TAKKET_NEI(navn = "Virksomheten har takket nei"),
}

enum class BegrunnelseType(
    val navn: String,
) {
    IKKE_DIALOG_MELLOM_PARTENE(navn = "Det er ikke dokumentert dialog mellom partene på arbeidsplassen"),
    FOR_FÅ_TAPTE_DAGSVERK(navn = "Virksomheten har for få tapte dagsverk"),
    SAKEN_ER_FEILREGISTRERT(navn = "Saken er feilregistrert"),

    VIRKSOMHETEN_ØNSKER_IKKE_SAMARBEID(navn = "Virksomheten ønsker ikke forpliktende samarbeid med NAV om IA"),
    VIRKSOMHETEN_HAR_IKKE_RESPONDERT(navn = "Virksomheten har ikke respondert på forespørsel om forpliktende samarbeid"),

    // -- FOR SYSTEMET. Ikke bruk
    AUTOMATISK_LUKKET(navn = "Automatisk lukket: Ingen eierskap tatt på seks måneder"),
    // --

    // -- UTDATERT. Ikke bruk. Ikke slett heller, da knekker samarbeidshistorikken.
    MANGLER_PARTSGRUPPE(navn = "Virksomheten mangler partsgruppe"),
    IKKE_TILFREDSSTILLENDE_SAMARBEID(navn = "Virksomheten har ikke tilfredsstillende samarbeid med partsgruppen"),
    FOR_LAVT_SYKEFRAVÆR(navn = "Virksomheten er vurdert til å ha for lavt sykefravær"),
    MINDRE_VIRKSOMHET(navn = "Virksomheten har et høyt sykefravær, men er en mindre virksomhet (færre ansatte)"),
    IKKE_TID(navn = "NAV vurderer at virksomheten ikke ønsker å sette av tilstrekkelig tid til samarbeidet"),
    HAR_IKKE_KAPASITET(navn = "Virksomheten har ikke tid eller kapasitet nå til å samarbeide med NAV"),
    GJENNOMFØRER_TILTAK_PÅ_EGENHÅND(navn = "Virksomheten vil gjøre tiltak på egen hånd"),
    GJENNOMFØRER_TILTAK_MED_BHT(navn = "Virksomheten vil gjennomføre tiltak sammen med BHT"),
    // --
}
