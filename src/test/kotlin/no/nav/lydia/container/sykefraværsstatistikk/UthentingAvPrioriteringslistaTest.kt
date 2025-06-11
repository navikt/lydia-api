package no.nav.lydia.container.sykefraværsstatistikk

import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.SakHelper.Companion.fullførSak
import no.nav.lydia.helper.SakHelper.Companion.hentSamarbeidshistorikk
import no.nav.lydia.helper.SakHelper.Companion.nySakIKontaktes
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.StatistikkHelper.Companion.hentSykefravær
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestVirksomhet.Companion.beliggenhet
import no.nav.lydia.helper.TestVirksomhet.Companion.nyVirksomhet
import no.nav.lydia.helper.VirksomhetHelper.Companion.lastInnNyVirksomhet
import no.nav.lydia.ia.sak.domene.IASakStatus
import no.nav.lydia.sykefraværsstatistikk.api.geografi.Kommune
import kotlin.test.Test

class UthentingAvPrioriteringslistaTest {
    @Test
    fun `Status som vises i prioriteringslista, er status på saken som ble opprettet sist i virksomhet`() {
        val testKommune = Kommune(navn = "Den skal være unik", nummer = "1331")
        val virksomhet =
            lastInnNyVirksomhet(nyVirksomhet = nyVirksomhet(beliggenhet = beliggenhet(kommune = testKommune)))

        val fullførtSak = nySakIViBistår(orgnummer = virksomhet.orgnr).fullførSak()
        virksomhet.orgnr shouldBe fullførtSak.orgnr
        nySakIKontaktes(orgnummer = fullførtSak.orgnr)
        // Oppdater 'endret' dato for å simulere 'maskinelt oppdatering' på en eldre sak
        TestContainerHelper.postgresContainerHelper.performUpdate(
            "update ia_sak set endret = now() " +
                "where orgnr = '${fullførtSak.orgnr}' " +
                "and saksnummer = '${fullførtSak.saksnummer}'",
        )
        val historikk = hentSamarbeidshistorikk(fullførtSak.orgnr)
        historikk.size shouldBe 2
        // Hent prioriteringslista
        val virksomheter = hentSykefravær(kommuner = testKommune.nummer)

        virksomheter.data.first { it.orgnr == fullførtSak.orgnr }
            .also { virksomhet ->
                virksomhet.status shouldBe IASakStatus.KONTAKTES
            }
    }

    @Test
    fun `skal kunne hente saksnummer for virksomheter i prioriteringslista`() {
        val testKommune = Kommune(navn = "Den skal også være unik", nummer = "1110")
        val virksomhet = lastInnNyVirksomhet(
            nyVirksomhet = nyVirksomhet(beliggenhet = beliggenhet(kommune = testKommune)),
        )

        val virksomheter = hentSykefravær(kommuner = testKommune.nummer)
        virksomheter.data.first { it.orgnr == virksomhet.orgnr }
            .also { virksomhet ->
                virksomhet.saksnummer shouldBe null
            }

        val sak = nySakIViBistår(orgnummer = virksomhet.orgnr)

        val oppdaterteVirksomheter = hentSykefravær(kommuner = testKommune.nummer)
        oppdaterteVirksomheter.data.first { it.orgnr == virksomhet.orgnr }.also { virksomhet ->
            virksomhet.saksnummer shouldBe sak.saksnummer
            virksomhet.status shouldBe IASakStatus.VI_BISTÅR
        }
    }
}
