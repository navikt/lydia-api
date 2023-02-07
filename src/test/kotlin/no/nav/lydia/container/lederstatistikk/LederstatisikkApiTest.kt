package no.nav.lydia.container.lederstatistikk

import io.kotest.matchers.ints.shouldBeGreaterThan
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.LederstatistikkHelper
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestData
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import kotlin.test.Test

class LederstatisikkApiTest {
    private val mockOAuth2Server = TestContainerHelper.oauth2ServerContainer

    @Test
    fun `skal hente lederstatistikk for de som ikke er aktive`() {
        VirksomhetHelper.lastInnNyVirksomhet(nyVirksomhet = TestVirksomhet.nyVirksomhet())

        val lederstatistikkKommunalSektor =
            LederstatistikkHelper.hentLederstatistikk(
                sektor = TestData.SEKTOR_KOMMUNAL_FORVALTNING,
                token = mockOAuth2Server.superbruker1.token
            ).third.get().data

        lederstatistikkKommunalSektor.size shouldBeGreaterThan 0
        lederstatistikkKommunalSektor.first { lederstatistikk ->
            lederstatistikk.status == IAProsessStatus.IKKE_AKTIV
        }.antall shouldBeGreaterThan 0
    }

    @Test
    fun `skal ikke kunne hente lederstatistikk dersom man ikke er superbruker`() {
        LederstatistikkHelper.hentLederstatistikk(
            token = mockOAuth2Server.lesebruker.token
        ).second.statusCode shouldBe 403
        LederstatistikkHelper.hentLederstatistikk(
            token = mockOAuth2Server.saksbehandler1.token
        ).second.statusCode shouldBe 403
    }

    @Test
    fun `skal kunne filtrere på sektor`() {
        val virksomhet = VirksomhetHelper.lastInnNyVirksomhet(nyVirksomhet = TestVirksomhet.nyVirksomhet(),
            sektor = TestData.SEKTOR_KOMMUNAL_FORVALTNING)

        SakHelper.opprettSakForVirksomhet(orgnummer = virksomhet.orgnr)
            .nyHendelse(IASakshendelseType.TA_EIERSKAP_I_SAK)
            .nyHendelse(IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(IASakshendelseType.VIRKSOMHET_KARTLEGGES)
            .nyHendelse(IASakshendelseType.VIRKSOMHET_SKAL_BISTÅS)
            .nyHendelse(IASakshendelseType.FULLFØR_BISTAND)

        val sakerForVirksomheten = SakHelper.hentSaker(orgnummer = virksomhet.orgnr)
        sakerForVirksomheten.size shouldBe 1
        sakerForVirksomheten.first().status shouldBe IAProsessStatus.FULLFØRT

        val lederstatistikkKommunalSektor =
            LederstatistikkHelper.hentLederstatistikk(
                sektor = TestData.SEKTOR_KOMMUNAL_FORVALTNING,
                token = mockOAuth2Server.superbruker1.token
            ).third.get().data
        lederstatistikkKommunalSektor.size shouldBeGreaterThan 0
        lederstatistikkKommunalSektor.first { lederstatistikk ->
            lederstatistikk.status == IAProsessStatus.FULLFØRT
        }.antall shouldBeGreaterThan 0
    }
}
