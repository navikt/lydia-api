package no.nav.lydia.container.ia.team

import com.github.kittinunf.fuel.core.extensions.authentication
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.ktor.http.HttpStatusCode
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.opprettSakForVirksomhet
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.oauth2ServerContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
import no.nav.lydia.helper.VirksomhetHelper.Companion.nyttOrgnummer
import no.nav.lydia.helper.tilListeRespons
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.team.IA_SAK_TEAM_PATH
import no.nav.lydia.ia.team.MINE_SAKER_PATH
import no.nav.lydia.ia.team.BrukerITeamDto
import no.nav.lydia.ia.team.MineSakerDto
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import kotlin.test.Test
import kotlin.test.fail

class IASakTeamApiTest {
    private val mockOAuth2Server = oauth2ServerContainer
    private val lydiaApiContainer = TestContainerHelper.lydiaApiContainer

    @Test
    fun `skal kunne bli med i team`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())

        val res = lydiaApiContainer.performPost("$IA_SAK_TEAM_PATH/${sak.saksnummer}")
            .authentication().bearer(mockOAuth2Server.superbruker1.token)
            .tilSingelRespons<BrukerITeamDto>().third.fold(
                success = { respons -> respons },
                failure = { fail(it.message) })

        res.saksnummer shouldBe sak.saksnummer
        res.ident shouldBe mockOAuth2Server.superbruker1.navIdent

        postgresContainer.hentAlleRaderTilEnkelKolonne<String>(
            """select saksnummer from ia_sak_team
                    where ident = '${mockOAuth2Server.superbruker1.navIdent}'
                    and saksnummer = '${sak.saksnummer}'""".trimIndent()
        ) shouldHaveSize 1
    }

    @Test
    fun `skal ikke kunne dobbeltregistrere knytning`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
        lydiaApiContainer.performPost("$IA_SAK_TEAM_PATH/${sak.saksnummer}")
            .authentication().bearer(mockOAuth2Server.superbruker1.token)
            .tilSingelRespons<BrukerITeamDto>().third.fold(
                success = { respons -> respons },
                failure = { fail(it.message) })


        val res = lydiaApiContainer.performPost("$IA_SAK_TEAM_PATH/${sak.saksnummer}")
            .authentication().bearer(mockOAuth2Server.superbruker1.token)
            .tilSingelRespons<BrukerITeamDto>().second

        res.statusCode shouldBe HttpStatusCode.BadRequest.value
    }

    @Test
    fun `skal ikke kunne bli med i team uten sak`() {
        val res = lydiaApiContainer.performPost("$IA_SAK_TEAM_PATH/ikkeetsaksnummer")
            .authentication().bearer(mockOAuth2Server.superbruker1.token)
            .tilSingelRespons<BrukerITeamDto>().second

        res.statusCode shouldBe HttpStatusCode.BadRequest.value
    }

    @Test
    fun `skal ikke kunne bli med i team som lesebruker`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
        val res = lydiaApiContainer.performPost("$IA_SAK_TEAM_PATH/${sak.saksnummer}")
            .authentication().bearer(mockOAuth2Server.lesebruker.token)
            .tilSingelRespons<BrukerITeamDto>().second

        res.statusCode shouldBe HttpStatusCode.Forbidden.value
    }

    //MineSakerTester
    private fun IASakDto.sammenlignMedMineSaker(minsak: MineSakerDto) =
        orgnr == minsak.orgnr &&
                saksnummer == minsak.saksnummer &&
                status == minsak.status &&
                eidAv == minsak.eidAv &&
                endretTidspunkt == minsak.endretTidspunkt

    @Test
    fun `skal få alle saker man er eier av`() {
        val bruker = mockOAuth2Server.superbruker1.token
        val sak0 = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(IASakshendelseType.TA_EIERSKAP_I_SAK, token = bruker)
        val sak1 = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(IASakshendelseType.TA_EIERSKAP_I_SAK, token = bruker)
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(IASakshendelseType.TA_EIERSKAP_I_SAK, token = mockOAuth2Server.superbruker2.token)

        val iaSakListe = listOf(sak0, sak1).sortedBy { it.orgnr }

        val res = lydiaApiContainer.performGet(MINE_SAKER_PATH)
            .authentication().bearer(bruker)
            .tilListeRespons<MineSakerDto>().third.fold(
                success = { respons -> respons },
                failure = { fail(it.message) })

        iaSakListe.all { sak ->
            res.any { sak.sammenlignMedMineSaker(it) }
        } shouldBe true
    }

    @Test
    fun `skal ikke få saker man ikke eier av`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(IASakshendelseType.TA_EIERSKAP_I_SAK, token = mockOAuth2Server.superbruker2.token)
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(IASakshendelseType.TA_EIERSKAP_I_SAK, token = mockOAuth2Server.superbruker1.token)

        val res = lydiaApiContainer.performGet(MINE_SAKER_PATH)
            .authentication().bearer(mockOAuth2Server.superbruker1.token)
            .tilListeRespons<MineSakerDto>().third.fold(
                success = { respons -> respons },
                failure = { fail(it.message) })

        res.none {
            sak.sammenlignMedMineSaker(it)
        } shouldBe true
    }
}