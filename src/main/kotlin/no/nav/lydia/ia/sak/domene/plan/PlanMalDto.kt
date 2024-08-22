package no.nav.lydia.ia.sak.domene.plan

import kotlinx.serialization.Serializable

@Serializable
data class PlanMalDto(
    val tema: List<TemaMalDto> = listOf(
        partssamarbeid,
        sykefraværsarbeid,
        arbeidsmiljø,
    ),
) {
    fun hentMålsetning(innholdNavn: String) =
        this.tema.flatMap { it.innhold }.firstOrNull { it.navn == innholdNavn }?.målsetning
            ?: ""
}

@Serializable
data class TemaMalDto(
    val navn: String,
    val innhold: List<InnholdsMalDto>,
)

@Serializable
data class InnholdsMalDto(
    val navn: String,
    val målsetning: String,
)

private val sykefraværsarbeid = TemaMalDto(
    navn = "Sykefraværsarbeid",
    innhold = listOf(
        InnholdsMalDto(
            navn = "Sykefraværsrutiner",
            målsetning = "Jobbe systematisk og forebyggende med sykefravær, samt forbedre rutiner og oppfølging av ansatte som er sykmeldte eller står i fare for å bli det.",
        ),
        InnholdsMalDto(
            navn = "Oppfølgingssamtaler",
            målsetning = "Øke kompetansen for hvordan man gjennomfører gode oppfølgingssamtaler, både gjennom teori og praksis.",
        ),
        InnholdsMalDto(
            navn = "Tilretteleggings- og medvirkningsplikt",
            målsetning = "Utvikle kultur og rutiner for tilrettelegging og medvirkning, samt kartlegging av tilretteleggingsmuligheter på arbeidsplassen. ",
        ),
        InnholdsMalDto(
            navn = "Sykefravær - enkeltsaker",
            målsetning = "Øke kompetansen for hvordan man tar tak i, følger opp og løser enkeltsaker. ",
        ),
    ),
)

private val partssamarbeid = TemaMalDto(
    navn = "Partssamarbeid",
    innhold = listOf(
        InnholdsMalDto(
            navn = "Utvikle partssamarbeidet",
            målsetning = "Styrke samarbeidet mellom leder, tillitsvalgt og verneombud, samt øke kunnskap og ferdigheter for å jobbe systematisk og forebyggende med sykefravær og arbeidsmiljø.",
        ),
    ),
)

private val arbeidsmiljø = TemaMalDto(
    navn = "Arbeidsmiljø",
    innhold = listOf(
        InnholdsMalDto(
            navn = "Utvikle arbeidsmiljøet",
            målsetning = "Kartlegge hvilke forhold ved arbeidsmiljøet som påvirker sykefravær og frafall, samt heve kompetansen for videreutvikling av arbeidsmiljøet.",
        ),
        InnholdsMalDto(
            navn = "Endring og omstilling",
            målsetning = "Forebygge fravær ved endringer og omstillingsprosesser og sette gode rammer for medvirkning, kommunikasjon og støtte til ansatte.",
        ),
        InnholdsMalDto(
            navn = "Oppfølging av arbeidsmiljøundersøkelser",
            målsetning = "Gi støtte til å identifisere og gjennomføre tiltak basert på behov og ressurser i virksomheten.",
        ),
        InnholdsMalDto(
            navn = "Livsfaseorientert personalpolitikk",
            målsetning = "Utvikle personalpolitikk som ivaretar medarbeideres ulike behov, krav, begrensninger og muligheter i  ulike livsfaser.",
        ),
        InnholdsMalDto(
            navn = "Psykisk helse",
            målsetning = "Øke kompetansen om psykisk helse og hvordan møte medarbeidere som har psykiske helseproblemer.",
        ),
        InnholdsMalDto(
            navn = "HelseIArbeid",
            målsetning = "Få ansatte til å mestre jobb, selv med muskel/skjelett- og psykiske helseplager",
        ),
    ),
)
