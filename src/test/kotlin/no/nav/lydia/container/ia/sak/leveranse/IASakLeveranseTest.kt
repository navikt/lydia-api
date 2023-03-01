package no.nav.lydia.container.ia.sak.leveranse

import io.kotest.assertions.shouldFail
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.comparables.shouldBeGreaterThan
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.ktor.http.*
import kotlinx.datetime.toKotlinLocalDate
import kotlinx.datetime.toKotlinLocalDateTime
import no.nav.lydia.helper.SakHelper.Companion.hentIASakLeveranser
import no.nav.lydia.helper.SakHelper.Companion.hentIATjenester
import no.nav.lydia.helper.SakHelper.Companion.hentModuler
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.oppdaterIASakLeveranse
import no.nav.lydia.helper.SakHelper.Companion.opprettIASakLeveranse
import no.nav.lydia.helper.SakHelper.Companion.opprettSakForVirksomhet
import no.nav.lydia.helper.SakHelper.Companion.slettIASakLeveranse
import no.nav.lydia.helper.TestContainerHelper.Companion.oauth2ServerContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
import no.nav.lydia.helper.VirksomhetHelper.Companion.nyttOrgnummer
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.statuskode
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IAProsessStatus.VI_BISTÅR
import no.nav.lydia.ia.sak.domene.IASakshendelseType.*
import no.nav.lydia.ia.sak.domene.IASakLeveranseStatus
import java.time.LocalDate
import kotlin.test.Test

class IASakLeveranseTest {
    private val mockOAuth2Server = oauth2ServerContainer

    @Test
    fun `skal få tjenester sortert etter navn`() {
        hentIATjenester().map { it.navn } shouldBe hentIATjenesterFraDatabase().sorted()

        val sakIViBistår = sakIViBistår()
        hentModuler().forEach {
            sakIViBistår.opprettIASakLeveranse(modulId = it.id)
        }

        hentIASakLeveranser(
            orgnr = sakIViBistår.orgnr,
            saksnummer = sakIViBistår.saksnummer
        ).map { it.iaTjeneste.navn } shouldBe hentIATjenesterFraDatabase().sorted()
    }

    @Test
    fun `skal få ut fullførtdato for leveranser`() {
        val sakIViBistårStatus = sakIViBistår()
        val leveranse = sakIViBistårStatus.opprettIASakLeveranse(
            frist = LocalDate.now().toKotlinLocalDate(),
            modulId = 1
        )
        leveranse.oppdaterIASakLeveranse(
            orgnr = sakIViBistårStatus.orgnr,
            status = IASakLeveranseStatus.LEVERT
        )

        hentIASakLeveranser(
            orgnr = sakIViBistårStatus.orgnr,
            saksnummer = sakIViBistårStatus.saksnummer
        ).forExactlyOne {
            it.leveranser.forExactlyOne { leveranse ->
                leveranse.fullført shouldNotBe null
                leveranse.fullført?.shouldBeGreaterThan(LocalDate.now().atStartOfDay().toKotlinLocalDateTime())
            }
        }
    }

    @Test
    fun `skal ikke kunne legge til duplikate leveranser`() {
        val sakIViBistårStatus = sakIViBistår()

        sakIViBistårStatus.opprettIASakLeveranse(
            frist = LocalDate.now().toKotlinLocalDate(),
            modulId = 1
        )

        opprettIASakLeveranse(
            orgnr = sakIViBistårStatus.orgnr,
            saksnummer = sakIViBistårStatus.saksnummer,
            frist = LocalDate.now().toKotlinLocalDate(),
            modulId = 1).response().statuskode() shouldBe HttpStatusCode.Conflict.value

        hentIASakLeveranser(
            orgnr = sakIViBistårStatus.orgnr,
            saksnummer = sakIViBistårStatus.saksnummer) shouldHaveSize 1
    }

    @Test
    fun `skal ikke kunne legge til leveranser dersom en sak ikke er i status Vi Bistår`() {
        val sakIStatusKartlegges = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(VIRKSOMHET_KARTLEGGES)

        sakIStatusKartlegges.status shouldBe IAProsessStatus.KARTLEGGES
        opprettIASakLeveranse(
            orgnr = sakIStatusKartlegges.orgnr,
            saksnummer = sakIStatusKartlegges.saksnummer,
            frist = LocalDate.now().toKotlinLocalDate(),
            modulId = 1
        ).response().statuskode() shouldBe HttpStatusCode.Conflict.value
    }

    @Test
    fun `skal kunne legge til leveranser dersom en sak er i status Vi Bistår`() {
        val frist = LocalDate.now().toKotlinLocalDate()
        val sakIStatusViBistår = sakIViBistår()

        sakIStatusViBistår.status shouldBe VI_BISTÅR
        val leveranse = sakIStatusViBistår.opprettIASakLeveranse(
            frist = frist,
            modulId = 1
        )

        leveranse.modul.id shouldBe 1
        leveranse.saksnummer shouldBe sakIStatusViBistår.saksnummer
        leveranse.status shouldBe IASakLeveranseStatus.UNDER_ARBEID
        leveranse.frist shouldBe frist
    }

    @Test
    fun `skal kunne hente ut leveranser på sak`() {
        val nå = LocalDate.now().toKotlinLocalDate()
        val imorgen = LocalDate.now().plusDays(1).toKotlinLocalDate()

        val sakIStatusViBistår = sakIViBistår()

        sakIStatusViBistår.opprettIASakLeveranse(
            frist = nå,
            modulId = 1
        )
        sakIStatusViBistår.opprettIASakLeveranse(
            frist = imorgen,
            modulId = 2
        )

        val iaSakLeveranserPerTjeneste = hentIASakLeveranser(
            orgnr = sakIStatusViBistår.orgnr,
            saksnummer = sakIStatusViBistår.saksnummer)

        iaSakLeveranserPerTjeneste.forExactlyOne { iaSakLeveranseForTjeneste ->
            iaSakLeveranseForTjeneste.leveranser shouldHaveSize 2
            iaSakLeveranseForTjeneste.leveranser.forExactlyOne {
                it.frist shouldBe nå
                it.modul.id shouldBe 1
            }
            iaSakLeveranseForTjeneste.leveranser.forExactlyOne {
                it.frist shouldBe imorgen
                it.modul.id shouldBe 2
            }
        }
    }

    @Test
    fun `kun eier av sak skal kunne slette leveranse`() {
        val sakIStatusViBistår = sakIViBistår(eier = mockOAuth2Server.saksbehandler1.token)
        val leveranse = sakIStatusViBistår.opprettIASakLeveranse(
            frist = LocalDate.now().toKotlinLocalDate(),
            modulId = 1,
            token = mockOAuth2Server.saksbehandler1.token
        )

        hentIASakLeveranser(orgnr = sakIStatusViBistår.orgnr, saksnummer = sakIStatusViBistår.saksnummer) shouldHaveSize 1

        shouldFail {
            leveranse.slettIASakLeveranse(orgnr = sakIStatusViBistår.orgnr, token = mockOAuth2Server.saksbehandler2.token)
        }
        hentIASakLeveranser(orgnr = sakIStatusViBistår.orgnr, saksnummer = sakIStatusViBistår.saksnummer) shouldHaveSize 1

        leveranse.slettIASakLeveranse(orgnr = sakIStatusViBistår.orgnr, token = mockOAuth2Server.saksbehandler1.token)
        hentIASakLeveranser(orgnr = sakIStatusViBistår.orgnr, saksnummer = sakIStatusViBistår.saksnummer) shouldHaveSize 0
    }

    @Test
    fun `skal ikke kunne slette leveranser på en sak som ikke er i Vi Bistår`() {
        val sakIViBistår = sakIViBistår()
        val iaSakLeveranse = sakIViBistår.opprettIASakLeveranse(
            frist = LocalDate.now().toKotlinLocalDate(),
            modulId = 1
        )
        sakIViBistår.nyHendelse(FULLFØR_BISTAND)
        shouldFail {
            iaSakLeveranse.slettIASakLeveranse(orgnr = sakIViBistår.orgnr)
        }
    }

    @Test
    fun `skal kunne fullføre en leveranse`() {
        val sakIViBistår = sakIViBistår()

        val leveranseDto = sakIViBistår.opprettIASakLeveranse(frist = LocalDate.now().toKotlinLocalDate(), modulId = 1)
        val fullførtLeveranse = leveranseDto.oppdaterIASakLeveranse(orgnr = sakIViBistår.orgnr, status = IASakLeveranseStatus.LEVERT)
        fullførtLeveranse.status shouldBe IASakLeveranseStatus.LEVERT

        hentIASakLeveranser(orgnr = sakIViBistår.orgnr, saksnummer = sakIViBistår.saksnummer).forExactlyOne {iaSakLeveranserForTjeneste ->
            iaSakLeveranserForTjeneste.leveranser.forExactlyOne {
                it.id shouldBe leveranseDto.id
                it.status shouldBe IASakLeveranseStatus.LEVERT
            }
        }
    }

    @Test
    fun `skal kunne hente IATjenester`() {
        val tjenester = hentIATjenester()
        tjenester shouldHaveSize 3
    }

    @Test
    fun `skal kunne hente moduler`() {
        val moduler = hentModuler()
        moduler shouldHaveSize 14
    }

    private fun sakIViBistår(
        eier: String = mockOAuth2Server.saksbehandler1.token
    ) = opprettSakForVirksomhet(nyttOrgnummer())
        .nyHendelse(TA_EIERSKAP_I_SAK, token = eier)
        .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
        .nyHendelse(VIRKSOMHET_KARTLEGGES)
        .nyHendelse(VIRKSOMHET_SKAL_BISTÅS).also {
            it.status shouldBe VI_BISTÅR
        }

    private fun hentIATjenesterFraDatabase() =
        postgresContainer.hentAlleKolonner<String>("select navn from ia_tjeneste")
}
