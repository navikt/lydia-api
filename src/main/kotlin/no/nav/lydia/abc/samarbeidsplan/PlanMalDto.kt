package no.nav.lydia.ia.sak.domene.plan

import kotlinx.datetime.LocalDate
import kotlinx.serialization.Serializable

@Serializable
data class PlanMalDto(
    val tema: List<TemaMalDto> = listOf(
        TemaMalDto(
            rekkefølge = 1,
            navn = "Partssamarbeid",
            inkludert = false,
            innhold = listOf(
                InnholdMalDto(
                    rekkefølge = 1,
                    navn = "Utvikle partssamarbeidet",
                    inkludert = false,
                    startDato = null,
                    sluttDato = null,
                ),
            ),
        ),
        TemaMalDto(
            rekkefølge = 2,
            navn = "Sykefraværsarbeid",
            inkludert = false,
            innhold = listOf(
                InnholdMalDto(
                    rekkefølge = 1,
                    navn = "Sykefraværsrutiner",
                    inkludert = false,
                    startDato = null,
                    sluttDato = null,
                ),
                InnholdMalDto(
                    rekkefølge = 2,
                    navn = "Oppfølgingssamtaler",
                    inkludert = false,
                    startDato = null,
                    sluttDato = null,
                ),
                InnholdMalDto(
                    rekkefølge = 3,
                    navn = "Tilretteleggings- og medvirkningsplikt",
                    inkludert = false,
                    startDato = null,
                    sluttDato = null,
                ),
                InnholdMalDto(
                    rekkefølge = 4,
                    navn = "Sykefravær - enkeltsaker",
                    inkludert = false,
                    startDato = null,
                    sluttDato = null,
                ),
            ),
        ),
        TemaMalDto(
            rekkefølge = 3,
            navn = "Arbeidsmiljø",
            inkludert = false,
            innhold = listOf(
                InnholdMalDto(
                    rekkefølge = 1,
                    navn = "Utvikle arbeidsmiljøet",
                    inkludert = false,
                    startDato = null,
                    sluttDato = null,
                ),
                InnholdMalDto(
                    rekkefølge = 2,
                    navn = "Endring og omstilling",
                    inkludert = false,
                    startDato = null,
                    sluttDato = null,
                ),
                InnholdMalDto(
                    rekkefølge = 3,
                    navn = "Oppfølging av arbeidsmiljøundersøkelser",
                    inkludert = false,
                    startDato = null,
                    sluttDato = null,
                ),
                InnholdMalDto(
                    rekkefølge = 4,
                    navn = "Livsfaseorientert personalpolitikk",
                    inkludert = false,
                    startDato = null,
                    sluttDato = null,
                ),
                InnholdMalDto(
                    rekkefølge = 5,
                    navn = "Psykisk helse",
                    inkludert = false,
                    startDato = null,
                    sluttDato = null,
                ),
                InnholdMalDto(
                    rekkefølge = 6,
                    navn = "HelseIArbeid",
                    inkludert = false,
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
    val inkludert: Boolean,
    val innhold: List<InnholdMalDto>,
)

@Serializable
data class InnholdMalDto(
    val rekkefølge: Int,
    val navn: String,
    val inkludert: Boolean,
    val startDato: LocalDate?,
    val sluttDato: LocalDate?,
)

fun hentInnholdsMålsetning(innholdsNavn: String): String? =
    when (innholdsNavn) {
        "Utvikle partssamarbeidet" ->
            "Styrke og strukturere samarbeidet mellom leder, tillitsvalgt og verneombud, samt øke kunnskap og ferdigheter for å jobbe systematisk og forebyggende med sykefravær og arbeidsmiljø."
        "Sykefraværsrutiner" ->
            "Jobbe systematisk og forebyggende med sykefravær, samt forbedre rutiner og oppfølging av ansatte som er sykmeldte eller står i fare for å bli det."
        "Oppfølgingssamtaler" ->
            "Øke kompetanse og ferdigheter for hvordan man gjennomfører gode oppfølgingssamtaler, både gjennom teori og praksis."
        "Tilretteleggings- og medvirkningsplikt" ->
            "Utvikle rutiner og kultur for tilrettelegging og medvirkning, samt kartlegging av tilretteleggingsmuligheter på arbeidsplassen."
        "Sykefravær - enkeltsaker" ->
            "Øke kompetanse og ferdigheter for hvordan man tar tak i, følger opp og løser enkeltsaker."
        "Utvikle arbeidsmiljøet" ->
            "Øke anvendelse og kompetanse innen verktøy og bransjerettet kunnskap for å jobbe målrettet og kunnskapsbasert med eget arbeidsmiljø."
        "Endring og omstilling" ->
            "Øke kompetansen for hvordan man ivaretar arbeidsmiljø og forebygger sykefravær under endring og omstilling."
        "Oppfølging av arbeidsmiljøundersøkelser" ->
            "Øke ferdigheter og gi støtte til hvordan man kan jobbe med forhold på arbeidsplassen som belyses i egne arbeidsmiljøundersøkelser."
        "Livsfaseorientert personalpolitikk" ->
            "Utvikle kultur og personalpolitikk som ivaretar medarbeideres ulike behov, krav, begrensninger og muligheter i ulike livsfaser."
        "Psykisk helse" ->
            "Gi innsikt i hvordan psykiske utfordringer kan komme til uttrykk i arbeidshverdagen og øke ferdigheter for hvordan man møter medarbeidere med psykiske helseutfordringer."
        "HelseIArbeid" ->
            "Øke kompetansen og få ansatte til å mestre jobb, selv med muskel/skjelett- og psykiske helseplager."
        else -> null
    }
