package no.nav.lydia.container.sykefraversstatistikk

import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.gson.responseObject
import io.kotest.matchers.booleans.shouldBeTrue
import io.kotest.matchers.collections.shouldContainExactly
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.equality.shouldBeEqualToComparingFields
import io.kotest.matchers.ints.shouldBeExactly
import io.kotest.matchers.nulls.shouldNotBeNull
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldStartWith
import no.nav.lydia.helper.HttpMock
import no.nav.lydia.helper.IntegrationsHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestSted
import no.nav.lydia.sykefraversstatistikk.api.FILTERVERDIER_PATH
import no.nav.lydia.sykefraversstatistikk.api.FilterverdierDto
import no.nav.lydia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import no.nav.lydia.sykefraversstatistikk.api.SykefraversstatistikkVirksomhetDto
import no.nav.lydia.sykefraversstatistikk.api.geografi.GeografiService
import no.nav.lydia.virksomhet.VirksomhetRepository
import no.nav.lydia.virksomhet.brreg.BrregDownloader
import no.nav.lydia.virksomhet.ssb.NæringsDownloader
import no.nav.lydia.virksomhet.ssb.NæringsRepository
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test
import kotlin.test.fail

class SykefraversstatistikkApiTest {
    val lydiaApiContainer = TestContainerHelper.lydiaApiContainer
    val mockOAuth2Server = TestContainerHelper.oauth2ServerContainer

    companion object {
        val httpMock = HttpMock()

        @BeforeClass
        @JvmStatic
        fun beforeAll() {
            httpMock.start()

            TestContainerHelper.kafkaContainerHelper.sendSykefraversstatistikkKafkaMelding(TestSted.oslo)
            TestContainerHelper.kafkaContainerHelper.sendSykefraversstatistikkKafkaMelding(TestSted.bergen)

            TestContainerHelper.postgresContainer.getDataSource().use { dataSource ->
                NæringsDownloader(
                    url = IntegrationsHelper.mockKallMotSsbNæringer(httpMock = httpMock),
                    næringsRepository = NæringsRepository(dataSource = dataSource)).lastNedNæringer()

                BrregDownloader(
                    url = IntegrationsHelper.mockKallMotBrregUnderhenter(httpMock = httpMock),
                    virksomhetRepository = VirksomhetRepository(dataSource = dataSource)).lastNed()
            }
        }

        @AfterClass
        @JvmStatic
        fun afterAll() {
            httpMock.stop()
        }
    }


    @Test
    fun `skal kunne hente sykefraværsstatistikk for en enkelt bedrift`() {
        val orgnum = "123456789"
        val (_, _, result) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$orgnum")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<List<SykefraversstatistikkVirksomhetDto>>()

        result.fold(
            success = { sykefraværsstatistikkVirksomhet ->
                sykefraværsstatistikkVirksomhet.size shouldBeExactly 1
                sykefraværsstatistikkVirksomhet[0] shouldBeEqualToComparingFields SykefraversstatistikkVirksomhetDto.dummySvar
            }, failure = {
                fail(it.message)
            })
    }
    @Test
    fun `skal kunne sortere sykefraværsstatistikk på valgfri nøkkel`() {
        val forventedeTapteDagsverk = listOf(20.0, 10.0)

        val sorteringsnøkkel = "tapte_dagsverk"

        val (_, _, result1) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/?sorteringsnokkel=$sorteringsnøkkel&sorteringsretning=desc")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<List<SykefraversstatistikkVirksomhetDto>>()

        result1.fold(
            success = { sykefraværsstatistikkVirksomhet ->
                sykefraværsstatistikkVirksomhet.size shouldBeExactly 2
                sykefraværsstatistikkVirksomhet.map { it.tapteDagsverk } shouldBe forventedeTapteDagsverk
            }, failure = {
                fail(it.message)
            })

        val (_, _, result2) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/?sorteringsnokkel=$sorteringsnøkkel&sorteringsretning=asc")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<List<SykefraversstatistikkVirksomhetDto>>()

        result2.fold(
            success = { sykefraværsstatistikkVirksomhet ->
                sykefraværsstatistikkVirksomhet.size shouldBeExactly 2
                sykefraværsstatistikkVirksomhet.map { it.tapteDagsverk } shouldBe forventedeTapteDagsverk.reversed()
            }, failure = {
                fail(it.message)
            })
    }

    @Test
    fun `frontend skal kunne hente filterverdier til prioriteringssiden`() {
        val (_, _, result) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$FILTERVERDIER_PATH")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<FilterverdierDto>()

        result.fold(
            success = { filterverdier ->
                filterverdier.fylker[0].fylke.navn shouldBe "Oslo"
                filterverdier.fylker[0].fylke.nummer shouldBe "03"
                filterverdier.fylker[0].kommuner.size shouldBe 1
                filterverdier.næringsgrupper.find { it.kode == "00.000" }.shouldNotBeNull() // Vi forventer en næringsgruppe av verdien Uoppgitt med kode 00.000
                filterverdier.næringsgrupper.size shouldBe 4
                filterverdier.næringsgrupper.all { næringsgruppe -> næringsgruppe.kode.length == 6 }.shouldBeTrue()
            }, failure = {
                fail(it.message)
            })
    }

    @Test
    fun `uautorisert kall mot sykefraværendepunktet skal returnere 401`() {
        val request = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$FILTERVERDIER_PATH")
        val (_, response, _) = request.responseString()

        response.statusCode shouldBe 401
    }

    @Test
    fun `skal kunne hente alle virksomheter i Bergen kommune`() {
        val kommunenummer = "4601" // Brønnøy kommune i Bergen
        val (_, _, result) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/?kommuner=$kommunenummer")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<List<SykefraversstatistikkVirksomhetDto>>()

        result.fold(
            success = { respons ->
                respons.size shouldBe 1
                val testVirksomhet = respons.first()
                testVirksomhet.orgnr shouldBe "995858266"
                testVirksomhet.kommune.navn shouldBe "BERGEN"
                testVirksomhet.kommune.nummer shouldBe kommunenummer
            }, failure = {
                fail(it.message)
            })
    }

    @Test
    fun `skal kunne hente alle virksomheter i Vestland fylke`() {
        val fylkesnummer = "46"
        val (_, _, result) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/?fylker=$fylkesnummer")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<List<SykefraversstatistikkVirksomhetDto>>()

        result.fold(
            success = { apiResponse ->
                val testVirksomhet = apiResponse.first()
                testVirksomhet.orgnr shouldBe "995858266"
                testVirksomhet.kommune.navn shouldBe "BERGEN"
                testVirksomhet.kommune.nummer shouldStartWith fylkesnummer
            }, failure = {
                fail(it.message)
            })
    }

    @Test
    fun `skal kunne hente alle virksomheter i et gitt fylke og en gitt kommune`() {
        val fylkesnummer = "46" // Vestland fylke
        val kommunenummer = "0301" // Oslo kommune
        val result =
            lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/?fylker=$fylkesnummer&kommuner=$kommunenummer")
                .authentication().bearer(mockOAuth2Server.lydiaApiToken)
                .responseObject<List<SykefraversstatistikkVirksomhetDto>>().third

        result.fold(
            success = { sykefravær ->
                sykefravær.map { it.orgnr } shouldContainExactly listOf(
                    "995858266",
                    "987654321"
                )
            }, failure = {
                fail(it.message)
            })
    }

    @Test
    fun `skal kunne hente alle virksomheter`() {
        val (_, _, result) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<List<SykefraversstatistikkVirksomhetDto>>()

        result.fold(
            success = { respons ->
                respons shouldHaveAtLeastSize 1
            }, failure = {
                fail(it.message)
            })
    }

    @Test
    fun `skal kunne hente virksomheter basert på næringskode`() {
        val næringskode = "70.220"
        val (_, _, result) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/?neringsgrupper=${næringskode}")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<List<SykefraversstatistikkVirksomhetDto>>()

        result.fold(
            success = { statistikk ->
                statistikk shouldHaveSize 1
            }, failure = {
                fail(it.message)
            })
    }

    @Test
    fun `kan hente kommuner basert på fylkesnummer`() {
        val fylkesnummer = listOf("46", "03") // Vestland og Oslo fylke
        val geografiService = GeografiService()
        val kommuner = geografiService.hentKommunerFraFylkesnummer(fylkesnummer)
        kommuner shouldHaveSize 44
    }
}