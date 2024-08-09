package no.nav.lydia.container.ia.sak.plan

import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.PlanHelper
import no.nav.lydia.helper.PlanHelper.Companion.tilRequest
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartlegges
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.sak.api.plan.PlanDto
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema
import kotlin.test.Test

class PlanApiTest {
    @Test
    fun `oppretter en ny plan`() {
        val sak = nySakIKartlegges()

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

        val plan = PlanHelper.hentPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer)

        val resp =
            PlanHelper.endreTema(
                orgnr = sak.orgnr,
                saksnummer = sak.saksnummer,
                temaId = plan.temaer.first().id,
                endring = plan.tilRequest().first().undertemaer,
            )

        resp.undertemaer.size shouldBe 4

        // TODO: Sjekk i database at det ble lagret rett
//        postgresContainer
//            .hentEnkelKolonne<String>(
//                "select kartlegging_id from ia_sak_kartlegging where kartlegging_id = '${resp.third.get().kartleggingId}'",
//            ) shouldNotBe null
    }

    @Test
    fun `kan endre status på undertema`() {
        val sak = nySakIKartlegges()

        val førsteTema = PlanHelper.hentPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer).temaer.first()
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

        // TODO: Sjekk i database at det ble lagret rett
//        postgresContainer
//            .hentEnkelKolonne<String>(
//                "select kartlegging_id from ia_sak_kartlegging where kartlegging_id = '${resp.third.get().kartleggingId}'",
//            ) shouldNotBe null
    }

    @Test
    fun `kan endre flere tema`() {
        val sak = nySakIKartlegges()

        val plan = PlanHelper.hentPlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer)

        val resp = PlanHelper.endrePlan(orgnr = sak.orgnr, saksnummer = sak.saksnummer, endring = plan.tilRequest())

        resp.size shouldBe 3

        // TODO: Sjekk i database at det ble lagret rett
//        postgresContainer
//            .hentEnkelKolonne<String>(
//                "select kartlegging_id from ia_sak_kartlegging where kartlegging_id = '${resp.third.get().kartleggingId}'",
//            ) shouldNotBe null
    }
}
