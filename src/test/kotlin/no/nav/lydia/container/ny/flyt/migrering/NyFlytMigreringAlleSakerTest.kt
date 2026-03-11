package no.nav.lydia.container.ny.flyt.migrering

import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.migreringSakIKartlegges
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.mirgeringSakIViBistår
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.sendMigreringsmeldingOgVerifiserLogg
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.utilsSetUp
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.utilsTearDown
import no.nav.lydia.helper.SakHelper.Companion.fullførSak
import no.nav.lydia.helper.TestVirksomhet.Companion.KOMMUNE_BERGEN
import no.nav.lydia.helper.TestVirksomhet.Companion.KOMMUNE_OSLO
import no.nav.lydia.helper.TestVirksomhet.Companion.beliggenhet
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test

class NyFlytMigreringAlleSakerTest {
    companion object {
        @BeforeClass
        @JvmStatic
        fun setUp() {
            utilsSetUp()
        }

        @AfterClass
        @JvmStatic
        fun tearDown() {
            utilsTearDown()
        }
    }

    @Test
    fun `skal kunne migrere alle saker`() {
        mirgeringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_OSLO, adresse = listOf("adresse"))).fullførSak()
        mirgeringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_OSLO, adresse = listOf("adresse")))
        mirgeringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_OSLO, adresse = listOf("adresse")))
        mirgeringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_OSLO, adresse = listOf("adresse")))
        mirgeringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_OSLO, adresse = listOf("adresse")))
        mirgeringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_BERGEN, adresse = listOf("adresse")))
        migreringSakIKartlegges(beliggenhet = beliggenhet(kommune = KOMMUNE_BERGEN, adresse = listOf("adresse")))
        migreringSakIKartlegges(beliggenhet = beliggenhet(kommune = KOMMUNE_BERGEN, adresse = listOf("adresse")))

        sendMigreringsmeldingOgVerifiserLogg(
            fylkenummer = "ALLE",
            (
                "Ferdig med migrering av saker for angitt parameter 'ALLE'. faktiskMigrer: true. "
            ).toRegex(),
        )
    }

    @Test
    fun `skal kunne migrere alle saker i et fylke`() {
        mirgeringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_OSLO, adresse = listOf("adresse"))).fullførSak()
        mirgeringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_OSLO, adresse = listOf("adresse")))
        mirgeringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_OSLO, adresse = listOf("adresse")))
        mirgeringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_OSLO, adresse = listOf("adresse")))
        mirgeringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_OSLO, adresse = listOf("adresse")))
        mirgeringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_BERGEN, adresse = listOf("adresse")))
        migreringSakIKartlegges(beliggenhet = beliggenhet(kommune = KOMMUNE_BERGEN, adresse = listOf("adresse")))
        migreringSakIKartlegges(beliggenhet = beliggenhet(kommune = KOMMUNE_BERGEN, adresse = listOf("adresse")))

        sendMigreringsmeldingOgVerifiserLogg(
            fylkenummer = "03", // Oslo
            (
                "Ferdig med migrering av saker for fylke 'Oslo'. faktiskMigrer: true. "
            ).toRegex(),
        )
    }
}
