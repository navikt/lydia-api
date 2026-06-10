package no.nav.lydia.abc.samarbeidsperiode

import kotlinx.serialization.Serializable
import no.nav.lydia.abc.samarbeidsperiode.GyldigBegrunnelse.Companion.somGyldigeBegrunnelser

@Serializable
class GyldigÅrsak(
    val type: ÅrsakType,
    val navn: String = type.navn,
    val begrunnelser: List<GyldigBegrunnelse>,
) {
    companion object {
        val GYLDIGE_ÅRSAKER_FOR_BAKGRUNN_FOR_VURDERING_AV_VIRKSOMHET = listOf(
            GyldigÅrsak(
                type = ÅrsakType.BAKGRUNN_FOR_VURDERING_AV_VIRKSOMHET,
                begrunnelser = listOf(
                    BegrunnelseType.NAV_VURDERER_VIRKSOMHETEN,
                    BegrunnelseType.VIRKSOMHETEN_HAR_TATT_KONTAKT,
                ).somGyldigeBegrunnelser(),
            ),
        )

        val GYLDIGE_ÅRSAKER_FOR_VURDERES_PÅ_ET_SENERE_TIDSPUNKT = listOf(
            GyldigÅrsak(
                type = ÅrsakType.VIRKSOMHETEN_VURDERES_PÅ_ET_SENERE_TIDSPUNKT,
                begrunnelser = listOf(
                    BegrunnelseType.VIRKSOMHETEN_ØNSKER_Å_BLI_KONTAKTET_SENERE,
                    BegrunnelseType.NAV_HAR_IKKE_KAPASITET_NÅ,
                ).somGyldigeBegrunnelser(),
            ),
        )

        val GYLDIGE_ÅRSAKER_FOR_FERDIG_VURDERT_MED_INTERN_VURDERING = listOf(
            GyldigÅrsak(
                type = ÅrsakType.VIRKSOMHETEN_ER_FERDIG_VURDERT_MED_INTERN_VURDERING,
                begrunnelser = listOf(
                    BegrunnelseType.VIRKSOMHETEN_HAR_IKKE_SVART_PÅ_HENVENDELSER,
                    BegrunnelseType.VIRKSOMHETEN_HAR_FOR_LAVT_POTENSIALE,
                    BegrunnelseType.VIRKSOMHETEN_MANGLER_REPRESANTANTER_ELLER_ETABLERT_PARTSGRUPPE,
                ).somGyldigeBegrunnelser(),
            ),
        )

        val GYLDIGE_ÅRSAKER_FOR_FERDIG_VURDERT_OG_TAKKET_NEI = listOf(
            GyldigÅrsak(
                type = ÅrsakType.VIRKSOMHETEN_ER_FERDIG_VURDERT_OG_TAKKET_NEI,
                begrunnelser = listOf(
                    BegrunnelseType.VIRKSOMHETEN_ER_IKKE_MOTIVERT_ELLER_HAR_IKKE_KAPASITET,
                    BegrunnelseType.VIRKSOMHETEN_SAMARBEIDER_MED_ANDRE_ELLER_GJØR_EGNE_TILTAK,
                    BegrunnelseType.VIRKSOMHETEN_ØNSKER_KUN_INFORMASJON_OG_VEILEDNING,
                    BegrunnelseType.KOMMUNEN_ELLER_OVERORDNET_LEDELSE_ØNSKER_IKKE_Å_STARTE_ET_SAMARBEID,
                    BegrunnelseType.VIRKSOMHETEN_FERDIG_VURDERT_TAKKET_NEI_ANNET,
                ).somGyldigeBegrunnelser(),
            ),
        )

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
    }
}

enum class ÅrsakType(
    val navn: String,
) {
    // bakgrunn for vurdering av virksomhet
    BAKGRUNN_FOR_VURDERING_AV_VIRKSOMHET(navn = "Bakgrunn for vurdering av virksomhet"),

    // avslutt-vurdering v1
    VIRKSOMHETEN_VURDERES_PÅ_ET_SENERE_TIDSPUNKT(navn = "Virksomheten vurderes på et senere tidspunkt"),
    VIRKSOMHETEN_ER_FERDIG_VURDERT_MED_INTERN_VURDERING(navn = "Virksomheten er ferdig vurdert med intern vurdering"),
    VIRKSOMHETEN_ER_FERDIG_VURDERT_OG_TAKKET_NEI(navn = "Virksomheten er ferdig vurdert og har takket nei"),

    // -- Gammel saksflyt
    NAV_IGANGSETTER_IKKE_TILTAK(navn = "NAV har besluttet å ikke starte samarbeid"),
    VIRKSOMHETEN_TAKKET_NEI(navn = "Virksomheten har takket nei"),
}

enum class BegrunnelseType(
    val navn: String,
) {
    // bakgrunn for vurdering av virksomhet
    NAV_VURDERER_VIRKSOMHETEN(navn = "Nav vurderer virksomheten"),
    VIRKSOMHETEN_HAR_TATT_KONTAKT(navn = "Virksomheten har tatt kontakt"),

    // avslutt-vurdering v1
    // Vurderes på et senere tidspunkt
    VIRKSOMHETEN_ØNSKER_Å_BLI_KONTAKTET_SENERE(navn = "Virksomheten ønsker å bli kontaktet senere"),
    NAV_HAR_IKKE_KAPASITET_NÅ(navn = "Nav har ikke kapasitet nå"),

    // Ferdig vurdert: Intern vurdering
    VIRKSOMHETEN_HAR_IKKE_SVART_PÅ_HENVENDELSER(navn = "Virksomheten har ikke svart på henvendelser"),
    VIRKSOMHETEN_HAR_FOR_LAVT_POTENSIALE(navn = "Virksomheten har for lavt potensiale til å redusere tapte dagsverk"),
    VIRKSOMHETEN_MANGLER_REPRESANTANTER_ELLER_ETABLERT_PARTSGRUPPE(navn = "Virksomheten mangler representanter / etablert partsgruppe"),

    // Ferdig vurdert: Virksomheten har takket nei
    VIRKSOMHETEN_ER_IKKE_MOTIVERT_ELLER_HAR_IKKE_KAPASITET(navn = "Virksomheten er ikke motivert / har ikke kapasitet"),
    VIRKSOMHETEN_SAMARBEIDER_MED_ANDRE_ELLER_GJØR_EGNE_TILTAK(navn = "Virksomheten samarbeider med andre / gjør egne tiltak"),
    VIRKSOMHETEN_ØNSKER_KUN_INFORMASJON_OG_VEILEDNING(navn = "Virksomheten ønsker kun informasjon og veiledning"),
    KOMMUNEN_ELLER_OVERORDNET_LEDELSE_ØNSKER_IKKE_Å_STARTE_ET_SAMARBEID(navn = "Kommunen / overordnet ledelse ønsker ikke å starte et samarbeid"),
    VIRKSOMHETEN_FERDIG_VURDERT_TAKKET_NEI_ANNET(navn = "Annet"),

    // Legacy: IKKE_AKTUELL
    FOR_FÅ_TAPTE_DAGSVERK(navn = "Virksomheten har for få tapte dagsverk"),
    INTERN_VURDERING_FØR_KONTAKT(navn = "Intern vurdering før kontakt med virksomhet "),
    NAV_HAR_IKKE_KAPASITET(navn = "NAV har ikke tid eller kapasitet nå til å samarbeide med virksomheten"),

    IKKE_DIALOG_MELLOM_PARTENE(navn = "Det er ikke dokumentert dialog mellom partene på arbeidsplassen"),
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
