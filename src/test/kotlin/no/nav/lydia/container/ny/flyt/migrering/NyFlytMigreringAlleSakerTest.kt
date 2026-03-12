package no.nav.lydia.container.ny.flyt.migrering

import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.migreringSakIKartlegges
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.migreringSakIViBistår
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
        private val FYLKESNUMMER_OSLO = "03"
        private val FYLKESNUMMER_VESTLAND = "46"

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
        migreringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_OSLO, adresse = listOf("adresse"))).fullførSak()
        migreringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_OSLO, adresse = listOf("adresse")))
        migreringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_OSLO, adresse = listOf("adresse")))
        migreringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_OSLO, adresse = listOf("adresse")))
        migreringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_OSLO, adresse = listOf("adresse")))
        migreringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_BERGEN, adresse = listOf("adresse")))
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
        migreringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_OSLO, adresse = listOf("adresse"))).fullførSak()
        migreringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_OSLO, adresse = listOf("adresse")))
        migreringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_OSLO, adresse = listOf("adresse")))
        migreringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_OSLO, adresse = listOf("adresse")))
        migreringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_OSLO, adresse = listOf("adresse")))
        migreringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_BERGEN, adresse = listOf("adresse")))
        migreringSakIKartlegges(beliggenhet = beliggenhet(kommune = KOMMUNE_BERGEN, adresse = listOf("adresse")))
        migreringSakIKartlegges(beliggenhet = beliggenhet(kommune = KOMMUNE_BERGEN, adresse = listOf("adresse")))

        sendMigreringsmeldingOgVerifiserLogg(
            fylkenummer = FYLKESNUMMER_OSLO, // Oslo
            (
                "Ferdig med migrering av saker for fylke 'Oslo'. faktiskMigrer: true. "
            ).toRegex(),
            migrer = true,
        )
    }

    @Test
    fun `skal kunne migrere alle saker i et fylke med faktiskMigrer er false`() {
        migreringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_OSLO, adresse = listOf("adresse")))
        migreringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_OSLO, adresse = listOf("adresse")))
        migreringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_OSLO, adresse = listOf("adresse")))
        migreringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_OSLO, adresse = listOf("adresse")))

        val virksomhetMedEnGammelSak = migreringSakIViBistår(
            beliggenhet = beliggenhet(kommune = KOMMUNE_BERGEN, adresse = listOf("adresse")),
        ).fullførSak().orgnr
        println("Virksomhet med en gammel sak: $virksomhetMedEnGammelSak")
        migreringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_BERGEN, adresse = listOf("adresse")), orgnr = virksomhetMedEnGammelSak)
        migreringSakIViBistår(beliggenhet = beliggenhet(kommune = KOMMUNE_BERGEN, adresse = listOf("adresse")))
        migreringSakIKartlegges(beliggenhet = beliggenhet(kommune = KOMMUNE_BERGEN, adresse = listOf("adresse")))
        migreringSakIKartlegges(beliggenhet = beliggenhet(kommune = KOMMUNE_BERGEN, adresse = listOf("adresse")))

        sendMigreringsmeldingOgVerifiserLogg(
            fylkenummer = FYLKESNUMMER_VESTLAND, // Bergen
            (
                "Ferdig med migrering av saker for fylke 'Vestland'. faktiskMigrer: false. "
            ).toRegex(),
            migrer = false,
        )
    }
}
