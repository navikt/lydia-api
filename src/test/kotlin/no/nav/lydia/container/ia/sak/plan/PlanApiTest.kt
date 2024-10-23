package no.nav.lydia.container.ia.sak.plan

import io.kotest.assertions.shouldFail
import io.kotest.inspectors.forAll
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.comparables.shouldBeGreaterThan
import io.kotest.matchers.equals.shouldBeEqual
import io.kotest.matchers.shouldBe
import kotlinx.datetime.DateTimeUnit
import kotlinx.datetime.LocalDate
import kotlinx.datetime.minus
import kotlinx.datetime.plus
import kotlinx.datetime.toKotlinLocalDate
import no.nav.lydia.helper.PlanHelper
import no.nav.lydia.helper.PlanHelper.Companion.tilRequest
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartlegges
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartleggesMedEtSamarbeid
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.lydiaApiContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.helper.opprettNyttSamarbeid
import no.nav.lydia.ia.sak.api.plan.EndreUndertemaRequest
import no.nav.lydia.ia.sak.domene.plan.InnholdMalDto
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema
import no.nav.lydia.ia.sak.domene.plan.TemaMalDto
import java.time.LocalDate.now
import kotlin.test.Test

class PlanApiTest {
    @Test
    fun `oppretter en tom ny plan med mal`() {
        val sak = nySakIKartleggesMedEtSamarbeid()

        val endretPlan = PlanMalDto()

        val planDto = PlanHelper.opprettEnPlan(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            redigertPlan = endretPlan,
            prosessId = sak.hentAlleSamarbeid().first().id,
        )

        planDto.temaer.any { it.inkludert } shouldBe false
        planDto.temaer.forEach { tema ->
            tema.undertemaer.any { it.inkludert } shouldBe false
        }
    }

    @Test
    fun `oppretter en ny plan med alle temaer og innhold planlagt med mal`() {
        val sak = nySakIKartleggesMedEtSamarbeid()

        val standardPlan = PlanMalDto()

        val redigertPlan = PlanMalDto(
            tema = standardPlan.tema.map { temaMalDto ->
                TemaMalDto(
                    rekkefølge = temaMalDto.rekkefølge,
                    navn = temaMalDto.navn,
                    inkludert = true,
                    innhold = temaMalDto.innhold.map { innholdMalDto ->
                        InnholdMalDto(
                            rekkefølge = innholdMalDto.rekkefølge,
                            navn = innholdMalDto.navn,
                            inkludert = true,
                            startDato = LocalDate(2021, 1, 1),
                            sluttDato = LocalDate(2021, 1, 2),
                        )
                    },
                )
            },
        )

        val planDto = PlanHelper.opprettEnPlan(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            redigertPlan = redigertPlan,
            prosessId = sak.hentAlleSamarbeid().first().id,
        )

        planDto.temaer.all { it.inkludert } shouldBe true
        planDto.temaer.forEach { tema ->
            tema.undertemaer.all { it.inkludert } shouldBe true
        }
    }

    @Test
    fun `kan endre status på undertema`() {
        val sak = nySakIKartleggesMedEtSamarbeid()

        val planDto = PlanHelper.opprettEnPlan(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
        )
        val førsteTema = planDto.temaer.first()
        val førsteUndertema = førsteTema.undertemaer.first()

        val nyStatus = PlanUndertema.Status.FULLFØRT

        val resp =
            PlanHelper.endreStatus(
                orgnr = sak.orgnr,
                saksnummer = sak.saksnummer,
                temaId = førsteTema.id,
                undertemaId = førsteUndertema.id,
                status = nyStatus,
                prosessId = sak.hentAlleSamarbeid().first().id,
            )

        resp.status shouldBe nyStatus
    }

    @Test
    fun `kan sette alle tema og alle undertema til planlagt`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val planDto = PlanHelper.opprettEnPlan(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
        )

        val endretPlan = planDto.copy(
            temaer = planDto.temaer.map { temaDto ->
                temaDto.copy(
                    inkludert = true,
                    undertemaer = temaDto.undertemaer.map { undertemaDto ->
                        undertemaDto.copy(
                            inkludert = true,
                            startDato = LocalDate(2021, 1, 1),
                            sluttDato = LocalDate(2021, 1, 2),
                        )
                    },
                )
            },
        )

        val resp = PlanHelper.endrePlan(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
            endring = endretPlan.tilRequest(),
        )

        resp.first().id shouldBe endretPlan.temaer.first().id
        resp.first().navn shouldBe endretPlan.temaer.first().navn
        resp.first().inkludert shouldBe endretPlan.temaer.first().inkludert
        resp.first().undertemaer.first().id shouldBe endretPlan.temaer.first().undertemaer.first().id
        resp.first().undertemaer.first().inkludert shouldBe endretPlan.temaer.first().undertemaer.first().inkludert
        resp.first().undertemaer.first().navn shouldBe endretPlan.temaer.first().undertemaer.first().navn
        resp.first().undertemaer.first().målsetning shouldBe endretPlan.temaer.first().undertemaer.first().målsetning
        resp.first().undertemaer.first().status shouldBe PlanUndertema.Status.PLANLAGT
        resp.first().undertemaer.first().startDato shouldBe endretPlan.temaer.first().undertemaer.first().startDato
        resp.first().undertemaer.first().sluttDato shouldBe endretPlan.temaer.first().undertemaer.first().sluttDato
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
        val planDto = PlanHelper.opprettEnPlan(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            redigertPlan = enNyPlan,
            prosessId = sak.hentAlleSamarbeid().first().id,
        )
        val førsteTema = planDto.temaer.first()
        val førsteUndertema = planDto.temaer.first().undertemaer.first()

        val resp =
            PlanHelper.endreStatus(
                orgnr = sak.orgnr,
                saksnummer = sak.saksnummer,
                prosessId = sak.hentAlleSamarbeid().first().id,
                temaId = førsteTema.id,
                undertemaId = førsteUndertema.id,
                status = PlanUndertema.Status.AVBRUTT,
            )
        resp.status shouldBe PlanUndertema.Status.AVBRUTT
        resp.sluttDato shouldBe omEnMåned

        val planMedNyStatus = PlanHelper.hentPlan(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
        )
        planMedNyStatus.temaer.first().undertemaer.first().status shouldBe PlanUndertema.Status.AVBRUTT
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

        val planDto = PlanHelper.opprettEnPlan(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
            redigertPlan = enNyPlan,
        )
        val førsteTema = planDto.temaer.first()
        val førsteUndertema = planDto.temaer.first().undertemaer.first()
        planDto.temaer.first().undertemaer.first().status shouldBe PlanUndertema.Status.PLANLAGT
        planDto.temaer.first().undertemaer.first().sluttDato shouldBe iGår

        val resp =
            PlanHelper.endreStatus(
                orgnr = sak.orgnr,
                saksnummer = sak.saksnummer,
                prosessId = sak.hentAlleSamarbeid().first().id,
                temaId = førsteTema.id,
                undertemaId = førsteUndertema.id,
                status = PlanUndertema.Status.AVBRUTT,
            )
        resp.status shouldBe PlanUndertema.Status.AVBRUTT
        resp.sluttDato shouldBe iGår

        val planMedNyStatus = PlanHelper.hentPlan(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
        )
        planMedNyStatus.temaer.first().undertemaer.first().status shouldBe PlanUndertema.Status.AVBRUTT
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

        val planDto = PlanHelper.opprettEnPlan(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
            redigertPlan = enNyPlan,
        )
        val førsteTema = planDto.temaer.first()
        val førsteUndertema = planDto.temaer.first().undertemaer.first()
        planDto.temaer.first().undertemaer.first().status shouldBe PlanUndertema.Status.PLANLAGT
        planDto.temaer.first().undertemaer.first().sluttDato shouldBe om6Måneder
        planDto.temaer.first().undertemaer.first().startDato shouldBe iMorgen

        val result = shouldFail {
            PlanHelper.endreStatus(
                orgnr = sak.orgnr,
                saksnummer = sak.saksnummer,
                prosessId = sak.hentAlleSamarbeid().first().id,
                temaId = førsteTema.id,
                undertemaId = førsteUndertema.id,
                status = PlanUndertema.Status.AVBRUTT,
            )
        }
        result.message shouldBe "HTTP Exception 400 Bad Request"
    }

    @Test
    fun `kan sette alle undertemaer til planlagt`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val planDto = PlanHelper.opprettEnPlan(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
        )

        val endretPlan = planDto.copy(
            temaer = planDto.temaer.map { temaDto ->
                temaDto.copy(
                    undertemaer = temaDto.undertemaer.map { undertemaDto ->
                        undertemaDto.copy(
                            inkludert = true,
                        )
                    },
                )
            },
        )

        val resp =
            PlanHelper.endreTema(
                orgnr = sak.orgnr,
                saksnummer = sak.saksnummer,
                prosessId = sak.hentAlleSamarbeid().first().id,
                temaId = endretPlan.temaer.first().id,
                endring = endretPlan.tilRequest().first().undertemaer,
            )

        resp.id shouldBe endretPlan.temaer.first().id
        resp.navn shouldBe endretPlan.temaer.first().navn
        resp.undertemaer.first().id shouldBe endretPlan.temaer.first().undertemaer.first().id
        resp.undertemaer.first().inkludert shouldBe endretPlan.temaer.first().undertemaer.first().inkludert
        resp.undertemaer.first().navn shouldBe endretPlan.temaer.first().undertemaer.first().navn
        resp.undertemaer.first().målsetning shouldBe endretPlan.temaer.first().undertemaer.first().målsetning
        resp.undertemaer.first().status shouldBe PlanUndertema.Status.PLANLAGT
    }

    @Test
    fun `kan legge til nytt tema i plan uten uventet bieffekter`() {
        val sak = nySakIKartleggesMedEtSamarbeid()

        val planMal: PlanMalDto = PlanHelper.hentPlanMal()

        val startDato = LocalDate(2010, 1, 1)
        val sluttDato = LocalDate(2025, 2, 2)

        val planMedEttTema = planMal.copy(
            tema = planMal.tema.map { tema ->
                if (tema.rekkefølge == 2) {
                    tema.copy(
                        inkludert = true,
                        innhold = tema.innhold.map { innhold ->
                            innhold.copy(
                                inkludert = true,
                                startDato = startDato,
                                sluttDato = sluttDato,
                            )
                        },
                    )
                } else {
                    tema
                }
            },
        )

        val opprettetPlan = PlanHelper.opprettEnPlan(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
            redigertPlan = planMedEttTema,
        )

        opprettetPlan.temaer[0].inkludert shouldBe false
        opprettetPlan.temaer[0].undertemaer.forEach { it.inkludert shouldBe false }
        opprettetPlan.temaer[0].undertemaer.forEach { it.status shouldBe null }
        opprettetPlan.temaer[0].undertemaer.forEach { it.startDato shouldBe null }
        opprettetPlan.temaer[0].undertemaer.forEach { it.sluttDato shouldBe null }

        opprettetPlan.temaer[1].inkludert shouldBe true
        opprettetPlan.temaer[1].undertemaer.forEach { it.inkludert shouldBe true }
        opprettetPlan.temaer[1].undertemaer.forEach { it.status shouldBe PlanUndertema.Status.PLANLAGT }
        opprettetPlan.temaer[1].undertemaer.forEach { it.startDato shouldBe startDato }
        opprettetPlan.temaer[1].undertemaer.forEach { it.sluttDato shouldBe sluttDato }

        opprettetPlan.temaer[2].inkludert shouldBe false
        opprettetPlan.temaer[2].undertemaer.forEach { it.inkludert shouldBe false }
        opprettetPlan.temaer[2].undertemaer.forEach { it.status shouldBe null }
        opprettetPlan.temaer[2].undertemaer.forEach { it.startDato shouldBe null }
        opprettetPlan.temaer[2].undertemaer.forEach { it.sluttDato shouldBe null }

        val nyStatus = PlanUndertema.Status.PÅGÅR

        PlanHelper.endreStatus(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
            temaId = opprettetPlan.temaer[1].id,
            undertemaId = opprettetPlan.temaer[1].undertemaer.first().id,
            status = nyStatus,
        )

        val planMedNyStatus = PlanHelper.hentPlan(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
        )

        planMedNyStatus.temaer[0].inkludert shouldBe false
        planMedNyStatus.temaer[0].undertemaer.forEach { it.inkludert shouldBe false }
        planMedNyStatus.temaer[0].undertemaer.forEach { it.status shouldBe null }
        planMedNyStatus.temaer[0].undertemaer.forEach { it.startDato shouldBe null }
        planMedNyStatus.temaer[0].undertemaer.forEach { it.sluttDato shouldBe null }

        planMedNyStatus.temaer[1].inkludert shouldBe true
        planMedNyStatus.temaer[1].undertemaer.forEach { it.inkludert shouldBe true }
        planMedNyStatus.temaer[1].undertemaer.forExactlyOne { it.status shouldBe nyStatus }
        planMedNyStatus.temaer[1].undertemaer.forEach { it.startDato shouldBe startDato }
        planMedNyStatus.temaer[1].undertemaer.forEach { it.sluttDato shouldBe sluttDato }

        planMedNyStatus.temaer[2].inkludert shouldBe false
        planMedNyStatus.temaer[2].undertemaer.forEach { it.inkludert shouldBe false }
        planMedNyStatus.temaer[2].undertemaer.forEach { it.status shouldBe null }
        planMedNyStatus.temaer[2].undertemaer.forEach { it.startDato shouldBe null }
        planMedNyStatus.temaer[2].undertemaer.forEach { it.sluttDato shouldBe null }

        val endretPlan = planMedNyStatus.copy(
            temaer = listOf(
                planMedNyStatus.temaer[0].copy(
                    inkludert = true,
                    undertemaer = planMedNyStatus.temaer[0].undertemaer.map { undertema ->
                        undertema.copy(
                            inkludert = true,
                            startDato = startDato,
                            sluttDato = sluttDato,
                        )
                    },
                ),
                planMedNyStatus.temaer[1],
                planMedNyStatus.temaer[2],
            ),
        )

        PlanHelper.endrePlan(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
            endring = endretPlan.tilRequest(),
        )

        val planMedNyttTema = PlanHelper.hentPlan(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
        )

        planMedNyttTema.temaer[0].inkludert shouldBe true
        planMedNyttTema.temaer[0].undertemaer.forEach { it.inkludert shouldBe true }
        planMedNyttTema.temaer[0].undertemaer.forEach { it.status shouldBe PlanUndertema.Status.PLANLAGT }
        planMedNyttTema.temaer[0].undertemaer.forEach { it.startDato shouldBe startDato }
        planMedNyttTema.temaer[0].undertemaer.forEach { it.sluttDato shouldBe sluttDato }

        planMedNyttTema.temaer[1].inkludert shouldBe true
        planMedNyttTema.temaer[1].undertemaer.forEach { it.inkludert shouldBe true }
        planMedNyttTema.temaer[1].undertemaer.forExactlyOne { it.status shouldBe nyStatus }
        planMedNyttTema.temaer[1].undertemaer.forEach { it.startDato shouldBe startDato }
        planMedNyttTema.temaer[1].undertemaer.forEach { it.sluttDato shouldBe sluttDato }

        planMedNyttTema.temaer[2].inkludert shouldBe false
        planMedNyttTema.temaer[2].undertemaer.forEach { it.inkludert shouldBe false }
        planMedNyttTema.temaer[2].undertemaer.forEach { it.status shouldBe null }
        planMedNyttTema.temaer[2].undertemaer.forEach { it.startDato shouldBe null }
        planMedNyttTema.temaer[2].undertemaer.forEach { it.sluttDato shouldBe null }
    }

    @Test
    fun `kan ikke opprette plan med periode som er negativ - start dato etter slutt dato`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val planMal: PlanMalDto = PlanHelper.hentPlanMal()

        val startDato = LocalDate(2025, 1, 1)
        val sluttDato = LocalDate(2010, 2, 2)

        val planMedEttTema = planMal.copy(
            tema = planMal.tema.map { tema ->
                if (tema.rekkefølge == 2) {
                    tema.copy(
                        inkludert = true,
                        innhold = tema.innhold.map { innhold ->
                            innhold.copy(
                                inkludert = true,
                                startDato = startDato,
                                sluttDato = sluttDato,
                            )
                        },
                    )
                } else {
                    tema
                }
            },
        )

        shouldFail {
            PlanHelper.opprettEnPlan(
                orgnr = sak.orgnr,
                saksnummer = sak.saksnummer,
                prosessId = sak.hentAlleSamarbeid().first().id,
                redigertPlan = planMedEttTema,
            )
        }

        lydiaApiContainer shouldContainLog "Plan er ikke gyldig".toRegex()
    }

    @Test
    fun `kan ikke endre plan med periode som er negativ - start dato etter slutt dato`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val planMal: PlanMalDto = PlanHelper.hentPlanMal()

        val startDato = LocalDate(2010, 1, 1)
        val sluttDato = LocalDate(2025, 2, 2)

        val planMedEttTema = planMal.copy(
            tema = planMal.tema.map { tema ->
                if (tema.rekkefølge == 2) {
                    tema.copy(
                        inkludert = true,
                        innhold = tema.innhold.map { innhold ->
                            innhold.copy(
                                inkludert = true,
                                startDato = startDato,
                                sluttDato = sluttDato,
                            )
                        },
                    )
                } else {
                    tema
                }
            },
        )

        val opprettetPlan = PlanHelper.opprettEnPlan(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
            redigertPlan = planMedEttTema,
        )

        opprettetPlan.temaer[0].inkludert shouldBe false
        opprettetPlan.temaer[0].undertemaer.forEach { it.inkludert shouldBe false }
        opprettetPlan.temaer[0].undertemaer.forEach { it.status shouldBe null }
        opprettetPlan.temaer[0].undertemaer.forEach { it.startDato shouldBe null }
        opprettetPlan.temaer[0].undertemaer.forEach { it.sluttDato shouldBe null }

        opprettetPlan.temaer[1].inkludert shouldBe true
        opprettetPlan.temaer[1].undertemaer.forEach { it.inkludert shouldBe true }
        opprettetPlan.temaer[1].undertemaer.forEach { it.status shouldBe PlanUndertema.Status.PLANLAGT }
        opprettetPlan.temaer[1].undertemaer.forEach { it.startDato shouldBe startDato }
        opprettetPlan.temaer[1].undertemaer.forEach { it.sluttDato shouldBe sluttDato }

        opprettetPlan.temaer[2].inkludert shouldBe false
        opprettetPlan.temaer[2].undertemaer.forEach { it.inkludert shouldBe false }
        opprettetPlan.temaer[2].undertemaer.forEach { it.status shouldBe null }
        opprettetPlan.temaer[2].undertemaer.forEach { it.startDato shouldBe null }
        opprettetPlan.temaer[2].undertemaer.forEach { it.sluttDato shouldBe null }

        val endretPlan = opprettetPlan.copy(
            temaer = listOf(
                opprettetPlan.temaer[0].copy(
                    inkludert = true,
                    undertemaer = opprettetPlan.temaer[0].undertemaer.map { undertema ->
                        undertema.copy(
                            inkludert = true,
                            startDato = sluttDato,
                            sluttDato = startDato,
                        )
                    },
                ),
                opprettetPlan.temaer[1],
                opprettetPlan.temaer[2],
            ),
        )

        shouldFail {
            PlanHelper.endrePlan(
                orgnr = sak.orgnr,
                saksnummer = sak.saksnummer,
                prosessId = sak.hentAlleSamarbeid().first().id,
                endring = endretPlan.tilRequest(),
            )
        }
        lydiaApiContainer shouldContainLog "Plan er ikke gyldig".toRegex()

        val lagretPlan = PlanHelper.hentPlan(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
        )
        lagretPlan.temaer[1].inkludert shouldBe true
        lagretPlan.temaer[1].undertemaer.forEach { it.inkludert shouldBe true }
        lagretPlan.temaer[1].undertemaer.forEach { it.status shouldBe PlanUndertema.Status.PLANLAGT }
        lagretPlan.temaer[1].undertemaer.forEach { it.startDato shouldBe startDato }
        lagretPlan.temaer[1].undertemaer.forEach { it.sluttDato shouldBe sluttDato }
    }

    @Test
    fun `kan ikke endre tema med periode som er negativ - start dato etter slutt dato`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val planMal: PlanMalDto = PlanHelper.hentPlanMal()

        val startDato = LocalDate(2010, 1, 1)
        val sluttDato = LocalDate(2025, 2, 2)

        val planMedEttTema = planMal.copy(
            tema = planMal.tema.map { tema ->
                if (tema.rekkefølge == 2) {
                    tema.copy(
                        inkludert = true,
                        innhold = tema.innhold.map { innhold ->
                            innhold.copy(
                                inkludert = true,
                                startDato = startDato,
                                sluttDato = sluttDato,
                            )
                        },
                    )
                } else {
                    tema
                }
            },
        )

        val opprettetPlan = PlanHelper.opprettEnPlan(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
            redigertPlan = planMedEttTema,
        )

        opprettetPlan.temaer[0].inkludert shouldBe false
        opprettetPlan.temaer[0].undertemaer.forEach { it.inkludert shouldBe false }
        opprettetPlan.temaer[0].undertemaer.forEach { it.status shouldBe null }
        opprettetPlan.temaer[0].undertemaer.forEach { it.startDato shouldBe null }
        opprettetPlan.temaer[0].undertemaer.forEach { it.sluttDato shouldBe null }

        opprettetPlan.temaer[1].inkludert shouldBe true
        opprettetPlan.temaer[1].undertemaer.forEach { it.inkludert shouldBe true }
        opprettetPlan.temaer[1].undertemaer.forEach { it.status shouldBe PlanUndertema.Status.PLANLAGT }
        opprettetPlan.temaer[1].undertemaer.forEach { it.startDato shouldBe startDato }
        opprettetPlan.temaer[1].undertemaer.forEach { it.sluttDato shouldBe sluttDato }

        opprettetPlan.temaer[2].inkludert shouldBe false
        opprettetPlan.temaer[2].undertemaer.forEach { it.inkludert shouldBe false }
        opprettetPlan.temaer[2].undertemaer.forEach { it.status shouldBe null }
        opprettetPlan.temaer[2].undertemaer.forEach { it.startDato shouldBe null }
        opprettetPlan.temaer[2].undertemaer.forEach { it.sluttDato shouldBe null }

        val endretPlan = opprettetPlan.copy(
            temaer = listOf(
                opprettetPlan.temaer[0].copy(
                    inkludert = true,
                    undertemaer = opprettetPlan.temaer[0].undertemaer.map { undertema ->
                        undertema.copy(
                            inkludert = true,
                            startDato = sluttDato,
                            sluttDato = startDato,
                        )
                    },
                ),
                opprettetPlan.temaer[1],
                opprettetPlan.temaer[2],
            ),
        )

        shouldFail {
            PlanHelper.endreTema(
                orgnr = sak.orgnr,
                saksnummer = sak.saksnummer,
                prosessId = sak.hentAlleSamarbeid().first().id,
                temaId = endretPlan.temaer.first().id,
                endring = endretPlan.tilRequest().first().undertemaer,
            )
        }

        lydiaApiContainer shouldContainLog "Plan er ikke gyldig".toRegex()

        val lagretPlan = PlanHelper.hentPlan(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
        )
        lagretPlan.temaer[1].inkludert shouldBe true
        lagretPlan.temaer[1].undertemaer.forEach { it.inkludert shouldBe true }
        lagretPlan.temaer[1].undertemaer.forEach { it.status shouldBe PlanUndertema.Status.PLANLAGT }
        lagretPlan.temaer[1].undertemaer.forEach { it.startDato shouldBe startDato }
        lagretPlan.temaer[1].undertemaer.forEach { it.sluttDato shouldBe sluttDato }
    }

    @Test
    fun `skal få feil når man henter plan uten å ha opprettet en plan`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        shouldFail {
            PlanHelper.hentPlan(
                orgnr = sak.orgnr,
                saksnummer = sak.saksnummer,
                prosessId = sak.hentAlleSamarbeid().first().id,
            )
        }
    }

    @Test
    fun `skal kunne hente plan uten å være eier som lesebruker`() {
        val sak = nySakIKartleggesMedEtSamarbeid()

        val opprettetPlan = PlanHelper.opprettEnPlan(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
        )
        val hentetPlan = PlanHelper.hentPlan(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
            token = TestContainerHelper.oauth2ServerContainer.lesebruker.token,
        )

        opprettetPlan.id shouldBeEqual hentetPlan.id
    }

    @Test
    fun `skal kunne hente plan-mal som eier`() {
        val planMal = PlanHelper.hentPlanMal()

        planMal.tema.size shouldBe 3
        planMal.tema.first().navn shouldBe "Partssamarbeid"
    }

    @Test
    fun `skal kunne opprette plan knyttet til en gitt prosess`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val prosessId = sak.hentAlleSamarbeid().first().id
        val opprettetPlan = PlanHelper.opprettEnPlan(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = prosessId,
        )
        opprettetPlan.id shouldBeEqual PlanHelper.hentPlan(sak.orgnr, sak.saksnummer, prosessId).id
    }

    @Test
    fun `skal kunne opprette og hente en plan knyttet til en prosess`() {
        val sak = nySakIKartlegges()
            .opprettNyttSamarbeid()
            .opprettNyttSamarbeid()
        val alleSamarbeid = sak.hentAlleSamarbeid()
        alleSamarbeid shouldHaveSize 2

        alleSamarbeid.forEach { samarbeid ->
            val opprettetPlan = PlanHelper.opprettEnPlan(
                orgnr = sak.orgnr,
                saksnummer = sak.saksnummer,
                prosessId = samarbeid.id,
            )

            val hentetPlan = PlanHelper.hentPlan(
                orgnr = sak.orgnr,
                saksnummer = sak.saksnummer,
                prosessId = samarbeid.id,
            )
            opprettetPlan.id shouldBe hentetPlan.id
        }
    }

    @Test
    fun `skal kunne endre status på et undertema i en plan knyttet til en prosess`() {
        val sak = nySakIKartlegges()
            .opprettNyttSamarbeid()
            .opprettNyttSamarbeid()
        val alleSamarbeid = sak.hentAlleSamarbeid()
        alleSamarbeid shouldHaveSize 2

        alleSamarbeid.forEach { samarbeid ->
            val planDto = PlanHelper.opprettEnPlan(
                orgnr = sak.orgnr,
                saksnummer = sak.saksnummer,
                prosessId = samarbeid.id,
            )
            val førsteTema = planDto.temaer.first()
            val førsteUndertema = førsteTema.undertemaer.first()

            val nyStatus = PlanUndertema.Status.FULLFØRT

            val resp =
                PlanHelper.endreStatus(
                    orgnr = sak.orgnr,
                    saksnummer = sak.saksnummer,
                    prosessId = samarbeid.id,
                    temaId = førsteTema.id,
                    undertemaId = førsteUndertema.id,
                    status = nyStatus,
                )

            resp.status shouldBe nyStatus
            val hentetPlan = PlanHelper.hentPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer, prosessId = samarbeid.id)
            hentetPlan.temaer
                .first { it.id == førsteTema.id }.undertemaer
                .first { it.id == førsteUndertema.id }.status shouldBe nyStatus
        }
    }

    @Test
    fun `kan sette alle undertemaer til planlagt i en plan knyttet til en prosess`() {
        val sak = nySakIKartlegges()
            .opprettNyttSamarbeid()
            .opprettNyttSamarbeid()
        val alleSamarbeid = sak.hentAlleSamarbeid()
        alleSamarbeid shouldHaveSize 2

        alleSamarbeid.forEach { samarbeid ->
            val planDto =
                PlanHelper.opprettEnPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer, prosessId = samarbeid.id)
            val tema = planDto.temaer.first()
            val endreTemaRequest = tema.undertemaer.map { undertemaDto ->
                EndreUndertemaRequest(
                    id = undertemaDto.id,
                    inkludert = true,
                    startDato = undertemaDto.startDato,
                    sluttDato = undertemaDto.sluttDato,
                )
            }

            PlanHelper.endreTema(
                orgnr = sak.orgnr,
                saksnummer = sak.saksnummer,
                prosessId = samarbeid.id,
                temaId = tema.id,
                endring = endreTemaRequest,
            )
            PlanHelper.hentPlan(sak.orgnr, sak.saksnummer, samarbeid.id)
                .temaer.first { it.id == tema.id }.undertemaer
                .forAll {
                    it.inkludert shouldBe true
                    it.status shouldBe PlanUndertema.Status.PLANLAGT
                }
        }
    }

    @Test
    fun `skal kunne endre en plan knyttet til en prosess`() {
        val sak = nySakIKartlegges()
            .opprettNyttSamarbeid()
            .opprettNyttSamarbeid()
        val alleSamarbeid = sak.hentAlleSamarbeid()
        alleSamarbeid shouldHaveSize 2

        alleSamarbeid.forEach { samarbeid ->
            val opprettetPlan = PlanHelper.opprettEnPlan(sak.orgnr, sak.saksnummer, samarbeid.id)
            val endretPlan = opprettetPlan.copy(
                temaer = opprettetPlan.temaer.map {
                    it.copy(
                        inkludert = true,
                        undertemaer = it.undertemaer.map {
                            it.copy(
                                inkludert = true,
                                status = PlanUndertema.Status.PLANLAGT,
                            )
                        },
                    )
                },
            )
            PlanHelper.endrePlan(sak.orgnr, sak.saksnummer, samarbeid.id, endretPlan.tilRequest())
            val hentetPlan = PlanHelper.hentPlan(sak.orgnr, sak.saksnummer, samarbeid.id)
            hentetPlan.id shouldBe opprettetPlan.id
            hentetPlan.temaer.forAll { tema ->
                tema.inkludert shouldBe true
                tema.undertemaer.forAll { undertema ->
                    undertema.inkludert shouldBe true
                    undertema.status shouldBe PlanUndertema.Status.PLANLAGT
                }
            }
        }
    }

    @Test
    fun `skal oppdatere plan sin sist_endret ved endringer av plan`() {
        val sak = nySakIKartlegges()
            .opprettNyttSamarbeid()
        val samarbeidId = sak.hentAlleSamarbeid().first().id
        val opprettetPlan = PlanHelper.opprettEnPlan(sak.orgnr, sak.saksnummer, samarbeidId)
        val førsteTema = opprettetPlan.temaer.first()
        val førsteUndertema = førsteTema.undertemaer.first()
        PlanHelper.endreStatus(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = samarbeidId,
            status = PlanUndertema.Status.PÅGÅR,
            temaId = førsteTema.id,
            undertemaId = førsteUndertema.id,
        )
        val endretPlan = PlanHelper.hentPlan(sak.orgnr, sak.saksnummer, samarbeidId)
        endretPlan.sistEndret shouldBeGreaterThan opprettetPlan.sistEndret
    }
}
