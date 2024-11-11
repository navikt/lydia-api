package no.nav.lydia.container.ia.sak.plan

import io.kotest.assertions.shouldFail
import io.kotest.matchers.comparables.shouldBeGreaterThan
import io.kotest.matchers.equals.shouldBeEqual
import io.kotest.matchers.shouldBe
import kotlinx.datetime.DatePeriod
import kotlinx.datetime.DateTimeUnit
import kotlinx.datetime.minus
import kotlinx.datetime.plus
import kotlinx.datetime.toKotlinLocalDate
import no.nav.lydia.helper.PlanHelper
import no.nav.lydia.helper.PlanHelper.Companion.SLUTT_DATO
import no.nav.lydia.helper.PlanHelper.Companion.START_DATO
import no.nav.lydia.helper.PlanHelper.Companion.antallInnholdInkludert
import no.nav.lydia.helper.PlanHelper.Companion.antallInnholdMedStatus
import no.nav.lydia.helper.PlanHelper.Companion.antallTemaInkludert
import no.nav.lydia.helper.PlanHelper.Companion.endreEttTema
import no.nav.lydia.helper.PlanHelper.Companion.endreFlereTemaer
import no.nav.lydia.helper.PlanHelper.Companion.endreStatusPåInnhold
import no.nav.lydia.helper.PlanHelper.Companion.hentPlan
import no.nav.lydia.helper.PlanHelper.Companion.inkluderAlt
import no.nav.lydia.helper.PlanHelper.Companion.inkluderAltInnhold
import no.nav.lydia.helper.PlanHelper.Companion.inkluderEttTemaOgAltInnhold
import no.nav.lydia.helper.PlanHelper.Companion.inkluderEttTemaOgEttInnhold
import no.nav.lydia.helper.PlanHelper.Companion.inkluderTemaOgAltInnhold
import no.nav.lydia.helper.PlanHelper.Companion.opprettEnPlan
import no.nav.lydia.helper.PlanHelper.Companion.senesteSluttDato
import no.nav.lydia.helper.PlanHelper.Companion.tidligstStartDato
import no.nav.lydia.helper.PlanHelper.Companion.tilRequest
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartlegges
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartleggesMedEtSamarbeid
import no.nav.lydia.helper.TestContainerHelper.Companion.oauth2ServerContainer
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.helper.opprettNyttSamarbeid
import no.nav.lydia.ia.sak.domene.plan.InnholdMalDto
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema.Status.AVBRUTT
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema.Status.FULLFØRT
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema.Status.PLANLAGT
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema.Status.PÅGÅR
import no.nav.lydia.ia.sak.domene.plan.TemaMalDto
import java.time.LocalDate.now
import kotlin.test.Test

class PlanApiTest {
    @Test
    fun `kan ikke endre en plan om forespørselen er ufullstendig`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val enTomPlanMal = PlanHelper.hentPlanMal()
        val planDto = sak.opprettEnPlan(plan = enTomPlanMal)

        val inkludertUtenDato = planDto.copy(
            temaer = planDto.temaer.map { tema ->
                tema.copy(
                    inkludert = true,
                    undertemaer = tema.undertemaer.map { innhold ->
                        innhold.copy(
                            inkludert = true,
                            startDato = null,
                            sluttDato = null,
                        )
                    },
                )
            },
        )

        val datoUtenInkludert = planDto.copy(
            temaer = planDto.temaer.map { tema ->
                tema.copy(
                    inkludert = true,
                    undertemaer = tema.undertemaer.map { innhold ->
                        innhold.copy(
                            inkludert = false,
                            startDato = START_DATO,
                            sluttDato = SLUTT_DATO,
                        )
                    },
                )
            },
        )

        val gyldigEndring = planDto.inkluderTemaOgAltInnhold(planDto.temaer.first().id)

        shouldFail { sak.endreFlereTemaer(endring = datoUtenInkludert.tilRequest()) }
            .message shouldBe "HTTP Exception 400 Bad Request"

        shouldFail { sak.endreFlereTemaer(endring = inkludertUtenDato.tilRequest()) }
            .message shouldBe "HTTP Exception 400 Bad Request"

        val uendretPlan = sak.hentPlan()
        uendretPlan.antallTemaInkludert() shouldBe 0
        uendretPlan.antallInnholdInkludert() shouldBe 0

        sak.endreFlereTemaer(endring = gyldigEndring.tilRequest())

        val endretPlan = sak.hentPlan()
        endretPlan.antallTemaInkludert() shouldBe 1
        endretPlan.antallInnholdInkludert() shouldBe planDto.temaer.first().undertemaer.size

        shouldFail {
            sak.endreEttTema(
                endring = datoUtenInkludert.temaer.first().undertemaer.tilRequest(),
                temaId = planDto.temaer.first().id,
            )
        }.message shouldBe "HTTP Exception 400 Bad Request"

        shouldFail {
            sak.endreEttTema(
                endring = inkludertUtenDato.temaer.first().undertemaer.tilRequest(),
                temaId = planDto.temaer.first().id,
            )
        }.message shouldBe "HTTP Exception 400 Bad Request"

        val sammePlan = sak.hentPlan()
        sammePlan.antallTemaInkludert() shouldBe 1
        sammePlan.antallInnholdInkludert() shouldBe planDto.temaer.first().undertemaer.size
    }

    @Test
    fun `kan opprette en plan basert på mal`() {
        // TODO: Det skal vel egentlig ikke være mulig å opprette en tom plan?
        //  (hindret ved oppretting i frontend, men mulig å nullstille en plan ved endring)

        val sak = nySakIKartleggesMedEtSamarbeid()
        val enTomPlanMal = PlanHelper.hentPlanMal()
        val plan = sak.opprettEnPlan(plan = enTomPlanMal)

        plan.antallTemaInkludert() shouldBe 0
        plan.antallInnholdInkludert() shouldBe 0
    }

    @Test
    fun `kan opprette en ny plan med alt inkludert`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val enTomPlanMal = PlanHelper.hentPlanMal()

        val plan = sak.opprettEnPlan(plan = enTomPlanMal.inkluderAlt())

        plan.antallTemaInkludert() shouldBeEqual plan.temaer.size
        plan.antallInnholdInkludert() shouldBeEqual plan.temaer.sumOf { it.undertemaer.size }
        plan.id shouldBeEqual sak.hentPlan().id
    }

    @Test
    fun `kan endre status på innhold i plan`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val enTomPlanMal = PlanHelper.hentPlanMal()
        val plan = sak.opprettEnPlan(plan = enTomPlanMal.inkluderAlt())

        sak.endreStatusPåInnhold(temaId = plan.temaer.first().id, innholdId = plan.temaer.first().undertemaer.first().id, status = FULLFØRT)

        val endretPlan = sak.hentPlan()

        endretPlan.antallTemaInkludert() shouldBe plan.temaer.size
        endretPlan.antallInnholdInkludert() shouldBe plan.temaer.sumOf { it.undertemaer.size }
        endretPlan.antallInnholdMedStatus(FULLFØRT) shouldBe 1
    }

    @Test
    fun `kan ikke endre status på innhold i plan om innhold ikke er inkludert`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val enTomPlanMal = PlanHelper.hentPlanMal()
        val plan = sak.opprettEnPlan(plan = enTomPlanMal)

        shouldFail {
            sak.endreStatusPåInnhold(
                temaId = plan.temaer.first().id,
                innholdId = plan.temaer.first().undertemaer.first().id,
                status = FULLFØRT,
            )
        }.message shouldBe "HTTP Exception 400 Bad Request"

        val endretPlan = sak.hentPlan()
        endretPlan.antallTemaInkludert() shouldBe 0
        endretPlan.antallInnholdInkludert() shouldBe 0
        endretPlan.temaer.first().undertemaer.first().status shouldBe null
    }

    @Test
    fun `kan endre på innhold i et tema som er inkludert`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val planMedEttTemaOgEttInnhold = PlanHelper.hentPlanMal().inkluderEttTemaOgEttInnhold(
            temanummer = 3,
            innholdnummer = 1,
        )
        val planDto = sak.opprettEnPlan(plan = planMedEttTemaOgEttInnhold)
        val temaId = planDto.temaer.last().id
        val endring = planDto.inkluderTemaOgAltInnhold(temaId = temaId).tilRequest().last()

        sak.endreEttTema(temaId = temaId, endring = endring.undertemaer)

        val endretPlan = sak.hentPlan()

        endretPlan.antallTemaInkludert() shouldBe 1
        endretPlan.antallInnholdInkludert() shouldBe 6
    }

    @Test
    fun `kan ikke endre innhold i plan om det temaet ikke allerede er inkludert`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val enTomPlanMal = PlanHelper.hentPlanMal()
        val plan = sak.opprettEnPlan(plan = enTomPlanMal)
        val førsteTema = plan.temaer.first()

        val endring = førsteTema.undertemaer.inkluderAltInnhold().tilRequest()

        shouldFail { sak.endreEttTema(temaId = førsteTema.id, endring = endring) }
            .message shouldBe "HTTP Exception 400 Bad Request"

        val endretPlan = sak.hentPlan()
        endretPlan.antallTemaInkludert() shouldBe 0
        endretPlan.antallInnholdInkludert() shouldBe 0
    }

    @Test
    fun `kan ikke endre på innhold i et tema som ikke er inkludert`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val enTomPlanMal = PlanHelper.hentPlanMal()
        val planDto = sak.opprettEnPlan(plan = enTomPlanMal)

        val endring = planDto.copy(
            temaer = planDto.temaer.map { tema ->
                tema.copy(
                    undertemaer = tema.undertemaer.inkluderAltInnhold(),
                )
            },
        )

        shouldFail { sak.endreEttTema(temaId = endring.temaer.first().id, endring = endring.tilRequest().first().undertemaer) }
            .message shouldBe "HTTP Exception 400 Bad Request"

        val endretPlan = sak.hentPlan()
        endretPlan.antallTemaInkludert() shouldBe 0
        endretPlan.antallInnholdInkludert() shouldBe 0
    }

    @Test
    fun `kan endre en tom plan til å inkludere alle tema og alle undertema`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val plan = sak.opprettEnPlan()

        sak.endreFlereTemaer(endring = plan.inkluderAlt().tilRequest())

        val endretPlan = sak.hentPlan()
        endretPlan.antallTemaInkludert() shouldBe plan.temaer.size
        endretPlan.antallInnholdInkludert() shouldBe plan.temaer.sumOf { it.undertemaer.size }
    }

    @Test
    fun `kan endre en plan med ett inkludert tema til å inkludere alt innhold i temaet`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val planMalDto = PlanHelper.hentPlanMal().inkluderEttTemaOgEttInnhold(temanummer = 3, innholdnummer = 1)
        val plan = sak.opprettEnPlan(plan = planMalDto)

        plan.antallTemaInkludert() shouldBe 1
        plan.antallInnholdInkludert() shouldBe 1

        sak.endreEttTema(temaId = plan.temaer.last().id, endring = plan.inkluderAlt().tilRequest().last().undertemaer)

        val endretPlan = sak.hentPlan()
        endretPlan.antallTemaInkludert() shouldBe 1
        endretPlan.antallInnholdInkludert() shouldBe plan.temaer.last().undertemaer.size
    }

    @Test
    fun `kan endre flere planer i flere samarbeid uten at de påvirker hverandre`() {
        val sak = nySakIKartlegges()
            .opprettNyttSamarbeid()
            .opprettNyttSamarbeid()
        val enTomPlanMal = PlanHelper.hentPlanMal()
        val planMalDto = enTomPlanMal.inkluderEttTemaOgEttInnhold(temanummer = 3, innholdnummer = 1)

        val alleSamarbeid = sak.hentAlleSamarbeid()

        val plan1 = sak.opprettEnPlan(plan = planMalDto, samarbeidId = alleSamarbeid.first().id)
        val plan2 = sak.opprettEnPlan(plan = enTomPlanMal, samarbeidId = alleSamarbeid.last().id)

        plan1.antallTemaInkludert() shouldBe 1
        plan1.antallInnholdInkludert() shouldBe 1

        plan2.antallTemaInkludert() shouldBe 0
        plan2.antallInnholdInkludert() shouldBe 0

        sak.endreEttTema(
            temaId = plan1.temaer.last().id,
            endring = plan1.inkluderAlt().tilRequest().last().undertemaer,
            prosessId = alleSamarbeid.first().id,
        )

        sak.endreFlereTemaer(endring = plan2.inkluderAlt().tilRequest(), prosessId = alleSamarbeid.last().id)

        val endretPlan1 = sak.hentPlan(prosessId = alleSamarbeid.first().id)
        endretPlan1.antallTemaInkludert() shouldBe 1
        endretPlan1.antallInnholdInkludert() shouldBe plan1.temaer.last().undertemaer.size

        val endretPlan2 = sak.hentPlan(prosessId = alleSamarbeid.last().id)
        endretPlan2.antallTemaInkludert() shouldBe 3
        endretPlan2.antallInnholdInkludert() shouldBe 11
    }

    @Test
    fun `endre status til avbrutt dersom undertema har startet eller er passert`() {
        val iDag = now().toKotlinLocalDate()
        val forEnMånedSiden = iDag.minus(6, DateTimeUnit.MONTH)
        val omEnMåned = iDag.plus(6, DateTimeUnit.MONTH)
        val sak = nySakIKartleggesMedEtSamarbeid()
        val enNyPlan = PlanMalDto(
            tema = listOf(
                TemaMalDto(
                    rekkefølge = 1,
                    navn = "Et tema til test",
                    inkludert = true,
                    innhold = listOf(
                        InnholdMalDto(
                            rekkefølge = 1,
                            navn = "Et undertema til test",
                            inkludert = true,
                            startDato = forEnMånedSiden,
                            sluttDato = omEnMåned,
                        ),
                    ),
                ),
            ),
        )
        val planDto = sak.opprettEnPlan(plan = enNyPlan)
        val førsteTema = planDto.temaer.first()
        val førsteUndertema = planDto.temaer.first().undertemaer.first()

        sak.endreStatusPåInnhold(temaId = førsteTema.id, innholdId = førsteUndertema.id, status = AVBRUTT)

        val planMedNyStatus = sak.hentPlan()
        planMedNyStatus.temaer.first().undertemaer.first().status shouldBe AVBRUTT
        planMedNyStatus.temaer.first().undertemaer.first().sluttDato shouldBe omEnMåned
    }

    @Test
    fun `endre status til avbrutt endrer ikke sluttdato dersom undertemaet er i fortiden`() {
        val iDag = now().toKotlinLocalDate()
        val for6MånedereSiden = iDag.minus(6, DateTimeUnit.MONTH)
        val iGår = iDag.minus(1, DateTimeUnit.DAY)
        val sak = nySakIKartleggesMedEtSamarbeid()
        val enNyPlan = PlanMalDto(
            tema = listOf(
                TemaMalDto(
                    rekkefølge = 1,
                    navn = "Et tema til test",
                    inkludert = true,
                    innhold = listOf(
                        InnholdMalDto(
                            rekkefølge = 1,
                            navn = "Et undertema til test",
                            inkludert = true,
                            startDato = for6MånedereSiden,
                            sluttDato = iGår,
                        ),
                    ),
                ),
            ),
        )

        val planDto = sak.opprettEnPlan(plan = enNyPlan)
        val førsteTema = planDto.temaer.first()
        val førsteUndertema = førsteTema.undertemaer.first()

        førsteUndertema.status shouldBe PLANLAGT
        førsteUndertema.sluttDato shouldBe iGår

        sak.endreStatusPåInnhold(temaId = førsteTema.id, innholdId = førsteUndertema.id, status = AVBRUTT)

        val planMedNyStatus = sak.hentPlan()
        planMedNyStatus.temaer.first().undertemaer.first().status shouldBe AVBRUTT
        planMedNyStatus.temaer.first().undertemaer.first().sluttDato shouldBe iGår
    }

    @Test
    fun `det er ikke mulig å endre status til avbrutt dersom undertemaet er i fremtiden`() {
        val iDag = now().toKotlinLocalDate()
        val om6Måneder = iDag.plus(6, DateTimeUnit.MONTH)
        val iMorgen = iDag.plus(1, DateTimeUnit.DAY)
        val sak = nySakIKartleggesMedEtSamarbeid()
        val enNyPlan = PlanMalDto(
            tema = listOf(
                TemaMalDto(
                    rekkefølge = 1,
                    navn = "Et tema til test",
                    inkludert = true,
                    innhold = listOf(
                        InnholdMalDto(
                            rekkefølge = 1,
                            navn = "Et undertema til test",
                            inkludert = true,
                            startDato = iMorgen,
                            sluttDato = om6Måneder,
                        ),
                    ),
                ),
            ),
        )

        val planDto = sak.opprettEnPlan(plan = enNyPlan)
        val førsteTema = planDto.temaer.first()
        val førsteUndertema = planDto.temaer.first().undertemaer.first()
        planDto.temaer.first().undertemaer.first().status shouldBe PLANLAGT
        planDto.temaer.first().undertemaer.first().sluttDato shouldBe om6Måneder
        planDto.temaer.first().undertemaer.first().startDato shouldBe iMorgen

        shouldFail { sak.endreStatusPåInnhold(temaId = førsteTema.id, innholdId = førsteUndertema.id, status = AVBRUTT) }
            .message shouldBe "HTTP Exception 400 Bad Request"
    }

    @Test
    fun `kan legge til nytt tema i plan uten uventet bieffekter`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val enTomPlan = PlanHelper.hentPlanMal()

        val opprettetPlan = sak.opprettEnPlan(plan = enTomPlan.inkluderEttTemaOgEttInnhold(2, 1))

        opprettetPlan.antallTemaInkludert() shouldBe 1
        opprettetPlan.antallInnholdInkludert() shouldBe 1
        opprettetPlan.antallInnholdMedStatus(status = PLANLAGT) shouldBe 1

        val nyStatus = PÅGÅR

        shouldFail {
            sak.endreStatusPåInnhold(
                temaId = opprettetPlan.temaer.first().id,
                innholdId = opprettetPlan.temaer.first().undertemaer.first().id,
                status = nyStatus,
            )
        }.message shouldBe "HTTP Exception 400 Bad Request"

        sak.endreStatusPåInnhold(
            temaId = opprettetPlan.temaer[1].id,
            innholdId = opprettetPlan.temaer[1].undertemaer.first().id,
            status = nyStatus,
        )

        val planMedNyStatus = sak.hentPlan()

        planMedNyStatus.antallTemaInkludert() shouldBe 1
        planMedNyStatus.antallInnholdInkludert() shouldBe 1
        planMedNyStatus.antallInnholdMedStatus(status = nyStatus) shouldBe 1

        sak.endreFlereTemaer(endring = planMedNyStatus.inkluderAlt().tilRequest())

        val planMedAltInnhold = sak.hentPlan()

        planMedAltInnhold.antallTemaInkludert() shouldBe 3
        planMedAltInnhold.antallInnholdInkludert() shouldBe 11
        planMedAltInnhold.antallInnholdMedStatus(status = nyStatus) shouldBe 1
        planMedAltInnhold.antallInnholdMedStatus(status = PLANLAGT) shouldBe 10
        planMedAltInnhold.antallInnholdMedStatus(status = PÅGÅR) shouldBe 1
    }

    @Test
    fun `Kan ikke opprette eller endre en plan med sluttdato før startdato`() {
        // TODO: Kanskje litt vel lang test, dekkes noe av dette av andre tester?
        val sak = nySakIKartleggesMedEtSamarbeid()
        val enTomPlan = PlanHelper.hentPlanMal()

        val ugyldigPlan = enTomPlan.inkluderEttTemaOgAltInnhold(temanummer = 3, startDato = SLUTT_DATO, sluttDato = START_DATO)
        // sluttdato før start-dato

        val gyldigPlan = enTomPlan.inkluderEttTemaOgAltInnhold(temanummer = 3)

        shouldFail { sak.opprettEnPlan(plan = ugyldigPlan) }
            .message shouldBe "HTTP Exception 400 Bad Request"

        val opprettetPlan = sak.opprettEnPlan(plan = gyldigPlan)
        val sisteTema = opprettetPlan.temaer.last()
        val førsteTema = opprettetPlan.temaer.first()

        opprettetPlan.antallTemaInkludert() shouldBe 1
        opprettetPlan.antallInnholdInkludert() shouldBe gyldigPlan.tema.last().innhold.size
        opprettetPlan.antallInnholdMedStatus(PLANLAGT) shouldBe gyldigPlan.tema.last().innhold.size
        opprettetPlan.tidligstStartDato() shouldBe START_DATO
        opprettetPlan.senesteSluttDato() shouldBe SLUTT_DATO
        // det siste temaet er inkludert

        val ugyldigEndring = opprettetPlan.inkluderTemaOgAltInnhold(
            temaId = opprettetPlan.temaer[0].id,
            startDato = SLUTT_DATO,
            sluttDato = START_DATO,
        )

        val gyldigEndring = opprettetPlan.inkluderTemaOgAltInnhold(
            temaId = opprettetPlan.temaer[0].id,
            startDato = START_DATO,
            sluttDato = SLUTT_DATO,
        )

        shouldFail { sak.endreFlereTemaer(endring = ugyldigEndring.tilRequest()) }
            .message shouldBe "HTTP Exception 400 Bad Request"

        val uendretPlan = sak.hentPlan()

        uendretPlan.antallTemaInkludert() shouldBe 1
        uendretPlan.antallInnholdInkludert() shouldBe sisteTema.undertemaer.size
        uendretPlan.antallInnholdMedStatus(PLANLAGT) shouldBe sisteTema.undertemaer.size
        uendretPlan.tidligstStartDato() shouldBe START_DATO
        uendretPlan.senesteSluttDato() shouldBe SLUTT_DATO
        // det siste temaet er inkludert samme som opprettetPlan

        sak.endreFlereTemaer(endring = gyldigEndring.tilRequest())

        val endretPlan = sak.hentPlan()
        endretPlan.antallTemaInkludert() shouldBe 2
        endretPlan.antallInnholdInkludert() shouldBe førsteTema.undertemaer.size + sisteTema.undertemaer.size
        endretPlan.antallInnholdMedStatus(PLANLAGT) shouldBe førsteTema.undertemaer.size + sisteTema.undertemaer.size
        endretPlan.tidligstStartDato() shouldBe START_DATO
        endretPlan.senesteSluttDato() shouldBe SLUTT_DATO
        // det første og siste temaet er inkludert

        val nyUgyldigEndring = endretPlan.inkluderTemaOgAltInnhold(
            temaId = endretPlan.temaer.last().id,
            startDato = SLUTT_DATO.plus(DatePeriod(years = 1)),
            sluttDato = START_DATO.plus(DatePeriod(years = 1)),
        ) // setter alle innhold til feil dato

        val nyGyldigEndring = endretPlan.inkluderTemaOgAltInnhold(
            temaId = endretPlan.temaer.last().id,
            startDato = START_DATO.plus(DatePeriod(years = 1)),
            sluttDato = SLUTT_DATO.plus(DatePeriod(years = 1)),
        ) // setter alle innhold til ny rett dato

        shouldFail {
            sak.endreEttTema(
                endring = nyUgyldigEndring.tilRequest().last().undertemaer,
                temaId = nyUgyldigEndring.temaer.last().id,
            )
        }.message shouldBe "HTTP Exception 400 Bad Request"

        sak.endreEttTema(
            endring = nyGyldigEndring.tilRequest().last().undertemaer,
            temaId = nyGyldigEndring.temaer.last().id,
        )

        val endretPlan2 = sak.hentPlan()

        endretPlan2.antallTemaInkludert() shouldBe 2
        endretPlan2.antallInnholdInkludert() shouldBe førsteTema.undertemaer.size + sisteTema.undertemaer.size
        endretPlan2.antallInnholdMedStatus(PLANLAGT) shouldBe førsteTema.undertemaer.size + sisteTema.undertemaer.size
        endretPlan2.tidligstStartDato() shouldBe START_DATO
        endretPlan2.senesteSluttDato() shouldBe SLUTT_DATO.plus(DatePeriod(years = 1))
        // Alle temaer og alt innhold er inkludert, seneste sluttdato

        // datoer er endret
    }

    @Test
    fun `skal få feil når man henter plan uten å ha opprettet en plan`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        shouldFail { sak.hentPlan() }.message shouldBe "HTTP Exception 400 Bad Request"
    }

    @Test
    fun `skal kunne hente plan uten å være eier som lesebruker`() {
        val sak = nySakIKartleggesMedEtSamarbeid()

        val opprettetPlan = sak.opprettEnPlan()

        val hentetPlan = sak.hentPlan(token = oauth2ServerContainer.lesebruker.token)

        opprettetPlan.id shouldBeEqual hentetPlan.id
    }

    @Test
    fun `skal kunne hente plan-mal som eier`() {
        val planMal = PlanHelper.hentPlanMal()

        planMal.tema.size shouldBe 3
        planMal.tema.first().navn shouldBe "Partssamarbeid"
    }

    @Test
    fun `Skal oppdatere sist endret dato ved endring av plan`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val enTomPlanMal = PlanHelper.hentPlanMal()

        val opprettetPlan = sak.opprettEnPlan(plan = enTomPlanMal.inkluderAlt())

        val førsteTema = opprettetPlan.temaer.first()
        val førsteUndertema = førsteTema.undertemaer.first()

        sak.endreStatusPåInnhold(
            temaId = førsteTema.id,
            innholdId = førsteUndertema.id,
            status = PÅGÅR,
        )

        sak.hentPlan().sistEndret shouldBeGreaterThan opprettetPlan.sistEndret
    }
}
