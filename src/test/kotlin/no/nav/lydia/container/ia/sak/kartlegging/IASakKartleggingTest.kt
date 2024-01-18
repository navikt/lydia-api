package no.nav.lydia.container.ia.sak.kartlegging

import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.kotest.matchers.string.shouldMatch
import io.ktor.http.HttpStatusCode
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

    @Test
    fun `skal få feil når saksnummer er ukjent`() {
        val resp = IASakKartleggingHelper.opprettIASakKartlegging(orgnr = "123456789", saksnummer = "ukjent")
            .tilSingelRespons<IASakKartleggingDto>()

        resp.second.statusCode shouldBe HttpStatusCode.BadRequest.value
        resp.second.body().asString("text/plain") shouldMatch "Ugyldig saksnummer"
    }

    @Test
    fun `skal få feil når orgnummer er feil`() {
        val sak = nySakIKartlegges()
        val resp = IASakKartleggingHelper.opprettIASakKartlegging(orgnr = "222233334", saksnummer = sak.saksnummer)
            .tilSingelRespons<IASakKartleggingDto>()

        resp.second.statusCode shouldBe HttpStatusCode.BadRequest.value
        resp.second.body().asString("text/plain") shouldMatch "Ugyldig orgnummer"
    }

}
