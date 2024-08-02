package no.nav.lydia.ia.sak.domene.plan

import kotlinx.datetime.toKotlinLocalDate
import java.util.*

val hardkodetPlanId: UUID = UUID.fromString("92ee8fcd-330d-4c64-b954-b6757924b70d")

fun getHardkodetPlan(): Plan =
    Plan(
        id = hardkodetPlanId,
        publisert = false,
        sistEndret = java.time.LocalDate.now().minusMonths(1).toKotlinLocalDate(),
        sistPublisert = null,
        temaer = ettPåbegyntTema(),
    )

fun ettPåbegyntTema(): List<PlanTema> =
    listOf(
        PlanTema(
            id = 1,
            navn = "Sykefraværsarbeid",
            undertemaer = sykefraværsarbeidPåbegynt,
            ressurser = hardkodedeRessurser,
            planlagt = true,
        ),
        PlanTema(
            id = 2,
            navn = "Partssamarbeid",
            undertemaer = partssamarbeidIkkeValgt,
            ressurser = emptyList(),
            planlagt = false,
        ),
        PlanTema(
            id = 3,
            navn = "Arbeidsmiljø",
            undertemaer = arbeidsmiljøIkkeValgt,
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

val sykefraværsarbeidPåbegynt: List<PlanUndertema>
    get() =
        listOf(
            sykefraværsrutinerInaktiv.planlegg(minusMonths = 2, plusMonths = 0, status = PlanUndertema.Status.FULLFØRT),
            oppfølgingssamtalerInaktiv.planlegg(plusMonths = 2, status = PlanUndertema.Status.PÅGÅR),
            tilretteleggingOgMedvirkningspliktInaktiv.planlegg(plusMonths = 3),
            gjentagendeSykefraværInaktiv,
        )

val partssamarbeidIkkeValgt: List<PlanUndertema>
    get() =
        listOf(
            UtviklePartssamarbeidetInaktiv,
        )
val arbeidsmiljøIkkeValgt: List<PlanUndertema>
    get() =
        listOf(
            arbeidsmiljølovenInaktiv,
            medbestemmelseInaktiv,
            medvirkningInaktiv,
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

val sykefraværsrutinerInaktiv =
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

val oppfølgingssamtalerInaktiv =
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
val tilretteleggingOgMedvirkningspliktInaktiv =
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
val gjentagendeSykefraværInaktiv =
    PlanUndertema(
        id = 4,
        navn = "Gjentagende sykefravær",
        målsetning = DUMMY_MÅLSETNING,
        beskrivelse = DUMMY_BESKRIVELSE,
        planlagt = false,
        startDato = null,
        sluttDato = null,
        status = null,
    )

val UtviklePartssamarbeidetInaktiv =
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

val arbeidsmiljølovenInaktiv =
    PlanUndertema(
        id = 6,
        navn = "Arbeidsmiljøloven",
        målsetning = DUMMY_MÅLSETNING,
        beskrivelse = DUMMY_BESKRIVELSE,
        planlagt = false,
        startDato = null,
        sluttDato = null,
        status = null,
    )

val medbestemmelseInaktiv =
    PlanUndertema(
        id = 7,
        navn = "Medbestemmelse",
        målsetning = DUMMY_MÅLSETNING,
        beskrivelse = DUMMY_BESKRIVELSE,
        planlagt = false,
        startDato = null,
        sluttDato = null,
        status = null,
    )

val medvirkningInaktiv =
    PlanUndertema(
        id = 8,
        navn = "Medvirkning",
        målsetning = DUMMY_MÅLSETNING,
        beskrivelse = DUMMY_BESKRIVELSE,
        planlagt = false,
        startDato = null,
        sluttDato = null,
        status = null,
    )
