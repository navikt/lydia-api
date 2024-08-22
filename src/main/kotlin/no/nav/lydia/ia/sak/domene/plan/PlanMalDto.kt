package no.nav.lydia.ia.sak.domene.plan

import kotlinx.datetime.LocalDate
import kotlinx.serialization.Serializable

@Serializable
data class PlanMalDto(
    val tema: List<TemaMalDto> = listOf(
        TemaMalDto(
            rekkefølge = 1,
            navn = "Partssamarbeid",
            planlagt = false,
            innhold = listOf(
                InnholdMalDto(
                    rekkefølge = 1,
                    navn = "Utvikle partssamarbeidet",
                    planlagt = false,
                    startDato = null,
                    sluttDato = null,
                ),
            ),
        ),
        TemaMalDto(
            rekkefølge = 2,
            navn = "Sykefraværsarbeid",
            planlagt = false,
            innhold = listOf(
                InnholdMalDto(
                    rekkefølge = 1,
                    navn = "Sykefraværsrutiner",
                    planlagt = false,
                    startDato = null,
                    sluttDato = null,
                ),
                InnholdMalDto(
                    rekkefølge = 2,
                    navn = "Oppfølgingssamtaler",
                    planlagt = false,
                    startDato = null,
                    sluttDato = null,
                ),
                InnholdMalDto(
                    rekkefølge = 3,
                    navn = "Tilretteleggings- og medvirkningsplikt",
                    planlagt = false,
                    startDato = null,
                    sluttDato = null,
                ),
                InnholdMalDto(
                    rekkefølge = 4,
                    navn = "Sykefravær - enkeltsaker",
                    planlagt = false,
                    startDato = null,
                    sluttDato = null,
                ),
            ),
        ),
        TemaMalDto(
            rekkefølge = 3,
            navn = "Arbeidsmiljø",
            planlagt = false,
            innhold = listOf(
                InnholdMalDto(
                    rekkefølge = 1,
                    navn = "Utvikle arbeidsmiljøet",
                    planlagt = false,
                    startDato = null,
                    sluttDato = null,
                ),
                InnholdMalDto(
                    rekkefølge = 2,
                    navn = "Endring og omstilling",
                    planlagt = false,
                    startDato = null,
                    sluttDato = null,
                ),
                InnholdMalDto(
                    rekkefølge = 3,
                    navn = "Oppfølging av arbeidsmiljøundersøkelser",
                    planlagt = false,
                    startDato = null,
                    sluttDato = null,
                ),
                InnholdMalDto(
                    rekkefølge = 4,
                    navn = "Livsfaseorientert personalpolitikk",
                    planlagt = false,
                    startDato = null,
                    sluttDato = null,
                ),
                InnholdMalDto(
                    rekkefølge = 5,
                    navn = "Psykisk helse",
                    planlagt = false,
                    startDato = null,
                    sluttDato = null,
                ),
                InnholdMalDto(
                    rekkefølge = 6,
                    navn = "HelseIArbeid",
                    planlagt = false,
                    startDato = null,
                    sluttDato = null,
                ),
            ),
        ),
    ),
)

@Serializable
data class TemaMalDto(
    val rekkefølge: Int,
    val navn: String,
    val planlagt: Boolean,
    val innhold: List<InnholdMalDto>,
)

@Serializable
data class InnholdMalDto(
    val rekkefølge: Int,
    val navn: String,
    val planlagt: Boolean,
    val startDato: LocalDate?,
    val sluttDato: LocalDate?,
)

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
