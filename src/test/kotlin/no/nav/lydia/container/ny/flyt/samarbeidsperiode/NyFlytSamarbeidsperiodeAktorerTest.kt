package no.nav.lydia.container.ny.flyt.samarbeidsperiode

import io.kotest.matchers.collections.shouldBeEmpty
import io.kotest.matchers.collections.shouldContain
import io.kotest.matchers.shouldBe
import no.nav.lydia.api.v1.NY_FLYT_API_PATH
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.vurderVirksomhet
import no.nav.lydia.helper.SakHelper.Companion.bliEier
import no.nav.lydia.helper.SakHelper.Companion.hentSamarbeidshistorikkNyFlyt
import no.nav.lydia.helper.SamarbeidsperiodeNavnHelper.Companion.hentAktorer
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.responseString
import kotlin.test.Test

// superbruker1 (S54321) er den eneste testbrukeren som også finnes i Azure-stubben
class NyFlytSamarbeidsperiodeAktorerTest {
    private val superbruker = authContainerHelper.superbruker1
    private val superbrukerNavIdent = "S54321"

    @Test
    fun `skal hente aktør for hendelse som tilhører saksnummeret`() {
        val sak = vurderVirksomhet(token = superbruker.token)

        val hendelseId = hentSamarbeidshistorikkNyFlyt(orgnummer = sak.orgnr)
            .first { it.saksnummer == sak.saksnummer }
            .sakshendelser.first { it.hendelseOpprettetAv == superbrukerNavIdent }.hendelseId

        val aktører = hentAktorer(saksnummer = sak.saksnummer, hendelseIder = setOf(hendelseId))

        aktører.map { it.hendelseId } shouldContain hendelseId
        aktører.first { it.hendelseId == hendelseId }.aktor.navIdent shouldBe superbrukerNavIdent
    }

    @Test
    fun `hendelseId fra en annen sak skal ikke gi treff`() {
        val eidSak = vurderVirksomhet(token = superbruker.token).bliEier(token = superbruker.token)
        val annenSak = vurderVirksomhet(token = authContainerHelper.superbruker2.token)

        val hendelseIdFraAnnenSak = hentSamarbeidshistorikkNyFlyt(orgnummer = annenSak.orgnr)
            .first { it.saksnummer == annenSak.saksnummer }
            .sakshendelser.first().hendelseId

        hentAktorer(saksnummer = eidSak.saksnummer, hendelseIder = setOf(hendelseIdFraAnnenSak)).shouldBeEmpty()
    }

    @Test
    fun `skal returnere tom liste når det ikke spørres om noe`() {
        val sak = vurderVirksomhet(token = superbruker.token)

        hentAktorer(saksnummer = sak.saksnummer, hendelseIder = emptySet()).shouldBeEmpty()
    }

    @Test
    fun `uautorisert kall skal returnere 401`() {
        val (_, response, _) = applikasjon
            .performPost("$NY_FLYT_API_PATH/samarbeidsperiode/SAK-1/aktorer")
            .responseString()

        response.statusCode shouldBe 401
    }
}
