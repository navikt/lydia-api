package no.nav.lydia.container.ia.sak.leveranse

import io.kotest.assertions.shouldFail
import io.kotest.matchers.collections.shouldContain
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.collections.shouldNotContain
import io.kotest.matchers.comparables.shouldBeGreaterThan
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.kotest.matchers.string.shouldMatch
import io.ktor.http.HttpStatusCode
import io.ktor.http.HttpStatusCode.Companion.BadRequest
import kotlinx.datetime.toKotlinLocalDate
import kotlinx.datetime.toKotlinLocalDateTime
import no.nav.lydia.helper.LeveranseHelper.Companion.deaktiverIATjeneste
import no.nav.lydia.helper.LeveranseHelper.Companion.deaktiverModul
import no.nav.lydia.helper.LeveranseHelper.Companion.hentIATjenesterFraDatabase
import no.nav.lydia.helper.LeveranseHelper.Companion.leggTilIATjeneste
import no.nav.lydia.helper.LeveranseHelper.Companion.leggTilModul
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.SakHelper.Companion.hentIASakLeveranser
import no.nav.lydia.helper.SakHelper.Companion.hentIATjenester
import no.nav.lydia.helper.SakHelper.Companion.hentModuler
import no.nav.lydia.helper.SakHelper.Companion.hentSak
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.SakHelper.Companion.oppdaterHendelsesTidspunkter
import no.nav.lydia.helper.SakHelper.Companion.oppdaterIASakLeveranse
import no.nav.lydia.helper.SakHelper.Companion.opprettIASakLeveranse
import no.nav.lydia.helper.SakHelper.Companion.opprettSakForVirksomhet
import no.nav.lydia.helper.SakHelper.Companion.slettIASakLeveranse
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.TestData
import no.nav.lydia.helper.VirksomhetHelper.Companion.nyttOrgnummer
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.statuskode
import no.nav.lydia.ia.sak.api.IATjenesteDto
import no.nav.lydia.ia.sak.api.ModulDto
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IAProsessStatus.VI_BISTÅR
import no.nav.lydia.ia.sak.domene.IASakLeveranseStatus
import no.nav.lydia.ia.sak.domene.IASakLeveranseStatus.LEVERT
import no.nav.lydia.ia.sak.domene.IASakshendelseType.FULLFØR_BISTAND
import no.nav.lydia.ia.sak.domene.IASakshendelseType.TA_EIERSKAP_I_SAK
import no.nav.lydia.ia.sak.domene.IASakshendelseType.TILBAKE
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_KARTLEGGES
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES
import no.nav.lydia.tilgangskontroll.fia.Rolle
import java.sql.Timestamp
import java.time.LocalDate
import java.time.LocalDateTime
import kotlin.test.Test

class IASakLeveranseTest {
    @Test
    fun `skal få tjenester sortert etter navn`() {
        hentIATjenester().map { it.navn } shouldBe hentIATjenesterFraDatabase().sorted()

        val sakIViBistår = nySakIViBistår()
        hentModuler().forEach {
            sakIViBistår.opprettIASakLeveranse(modulId = it.id)
        }

        hentIASakLeveranser(
            orgnr = sakIViBistår.orgnr,
            saksnummer = sakIViBistår.saksnummer,
        ).map { it.iaTjeneste.navn } shouldBe hentIATjenesterFraDatabase().sorted()
    }

    @Test
    fun `skal få ut fullførtdato for leveranser`() {
        val sakIViBistårStatus = nySakIViBistår()
        val leveranse = sakIViBistårStatus.opprettIASakLeveranse(
            frist = LocalDate.now().toKotlinLocalDate(),
            modulId = TestData.AKTIV_MODUL.id,
        )
        leveranse.oppdaterIASakLeveranse(
            orgnr = sakIViBistårStatus.orgnr,
            status = LEVERT,
        )

        hentIASakLeveranser(
            orgnr = sakIViBistårStatus.orgnr,
            saksnummer = sakIViBistårStatus.saksnummer,
        ).forExactlyOne {
            it.leveranser.forExactlyOne { leveranse ->
                leveranse.fullført shouldNotBe null
                leveranse.fullført?.shouldBeGreaterThan(LocalDate.now().atStartOfDay().toKotlinLocalDateTime())
            }
        }
    }

    @Test
    fun `skal ikke kunne legge til duplikate leveranser`() {
        val sakIViBistårStatus = nySakIViBistår()

        sakIViBistårStatus.opprettIASakLeveranse(
            frist = LocalDate.now().toKotlinLocalDate(),
            modulId = TestData.AKTIV_MODUL.id,
        )

        opprettIASakLeveranse(
            orgnr = sakIViBistårStatus.orgnr,
            saksnummer = sakIViBistårStatus.saksnummer,
            frist = LocalDate.now().toKotlinLocalDate(),
            modulId = TestData.AKTIV_MODUL.id,
        ).response().statuskode() shouldBe HttpStatusCode.Conflict.value

        hentIASakLeveranser(
            orgnr = sakIViBistårStatus.orgnr,
            saksnummer = sakIViBistårStatus.saksnummer,
        ) shouldHaveSize 1
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
            modulId = TestData.AKTIV_MODUL.id,
        ).response().statuskode() shouldBe HttpStatusCode.Conflict.value
    }

    @Test
    fun `skal kunne legge til leveranser dersom en sak er i status Vi Bistår`() {
        val frist = LocalDate.now().toKotlinLocalDate()
        val sakIStatusViBistår = nySakIViBistår()

        sakIStatusViBistår.status shouldBe VI_BISTÅR
        val leveranse = sakIStatusViBistår.opprettIASakLeveranse(
            frist = frist,
            modulId = TestData.AKTIV_MODUL.id,
            token = authContainerHelper.saksbehandler1.token,
        )

        leveranse.modul.id shouldBe TestData.AKTIV_MODUL.id
        leveranse.saksnummer shouldBe sakIStatusViBistår.saksnummer
        leveranse.status shouldBe IASakLeveranseStatus.UNDER_ARBEID
        leveranse.frist shouldBe frist

        postgresContainerHelper.hentEnkelKolonne<String>(
            """
            select sist_endret_av_rolle from iasak_leveranse where id = ${leveranse.id}
            """.trimIndent(),
        ) shouldBe Rolle.SAKSBEHANDLER.name

        postgresContainerHelper.hentEnkelKolonne<String>(
            """
            select sist_endret_av from iasak_leveranse where id = ${leveranse.id}
            """.trimIndent(),
        ) shouldBe authContainerHelper.saksbehandler1.navIdent
    }

    @Test
    fun `skal kunne hente ut leveranser på sak`() {
        val nå = LocalDate.now().toKotlinLocalDate()
        val imorgen = LocalDate.now().plusDays(1).toKotlinLocalDate()

        val sakIStatusViBistår = nySakIViBistår()

        sakIStatusViBistår.opprettIASakLeveranse(
            frist = nå,
            modulId = TestData.AKTIV_MODUL.id,
        )
        sakIStatusViBistår.opprettIASakLeveranse(
            frist = imorgen,
            modulId = 16,
        )

        val iaSakLeveranserPerTjeneste = hentIASakLeveranser(
            orgnr = sakIStatusViBistår.orgnr,
            saksnummer = sakIStatusViBistår.saksnummer,
        )

        val leveranser = iaSakLeveranserPerTjeneste.flatMap { it.leveranser }

        leveranser shouldHaveSize 2
        leveranser.forExactlyOne {
            it.frist shouldBe nå
            it.modul.id shouldBe TestData.AKTIV_MODUL.id
        }
        leveranser.forExactlyOne {
            it.frist shouldBe imorgen
            it.modul.id shouldBe 16
        }
    }

    @Test
    fun `kun eier av sak skal kunne slette leveranse`() {
        val sakIStatusViBistår = nySakIViBistår(token = authContainerHelper.saksbehandler1.token)
        val leveranse = sakIStatusViBistår.opprettIASakLeveranse(
            frist = LocalDate.now().toKotlinLocalDate(),
            modulId = TestData.AKTIV_MODUL.id,
            token = authContainerHelper.saksbehandler1.token,
        )

        hentIASakLeveranser(
            orgnr = sakIStatusViBistår.orgnr,
            saksnummer = sakIStatusViBistår.saksnummer,
        ) shouldHaveSize 1

        shouldFail {
            leveranse.slettIASakLeveranse(
                orgnr = sakIStatusViBistår.orgnr,
                token = authContainerHelper.saksbehandler2.token,
            )
        }
        hentIASakLeveranser(
            orgnr = sakIStatusViBistår.orgnr,
            saksnummer = sakIStatusViBistår.saksnummer,
        ) shouldHaveSize 1

        leveranse.slettIASakLeveranse(orgnr = sakIStatusViBistår.orgnr, token = authContainerHelper.saksbehandler1.token)
        hentIASakLeveranser(
            orgnr = sakIStatusViBistår.orgnr,
            saksnummer = sakIStatusViBistår.saksnummer,
        ) shouldHaveSize 0
    }

    @Test
    fun `skal ikke kunne slette leveranser på en sak som ikke er i Vi Bistår`() {
        val sakIViBistår = nySakIViBistår()
        val iaSakLeveranse = sakIViBistår.opprettIASakLeveranse(
            frist = LocalDate.now().toKotlinLocalDate(),
            modulId = TestData.AKTIV_MODUL.id,
        )
        sakIViBistår.nyHendelse(TILBAKE)
        shouldFail {
            iaSakLeveranse.slettIASakLeveranse(orgnr = sakIViBistår.orgnr)
        }
    }

    @Test
    fun `skal kunne fullføre en leveranse`() {
        val sakIViBistår = nySakIViBistår()

        val leveranseDto = sakIViBistår.opprettIASakLeveranse(
            frist = LocalDate.now().toKotlinLocalDate(),
            modulId = TestData.AKTIV_MODUL.id,
        )
        val fullførtLeveranse = leveranseDto.oppdaterIASakLeveranse(orgnr = sakIViBistår.orgnr, status = LEVERT)
        fullførtLeveranse.status shouldBe LEVERT

        hentIASakLeveranser(
            orgnr = sakIViBistår.orgnr,
            saksnummer = sakIViBistår.saksnummer,
        ).forExactlyOne { iaSakLeveranserForTjeneste ->
            iaSakLeveranserForTjeneste.leveranser.forExactlyOne {
                it.id shouldBe leveranseDto.id
                it.status shouldBe LEVERT
            }
        }
    }

    @Test
    fun `skal ikke kunne fullføre sak med leveranser som er under arbeid`() {
        val sakIViBistår = nySakIViBistår()
        sakIViBistår.opprettIASakLeveranse(
            frist = LocalDate.now().toKotlinLocalDate(),
            modulId = TestData.AKTIV_MODUL.id,
        )
        val response = SakHelper.nyHendelsePåSakMedRespons(
            sak = sakIViBistår,
            hendelsestype = FULLFØR_BISTAND,
            token = authContainerHelper.saksbehandler1.token,
        )
        response.statuskode() shouldBe BadRequest.value
        response.second.body().asString("text/plain") shouldMatch "Kan ikke fullf.*re med gjenst.*ende leveranser"
    }

    @Test
    fun `skal kunne hente IATjenester`() {
        val tjenester = hentIATjenester()
        tjenester shouldHaveAtLeastSize 3
    }

    @Test
    fun `skal kunne hente moduler`() {
        val moduler = hentModuler()
        moduler shouldHaveAtLeastSize 3
    }

    @Test
    fun `skal ikke få deaktiverte moduler og tjenester`() {
        val deaktivertTjenese = IATjenesteDto(id = 1000, navn = "Test", deaktivert = true)
        val aktivModulIDeaktivertTjeneste = ModulDto(id = 1000, iaTjeneste = 1000, navn = "Test", deaktivert = false)
        leggTilIATjeneste(deaktivertTjenese)
        leggTilModul(aktivModulIDeaktivertTjeneste)

        val aktivTjenesteMedDeaktivertModul = IATjenesteDto(id = 1001, navn = "Test", deaktivert = false)
        val deaktivertModul = ModulDto(id = 1001, iaTjeneste = 1001, navn = "Test", deaktivert = true)
        val aktivModul = ModulDto(id = 1002, iaTjeneste = 1001, navn = "Test", deaktivert = false)
        leggTilIATjeneste(aktivTjenesteMedDeaktivertModul)
        leggTilModul(deaktivertModul)
        leggTilModul(aktivModul)

        val iaTjenester = hentIATjenester()
        iaTjenester shouldNotContain deaktivertTjenese
        iaTjenester shouldContain aktivTjenesteMedDeaktivertModul

        val moduler = hentModuler()
        moduler shouldNotContain deaktivertModul
        moduler shouldNotContain aktivModulIDeaktivertTjeneste
        moduler shouldContain aktivModul
    }

    @Test
    fun `skal kunne liste opp leveranser med deaktiverte tjenester og moduler`() {
        val tjeneste = IATjenesteDto(id = 2000, navn = "Test", deaktivert = false)
        val modul = ModulDto(id = 2000, navn = "Test", iaTjeneste = tjeneste.id, deaktivert = false)
        leggTilIATjeneste(iaTjeneste = tjeneste)
        leggTilModul(modul = modul)

        val sak = nySakIViBistår()
        sak.opprettIASakLeveranse(modulId = modul.id)

        deaktiverModul(modul = modul)
        hentIASakLeveranser(orgnr = sak.orgnr, saksnummer = sak.saksnummer) shouldHaveSize 1

        deaktiverIATjeneste(iaTjeneste = tjeneste)
        hentIASakLeveranser(orgnr = sak.orgnr, saksnummer = sak.saksnummer) shouldHaveSize 1
    }

    @Test
    fun `skal ikke kunne legge til leveranse på deaktivert modul eller tjeneste`() {
        val deaktivertTjeneste = IATjenesteDto(id = 3000, navn = "Test", deaktivert = true)
        val aktivModulIDeaktivertTjeneste =
            ModulDto(id = 3000, navn = "Test", iaTjeneste = deaktivertTjeneste.id, deaktivert = false)
        leggTilIATjeneste(iaTjeneste = deaktivertTjeneste)
        leggTilModul(modul = aktivModulIDeaktivertTjeneste)

        val aktivTjeneste = IATjenesteDto(id = 4000, navn = "Test", deaktivert = false)
        val deaktivertModul = ModulDto(id = 4000, navn = "Test", iaTjeneste = aktivTjeneste.id, deaktivert = true)
        leggTilIATjeneste(iaTjeneste = aktivTjeneste)
        leggTilModul(modul = deaktivertModul)

        val sak = nySakIViBistår()
        shouldFail {
            sak.opprettIASakLeveranse(modulId = aktivModulIDeaktivertTjeneste.id)
        }
        shouldFail {
            sak.opprettIASakLeveranse(modulId = deaktivertModul.id)
        }
    }

    @Test
    fun `skal kunne fullføre en leveranse med deaktivert modul`() {
        val tjeneste = IATjenesteDto(id = 5000, navn = "Test", deaktivert = false)
        val modul = ModulDto(id = 5000, navn = "Test", iaTjeneste = tjeneste.id, deaktivert = false)
        leggTilIATjeneste(iaTjeneste = tjeneste)
        leggTilModul(modul = modul)

        val sak = nySakIViBistår()
        val leveranse = sak.opprettIASakLeveranse(modulId = modul.id)
        deaktiverModul(modul = modul)
        val levert = leveranse.oppdaterIASakLeveranse(orgnr = sak.orgnr, status = LEVERT)
        levert.status shouldBe LEVERT

        hentIASakLeveranser(orgnr = sak.orgnr, saksnummer = sak.saksnummer).forExactlyOne {
            it.leveranser shouldContain levert
        }
    }

    @Test
    fun `oppretting av leveranse skal oppdatere sak sin sist endret dato`() {
        val antallDagerSiden = 10L
        val sak = nySakIViBistår().oppdaterHendelsesTidspunkter(antallDagerTilbake = antallDagerSiden)
        sak.endretTidspunkt?.dayOfYear shouldBe LocalDateTime.now().minusDays(antallDagerSiden).dayOfYear

        sak.opprettIASakLeveranse(modulId = TestData.AKTIV_MODUL.id)
        val etterOpprettetLeveranseTidspunkt = hentSak(orgnummer = sak.orgnr).endretTidspunkt
        etterOpprettetLeveranseTidspunkt?.dayOfYear shouldBe LocalDateTime.now().dayOfYear
    }

    @Test
    fun `oppdatering av leveranse skal oppdatere sak sin sist endret dato`() {
        val sak = nySakIViBistår()
        val leveranse = sak.opprettIASakLeveranse(modulId = TestData.AKTIV_MODUL.id)
        sak.oppdaterHendelsesTidspunkter(antallDagerTilbake = 10)

        leveranse.oppdaterIASakLeveranse(sak.orgnr, LEVERT)
        val etterOppdatertLeveranseTidspunkt = hentSak(orgnummer = sak.orgnr).endretTidspunkt
        etterOppdatertLeveranseTidspunkt?.dayOfYear shouldBe LocalDateTime.now().dayOfYear
    }

    @Test
    fun `skal lagre opprettet-tidspunkt for leveranser`() {
        val sak = nySakIViBistår()
        val leveranse = sak.opprettIASakLeveranse(modulId = TestData.AKTIV_MODUL.id)
        val førFullført = postgresContainerHelper.hentEnkelKolonne<Timestamp?>(
            """
            select opprettet_tidspunkt from iasak_leveranse where id = ${leveranse.id}
            """.trimIndent(),
        )?.toLocalDateTime()
        førFullført shouldNotBe null

        leveranse.oppdaterIASakLeveranse(sak.orgnr, LEVERT)
        val etterFullført = postgresContainerHelper.hentEnkelKolonne<Timestamp?>(
            """
            select opprettet_tidspunkt from iasak_leveranse where id = ${leveranse.id}
            """.trimIndent(),
        )?.toLocalDateTime()
        etterFullført shouldBe førFullført
    }

    @Test
    fun `skal kunne hente IA-tjenesten 'Utvikle partssamarbeid'`() {
        hentIATjenester().forExactlyOne {
            it.navn shouldBe "Utvikle partssamarbeid"
            it.id shouldBe 4
        }
        hentModuler().forExactlyOne {
            it.navn shouldBe "Utvikle partssamarbeid"
            it.id shouldBe 18
            it.iaTjeneste shouldBe 4
        }
    }

    @Test
    fun `skal kunne opprette leveranser av IA-tjenesten 'Utvikle partssamarbeid'`() {
        val sak = nySakIViBistår()
        sak.opprettIASakLeveranse(modulId = 18) // Utvikle partssamarbeid
        hentIASakLeveranser(orgnr = sak.orgnr, saksnummer = sak.saksnummer).forExactlyOne { leveransePerTjeneste ->
            leveransePerTjeneste.leveranser.forExactlyOne { leveranse ->
                leveranse.modul.id shouldBe 18
            }
        }
    }
}
