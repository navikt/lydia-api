package no.nav.lydia.ia.sak.domene.plan

data class PlanMal(
    val tema: List<TemaMal> = listOf(
        partssamarbeid,
        sykefraværsarbeid,
        arbeidsmiljø,
    ),
) {
    fun hentMålsetning(innholdNavn: String) =
        this.tema.flatMap { it.innhold }.firstOrNull { it.navn == innholdNavn }?.målsetning
            ?: ""
}

data class TemaMal(
    val navn: String,
    val innhold: List<InnholdsMal>,
)

data class InnholdsMal(
    val navn: String,
    val målsetning: String,
)

private val sykefraværsarbeid = TemaMal(
    navn = "Sykefraværsarbeid",
    innhold = listOf(
        InnholdsMal(
            navn = "Sykefraværsrutiner",
            målsetning = "Jobbe systematisk og forebyggende med sykefravær, samt forbedre rutiner og oppfølging av ansatte som er sykmeldte eller står i fare for å bli det.",
        ),
        InnholdsMal(
            navn = "Oppfølgingssamtaler",
            målsetning = "Øke kompetansen for hvordan man gjennomfører gode oppfølgingssamtaler, både gjennom teori og praksis.",
        ),
        InnholdsMal(
            navn = "Tilretteleggings- og medvirkningsplikt",
            målsetning = "Utvikle kultur og rutiner for tilrettelegging og medvirkning, samt kartlegging av tilretteleggingsmuligheter på arbeidsplassen. ",
        ),
        InnholdsMal(
            navn = "Sykefravær - enkeltsaker",
            målsetning = "Øke kompetansen for hvordan man tar tak i, følger opp og løser enkeltsaker. ",
        ),
    ),
)

private val partssamarbeid = TemaMal(
    navn = "Partssamarbeid",
    innhold = listOf(
        InnholdsMal(
            navn = "Utvikle partssamarbeidet",
            målsetning = "Styrke samarbeidet mellom leder, tillitsvalgt og verneombud, samt øke kunnskap og ferdigheter for å jobbe systematisk og forebyggende med sykefravær og arbeidsmiljø.",
        ),
    ),
)

private val arbeidsmiljø = TemaMal(
    navn = "Arbeidsmiljø",
    innhold = listOf(
        InnholdsMal(
            navn = "Utvikle arbeidsmiljøet",
            målsetning = "Kartlegge hvilke forhold ved arbeidsmiljøet som påvirker sykefravær og frafall, samt heve kompetansen for videreutvikling av arbeidsmiljøet.",
        ),
        InnholdsMal(
            navn = "Endring og omstilling",
            målsetning = "Forebygge fravær ved endringer og omstillingsprosesser og sette gode rammer for medvirkning, kommunikasjon og støtte til ansatte.",
        ),
        InnholdsMal(
            navn = "Oppfølging av arbeidsmiljøundersøkelser",
            målsetning = "Gi støtte til å identifisere og gjennomføre tiltak basert på behov og ressurser i virksomheten.",
        ),
        InnholdsMal(
            navn = "Livsfaseorientert personalpolitikk",
            målsetning = "Utvikle personalpolitikk som ivaretar medarbeideres ulike behov, krav, begrensninger og muligheter i  ulike livsfaser.",
        ),
        InnholdsMal(
            navn = "Psykisk helse",
            målsetning = "Øke kompetansen om psykisk helse og hvordan møte medarbeidere som har psykiske helseproblemer.",
        ),
        InnholdsMal(
            navn = "HelseIArbeid",
            målsetning = "Få ansatte til å mestre jobb, selv med muskel/skjelett- og psykiske helseplager",
        ),
    ),
)
