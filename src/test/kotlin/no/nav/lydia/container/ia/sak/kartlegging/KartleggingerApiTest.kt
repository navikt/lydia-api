package no.nav.lydia.container.ia.sak.kartlegging

import io.kotest.matchers.collections.shouldContainExactlyInAnyOrder
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.hentKartleggingresultatPdf
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.opprettBehovsvurdering
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.opprettEvaluering
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.opprettSvarOgAvsluttSpørreundersøkelse
import no.nav.lydia.helper.PlanHelper.Companion.hentPlanMal
import no.nav.lydia.helper.PlanHelper.Companion.inkluderAlt
import no.nav.lydia.helper.PlanHelper.Companion.opprettEnPlan
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.integrasjoner.pdfgen.lokalTestPdf
import kotlin.test.Test

class KartleggingerApiTest {
    @Test
    fun `skal få alle kartlegginger når man henter kartleggingger uten type`() {
        val sak = SakHelper.nySakIViBistår()
        val behovsvurdering = sak.opprettBehovsvurdering()
        sak.opprettEnPlan(plan = hentPlanMal().inkluderAlt())
        val evaluering = sak.opprettEvaluering()
        IASakSpørreundersøkelseHelper.hentSpørreundersøkelser(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
        ).map { it.id } shouldContainExactlyInAnyOrder listOf(behovsvurdering.id, evaluering.id)
    }

    @Test
    fun `skal kunne laste ned en pdf av kartleggingresultater`() {
        val sak = SakHelper.nySakIViBistår()
        val behovsvurdering = sak.opprettSvarOgAvsluttSpørreundersøkelse(type = Spørreundersøkelse.Type.Behovsvurdering)
        behovsvurdering.hentKartleggingresultatPdf(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
        ) shouldBe lokalTestPdf
    }
}
