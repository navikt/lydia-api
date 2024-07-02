package no.nav.lydia.container.ia.sak

import com.github.kittinunf.fuel.core.extensions.authentication
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.ktor.http.*
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
import no.nav.lydia.ia.sak.api.IA_SAK_TEAM_PATH
import no.nav.lydia.ia.sak.api.MINE_SAKER_PATH
import no.nav.lydia.ia.sak.db.BrukerITeamDto
import no.nav.lydia.ia.sak.db.MineSakerDto
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
    @Test
    fun `skal få alle saker man er eier av`() {
        val bruker1 = mockOAuth2Server.superbruker1.token
        val sak0 = opprettSakForVirksomhet(orgnummer = nyttOrgnummer()).nyHendelse(IASakshendelseType.TA_EIERSKAP_I_SAK, token = bruker1)
        val sak1 = opprettSakForVirksomhet(orgnummer = nyttOrgnummer()).nyHendelse(IASakshendelseType.TA_EIERSKAP_I_SAK, token = bruker1)
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer()).nyHendelse(IASakshendelseType.TA_EIERSKAP_I_SAK, token = mockOAuth2Server.superbruker2.token)

        val iaSakListe = listOf(sak0, sak1).sortedBy { it.orgnr }

        val res = lydiaApiContainer.performGet(MINE_SAKER_PATH)
            .authentication().bearer(bruker1)
            .tilListeRespons<MineSakerDto>().third.fold(
                success = { respons -> respons },
                failure = { fail(it.message) })

        iaSakListe.all{ sak ->
            res.any { sak.orgnr == it.orgnr && sak.saksnummer == it.saksnummer && sak.status.name == it.status }
        } shouldBe true
    }

    @Test
    fun `skal ikke få saker man ikke eier av`() {
        val bruker2 = mockOAuth2Server.superbruker2.token
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer()).nyHendelse(IASakshendelseType.TA_EIERSKAP_I_SAK, token = bruker2)
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer()).nyHendelse(IASakshendelseType.TA_EIERSKAP_I_SAK, token = mockOAuth2Server.saksbehandler1.token)

        val res = lydiaApiContainer.performGet(MINE_SAKER_PATH)
            .authentication().bearer(mockOAuth2Server.superbruker1.token)
            .tilListeRespons<MineSakerDto>().third.fold(
                success = { respons -> respons },
                failure = { fail(it.message) })

        res.none {
            (sak.orgnr == it.orgnr && sak.saksnummer == it.saksnummer && sak.status.name == it.status)
        } shouldBe true
    }
}