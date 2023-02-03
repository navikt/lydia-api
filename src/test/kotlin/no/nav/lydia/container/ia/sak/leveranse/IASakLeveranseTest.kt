package no.nav.lydia.container.ia.sak.leveranse

import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.ktor.http.*
import kotlinx.datetime.toKotlinLocalDate
import no.nav.lydia.helper.SakHelper.Companion.hentIASakLeveranser
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.opprettLeveranse
import no.nav.lydia.helper.SakHelper.Companion.opprettSakForVirksomhet
import no.nav.lydia.helper.VirksomhetHelper.Companion.nyttOrgnummer
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.statuskode
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASakshendelseType.*
import no.nav.lydia.ia.sak.domene.LeveranseStatus
import kotlin.test.Test

class IASakLeveranseTest {
    @Test
    fun `skal ikke kunne legge til leveranser dersom en sak ikke er i status Vi Bistår`() {
        val sakIStatusKartlegges = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(VIRKSOMHET_KARTLEGGES)

        sakIStatusKartlegges.status shouldBe IAProsessStatus.KARTLEGGES
        opprettLeveranse(
            saksnummer = sakIStatusKartlegges.saksnummer,
            frist = java.time.LocalDate.now().toKotlinLocalDate(),
            modulId = 1
        ).response().statuskode() shouldBe HttpStatusCode.Conflict.value
    }

    @Test
    fun `skal kunne legge til leveranser dersom en sak er i status Vi Bistår`() {
        val frist = java.time.LocalDate.now().toKotlinLocalDate()
        val sakIStatusViBistår = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(VIRKSOMHET_KARTLEGGES)
            .nyHendelse(VIRKSOMHET_SKAL_BISTÅS)

        sakIStatusViBistår.status shouldBe IAProsessStatus.VI_BISTÅR
        val leveranse = sakIStatusViBistår.opprettLeveranse(
            frist = frist,
            modulId = 1
        )

        leveranse.modul.id shouldBe 1
        leveranse.saksnummer shouldBe sakIStatusViBistår.saksnummer
        leveranse.status shouldBe LeveranseStatus.UNDER_ARBEID
        leveranse.frist shouldBe frist
    }

    @Test
    fun `skal kunne hente ut leveranser på sak`() {
        val nå = java.time.LocalDate.now().toKotlinLocalDate()
        val imorgen = java.time.LocalDate.now().plusDays(1).toKotlinLocalDate()

        val sakIStatusViBistår = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(VIRKSOMHET_KARTLEGGES)
            .nyHendelse(VIRKSOMHET_SKAL_BISTÅS)

        sakIStatusViBistår.opprettLeveranse(
            frist = nå,
            modulId = 1
        )
        sakIStatusViBistår.opprettLeveranse(
            frist = imorgen,
            modulId = 2
        )

        val leveranser = hentIASakLeveranser(saksnummer = sakIStatusViBistår.saksnummer)
        leveranser shouldHaveSize 2
        leveranser.forExactlyOne {
            it.frist shouldBe nå
            it.modul.id shouldBe 1
        }
        leveranser.forExactlyOne {
            it.frist shouldBe imorgen
            it.modul.id shouldBe 2
        }
    }

//    @Test
//    fun `skal kunne hente IATjenester`() {
//        val tjenester = hentIATjenester()
//    }
}
