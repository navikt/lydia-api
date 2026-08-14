package no.nav.lydia.container.ny.flyt.samarbeidsperiode

import io.kotest.matchers.collections.shouldBeEmpty
import io.kotest.matchers.collections.shouldContain
import io.kotest.matchers.collections.shouldNotContain
import io.kotest.matchers.shouldBe
import no.nav.lydia.api.v1.NY_FLYT_API_PATH
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.vurderVirksomhet
import no.nav.lydia.helper.SakHelper.Companion.bliEier
import no.nav.lydia.helper.SakHelper.Companion.leggTilFolger
import no.nav.lydia.helper.SamarbeidsperiodeNavnHelper.Companion.hentEiere
import no.nav.lydia.helper.SamarbeidsperiodeNavnHelper.Companion.hentRadgivere
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.responseString
import no.nav.lydia.prioritering.sykefraværsstatistikk.api.EierDTO
import kotlin.test.Test

// superbruker1 (S54321) er den eneste testbrukeren som også finnes i Azure-stubben
class NyFlytSamarbeidsperiodeNavnTest {
    private val superbruker = authContainerHelper.superbruker1
    private val superbrukerNavn = EierDTO(navIdent = "S54321", navn = "Bjørg Scheie Scheie")

    @Test
    fun `skal hente navn på eiere av saker`() {
        val sak = vurderVirksomhet(token = superbruker.token).bliEier(token = superbruker.token)

        hentEiere(saksnumre = setOf(sak.saksnummer)) shouldContain superbrukerNavn
    }

    @Test
    fun `skal ikke returnere eiere av saker det ikke spørres om`() {
        val eidSak = vurderVirksomhet(token = superbruker.token).bliEier(token = superbruker.token)
        val annenSak = vurderVirksomhet(token = authContainerHelper.superbruker2.token)

        hentEiere(saksnumre = setOf(annenSak.saksnummer)) shouldNotContain superbrukerNavn
        hentEiere(saksnumre = setOf(eidSak.saksnummer)) shouldContain superbrukerNavn
    }

    @Test
    fun `radgivere skal inneholde både eier og følgere`() {
        val eidSak = vurderVirksomhet(token = superbruker.token).bliEier(token = superbruker.token)
        val fulgtSak = vurderVirksomhet(token = authContainerHelper.superbruker2.token)
            .leggTilFolger(token = superbruker.token)

        hentRadgivere(saksnumre = setOf(eidSak.saksnummer)) shouldContain superbrukerNavn
        hentRadgivere(saksnumre = setOf(fulgtSak.saksnummer)) shouldContain superbrukerNavn
    }

    @Test
    fun `skal returnere tom liste når det ikke spørres om noe`() {
        hentEiere(saksnumre = emptySet()).shouldBeEmpty()
    }

    @Test
    fun `uautorisert kall skal returnere 401`() {
        val (_, response, _) = applikasjon
            .performPost("$NY_FLYT_API_PATH/samarbeidsperiode/eiere")
            .responseString()

        response.statusCode shouldBe 401
    }
}
