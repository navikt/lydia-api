package no.nav.lydia.container.ia.leveranse

import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.SakHelper.Companion.hentIASakLeveranser
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.VirksomhetHelper.Companion.nyttOrgnummer
import no.nav.lydia.helper.SakHelper.Companion.opprettSakForVirksomhet
import no.nav.lydia.helper.statuskode
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASakshendelseType.*
import kotlin.test.Test

class IASakLeveranseTest {


    @Test
    fun `skal kunne kalle endepunkt uten feil`() {
        val sakIStatusViBistår = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(VIRKSOMHET_KARTLEGGES)
            .nyHendelse(VIRKSOMHET_SKAL_BISTÅS)
            .also { sak -> sak.status shouldBe IAProsessStatus.VI_BISTÅR }

        hentIASakLeveranser(saksnummer = sakIStatusViBistår.saksnummer).statuskode() shouldBe 200
    }
}