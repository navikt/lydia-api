package no.nav.lydia.container.styring

import io.kotest.matchers.ints.shouldBeGreaterThan
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.StyringsstatistikkHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestData
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import kotlin.test.Test

class StyringsstatisikkApiTest {
    private val mockOAuth2Server = TestContainerHelper.oauth2ServerContainer

    @Test
    fun `skal kunne filtrere sykefraværsstatistikk på sektor`() {
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

        val styringsstatistikkKommunalSektor =
            StyringsstatistikkHelper.hentStyringsstatistikk(
                sektor = TestData.SEKTOR_KOMMUNAL_FORVALTNING,
                token = mockOAuth2Server.superbruker1.token
            ).data
        styringsstatistikkKommunalSektor.size shouldBeGreaterThan 0
        styringsstatistikkKommunalSektor.first { styringsstatistikk ->
            styringsstatistikk.status == IAProsessStatus.FULLFØRT
        }.antall shouldBeGreaterThan 0
    }
}
