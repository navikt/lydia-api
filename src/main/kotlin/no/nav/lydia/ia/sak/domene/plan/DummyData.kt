package no.nav.lydia.ia.sak.domene.plan

import kotlinx.datetime.toKotlinLocalDate
import java.util.UUID

val hardkodetPlanId: UUID = UUID.fromString("92ee8fcd-330d-4c64-b954-b6757924b70d")

fun getHardkodetPlan(): Plan =
    Plan(
        id = hardkodetPlanId,
        sistEndret = java.time.LocalDate.now().minusMonths(1).toKotlinLocalDate(),
        sistPublisert = null,
        temaer = toAktiveTemaer(),
    )

fun toAktiveTemaer(): List<PlanTema> =
    listOf(
        PlanTema(
            id = 1,
            navn = "Partssamarbeid",
            undertemaer = `Undertemaer Partssamarbeid Planlagt`,
            ressurser = emptyList(),
            planlagt = true,
        ),
        PlanTema(
            id = 2,
            navn = "Sykefraværsarbeid",
            undertemaer = `Undertemaer Sykefraværsarbeid Pågår`,
            ressurser = hardkodedeRessurser,
            planlagt = true,
        ),
        PlanTema(
            id = 3,
            navn = "Arbeidsmiljø",
            undertemaer = `Undertemaer Arbeidsmiljø Inaktiv`,
            ressurser = emptyList(),
            planlagt = false,
        ),
        PlanTema(
            id = 4,
            navn = "HelseIArbeid",
            undertemaer = `Undertemaer HelseIArbeid Inaktiv`,
            ressurser = emptyList(),
            planlagt = false,
        ),
    )

val hardkodedeRessurser: List<PlanRessurs>
    get() =
        listOf(
            PlanRessurs(
                id = 1,
                beskrivelse = "Min side - arbeidsgiver",
                url = "https://arbeidsgiver.intern.dev.nav.no/min-side-arbeidsgiver/",
            ),
            PlanRessurs(
                id = 2,
                beskrivelse = "Min side - arbeidsgiver | Forebygge fravær",
                url = "https://forebygge-fravar.intern.dev.nav.no/forebygge-fravar",
            ),
            PlanRessurs(
                id = 3,
                beskrivelse = "Ta jevnlige med ispauser på taket",
                url = null,
            ),
        )

val `Undertemaer Partssamarbeid Planlagt`: List<PlanUndertema>
    get() =
        listOf(
            `Utvikle partssamarbeidet Inaktiv`.planlegg(
                minusMonths = 2,
                plusMonths = 0,
            ),
        )

val `Undertemaer Sykefraværsarbeid Pågår`: List<PlanUndertema>
    get() =
        listOf(
            `Sykefraværsrutiner Inaktiv`.planlegg(minusMonths = 2, plusMonths = 0, status = PlanUndertema.Status.FULLFØRT),
            `Oppfølgingssamtaler Inaktiv`.planlegg(plusMonths = 2, status = PlanUndertema.Status.PÅGÅR),
            `Tilretteleggings- og medvirkningsplikt Inaktiv`.planlegg(plusMonths = 3),
            `Sykefravær - enkeltsaker Inaktiv`,
        )
val `Undertemaer Arbeidsmiljø Inaktiv`: List<PlanUndertema>
    get() =
        listOf(
            `Utvikle arbeidsmiljøet Inaktiv`,
            `Endring og omstilling Inaktiv`,
            `Oppfølging av arbeidsmiljøundersøkelser Inaktiv`,
            `Livsfaseorientert personlapolitikk Inaktiv`,
            `Psykisk helse Inaktiv`,
        )

val `Undertemaer HelseIArbeid Inaktiv`: List<PlanUndertema>
    get() =
        listOf(
            `HelseIArbeid Inaktiv`,
        )

fun PlanUndertema.planlegg(
    plusMonths: Long,
    minusMonths: Long = 0,
    status: PlanUndertema.Status = PlanUndertema.Status.PLANLAGT,
): PlanUndertema =
    copy(
        planlagt = true,
        startDato = java.time.LocalDate.now().minusMonths(minusMonths).toKotlinLocalDate(),
        sluttDato = java.time.LocalDate.now().plusMonths(plusMonths).toKotlinLocalDate(),
        status = status,
    )

const val DUMMY_MÅLSETNING =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam cursus blandit rhoncus. "
const val DUMMY_BESKRIVELSE =
    "Maecenas pulvinar dapibus venenatis. Sed a magna tortor. Sed ac cursus tortor, in molestie libero. Praesent elementum pharetra commodo. Pellentesque non ultrices orci. Sed justo risus, aliquet ac vehicula et, ultrices et nunc. Duis fermentum semper dolor in aliquam. In erat elit, commodo vitae lorem quis, rutrum placerat nisl. Ut sed posuere leo, id tristique quam."

val `Utvikle partssamarbeidet Inaktiv` =
    PlanUndertema(
        id = 5,
        navn = "Utvikle partssamarbeidet",
        målsetning = DUMMY_MÅLSETNING,
        beskrivelse = DUMMY_BESKRIVELSE,
        planlagt = false,
        startDato = null,
        sluttDato = null,
        status = null,
    )

val `Sykefraværsrutiner Inaktiv` =
    PlanUndertema(
        id = 1,
        navn = "Sykefraværsrutiner",
        målsetning = DUMMY_MÅLSETNING,
        beskrivelse = DUMMY_BESKRIVELSE,
        planlagt = false,
        startDato = null,
        sluttDato = null,
        status = null,
    )
val `Oppfølgingssamtaler Inaktiv` =
    PlanUndertema(
        id = 2,
        navn = "Oppfølgingssamtaler",
        målsetning = DUMMY_MÅLSETNING,
        beskrivelse = DUMMY_BESKRIVELSE,
        planlagt = false,
        startDato = null,
        sluttDato = null,
        status = null,
    )
val `Tilretteleggings- og medvirkningsplikt Inaktiv` =
    PlanUndertema(
        id = 3,
        navn = "Tilretteleggings- og medvirkningsplikt",
        målsetning = DUMMY_MÅLSETNING,
        beskrivelse = DUMMY_BESKRIVELSE,
        planlagt = false,
        startDato = null,
        sluttDato = null,
        status = null,
    )

val `Sykefravær - enkeltsaker Inaktiv` =
    PlanUndertema(
        id = 4,
        navn = "Sykefravær - enkeltsaker",
        målsetning = DUMMY_MÅLSETNING,
        beskrivelse = DUMMY_BESKRIVELSE,
        planlagt = false,
        startDato = null,
        sluttDato = null,
        status = null,
    )

val `Utvikle arbeidsmiljøet Inaktiv` =
    PlanUndertema(
        id = 6,
        navn = "Utvikle arbeidsmiljøet",
        målsetning = DUMMY_MÅLSETNING,
        beskrivelse = DUMMY_BESKRIVELSE,
        planlagt = false,
        startDato = null,
        sluttDato = null,
        status = null,
    )

val `Endring og omstilling Inaktiv` =
    PlanUndertema(
        id = 7,
        navn = "Endring og omstilling",
        målsetning = DUMMY_MÅLSETNING,
        beskrivelse = DUMMY_BESKRIVELSE,
        planlagt = false,
        startDato = null,
        sluttDato = null,
        status = null,
    )

val `Oppfølging av arbeidsmiljøundersøkelser Inaktiv` =
    PlanUndertema(
        id = 8,
        navn = "Oppfølging av arbeidsmiljøundersøkelser",
        målsetning = DUMMY_MÅLSETNING,
        beskrivelse = DUMMY_BESKRIVELSE,
        planlagt = false,
        startDato = null,
        sluttDato = null,
        status = null,
    )

val `Livsfaseorientert personlapolitikk Inaktiv` =
    PlanUndertema(
        id = 9,
        navn = "Livsfaseorientert personlapolitikk",
        målsetning = DUMMY_MÅLSETNING,
        beskrivelse = DUMMY_BESKRIVELSE,
        planlagt = false,
        startDato = null,
        sluttDato = null,
        status = null,
    )

val `Psykisk helse Inaktiv` =
    PlanUndertema(
        id = 10,
        navn = "Psykisk helse",
        målsetning = DUMMY_MÅLSETNING,
        beskrivelse = DUMMY_BESKRIVELSE,
        planlagt = false,
        startDato = null,
        sluttDato = null,
        status = null,
    )

val `HelseIArbeid Inaktiv` =
    PlanUndertema(
        id = 11,
        navn = "HelseIArbeid",
        målsetning = DUMMY_MÅLSETNING,
        beskrivelse = DUMMY_BESKRIVELSE,
        planlagt = false,
        startDato = null,
        sluttDato = null,
        status = null,
    )
