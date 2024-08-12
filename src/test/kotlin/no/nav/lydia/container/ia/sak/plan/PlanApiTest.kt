package no.nav.lydia.container.ia.sak.plan

import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettKartlegging
import no.nav.lydia.helper.PlanHelper
import no.nav.lydia.helper.PlanHelper.Companion.tilRequest
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartlegges
import no.nav.lydia.helper.hentIAProsesser
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.sak.api.plan.PlanDto
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema
import kotlin.test.Test

class PlanApiTest {
    @Test
    fun `oppretter en ny plan`() {
        val sak = nySakIKartlegges()
        sak.opprettKartlegging()
        val prosesser = sak.hentIAProsesser()
        prosesser shouldHaveSize 1

        val resp =
            PlanHelper.opprettPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
                .tilSingelRespons<PlanDto>()

        resp.third.get().temaer.size shouldBe 4

        // TODO: Sjekk i database at det ble lagret rett
//        postgresContainer
//            .hentEnkelKolonne<String>(
//                "select kartlegging_id from ia_sak_kartlegging where kartlegging_id = '${resp.third.get().kartleggingId}'",
//            ) shouldNotBe null
    }

    @Test
    fun `kan endre tema`() {
        val sak = nySakIKartlegges()
        sak.opprettKartlegging()
        val prosesser = sak.hentIAProsesser()
        prosesser shouldHaveSize 1
        val opprettetPlan = PlanHelper.opprettPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
            .tilSingelRespons<PlanDto>()
        opprettetPlan.third.get().temaer.size shouldBe 4

        val lagretPlan = PlanHelper.hentPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer)

        val endretPlan = lagretPlan.copy(
            temaer = lagretPlan.temaer.map { temaDto ->
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
        resp.undertemaer.first().beskrivelse shouldBe endretPlan.temaer.first().undertemaer.first().beskrivelse
        resp.undertemaer.first().målsetning shouldBe endretPlan.temaer.first().undertemaer.first().målsetning
        resp.undertemaer.first().status shouldBe PlanUndertema.Status.PLANLAGT
    }

    @Test
    fun `kan endre status på undertema`() {
        val sak = nySakIKartlegges()
        sak.opprettKartlegging()
        val prosesser = sak.hentIAProsesser()
        prosesser shouldHaveSize 1
        val opprettetPlan = PlanHelper.opprettPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
            .tilSingelRespons<PlanDto>()
        opprettetPlan.third.get().temaer.size shouldBe 4
        val plan = PlanHelper.hentPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
        val førsteTema = plan.temaer.first()

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
    fun `kan endre flere tema`() {
        val sak = nySakIKartlegges()
        sak.opprettKartlegging()
        val prosesser = sak.hentIAProsesser()
        prosesser shouldHaveSize 1
        val opprettetPlan = PlanHelper.opprettPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
            .tilSingelRespons<PlanDto>()
        opprettetPlan.third.get().temaer.size shouldBe 4

        val lagretPlan = PlanHelper.hentPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer)

        val endretPlan = lagretPlan.copy(
            temaer = lagretPlan.temaer.map { temaDto ->
                temaDto.copy(
                    planlagt = true,
                    undertemaer = temaDto.undertemaer.map { undertemaDto ->
                        undertemaDto.copy(
                            planlagt = true,
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
        resp.first().undertemaer.first().beskrivelse shouldBe endretPlan.temaer.first().undertemaer.first().beskrivelse
        resp.first().undertemaer.first().målsetning shouldBe endretPlan.temaer.first().undertemaer.first().målsetning
        resp.first().undertemaer.first().status shouldBe PlanUndertema.Status.PLANLAGT
    }
}
