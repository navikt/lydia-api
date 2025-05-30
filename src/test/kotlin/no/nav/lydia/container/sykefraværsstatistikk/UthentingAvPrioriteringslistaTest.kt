package no.nav.lydia.container.sykefraværsstatistikk

import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.SakHelper.Companion.fullførSak
import no.nav.lydia.helper.SakHelper.Companion.nySakIKontaktes
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.StatistikkHelper.Companion.hentSykefravær
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import kotlin.test.Test

class UthentingAvPrioriteringslistaTest {
    @Test
    fun `Status som vises i prioriteringslista, er status på saken som ble opprettet sist i virksomhet`() {
        val fullførtSak = nySakIViBistår().fullførSak()
        nySakIKontaktes(orgnummer = fullførtSak.orgnr)
        // Oppdater 'endret' dato for å simulere 'maskinelt oppdatering' på en eldre sak
        TestContainerHelper.postgresContainerHelper.performUpdate(
            "update ia_sak set endret = now() " +
                "where orgnr = '${fullførtSak.orgnr}' " +
                "and saksnummer = '${fullførtSak.saksnummer}'",
        )
        // Hent prioriteringslista
        val virksomheter = hentSykefravær()

        virksomheter.data.first { it.orgnr == fullførtSak.orgnr }
            .also { virksomhet ->
                virksomhet.status shouldBe IAProsessStatus.KONTAKTES
            }
    }
}
