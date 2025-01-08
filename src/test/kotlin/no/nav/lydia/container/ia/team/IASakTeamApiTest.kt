package no.nav.lydia.container.ia.team

import com.github.kittinunf.fuel.core.extensions.authentication
import io.kotest.matchers.collections.shouldBeUnique
import io.kotest.matchers.collections.shouldContainAll
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.ktor.http.HttpStatusCode
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.opprettSakForVirksomhet
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.oauth2ServerContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.performDelete
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
import no.nav.lydia.helper.VirksomhetHelper.Companion.nyttOrgnummer
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.tilListeRespons
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.domene.IASakshendelseType.TA_EIERSKAP_I_SAK
import no.nav.lydia.ia.team.BrukerITeamDto
import no.nav.lydia.ia.team.IA_SAK_TEAM_PATH
import no.nav.lydia.ia.team.MINE_SAKER_PATH
import no.nav.lydia.ia.team.MineSakerDto
import kotlin.test.Test
import kotlin.test.fail

class IASakTeamApiTest {
    private val mockOAuth2Server = oauth2ServerContainer
    private val lydiaApiContainer = TestContainerHelper.lydiaApiContainer

    private fun bliMedITeam(
        token: String,
        saksnummer: String,
    ) = lydiaApiContainer.performPost("$IA_SAK_TEAM_PATH/$saksnummer")
        .authentication().bearer(token)
        .tilSingelRespons<BrukerITeamDto>().third.fold(
            success = { respons -> respons },
            failure = { fail(it.message) },
        )
        .also { it.saksnummer shouldBe saksnummer }

    private fun IASakDto.leggTilFolger(token: String) = also { bliMedITeam(token = token, saksnummer) }

    private fun opprettSakBliOgMedITeam(
        token: String,
        orgnummer: String = nyttOrgnummer(),
    ): Pair<IASakDto, BrukerITeamDto> {
        val sak = opprettSakForVirksomhet(orgnummer = orgnummer)
        return Pair(sak, bliMedITeam(token = token, saksnummer = sak.saksnummer))
    }

    @Test
    fun `skal hente alle brukere i team på en sak`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())

        lydiaApiContainer.performGet("$IA_SAK_TEAM_PATH/${sak.saksnummer}")
            .authentication().bearer(mockOAuth2Server.superbruker1.token)
            .tilListeRespons<String>().third.fold(
                success = { respons -> respons },
                failure = { fail(it.message) },
            )
            .shouldHaveSize(0)

        val userList = listOf(
            mockOAuth2Server.superbruker1,
            mockOAuth2Server.superbruker2,
            mockOAuth2Server.saksbehandler1,
            mockOAuth2Server.saksbehandler2,
        )
        userList.forEach {
            bliMedITeam(token = it.token, saksnummer = sak.saksnummer)
        }

        val teamList = lydiaApiContainer.performGet("$IA_SAK_TEAM_PATH/${sak.saksnummer}")
            .authentication().bearer(mockOAuth2Server.superbruker1.token)
            .tilListeRespons<String>().third.fold(
                success = { respons -> respons },
                failure = { fail(it.message) },
            )
            .shouldHaveSize(userList.size)

        teamList
            .shouldContainAll(userList.map { it.navIdent })
    }

    @Test
    fun `skal kunne bli med i team`() {
        val (sak, res) = opprettSakBliOgMedITeam(token = mockOAuth2Server.superbruker1.token)

        res.saksnummer shouldBe sak.saksnummer
        res.ident shouldBe mockOAuth2Server.superbruker1.navIdent

        postgresContainer.hentAlleRaderTilEnkelKolonne<String>(
            """
            select saksnummer from ia_sak_team
            where ident = '${mockOAuth2Server.superbruker1.navIdent}'
            and saksnummer = '${sak.saksnummer}'
            """.trimIndent(),
        ) shouldHaveSize 1
    }

    @Test
    fun `skal kunne bli med i flere team`() {
        val bruker = mockOAuth2Server.superbruker1
        val resList = listOf(
            opprettSakBliOgMedITeam(token = bruker.token).second,
            opprettSakBliOgMedITeam(token = bruker.token).second,
            opprettSakBliOgMedITeam(token = bruker.token).second,
        )

        resList.all {
            it.ident == bruker.navIdent
        }
    }

    @Test
    fun `skal ikke kunne bli med i team uten sak`() {
        val res = lydiaApiContainer.performPost("$IA_SAK_TEAM_PATH/ikkeetsaksnummer")
            .authentication().bearer(mockOAuth2Server.superbruker1.token)
            .tilSingelRespons<BrukerITeamDto>().second

        res.statusCode shouldBe HttpStatusCode.BadRequest.value
    }

    @Test
    fun `skal bli følger av sak dersom man blir fratatt eierskap`() {
        // sanity
        mockOAuth2Server.saksbehandler1.navIdent shouldNotBe mockOAuth2Server.saksbehandler2.navIdent

        val sakFørEierskapsendring = opprettSakForVirksomhet(orgnummer = nyttOrgnummer()).nyHendelse(
            TA_EIERSKAP_I_SAK,
            token = mockOAuth2Server.saksbehandler1.token,
        )

        val sakEtterEierskapBytte = sakFørEierskapsendring.nyHendelse(
            TA_EIERSKAP_I_SAK,
            token = mockOAuth2Server.saksbehandler2.token,
        )
        sakEtterEierskapBytte.eidAv shouldBe mockOAuth2Server.saksbehandler2.navIdent

        val res = lydiaApiContainer.performGet(MINE_SAKER_PATH)
            .authentication().bearer(mockOAuth2Server.saksbehandler1.token)
            .tilListeRespons<MineSakerDto>().third.fold(
                success = { respons -> respons },
                failure = { fail(it.message) },
            )
        res.forExactlyOne {
            it.iaSak.saksnummer shouldBe sakFørEierskapsendring.saksnummer
            it.iaSak.eidAv shouldBe sakEtterEierskapBytte.eidAv shouldBe mockOAuth2Server.saksbehandler2.navIdent
            it.iaSak.eidAv shouldNotBe sakFørEierskapsendring.eidAv
        }
    }

    @Test
    fun `skal kunne bli med i team som lesebruker`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
        val res = lydiaApiContainer.performPost("$IA_SAK_TEAM_PATH/${sak.saksnummer}")
            .authentication().bearer(mockOAuth2Server.lesebruker.token)
            .tilSingelRespons<BrukerITeamDto>().second

        res.statusCode shouldBe HttpStatusCode.Created.value
    }

    @Test
    fun `skal kunne fjernes fra team`() {
        val (sak, _) = opprettSakBliOgMedITeam(token = mockOAuth2Server.superbruker1.token)

        postgresContainer.hentAlleRaderTilEnkelKolonne<String>(
            """
            select saksnummer from ia_sak_team
            where ident = '${mockOAuth2Server.superbruker1.navIdent}'
            and saksnummer = '${sak.saksnummer}'
            """.trimIndent(),
        ) shouldHaveSize 1

        val deleteRes = lydiaApiContainer.performDelete("$IA_SAK_TEAM_PATH/${sak.saksnummer}")
            .authentication().bearer(mockOAuth2Server.superbruker1.token)
            .tilSingelRespons<BrukerITeamDto>().third.fold(
                success = { respons -> respons },
                failure = { fail(it.message) },
            )

        deleteRes.saksnummer shouldBe sak.saksnummer
        deleteRes.ident shouldBe mockOAuth2Server.superbruker1.navIdent

        postgresContainer.hentAlleRaderTilEnkelKolonne<String>(
            """
            select saksnummer from ia_sak_team
            where ident = '${mockOAuth2Server.superbruker1.navIdent}'
            and saksnummer = '${sak.saksnummer}'
            """.trimIndent(),
        ) shouldHaveSize 0
    }

    @Test
    fun `skal ikke kunne fjernes fra team uten sak`() {
        val res = lydiaApiContainer.performDelete("$IA_SAK_TEAM_PATH/ikkeetsaksnummer")
            .authentication().bearer(mockOAuth2Server.superbruker1.token)
            .tilSingelRespons<BrukerITeamDto>().second

        res.statusCode shouldBe HttpStatusCode.BadRequest.value
    }

    @Test
    fun `skal ikke kunne fjernes fra team uten å være i teamet`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
        val res = lydiaApiContainer.performDelete("$IA_SAK_TEAM_PATH/${sak.saksnummer}")
            .authentication().bearer(mockOAuth2Server.superbruker1.token)
            .tilSingelRespons<BrukerITeamDto>().second

        res.statusCode shouldBe HttpStatusCode.BadRequest.value
    }

    // MineSakerTester
    private fun IASakDto.sammenlignMedMineSaker(minsak: MineSakerDto) =
        minsak.iaSak.copy(gyldigeNesteHendelser = emptyList()) == this.copy(gyldigeNesteHendelser = emptyList())

    @Test
    fun `skal få alle saker man er eier av`() {
        val bruker = mockOAuth2Server.superbruker1.token
        val sak0 = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK, token = bruker)
        val sak1 = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK, token = bruker)
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK, token = mockOAuth2Server.superbruker2.token)

        val iaSakListe = listOf(sak0, sak1).sortedBy { it.orgnr }

        val res = lydiaApiContainer.performGet(MINE_SAKER_PATH)
            .authentication().bearer(bruker)
            .tilListeRespons<MineSakerDto>().third.fold(
                success = { respons -> respons },
                failure = { fail(it.message) },
            )

        iaSakListe.all { sak ->
            res.any { sak.sammenlignMedMineSaker(it) }
        } shouldBe true
    }

    @Test
    fun `skal få alle saker man følger eller eier`() {
        val bruker = mockOAuth2Server.superbruker1.token
        val sak0 = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK, token = bruker)
        val sak1 = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK, token = bruker)
            .leggTilFolger(token = bruker)
            .leggTilFolger(token = mockOAuth2Server.superbruker2.token)
            .leggTilFolger(token = mockOAuth2Server.saksbehandler1.token)
        val sak2 = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK, token = mockOAuth2Server.superbruker2.token)
            .leggTilFolger(token = bruker)
        val sak3 = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK, token = mockOAuth2Server.superbruker2.token)
            .leggTilFolger(token = bruker)
            .leggTilFolger(token = mockOAuth2Server.superbruker2.token)
            .leggTilFolger(token = mockOAuth2Server.saksbehandler1.token)

        val sak4 = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK, token = mockOAuth2Server.superbruker2.token)

        val iaSakListe = listOf(sak0, sak1, sak2, sak3)

        val res = lydiaApiContainer.performGet(MINE_SAKER_PATH)
            .authentication().bearer(bruker)
            .tilListeRespons<MineSakerDto>().third.fold(
                success = { respons -> respons },
                failure = { fail(it.message) },
            )

        iaSakListe.all { sak ->
            res.any { sak.sammenlignMedMineSaker(it) }
        } shouldBe true

        res.any { sak4.sammenlignMedMineSaker(it) } shouldBe false

        res.map { it.iaSak.saksnummer }.shouldBeUnique()
    }

    @Test
    fun `skal ikke få saker man ikke eier eller følger`() {
        val sak0 = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK, token = mockOAuth2Server.superbruker2.token)
        val sak1 = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK, token = mockOAuth2Server.saksbehandler1.token)
            .leggTilFolger(token = mockOAuth2Server.superbruker2.token)

        opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK, token = mockOAuth2Server.superbruker1.token)

        val res = lydiaApiContainer.performGet(MINE_SAKER_PATH)
            .authentication().bearer(mockOAuth2Server.superbruker1.token)
            .tilListeRespons<MineSakerDto>().third.fold(
                success = { respons -> respons },
                failure = { fail(it.message) },
            )

        res.none {
            sak0.sammenlignMedMineSaker(it) || sak1.sammenlignMedMineSaker(it)
        } shouldBe true
    }
}
