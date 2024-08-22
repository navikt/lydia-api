package no.nav.lydia.ia.sak.domene.plan

import kotlinx.serialization.Serializable

@Serializable
data class PlanMalDto(
    val tema: List<TemaMalDto> = listOf(
        TemaMalDto(
            rekkefølge = 1,
            navn = "Partssamarbeid",
            innhold = listOf(
                InnholdMalDto(
                    rekkefølge = 1,
                    navn = "Utvikle partssamarbeidet",
                ),
            ),
        ),
        TemaMalDto(
            rekkefølge = 2,
            navn = "Sykefraværsarbeid",
            innhold = listOf(
                InnholdMalDto(
                    rekkefølge = 1,
                    navn = "Sykefraværsrutiner",
                ),
                InnholdMalDto(
                    rekkefølge = 2,
                    navn = "Oppfølgingssamtaler",
                ),
                InnholdMalDto(
                    rekkefølge = 3,
                    navn = "Tilretteleggings- og medvirkningsplikt",
                ),
                InnholdMalDto(
                    rekkefølge = 4,
                    navn = "Sykefravær - enkeltsaker",
                ),
            ),
        ),
        TemaMalDto(
            rekkefølge = 3,
            navn = "Arbeidsmiljø",
            innhold = listOf(
                InnholdMalDto(
                    rekkefølge = 1,
                    navn = "Utvikle arbeidsmiljøet",
                ),
                InnholdMalDto(
                    rekkefølge = 2,
                    navn = "Endring og omstilling",
                ),
                InnholdMalDto(
                    rekkefølge = 3,
                    navn = "Oppfølging av arbeidsmiljøundersøkelser",
                ),
                InnholdMalDto(
                    rekkefølge = 4,
                    navn = "Livsfaseorientert personalpolitikk",
                ),
                InnholdMalDto(
                    rekkefølge = 5,
                    navn = "Psykisk helse",
                ),
                InnholdMalDto(
                    rekkefølge = 6,
                    navn = "HelseIArbeid",
                ),
            ),
        ),
    ),
) {
    fun tilRedigertPlanMalDto(): RedigertPlanMalDto = RedigertPlanMalDto(tema = tema.map { it.tilRedigertTemaMalDto() })
}

@Serializable
data class TemaMalDto(
    val rekkefølge: Int,
    val navn: String,
    val innhold: List<InnholdMalDto>,
) {
    fun tilRedigertTemaMalDto(): RedigertTemaMalDto =
        RedigertTemaMalDto(
            rekkefølge = rekkefølge,
            navn = navn,
            planlagt = false,
            innhold = innhold.map { it.tilRedigertInnholdMalDto() },
        )
}

@Serializable
data class InnholdMalDto(
    val rekkefølge: Int,
    val navn: String,
) {
    fun tilRedigertInnholdMalDto(): RedigertInnholdMalDto =
        RedigertInnholdMalDto(
            rekkefølge = rekkefølge,
            navn = navn,
            planlagt = false,
            startDato = null,
            sluttDato = null,
        )
}

fun hentInnholdsMålsetning(innholdsNavn: String): String? =
    when (innholdsNavn) {
        "Sykefraværsrutiner" ->
            "Jobbe systematisk og forebyggende med sykefravær, samt forbedre rutiner og oppfølging av ansatte som er sykmeldte eller står i fare for å bli det."
        "Oppfølgingssamtaler" ->
            "Øke kompetansen for hvordan man gjennomfører gode oppfølgingssamtaler, både gjennom teori og praksis."
        "Tilretteleggings- og medvirkningsplikt" ->
            "Utvikle kultur og rutiner for tilrettelegging og medvirkning, samt kartlegging av tilretteleggingsmuligheter på arbeidsplassen."
        "Sykefravær - enkeltsaker" ->
            "Øke kompetansen for hvordan man tar tak i, følger opp og løser enkeltsaker."
        "Utvikle partssamarbeidet" ->
            "Styrke samarbeidet mellom leder, tillitsvalgt og verneombud, samt øke kunnskap og ferdigheter for å jobbe systematisk og forebyggende med sykefravær og arbeidsmiljø."
        "Utvikle arbeidsmiljøet" ->
            "Kartlegge hvilke forhold ved arbeidsmiljøet som påvirker sykefravær og frafall, samt heve kompetansen for videreutvikling av arbeidsmiljøet."
        "Endring og omstilling" ->
            "Forebygge fravær ved endringer og omstillingsprosesser og sette gode rammer for medvirkning, kommunikasjon og støtte til ansatte."
        "Oppfølging av arbeidsmiljøundersøkelser" ->
            "Gi støtte til å identifisere og gjennomføre tiltak basert på behov og ressurser i virksomheten."
        "Livsfaseorientert personalpolitikk" ->
            "Utvikle personalpolitikk som ivaretar medarbeideres ulike behov, krav, begrensninger og muligheter i  ulike livsfaser."
        "Psykisk helse" ->
            "Øke kompetansen om psykisk helse og hvordan møte medarbeidere som har psykiske helseproblemer."
        "HelseIArbeid" ->
            "Få ansatte til å mestre jobb, selv med muskel/skjelett- og psykiske helseplager"
        else -> null
    }
