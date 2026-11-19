package no.nav.lydia.container.ny.flyt.samarbeid

import io.kotest.matchers.shouldBe
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.opprettSamarbeid
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.vurderVirksomhet
import no.nav.lydia.helper.SakHelper.Companion.leggTilFolger
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.integrasjoner.azure.NavEnhet
import org.junit.Test

class NyFlytSamarbeidTest {
    val saksbehandler2NavEnhet = NavEnhet(enhetsnummer = "2222", enhetsnavn = "ANNEN ENHET")

    @Test
    fun `nav-enhet tilhørende saksbehandler som oppretter samarbeid blir inkludert i respons`() {
        val samarbeid = vurderVirksomhet()
            .leggTilFolger(token = authContainerHelper.saksbehandler2.token)
            .opprettSamarbeid(token = authContainerHelper.saksbehandler2.token)

        samarbeid.navEnhet shouldBe saksbehandler2NavEnhet
    }
}
