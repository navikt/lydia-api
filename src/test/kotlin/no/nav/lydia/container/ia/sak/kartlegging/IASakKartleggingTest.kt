package no.nav.lydia.container.ia.sak.kartlegging

import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import kotlin.test.Test
import no.nav.lydia.helper.IASakKartleggingHelper
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartlegges
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.sak.api.IASakKartleggingDto

class IASakKartleggingTest {

    @Test
    fun `oppretter en ny kartlegging`() {
        val sak = nySakIKartlegges()

        val resp = IASakKartleggingHelper.opprettIASakKartlegging(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
            .tilSingelRespons<IASakKartleggingDto>()

        resp.third.get().kartleggingId.length shouldBe 36

        postgresContainer
            .hentEnkelKolonne<String>(
                "select kartlegging_id from ia_sak_kartlegging where kartlegging_id = '${resp.third.get().kartleggingId}'"
            ) shouldNotBe null
    }

}
