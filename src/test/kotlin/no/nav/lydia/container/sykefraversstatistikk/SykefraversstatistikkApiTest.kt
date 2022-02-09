package no.nav.lydia.container.sykefraversstatistikk

import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.gson.responseObject
import com.github.tomakehurst.wiremock.client.WireMock
import com.github.tomakehurst.wiremock.common.Gzip
import com.google.common.net.HttpHeaders
import io.kotest.matchers.collections.shouldContainExactly
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.equality.shouldBeEqualToComparingFields
import io.kotest.matchers.ints.shouldBeExactly
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldStartWith
import no.nav.lydia.helper.DbTestHelper
import no.nav.lydia.helper.HttpMock
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.sykefraversstatistikk.api.FILTERVERDIER_PATH
import no.nav.lydia.sykefraversstatistikk.api.FilterverdierDto
import no.nav.lydia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import no.nav.lydia.sykefraversstatistikk.api.SykefraversstatistikkVirksomhetDto
import no.nav.lydia.sykefraversstatistikk.api.geografi.GeografiService
import no.nav.lydia.virksomhet.VirksomhetRepository
import no.nav.lydia.virksomhet.VirksomheterDto
import no.nav.lydia.virksomhet.brreg.BrregDownloader
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
            val postgres = TestContainerHelper.postgresContainer
            val dataSource = DbTestHelper.getDataSource(postgresContainer = postgres).apply {
                DbTestHelper.cleanMigrate(this)
            }
            val virksomhetRepository = VirksomhetRepository(dataSource)
            val brregMockUrl = mockKallMotBrregUnderhenter()
            BrregDownloader(url = brregMockUrl, virksomhetRepository = virksomhetRepository).lastNed()

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
    fun `frontend skal kunne hente filterverdier til prioriteringssiden`() {
        val (_, _, result) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$FILTERVERDIER_PATH")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<FilterverdierDto>()

        result.fold(
            success = { filterverdier ->
                filterverdier.fylker[0].fylke.navn shouldBe "Oslo"
                filterverdier.fylker[0].fylke.nummer shouldBe "03"
                filterverdier.fylker[0].kommuner.size shouldBe 1
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
        val kommunenummer = "4601"
        val (_, _, result) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/?kommuner=$kommunenummer")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<VirksomheterDto>()

        result.fold(
            success = { respons ->
                val testVirksomhet = respons.virksomheter.first()
                testVirksomhet.organisasjonsnummer shouldBe "995858266"
                testVirksomhet.beliggenhetsadresse.kommune shouldBe "BERGEN"
                testVirksomhet.beliggenhetsadresse.kommunenummer shouldBe kommunenummer
            }, failure = {
                fail(it.message)
            })
    }

    @Test
    fun `skal kunne hente alle virksomheter i Vestland fylke`(){
        val fylkesnummer = "46"
        val (_, _, result) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/?fylker=$fylkesnummer")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<VirksomheterDto>()

        result.fold(
            success = { apiResponse ->
                val testVirksomhet = apiResponse.virksomheter.first()
                testVirksomhet.organisasjonsnummer shouldBe "995858266"
                testVirksomhet.beliggenhetsadresse.kommune shouldBe "BERGEN"
                testVirksomhet.beliggenhetsadresse.kommunenummer shouldStartWith fylkesnummer
            }, failure = {
                fail(it.message)
            })
    }

    @Test
    fun `skal kunne hente alle virksomheter i et gitt fylke og en gitt kommune`(){
        val fylkesnummer = "46"
        val kommunenummer = "0301"
        val (_, _, result) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/?fylker=$fylkesnummer&kommuner=$kommunenummer")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<VirksomheterDto>()

        result.fold(
            success = { respons ->
                val testVirsomheter = respons.virksomheter
                testVirsomheter.map { it.organisasjonsnummer } shouldContainExactly listOf("995858266", "825001662")
            }, failure = {
                fail(it.message)
            })
    }

    @Test
    fun `skal kunne hente alle virksomheter`(){
        val (_, _, result) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<VirksomheterDto>()

        result.fold(
            success = { respons ->
                respons.virksomheter shouldHaveAtLeastSize 1
            }, failure = {
                fail(it.message)
            })
    }

    @Test
    fun `kan hente kommuner basert på fylkesnummer`(){
        val fylkesnummer = listOf("46", "03") // Vestland og Oslo
        val geografiService = GeografiService()
        val kommuner = geografiService.hentKommunerFraFylkesnummer(fylkesnummer)
        kommuner shouldHaveSize 44
    }
}

fun mockKallMotBrregUnderhenter() : String {

    val lastNedPath = "/brregmock/enhetsregisteret/api/underenheter/lastned"
    val brregMockUrl = SykefraversstatistikkApiTest.httpMock.url(lastNedPath)

    val underEnheter =
        """
          [
            {
              "organisasjonsnummer" : "995858266",
              "navn" : ":-) PROSJEKTER",
              "organisasjonsform" : {
                "kode" : "BEDR",
                "beskrivelse" : "Bedrift",
                "links" : [ ]
              },
              "registreringsdatoEnhetsregisteret" : "2010-08-25",
              "registrertIMvaregisteret" : false,
              "naeringskode1" : {
                "beskrivelse" : "Bedriftsrådgivning og annen administrativ rådgivning",
                "kode" : "70.220"
              },
              "antallAnsatte" : 1,
              "overordnetEnhet" : "995849364",
              "oppstartsdato" : "2010-07-01",
              "beliggenhetsadresse" : {
                "land" : "Norge",
                "landkode" : "NO",
                "postnummer" : "5034",
                "poststed" : "BERGEN",
                "adresse" : [ "Skanselien 37" ],
                "kommune" : "BERGEN",
                "kommunenummer" : "4601"
              },
              "links" : [ ]
            },
            {
              "organisasjonsnummer" : "825001662",
              "navn" : "1012 PROJECT AISTE CESNAUSKAITE",
              "organisasjonsform" : {
                "kode" : "BEDR",
                "beskrivelse" : "Underenhet til næringsdrivende og offentlig forvaltning",
                "links" : [ ]
              },
              "registreringsdatoEnhetsregisteret" : "2020-04-28",
              "registrertIMvaregisteret" : false,
              "naeringskode1" : {
                "beskrivelse" : "Utøvende kunstnere og underholdningsvirksomhet innen scenekunst",
                "kode" : "90.012"
              },
              "antallAnsatte" : 0,
              "overordnetEnhet" : "924965304",
              "oppstartsdato" : "2020-04-22",
              "beliggenhetsadresse" : {
                "land" : "Norge",
                "landkode" : "NO",
                "postnummer" : "0364",
                "poststed" : "OSLO",
                "adresse" : [ "Trudvangveien 5C" ],
                "kommune" : "OSLO",
                "kommunenummer" : "0301"
              },
              "links" : [ ]
            }                  
          ]
        """.trimIndent()

    SykefraversstatistikkApiTest.httpMock.wireMockServer.stubFor(
        WireMock.get(WireMock.urlPathEqualTo(lastNedPath))
            .willReturn(
                WireMock.ok()
                    .withHeader(HttpHeaders.CONTENT_TYPE, BrregDownloader.underEnhetApplicationType)
                    .withBody(Gzip.gzip(underEnheter))
            )
    )
    return brregMockUrl
}