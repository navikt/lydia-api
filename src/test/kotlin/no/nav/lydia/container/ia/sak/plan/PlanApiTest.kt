package no.nav.lydia.container.ia.sak.plan

import io.kotest.assertions.shouldFail
import io.kotest.inspectors.forAll
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.comparables.shouldBeGreaterThan
import io.kotest.matchers.equals.shouldBeEqual
import io.kotest.matchers.shouldBe
import kotlinx.datetime.LocalDate
import no.nav.lydia.helper.PlanHelper
import no.nav.lydia.helper.PlanHelper.Companion.tilRequest
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartlegges
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.lydiaApiContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.hentIAProsesser
import no.nav.lydia.helper.opprettNyProsses
import no.nav.lydia.ia.sak.api.plan.EndreUndertemaRequest
import no.nav.lydia.ia.sak.domene.plan.InnholdMalDto
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema
import no.nav.lydia.ia.sak.domene.plan.TemaMalDto
import kotlin.test.Test

class PlanApiTest {
    @Test
    fun `oppretter en tom ny plan med mal`() {
        val sak = nySakIKartlegges()

        val endretPlan = PlanMalDto()

        val planDto = PlanHelper.opprettEnPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer, redigertPlan = endretPlan)

        planDto.temaer.any { it.planlagt } shouldBe false
        planDto.temaer.forEach { tema ->
            tema.undertemaer.any { it.planlagt } shouldBe false
        }
    }

    @Test
    fun `oppretter en ny plan med alle temaer og innhold planlagt med mal`() {
        val sak = nySakIKartlegges()

        val standardPlan = PlanMalDto()

        val redigertPlan = PlanMalDto(
            tema = standardPlan.tema.map { temaMalDto ->
                TemaMalDto(
                    rekkefølge = temaMalDto.rekkefølge,
                    navn = temaMalDto.navn,
                    planlagt = true,
                    innhold = temaMalDto.innhold.map { innholdMalDto ->
                        InnholdMalDto(
                            rekkefølge = innholdMalDto.rekkefølge,
                            navn = innholdMalDto.navn,
                            planlagt = true,
                            startDato = LocalDate(2021, 1, 1),
                            sluttDato = LocalDate(2021, 1, 2),
                        )
                    },
                )
            },
        )

        val planDto =
            PlanHelper.opprettEnPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer, redigertPlan = redigertPlan)

        planDto.temaer.all { it.planlagt } shouldBe true
        planDto.temaer.forEach { tema ->
            tema.undertemaer.all { it.planlagt } shouldBe true
        }
    }

    @Test
    fun `kan endre status på undertema`() {
        val sak = nySakIKartlegges()

        val planDto = PlanHelper.opprettEnPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
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
            )

        resp.status shouldBe nyStatus
    }

    @Test
    fun `kan sette alle tema og alle undertema til planlagt`() {
        val sak = nySakIKartlegges()
        val planDto = PlanHelper.opprettEnPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer)

        val endretPlan = planDto.copy(
            temaer = planDto.temaer.map { temaDto ->
                temaDto.copy(
                    planlagt = true,
                    undertemaer = temaDto.undertemaer.map { undertemaDto ->
                        undertemaDto.copy(
                            planlagt = true,
                            startDato = LocalDate(2021, 1, 1),
                            sluttDato = LocalDate(2021, 1, 2),
                        )
                    },
                )
            },
        )

        val resp = PlanHelper.endrePlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer, endring = endretPlan.tilRequest())

        resp.first().id shouldBe endretPlan.temaer.first().id
        resp.first().navn shouldBe endretPlan.temaer.first().navn
        resp.first().planlagt shouldBe endretPlan.temaer.first().planlagt
        resp.first().undertemaer.first().id shouldBe endretPlan.temaer.first().undertemaer.first().id
        resp.first().undertemaer.first().planlagt shouldBe endretPlan.temaer.first().undertemaer.first().planlagt
        resp.first().undertemaer.first().navn shouldBe endretPlan.temaer.first().undertemaer.first().navn
        resp.first().undertemaer.first().målsetning shouldBe endretPlan.temaer.first().undertemaer.first().målsetning
        resp.first().undertemaer.first().status shouldBe PlanUndertema.Status.PLANLAGT
        resp.first().undertemaer.first().startDato shouldBe endretPlan.temaer.first().undertemaer.first().startDato
        resp.first().undertemaer.first().sluttDato shouldBe endretPlan.temaer.first().undertemaer.first().sluttDato
    }

    @Test
    fun `kan sette alle undertemaer til planlagt`() {
        val sak = nySakIKartlegges()
        val planDto = PlanHelper.opprettEnPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer)

        val endretPlan = planDto.copy(
            temaer = planDto.temaer.map { temaDto ->
                temaDto.copy(
                    undertemaer = temaDto.undertemaer.map { undertemaDto ->
                        undertemaDto.copy(
                            planlagt = true,
                        )
                    },
                )
            },
        )

        val resp =
            PlanHelper.endreTema(
                orgnr = sak.orgnr,
                saksnummer = sak.saksnummer,
                temaId = endretPlan.temaer.first().id,
                endring = endretPlan.tilRequest().first().undertemaer,
            )

        resp.id shouldBe endretPlan.temaer.first().id
        resp.navn shouldBe endretPlan.temaer.first().navn
        resp.undertemaer.first().id shouldBe endretPlan.temaer.first().undertemaer.first().id
        resp.undertemaer.first().planlagt shouldBe endretPlan.temaer.first().undertemaer.first().planlagt
        resp.undertemaer.first().navn shouldBe endretPlan.temaer.first().undertemaer.first().navn
        resp.undertemaer.first().målsetning shouldBe endretPlan.temaer.first().undertemaer.first().målsetning
        resp.undertemaer.first().status shouldBe PlanUndertema.Status.PLANLAGT
    }

    @Test
    fun `kan legge til nytt tema i plan uten uventet bieffekter`() {
        val sak = nySakIKartlegges()

        val planMal: PlanMalDto = PlanHelper.hentPlanMal()

        val startDato = LocalDate(2010, 1, 1)
        val sluttDato = LocalDate(2025, 2, 2)

        val planMedEttTema = planMal.copy(
            tema = planMal.tema.map { tema ->
                if (tema.rekkefølge == 2) {
                    tema.copy(
                        planlagt = true,
                        innhold = tema.innhold.map { innhold ->
                            innhold.copy(
                                planlagt = true,
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

        val opprettetPlan = PlanHelper.opprettEnPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer, redigertPlan = planMedEttTema)

        opprettetPlan.temaer[0].planlagt shouldBe false
        opprettetPlan.temaer[0].undertemaer.forEach { it.planlagt shouldBe false }
        opprettetPlan.temaer[0].undertemaer.forEach { it.status shouldBe null }
        opprettetPlan.temaer[0].undertemaer.forEach { it.startDato shouldBe null }
        opprettetPlan.temaer[0].undertemaer.forEach { it.sluttDato shouldBe null }

        opprettetPlan.temaer[1].planlagt shouldBe true
        opprettetPlan.temaer[1].undertemaer.forEach { it.planlagt shouldBe true }
        opprettetPlan.temaer[1].undertemaer.forEach { it.status shouldBe PlanUndertema.Status.PLANLAGT }
        opprettetPlan.temaer[1].undertemaer.forEach { it.startDato shouldBe startDato }
        opprettetPlan.temaer[1].undertemaer.forEach { it.sluttDato shouldBe sluttDato }

        opprettetPlan.temaer[2].planlagt shouldBe false
        opprettetPlan.temaer[2].undertemaer.forEach { it.planlagt shouldBe false }
        opprettetPlan.temaer[2].undertemaer.forEach { it.status shouldBe null }
        opprettetPlan.temaer[2].undertemaer.forEach { it.startDato shouldBe null }
        opprettetPlan.temaer[2].undertemaer.forEach { it.sluttDato shouldBe null }

        val nyStatus = PlanUndertema.Status.PÅGÅR

        PlanHelper.endreStatus(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            temaId = opprettetPlan.temaer[1].id,
            undertemaId = opprettetPlan.temaer[1].undertemaer.first().id,
            status = nyStatus,
        )

        val planMedNyStatus = PlanHelper.hentPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer)

        planMedNyStatus.temaer[0].planlagt shouldBe false
        planMedNyStatus.temaer[0].undertemaer.forEach { it.planlagt shouldBe false }
        planMedNyStatus.temaer[0].undertemaer.forEach { it.status shouldBe null }
        planMedNyStatus.temaer[0].undertemaer.forEach { it.startDato shouldBe null }
        planMedNyStatus.temaer[0].undertemaer.forEach { it.sluttDato shouldBe null }

        planMedNyStatus.temaer[1].planlagt shouldBe true
        planMedNyStatus.temaer[1].undertemaer.forEach { it.planlagt shouldBe true }
        planMedNyStatus.temaer[1].undertemaer.forExactlyOne { it.status shouldBe nyStatus }
        planMedNyStatus.temaer[1].undertemaer.forEach { it.startDato shouldBe startDato }
        planMedNyStatus.temaer[1].undertemaer.forEach { it.sluttDato shouldBe sluttDato }

        planMedNyStatus.temaer[2].planlagt shouldBe false
        planMedNyStatus.temaer[2].undertemaer.forEach { it.planlagt shouldBe false }
        planMedNyStatus.temaer[2].undertemaer.forEach { it.status shouldBe null }
        planMedNyStatus.temaer[2].undertemaer.forEach { it.startDato shouldBe null }
        planMedNyStatus.temaer[2].undertemaer.forEach { it.sluttDato shouldBe null }

        val endretPlan = planMedNyStatus.copy(
            temaer = listOf(
                planMedNyStatus.temaer[0].copy(
                    planlagt = true,
                    undertemaer = planMedNyStatus.temaer[0].undertemaer.map { undertema ->
                        undertema.copy(
                            planlagt = true,
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
            endring = endretPlan.tilRequest(),
        )

        val planMedNyttTema = PlanHelper.hentPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer)

        planMedNyttTema.temaer[0].planlagt shouldBe true
        planMedNyttTema.temaer[0].undertemaer.forEach { it.planlagt shouldBe true }
        planMedNyttTema.temaer[0].undertemaer.forEach { it.status shouldBe PlanUndertema.Status.PLANLAGT }
        planMedNyttTema.temaer[0].undertemaer.forEach { it.startDato shouldBe startDato }
        planMedNyttTema.temaer[0].undertemaer.forEach { it.sluttDato shouldBe sluttDato }

        planMedNyttTema.temaer[1].planlagt shouldBe true
        planMedNyttTema.temaer[1].undertemaer.forEach { it.planlagt shouldBe true }
        planMedNyttTema.temaer[1].undertemaer.forExactlyOne { it.status shouldBe nyStatus }
        planMedNyttTema.temaer[1].undertemaer.forEach { it.startDato shouldBe startDato }
        planMedNyttTema.temaer[1].undertemaer.forEach { it.sluttDato shouldBe sluttDato }

        planMedNyttTema.temaer[2].planlagt shouldBe false
        planMedNyttTema.temaer[2].undertemaer.forEach { it.planlagt shouldBe false }
        planMedNyttTema.temaer[2].undertemaer.forEach { it.status shouldBe null }
        planMedNyttTema.temaer[2].undertemaer.forEach { it.startDato shouldBe null }
        planMedNyttTema.temaer[2].undertemaer.forEach { it.sluttDato shouldBe null }
    }

    @Test
    fun `kan ikke opprette plan med periode som er negativ - start dato etter slutt dato`() {
        val sak = nySakIKartlegges()
        val planMal: PlanMalDto = PlanHelper.hentPlanMal()

        val startDato = LocalDate(2025, 1, 1)
        val sluttDato = LocalDate(2010, 2, 2)

        val planMedEttTema = planMal.copy(
            tema = planMal.tema.map { tema ->
                if (tema.rekkefølge == 2) {
                    tema.copy(
                        planlagt = true,
                        innhold = tema.innhold.map { innhold ->
                            innhold.copy(
                                planlagt = true,
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
            PlanHelper.opprettEnPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer, redigertPlan = planMedEttTema)
        }

        lydiaApiContainer shouldContainLog "Plan er ikke gyldig".toRegex()
    }

    @Test
    fun `kan ikke endre plan med periode som er negativ - start dato etter slutt dato`() {
        val sak = nySakIKartlegges()
        val planMal: PlanMalDto = PlanHelper.hentPlanMal()

        val startDato = LocalDate(2010, 1, 1)
        val sluttDato = LocalDate(2025, 2, 2)

        val planMedEttTema = planMal.copy(
            tema = planMal.tema.map { tema ->
                if (tema.rekkefølge == 2) {
                    tema.copy(
                        planlagt = true,
                        innhold = tema.innhold.map { innhold ->
                            innhold.copy(
                                planlagt = true,
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

        val opprettetPlan = PlanHelper.opprettEnPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer, redigertPlan = planMedEttTema)

        opprettetPlan.temaer[0].planlagt shouldBe false
        opprettetPlan.temaer[0].undertemaer.forEach { it.planlagt shouldBe false }
        opprettetPlan.temaer[0].undertemaer.forEach { it.status shouldBe null }
        opprettetPlan.temaer[0].undertemaer.forEach { it.startDato shouldBe null }
        opprettetPlan.temaer[0].undertemaer.forEach { it.sluttDato shouldBe null }

        opprettetPlan.temaer[1].planlagt shouldBe true
        opprettetPlan.temaer[1].undertemaer.forEach { it.planlagt shouldBe true }
        opprettetPlan.temaer[1].undertemaer.forEach { it.status shouldBe PlanUndertema.Status.PLANLAGT }
        opprettetPlan.temaer[1].undertemaer.forEach { it.startDato shouldBe startDato }
        opprettetPlan.temaer[1].undertemaer.forEach { it.sluttDato shouldBe sluttDato }

        opprettetPlan.temaer[2].planlagt shouldBe false
        opprettetPlan.temaer[2].undertemaer.forEach { it.planlagt shouldBe false }
        opprettetPlan.temaer[2].undertemaer.forEach { it.status shouldBe null }
        opprettetPlan.temaer[2].undertemaer.forEach { it.startDato shouldBe null }
        opprettetPlan.temaer[2].undertemaer.forEach { it.sluttDato shouldBe null }

        val endretPlan = opprettetPlan.copy(
            temaer = listOf(
                opprettetPlan.temaer[0].copy(
                    planlagt = true,
                    undertemaer = opprettetPlan.temaer[0].undertemaer.map { undertema ->
                        undertema.copy(
                            planlagt = true,
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
                endring = endretPlan.tilRequest(),
            )
        }
        lydiaApiContainer shouldContainLog "Plan er ikke gyldig".toRegex()

        val lagretPlan = PlanHelper.hentPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
        // TODO: her burde det vel gå ann å sjekke på sistEndret
        lagretPlan.temaer[1].planlagt shouldBe true
        lagretPlan.temaer[1].undertemaer.forEach { it.planlagt shouldBe true }
        lagretPlan.temaer[1].undertemaer.forEach { it.status shouldBe PlanUndertema.Status.PLANLAGT }
        lagretPlan.temaer[1].undertemaer.forEach { it.startDato shouldBe startDato }
        lagretPlan.temaer[1].undertemaer.forEach { it.sluttDato shouldBe sluttDato }

    }

    @Test
    fun `kan ikke endre tema med periode som er negativ - start dato etter slutt dato`() {
        val sak = nySakIKartlegges()
        val planMal: PlanMalDto = PlanHelper.hentPlanMal()

        val startDato = LocalDate(2010, 1, 1)
        val sluttDato = LocalDate(2025, 2, 2)

        val planMedEttTema = planMal.copy(
            tema = planMal.tema.map { tema ->
                if (tema.rekkefølge == 2) {
                    tema.copy(
                        planlagt = true,
                        innhold = tema.innhold.map { innhold ->
                            innhold.copy(
                                planlagt = true,
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

        val opprettetPlan = PlanHelper.opprettEnPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer, redigertPlan = planMedEttTema)

        opprettetPlan.temaer[0].planlagt shouldBe false
        opprettetPlan.temaer[0].undertemaer.forEach { it.planlagt shouldBe false }
        opprettetPlan.temaer[0].undertemaer.forEach { it.status shouldBe null }
        opprettetPlan.temaer[0].undertemaer.forEach { it.startDato shouldBe null }
        opprettetPlan.temaer[0].undertemaer.forEach { it.sluttDato shouldBe null }

        opprettetPlan.temaer[1].planlagt shouldBe true
        opprettetPlan.temaer[1].undertemaer.forEach { it.planlagt shouldBe true }
        opprettetPlan.temaer[1].undertemaer.forEach { it.status shouldBe PlanUndertema.Status.PLANLAGT }
        opprettetPlan.temaer[1].undertemaer.forEach { it.startDato shouldBe startDato }
        opprettetPlan.temaer[1].undertemaer.forEach { it.sluttDato shouldBe sluttDato }

        opprettetPlan.temaer[2].planlagt shouldBe false
        opprettetPlan.temaer[2].undertemaer.forEach { it.planlagt shouldBe false }
        opprettetPlan.temaer[2].undertemaer.forEach { it.status shouldBe null }
        opprettetPlan.temaer[2].undertemaer.forEach { it.startDato shouldBe null }
        opprettetPlan.temaer[2].undertemaer.forEach { it.sluttDato shouldBe null }

        val endretPlan = opprettetPlan.copy(
            temaer = listOf(
                opprettetPlan.temaer[0].copy(
                    planlagt = true,
                    undertemaer = opprettetPlan.temaer[0].undertemaer.map { undertema ->
                        undertema.copy(
                            planlagt = true,
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
                temaId = endretPlan.temaer.first().id,
                endring = endretPlan.tilRequest().first().undertemaer,
            )
        }

        lydiaApiContainer shouldContainLog "Plan er ikke gyldig".toRegex()

        val lagretPlan = PlanHelper.hentPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
        // -- TODO: Her burde det gå ann å sjekke på sistEndret
        lagretPlan.temaer[1].planlagt shouldBe true
        lagretPlan.temaer[1].undertemaer.forEach { it.planlagt shouldBe true }
        lagretPlan.temaer[1].undertemaer.forEach { it.status shouldBe PlanUndertema.Status.PLANLAGT }
        lagretPlan.temaer[1].undertemaer.forEach { it.startDato shouldBe startDato }
        lagretPlan.temaer[1].undertemaer.forEach { it.sluttDato shouldBe sluttDato }
    }

    @Test
    fun `skal få feil når man henter plan uten å ha opprettet en plan`() {
        val sak = nySakIKartlegges()
        shouldFail {
            PlanHelper.hentPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
        }

        shouldFail {
            PlanHelper.hentPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
        }
    }

    @Test
    fun `skal kunne hente plan uten å være eier som lesebruker`() {
        val sak = nySakIKartlegges()

        val opprettetPlan = PlanHelper.opprettEnPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
        val hentetPlan = PlanHelper.hentPlan(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
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
        val sak = nySakIKartlegges()
            .opprettNyProsses()
        val prosessId = sak.hentIAProsesser().first().id
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
            .opprettNyProsses()
            .opprettNyProsses()
        val prosesser = sak.hentIAProsesser()
        prosesser shouldHaveSize 2

        prosesser.forEach { prosess ->
            val opprettetPlan = PlanHelper.opprettEnPlan(
                orgnr = sak.orgnr,
                saksnummer = sak.saksnummer,
                prosessId = prosess.id,
            )

            val hentetPlan = PlanHelper.hentPlan(
                orgnr = sak.orgnr,
                saksnummer = sak.saksnummer,
                prosessId = prosess.id
            )
            opprettetPlan.id shouldBe hentetPlan.id
        }
    }

    @Test
    fun `skal kunne endre status på et undertema i en plan knyttet til en prosess`() {
        val sak = nySakIKartlegges()
            .opprettNyProsses()
            .opprettNyProsses()
        val prosesser = sak.hentIAProsesser()
        prosesser shouldHaveSize 2

        prosesser.forEach { prosess ->
            val planDto = PlanHelper.opprettEnPlan(
                orgnr = sak.orgnr,
                saksnummer = sak.saksnummer,
                prosessId = prosess.id,
            )
            val førsteTema = planDto.temaer.first()
            val førsteUndertema = førsteTema.undertemaer.first()

            val nyStatus = PlanUndertema.Status.FULLFØRT

            val resp =
                PlanHelper.endreStatus(
                    orgnr = sak.orgnr,
                    saksnummer = sak.saksnummer,
                    prosessId = prosess.id,
                    temaId = førsteTema.id,
                    undertemaId = førsteUndertema.id,
                    status = nyStatus,
                )

            resp.status shouldBe nyStatus
            val hentetPlan = PlanHelper.hentPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer, prosessId = prosess.id)
            hentetPlan.temaer
                .first { it.id == førsteTema.id }.undertemaer
                .first { it.id == førsteUndertema.id }.status shouldBe nyStatus
        }
    }

    @Test
    fun `kan sette alle undertemaer til planlagt i en plan knyttet til en prosess`() {
        val sak = nySakIKartlegges()
            .opprettNyProsses()
            .opprettNyProsses()
        val prosesser = sak.hentIAProsesser()
        prosesser shouldHaveSize 2

        prosesser.forEach { prosess ->
            val planDto = PlanHelper.opprettEnPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer, prosessId = prosess.id)
            val tema = planDto.temaer.first()
            val endreTemaRequest = tema.undertemaer.map { undertemaDto ->
                EndreUndertemaRequest(
                    id = undertemaDto.id,
                    planlagt = true,
                    startDato = undertemaDto.startDato,
                    sluttDato = undertemaDto.sluttDato
                )
            }

            PlanHelper.endreTema(
                orgnr = sak.orgnr,
                saksnummer = sak.saksnummer,
                prosessId = prosess.id,
                temaId = tema.id,
                endring = endreTemaRequest,
            )
            PlanHelper.hentPlan(sak.orgnr, sak.saksnummer, prosess.id)
                .temaer.first { it.id == tema.id }.undertemaer
                .forAll {
                    it.planlagt shouldBe true
                    it.status shouldBe PlanUndertema.Status.PLANLAGT
                }
        }
    }

    @Test
    fun `skal kunne endre en plan knyttet til en prosess`() {
        val sak = nySakIKartlegges()
            .opprettNyProsses()
            .opprettNyProsses()
        val prosesser = sak.hentIAProsesser()
        prosesser shouldHaveSize 2

        prosesser.forEach { prosess ->
            val opprettetPlan = PlanHelper.opprettEnPlan(sak.orgnr, sak.saksnummer, prosess.id)
            val endretPlan = opprettetPlan.copy(
                temaer = opprettetPlan.temaer.map {
                    it.copy(
                        planlagt = true,
                        undertemaer = it.undertemaer.map {
                            it.copy(
                                planlagt = true,
                                status = PlanUndertema.Status.PLANLAGT
                            )
                        }
                    )
                }
            )
            PlanHelper.endrePlan(sak.orgnr, sak.saksnummer, prosess.id, endretPlan.tilRequest())
            val hentetPlan = PlanHelper.hentPlan(sak.orgnr, sak.saksnummer, prosess.id)
            hentetPlan.id shouldBe opprettetPlan.id
            hentetPlan.temaer.forAll { tema ->
                tema.planlagt shouldBe true
                tema.undertemaer.forAll { undertema ->
                    undertema.planlagt shouldBe true
                    undertema.status shouldBe PlanUndertema.Status.PLANLAGT
                }
            }
        }
    }

    @Test
    fun `skal oppdatere plan sin sist_endret ved endringer av plan`() {
        val sak = nySakIKartlegges()
            .opprettNyProsses()
        val prosessId = sak.hentIAProsesser().first().id
        val opprettetPlan = PlanHelper.opprettEnPlan(sak.orgnr, sak.saksnummer, prosessId)
        val førsteTema = opprettetPlan.temaer.first()
        val førsteUndertema = førsteTema.undertemaer.first()
        PlanHelper.endreStatus(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = prosessId,
            status = PlanUndertema.Status.PÅGÅR,
            temaId = førsteTema.id,
            undertemaId = førsteUndertema.id
        )
        val endretPlan = PlanHelper.hentPlan(sak.orgnr, sak.saksnummer, prosessId)
        endretPlan.sistEndret shouldBeGreaterThan opprettetPlan.sistEndret
    }
}
