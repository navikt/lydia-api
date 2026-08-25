package no.nav.lydia.container.ny.flyt

import io.kotest.inspectors.shouldForAll
import io.kotest.matchers.comparables.shouldBeLessThanOrEqualTo
import io.kotest.matchers.ints.shouldBeAtLeast
import io.kotest.matchers.shouldBe
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.aktivSamarbeidsperiode
import no.nav.lydia.helper.SakHelper.Companion.hentHistorikkForSamarbeidsperiode
import no.nav.lydia.helper.SakHelper.Companion.hentHistorikkForSamarbeidsperiodeRespons
import no.nav.lydia.helper.statuskode
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test

class HistorikkTest {
    companion object {
        @BeforeClass
        @JvmStatic
        fun setUp() {
            NyFlytTestUtils.setUpKonsumenter()
        }

        @AfterClass
        @JvmStatic
        fun tearDown() {
            NyFlytTestUtils.tearDownKonsumenter()
        }
    }

    @Test
    fun `hent historikk for samarbeidsperiode krever autentisering`() {
        val sak = aktivSamarbeidsperiode()

        val respons = hentHistorikkForSamarbeidsperiodeRespons(
            orgnummer = sak.orgnr,
            saksnummer = sak.saksnummer,
            token = "ugyldig-token",
        )

        respons.statuskode() shouldBe 401
    }

    @Test
    fun `hent historikk for samarbeidsperiode returnerer hendelser sortert på tidspunkt`() {
        val sak = aktivSamarbeidsperiode()

        val historikk = hentHistorikkForSamarbeidsperiode(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        historikk.historikkHendelser.size shouldBeAtLeast 1

        historikk.historikkHendelser.zipWithNext().shouldForAll { (a, b) ->
            a.tidspunkt shouldBeLessThanOrEqualTo b.tidspunkt
        }
    }
}
