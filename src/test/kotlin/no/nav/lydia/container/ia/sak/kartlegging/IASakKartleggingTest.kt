package no.nav.lydia.container.ia.sak.kartlegging

import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.IASakKartleggingHelper
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartlegges
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.sak.api.IASakKartleggingDto
import kotlin.test.Test

class IASakKartleggingTest {

    @Test
    fun `oppretter en ny kartlegging`() {
        val sak = nySakIKartlegges()

        val resp = IASakKartleggingHelper.opprettIASakKartlegging(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
            .tilSingelRespons<IASakKartleggingDto>()

        resp.third.get().kartleggingId.length shouldBe 36
    }
}
