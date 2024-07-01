package no.nav.lydia.container.ia.sak

import com.github.kittinunf.fuel.core.extensions.authentication
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.ktor.http.*
import no.nav.lydia.helper.SakHelper.Companion.opprettSakForVirksomhet
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.oauth2ServerContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
import no.nav.lydia.helper.VirksomhetHelper.Companion.nyttOrgnummer
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.sak.api.IA_SAK_TEAM_PATH
import no.nav.lydia.ia.sak.db.BrukerITeamDto
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
}