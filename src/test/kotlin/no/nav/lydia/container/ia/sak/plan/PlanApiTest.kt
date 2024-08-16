package no.nav.lydia.container.ia.sak.plan

import io.kotest.assertions.shouldFail
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.equals.shouldBeEqual
import io.kotest.matchers.shouldBe
import kotlinx.datetime.toKotlinLocalDateTime
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettKartlegging
import no.nav.lydia.helper.PlanHelper
import no.nav.lydia.helper.PlanHelper.Companion.tilRequest
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartlegges
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.hentIAProsesser
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema
import java.time.LocalDateTime.now
import kotlin.test.Test

class PlanApiTest {
    @Test
    fun `oppretter en ny plan`() {
        val sak = nySakIKartlegges()
        sak.opprettKartlegging()
        val prosesser = sak.hentIAProsesser()
        prosesser shouldHaveSize 1

        val planDto =
            PlanHelper.opprettPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
        planDto.temaer.size shouldBe 3
    }

    @Test
    fun `kan endre status på undertema`() {
        val sak = nySakIKartlegges()
        sak.opprettKartlegging()
        val prosesser = sak.hentIAProsesser()
        prosesser shouldHaveSize 1
        val planDto = PlanHelper.opprettPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
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
        sak.opprettKartlegging()
        val prosesser = sak.hentIAProsesser()
        prosesser shouldHaveSize 1
        val planDto = PlanHelper.opprettPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer)

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
        sak.opprettKartlegging()
        val prosesser = sak.hentIAProsesser()
        prosesser shouldHaveSize 1
        val planDto = PlanHelper.opprettPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer)

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
    fun `skal få feil når man henter plan uten å ha opprettet en plan`() {
        val sak = nySakIKartlegges()
        shouldFail {
            PlanHelper.hentPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
        }

        // lag prosess (dette bør bort på sikt)
        sak.opprettKartlegging()

        shouldFail {
            PlanHelper.hentPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
        }
    }

    @Test
    fun `skal kunne hente plan uten å være eier som lesebruker`() {
        val sak = nySakIKartlegges()

        // lag prosess (dette bør bort på sikt)
        sak.opprettKartlegging()

        val opprettetPlan = PlanHelper.opprettPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
        val hentetPlan = PlanHelper.hentPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer, token = TestContainerHelper.oauth2ServerContainer.lesebruker.token)

        opprettetPlan shouldBeEqual hentetPlan
    }
}
