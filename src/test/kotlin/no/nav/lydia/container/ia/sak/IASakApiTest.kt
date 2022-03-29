package no.nav.lydia.container.ia.sak

import com.github.guepardoapps.kulid.ULID
import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.gson.jsonBody
import com.github.kittinunf.fuel.gson.responseObject
import io.kotest.inspectors.forAtLeastOne
import io.kotest.inspectors.shouldForAtLeastOne
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import no.nav.lydia.helper.AuthContainerHelper.Companion.NAV_IDENT
import no.nav.lydia.helper.HttpMock
import no.nav.lydia.helper.IntegrationsHelper
import no.nav.lydia.helper.IntegrationsHelper.Companion.orgnr_bergen
import no.nav.lydia.helper.IntegrationsHelper.Companion.orgnr_oslo
import no.nav.lydia.helper.Melding
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.IASakshendelseDto
import no.nav.lydia.ia.sak.api.IA_SAK_RADGIVER_PATH
import no.nav.lydia.ia.sak.api.SAK_HENDELSE_SUB_PATH
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.SaksHendelsestype
import no.nav.lydia.integrasjoner.brreg.BrregDownloader
import no.nav.lydia.integrasjoner.ssb.NæringsDownloader
import no.nav.lydia.integrasjoner.ssb.NæringsRepository
import no.nav.lydia.sykefraversstatistikk.api.ListResponse
import no.nav.lydia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import no.nav.lydia.sykefraversstatistikk.api.SykefraversstatistikkVirksomhetDto
import no.nav.lydia.virksomhet.VirksomhetRepository
import org.junit.AfterClass
import kotlin.test.Test
import kotlin.test.assertTrue
import kotlin.test.fail

class IASakApiTest {
    val lydiaApiContainer = TestContainerHelper.lydiaApiContainer
    val mockOAuth2Server = TestContainerHelper.oauth2ServerContainer

    companion object {
        val httpMock = HttpMock()

        init {
            httpMock.start()
            postgresContainer.getDataSource().use { dataSource ->
                NæringsDownloader(
                    url = IntegrationsHelper.mockKallMotSsbNæringer(httpMock = httpMock),
                    næringsRepository = NæringsRepository(dataSource = dataSource)
                ).lastNedNæringer()

                BrregDownloader(
                    url = IntegrationsHelper.mockKallMotBrregUnderhenter(httpMock = httpMock),
                    virksomhetRepository = VirksomhetRepository(dataSource = dataSource)
                ).lastNed()
            }

            TestContainerHelper.kafkaContainerHelper.sendSykefraversstatistikkKafkaMelding(Melding.osloGjeldeneKvartal)
            TestContainerHelper.kafkaContainerHelper.sendSykefraversstatistikkKafkaMelding(Melding.bergenGjeldeneKvartal)
        }

        @AfterClass
        @JvmStatic
        fun afterAll() {
            httpMock.stop()
        }
    }


    @Test
    fun `skal kunne prioritere en virksomhet og vise status i listevisning`() {
        postgresContainer.performUpdate("DELETE FROM ia_sak")

        val (_, _, listeResultatFørPrioritering) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<ListResponse<SykefraversstatistikkVirksomhetDto>>()

        listeResultatFørPrioritering.fold(
            success = { response ->
                response.data shouldHaveAtLeastSize 1
                response.data.shouldForAtLeastOne { sykefraversstatistikkVirksomhetDto ->
                    sykefraversstatistikkVirksomhetDto.orgnr shouldBe orgnr_oslo
                    sykefraversstatistikkVirksomhetDto.status shouldBe IAProsessStatus.IKKE_AKTIV
                }
            }, failure = {
                fail(it.message)
            })

        val sak = opprettSakForVirksomhet(orgnummer = orgnr_oslo)
        assertTrue(ULID.isValid(ulid = sak.saksnummer))

        val (_, _, listeResultatEtterPrioritering) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<ListResponse<SykefraversstatistikkVirksomhetDto>>()

        listeResultatEtterPrioritering.fold(
            success = { response ->
                response.data shouldHaveAtLeastSize 1
                response.data.shouldForAtLeastOne { sykefraversstatistikkVirksomhetDto ->
                    sykefraversstatistikkVirksomhetDto.orgnr shouldBe orgnr_oslo
                    sykefraversstatistikkVirksomhetDto.status shouldBe IAProsessStatus.NY
                }
            }, failure = {
                fail(it.message)
            })
    }


    @Test
    fun `skal kunne spore endringene som har skjedd på en sak`() {
        val sak = opprettSakForVirksomhet(orgnummer = orgnr_bergen)

        val iaSaker = hentIASaker(orgnr_bergen)
        iaSaker.forAtLeastOne {
            it.orgnr shouldBe orgnr_bergen
            it.status shouldBe IAProsessStatus.NY
            it.opprettetAv shouldBe NAV_IDENT
            it.saksnummer shouldBe sak.saksnummer
        }

        val prioriteringsHendelseDto = IASakshendelseDto(
            orgnummer = sak.orgnr,
            saksnummer = sak.saksnummer,
            hendelsesType = SaksHendelsestype.VIRKSOMHET_PRIORITERES,
            endretAvHendelsesId = sak.endretAvHendelseId
        )
        val sakEtterPrioritering = nyHendelsePåSak(prioriteringsHendelseDto).also {
            it.orgnr shouldBe orgnr_bergen
            it.saksnummer shouldBe sak.saksnummer
            it.status shouldBe IAProsessStatus.PRIORITERT
            it.opprettetAv shouldBe sak.opprettetAv
            it.endretAvHendelseId shouldNotBe sak.endretAvHendelseId
        }
        val takketNeiHendelseDto = IASakshendelseDto(
            orgnummer = sak.orgnr,
            saksnummer = sak.saksnummer,
            hendelsesType = SaksHendelsestype.VIRKSOMHET_TAKKER_NEI,
            endretAvHendelsesId = sakEtterPrioritering.endretAvHendelseId
        )
        nyHendelsePåSak(takketNeiHendelseDto).also {
            it.orgnr shouldBe orgnr_bergen
            it.saksnummer shouldBe sak.saksnummer
            it.status shouldBe IAProsessStatus.TAKKET_NEI
            it.opprettetAv shouldBe sak.opprettetAv
            it.endretAvHendelseId shouldNotBe sak.endretAvHendelseId
        }
    }

    private fun hentIASaker(orgnummer: String) =
        lydiaApiContainer.performGet("$IA_SAK_RADGIVER_PATH/$orgnummer")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<List<IASakDto>>().third.fold(success = { respons -> respons }, failure = {
                fail(it.message)
            })


    private fun opprettSakForVirksomhet(orgnummer: String) =
        lydiaApiContainer.performPost("$IA_SAK_RADGIVER_PATH/$orgnummer")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<IASakDto>().third.fold(success = { respons -> respons }, failure = {
                fail(it.message)
            })

    private fun nyHendelsePåSak(hendelseDto: IASakshendelseDto) =
        lydiaApiContainer.performPost("$IA_SAK_RADGIVER_PATH/$SAK_HENDELSE_SUB_PATH")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .jsonBody(hendelseDto)
            .responseObject<IASakDto>().third.fold(success = { respons -> respons }, failure = {
                fail(it.message)
            })

}