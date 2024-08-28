package no.nav.lydia.container.ia.sak.plan

import io.kotest.assertions.shouldFail
import io.kotest.matchers.equals.shouldBeEqual
import io.kotest.matchers.shouldBe
import kotlinx.datetime.LocalDate
import kotlinx.datetime.toKotlinLocalDateTime
import no.nav.lydia.helper.PlanHelper
import no.nav.lydia.helper.PlanHelper.Companion.tilRequest
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartlegges
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.ia.sak.domene.plan.InnholdMalDto
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema
import no.nav.lydia.ia.sak.domene.plan.TemaMalDto
import java.time.LocalDateTime.now
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
                            startDato = now().toKotlinLocalDateTime().date,
                            sluttDato = now().toKotlinLocalDateTime().date,
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
                            startDato = now().toKotlinLocalDateTime().date,
                            sluttDato = now().toKotlinLocalDateTime().date,
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

        opprettetPlan shouldBeEqual hentetPlan
    }

    @Test
    fun `skal kunne hente plan-mal som eier`() {
        val planMal = PlanHelper.hentPlanMal()

        planMal.tema.size shouldBe 3
        planMal.tema.first().navn shouldBe "Partssamarbeid"
    }
}
