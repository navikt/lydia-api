package no.nav.lydia.container.ia.leveranse

import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.SakHelper.Companion.hentIASakLeveranser
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.VirksomhetHelper.Companion.nyttOrgnummer
import no.nav.lydia.helper.SakHelper.Companion.opprettSakForVirksomhet
import no.nav.lydia.helper.statuskode
import no.nav.lydia.ia.sak.domene.IASakshendelseType.*
import kotlin.test.Test

class IASakLeveranseTest {


    @Test
    fun `skal kunne kalle endepunkt uten feil`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(VIRKSOMHET_VURDERES)
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(VIRKSOMHET_KARTLEGGES)
            .nyHendelse(VIRKSOMHET_SKAL_BISTÅS)

        hentIASakLeveranser(saksnummer = sak.saksnummer).statuskode() shouldBe 200
    }
}