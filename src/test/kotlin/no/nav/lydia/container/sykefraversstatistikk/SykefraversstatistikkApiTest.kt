package no.nav.lydia.container.sykefraversstatistikk

import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.gson.responseObject
import com.github.tomakehurst.wiremock.client.WireMock
import com.github.tomakehurst.wiremock.common.Gzip
import com.google.common.net.HttpHeaders
import io.kotest.matchers.equality.shouldBeEqualToComparingFields
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.DbTestHelper
import no.nav.lydia.helper.HttpMock
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.runMigration
import no.nav.lydia.sykefraversstatistikk.api.FILTERVERDIER_PATH
import no.nav.lydia.sykefraversstatistikk.api.FilterverdierDto
import no.nav.lydia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import no.nav.lydia.sykefraversstatistikk.api.SykefraversstatistikkVirksomhetDto
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
        }

        @AfterClass
        @JvmStatic
        fun afterAll() {
            httpMock.stop()
        }
    }

    @Test
    fun `Skal kunne hente sykefraværsstatistikk for en enkelt bedrift`() {
        val orgnum = "123456789"
        val (_, _, result) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$orgnum")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<SykefraversstatistikkVirksomhetDto>()

        result.fold(
            success = { sykefraværsstatistikkVirksomhet ->
                sykefraværsstatistikkVirksomhet shouldBeEqualToComparingFields SykefraversstatistikkVirksomhetDto.dummySvar
            }, failure = {
                fail(it.message)
            })
    }

    @Test
    fun `Uautorisert kall mot sykefraværsstatistikkVirksomhet-endepunktet skal returnere 401`() {
        val request = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$FILTERVERDIER_PATH")
        val (_, response, _) = request.responseString()

        response.statusCode shouldBe 401
    }

    @Test
    fun `Frontend skal kunne hente filterverdier til prioriteringssiden`() {
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
    fun `Uautorisert kall mot filterverdi-endepunktet skal returnere 401`() {
        val request = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$FILTERVERDIER_PATH")
        val (_, response, _) = request.responseString()

        response.statusCode shouldBe 401
    }

    @Test
    fun `Skal kunne hente alle virksomheter i Bergen kommune`() {
        val postgres = TestContainerHelper.postgresContainer
        val dataSource = DbTestHelper.getDataSource(postgresContainer = postgres).apply {
            runMigration(this)
        }
        val virksomhetRepository = VirksomhetRepository(dataSource)
        val lastNedPath = "/brregmock/enhetsregisteret/api/underenheter/lastned"
        val brregMockUrl = httpMock.url(lastNedPath)

        val underEnheter =
            """
          [{
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
        }]
        """.trimIndent()

        httpMock.wireMockServer.stubFor(
            WireMock.get(WireMock.urlPathEqualTo(lastNedPath))
                .willReturn(
                    WireMock.ok()
                        .withHeader(HttpHeaders.CONTENT_TYPE, BrregDownloader.underEnhetApplicationType)
                        .withBody(Gzip.gzip(underEnheter))
                )
        )

        BrregDownloader(url = brregMockUrl, virksomhetRepository = virksomhetRepository).lastNed()

        val (_, _, result) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/?kommuner=4601")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<VirksomheterDto>()

        result.fold(
            success = { respons ->
                respons.virksomheter.first().beliggenhetsadresse.kommune shouldBe "BERGEN"
            }, failure = {
                fail(it.message)
            })
    }
}