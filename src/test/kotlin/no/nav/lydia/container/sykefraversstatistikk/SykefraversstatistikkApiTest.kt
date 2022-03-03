package no.nav.lydia.container.sykefraversstatistikk

import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.gson.responseObject
import io.kotest.inspectors.forAll
import io.kotest.matchers.booleans.shouldBeTrue
import io.kotest.matchers.collections.*
import io.kotest.matchers.equality.shouldBeEqualToComparingFields
import io.kotest.matchers.ints.shouldBeExactly
import io.kotest.matchers.ints.shouldBeGreaterThan
import io.kotest.matchers.nulls.shouldNotBeNull
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldStartWith
import no.nav.lydia.helper.*
import no.nav.lydia.helper.IntegrationsHelper.Companion.næringskodeBedriftsrådgivning
import no.nav.lydia.helper.IntegrationsHelper.Companion.næringskodeScenekunst
import no.nav.lydia.helper.IntegrationsHelper.Companion.orgnr_CESNAUSKAITE_oslo
import no.nav.lydia.helper.IntegrationsHelper.Companion.orgnr_smileyprosjekter_bergen
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.sykefraversstatistikk.api.*
import no.nav.lydia.sykefraversstatistikk.api.geografi.GeografiService
import no.nav.lydia.virksomhet.VirksomhetRepository
import no.nav.lydia.virksomhet.brreg.BrregDownloader
import no.nav.lydia.virksomhet.ssb.NæringsDownloader
import no.nav.lydia.virksomhet.ssb.NæringsRepository
import org.junit.AfterClass
import kotlin.test.Test
import kotlin.test.fail

class SykefraversstatistikkApiTest {
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
        val sorteringsnøkkel = "tapte_dagsverk"

        val (_, _, result1) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/?sorteringsnokkel=$sorteringsnøkkel&sorteringsretning=desc")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<List<SykefraversstatistikkVirksomhetDto>>()

        result1.fold(
            success = { sykefraværsstatistikkVirksomhet ->
                val tapteDagsverk = sykefraværsstatistikkVirksomhet.map { it.tapteDagsverk }
                tapteDagsverk shouldContainInOrder tapteDagsverk.sortedDescending()
            }, failure = {
                fail(it.message)
            })

        val (_, _, result2) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/?sorteringsnokkel=$sorteringsnøkkel&sorteringsretning=asc")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<List<SykefraversstatistikkVirksomhetDto>>()

        result2.fold(
            success = { sykefraværsstatistikkVirksomhet ->
                val tapteDagsverk = sykefraværsstatistikkVirksomhet.map { it.tapteDagsverk }
                tapteDagsverk shouldContainInOrder tapteDagsverk.sorted()
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
                testVirksomhet.orgnr shouldBe orgnr_smileyprosjekter_bergen
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
                testVirksomhet.orgnr shouldBe orgnr_smileyprosjekter_bergen
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
                sykefravær.map { it.orgnr }.toSet() shouldContainAll setOf(
                    orgnr_smileyprosjekter_bergen,
                    orgnr_CESNAUSKAITE_oslo
                )
                sykefravær.map { it.kommune.nummer.substring(0..1) }.toSet() shouldBe setOf("46", "03")
            }, failure = {
                fail(it.message)
            })
    }

    @Test
    fun `skal kunne hente alle virksomheter i en gitt næring`() {
        val result =
            lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/?neringsgrupper=$næringskodeScenekunst")
                .authentication().bearer(mockOAuth2Server.lydiaApiToken)
                .responseObject<List<SykefraversstatistikkVirksomhetDto>>().third

        result.fold(
            success = { sykefravær ->
                sykefravær.map { it.orgnr } shouldContainExactly listOf(
                    orgnr_smileyprosjekter_bergen,
                    orgnr_CESNAUSKAITE_oslo
                )
            }, failure = {
                fail(it.message)
            })
    }
    @Test
    fun `tomme søkeparametre skal ikke filtrere på noen parametre`() {
        val resultatMedTommeParametre =
            lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/?neringsgrupper=&fylker=&kommuner=")
                .authentication().bearer(mockOAuth2Server.lydiaApiToken)
                .responseObject<List<SykefraversstatistikkVirksomhetDto>>().third


        val resultatUtenParametre =
            lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/")
                .authentication().bearer(mockOAuth2Server.lydiaApiToken)
                .responseObject<List<SykefraversstatistikkVirksomhetDto>>().third

        resultatMedTommeParametre.get() shouldContainAll resultatUtenParametre.get()
    }

    @Test
    fun `skal kunne hente virksomheter filtrert på kommune og næring`() {
        val oslo = "0301"
        val nordreFollo = "3020"
        val result =
            lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/?kommuner=$oslo,$nordreFollo&neringsgrupper=$næringskodeScenekunst,$næringskodeBedriftsrådgivning")
                .authentication().bearer(mockOAuth2Server.lydiaApiToken)
                .responseObject<List<SykefraversstatistikkVirksomhetDto>>().third

        result.fold(
            success = { sykefravær ->
                sykefravær.map { it.orgnr } shouldContainExactly listOf(
                    orgnr_CESNAUSKAITE_oslo
                )
            }, failure = {
                fail(it.message)
            })
    }

    @Test
    fun `skal kunne hente virksomheter for et bestemt år og kvartal`() {
        val forrigePeriode = Periode.forrigePeriode()
        TestContainerHelper.kafkaContainerHelper.sendSykefraversstatistikkKafkaMelding(Melding.osloGjeldeneKvartal)
        TestContainerHelper.kafkaContainerHelper.sendSykefraversstatistikkKafkaMelding(Melding.osloForrigeKvartal)
        lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/?arstall=${forrigePeriode.årstall}&kvartal=${forrigePeriode.kvartal}")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<List<SykefraversstatistikkVirksomhetDto>>().third
            .fold(success = { statistikk ->
                statistikk.size shouldBeGreaterThan 0
                statistikk.forAll {
                    it.kvartal shouldBe forrigePeriode.kvartal
                    it.arstall shouldBe forrigePeriode.årstall
                }
                }, failure = {
                    fail(it.message)
                }
            )
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
    fun `kan hente kommuner basert på fylkesnummer`() {
        val fylkesnummer = listOf("46", "03") // Vestland og Oslo fylke
        val geografiService = GeografiService()
        val kommuner = geografiService.hentKommunerFraFylkesnummer(fylkesnummer)
        kommuner shouldHaveSize 44
    }
}