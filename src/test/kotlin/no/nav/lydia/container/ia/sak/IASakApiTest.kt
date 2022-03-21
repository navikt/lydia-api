package no.nav.lydia.container.ia.sak

import com.github.guepardoapps.kulid.ULID
import com.github.kittinunf.fuel.core.FuelError
import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.gson.jsonBody
import com.github.kittinunf.fuel.gson.responseObject
import io.kotest.inspectors.shouldForAll
import io.kotest.inspectors.shouldForAtLeastOne
import io.kotest.matchers.collections.*
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.HttpMock
import no.nav.lydia.helper.IntegrationsHelper
import no.nav.lydia.helper.IntegrationsHelper.Companion.orgnr_bergen
import no.nav.lydia.helper.IntegrationsHelper.Companion.orgnr_oslo
import no.nav.lydia.helper.Melding
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
import no.nav.lydia.ia.sak.api.IASakshendelseDto
import no.nav.lydia.ia.sak.api.IA_SAK_RADGIVER_PATH
import no.nav.lydia.ia.sak.api.SAK_HENDELSE_SUB_PATH
import no.nav.lydia.ia.sak.domene.IAProsessStatus.IKKE_AKTIV
import no.nav.lydia.ia.sak.domene.IAProsessStatus.PRIORITERT
import no.nav.lydia.ia.sak.domene.SaksHendelsestype.VIRKSOMHET_PRIORITERES
import no.nav.lydia.sykefraversstatistikk.api.*
import no.nav.lydia.virksomhet.VirksomhetRepository
import no.nav.lydia.virksomhet.brreg.BrregDownloader
import no.nav.lydia.virksomhet.ssb.NæringsDownloader
import no.nav.lydia.virksomhet.ssb.NæringsRepository
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
            TestContainerHelper.postgresContainer.getDataSource().use { dataSource ->
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
        val (_, _, listeResultatFørPrioritering) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<List<SykefraversstatistikkVirksomhetDto>>()

        listeResultatFørPrioritering.fold(
            success = { respons ->
                respons shouldHaveAtLeastSize 1
                respons.shouldForAtLeastOne { sykefraversstatistikkVirksomhetDto ->
                    sykefraversstatistikkVirksomhetDto.orgnr shouldBe orgnr_oslo
                    sykefraversstatistikkVirksomhetDto.status shouldBe IKKE_AKTIV
                }
            }, failure = {
                fail(it.message)
            })

        val saksnummer = prioriterVirksomhet(orgnummer = orgnr_oslo)
        assertTrue(ULID.isValid(ulid = saksnummer))

        val (_, _, listeResultatEtterPrioritering) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<List<SykefraversstatistikkVirksomhetDto>>()

        listeResultatEtterPrioritering.fold(
            success = { respons ->
                respons shouldHaveAtLeastSize 1
                respons.shouldForAtLeastOne { sykefraversstatistikkVirksomhetDto ->
                    sykefraversstatistikkVirksomhetDto.orgnr shouldBe orgnr_oslo
                    sykefraversstatistikkVirksomhetDto.status shouldBe PRIORITERT
                }
            }, failure = {
                fail(it.message)
            })
    }


    @Test
    fun `skal kunne spore endringene som har skjedd på en sak`() {
        val saksnummer = prioriterVirksomhet(orgnummer = orgnr_bergen)
        postgresContainer
            .performQuery("select * from ia_sak_hendelse where saksnummer = '$saksnummer'")
            .row shouldBe 1
    }

    private fun prioriterVirksomhet(orgnummer : String) = lydiaApiContainer.performPost("$IA_SAK_RADGIVER_PATH/$SAK_HENDELSE_SUB_PATH")
        .authentication().bearer(mockOAuth2Server.lydiaApiToken)
        .jsonBody(
            IASakshendelseDto(
                orgnummer = orgnummer,
                hendelsesType = VIRKSOMHET_PRIORITERES.name
            )
        )
        .responseObject<String>().third.fold( success = { respons -> respons }, failure = {
            fail(it.message)
        })
}