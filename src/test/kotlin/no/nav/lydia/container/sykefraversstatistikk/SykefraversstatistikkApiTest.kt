package no.nav.lydia.container.sykefraversstatistikk

import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.gson.jsonBody
import com.github.kittinunf.fuel.gson.responseObject
import io.kotest.inspectors.forAll
import io.kotest.inspectors.forAtLeastOne
import io.kotest.matchers.booleans.shouldBeTrue
import io.kotest.matchers.collections.*
import io.kotest.matchers.doubles.shouldBeGreaterThanOrEqual
import io.kotest.matchers.doubles.shouldBeLessThanOrEqual
import io.kotest.matchers.nulls.shouldNotBeNull
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldStartWith
import no.nav.lydia.helper.HttpMock
import no.nav.lydia.helper.IntegrationsHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
import no.nav.lydia.helper.TestData
import no.nav.lydia.helper.TestVirksomhet.Companion.BEDRIFTSRÅDGIVNING
import no.nav.lydia.helper.TestVirksomhet.Companion.BERGEN
import no.nav.lydia.helper.TestVirksomhet.Companion.OSLO
import no.nav.lydia.helper.TestVirksomhet.Companion.SCENEKUNST
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.IASakshendelseDto
import no.nav.lydia.ia.sak.api.IA_SAK_RADGIVER_PATH
import no.nav.lydia.ia.sak.api.SAK_HENDELSE_SUB_PATH
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.SaksHendelsestype
import no.nav.lydia.integrasjoner.brreg.BrregDownloader
import no.nav.lydia.integrasjoner.ssb.NæringsDownloader
import no.nav.lydia.integrasjoner.ssb.NæringsRepository
import no.nav.lydia.sykefraversstatistikk.api.*
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.FYLKER
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.IA_STATUS
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.KOMMUNER
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.KVARTAL
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.NÆRINGSGRUPPER
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.SIDE
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.SORTERINGSNØKKEL
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.SORTERINGSRETNING
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.SYKEFRAVÆRSPROSENT_FRA
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.SYKEFRAVÆRSPROSENT_TIL
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.ÅRSTALL
import no.nav.lydia.sykefraversstatistikk.api.geografi.GeografiService
import no.nav.lydia.virksomhet.VirksomhetRepository
import kotlin.test.Test
import kotlin.test.fail

class SykefraversstatistikkApiTest {
    private val lydiaApiContainer = TestContainerHelper.lydiaApiContainer
    private val mockOAuth2Server = TestContainerHelper.oauth2ServerContainer

    companion object {
        init {
            val testData = TestData(initsialiserStandardVirksomheter = true)
            HttpMock().also { httpMock ->
                httpMock.start()
                postgresContainer.getDataSource().use { dataSource ->
                    NæringsDownloader(
                        url = IntegrationsHelper.mockKallMotSsbNæringer(httpMock = httpMock, testData = testData),
                        næringsRepository = NæringsRepository(dataSource = dataSource)
                    ).lastNedNæringer()

                    BrregDownloader(
                        url = IntegrationsHelper.mockKallMotBrregUnderhenter(httpMock = httpMock, testData = testData),
                        virksomhetRepository = VirksomhetRepository(dataSource = dataSource)
                    ).lastNed()
                }
                httpMock.stop()
            }

            testData.sykefraværsStatistikkMeldinger().forEach { melding ->
                kafkaContainerHelper.sendSykefraversstatistikkKafkaMelding(melding)
            }
        }
    }


    @Test
    fun `skal kunne hente sykefraværsstatistikk for en enkelt bedrift`() {
        val orgnr = BERGEN.orgnr
        val (_, _, result) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$orgnr")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<List<SykefraversstatistikkVirksomhetDto>>()

        result.fold(
            success = { sykefraværsstatistikkVirksomhet ->
                sykefraværsstatistikkVirksomhet.forAll {
                    it.orgnr shouldBe orgnr
                    it.kvartal shouldBeOneOf listOf(1, 2, 3, 4)
                    it.kommune.navn shouldBe BERGEN.beliggenhet?.kommune
                }
            }, failure = { fail(it.message) })
    }

    @Test
    fun `skal kunne sortere sykefraværsstatistikk på valgfri nøkkel`() {
        val sorteringsnøkkel = "tapte_dagsverk"

        hentSykefravær(sorteringsnokkel = sorteringsnøkkel, sorteringsretning = "desc", success = { response ->
            val tapteDagsverk = response.data.map { it.tapteDagsverk }
            tapteDagsverk shouldContainInOrder tapteDagsverk.sortedDescending()
        })

        hentSykefravær(sorteringsnokkel = sorteringsnøkkel, sorteringsretning = "asc", success = { response ->
            val tapteDagsverk = response.data.map { it.tapteDagsverk }
            tapteDagsverk shouldContainInOrder tapteDagsverk.sorted()
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
                filterverdier.neringsgrupper.find { it.kode == "00.000" }
                    .shouldNotBeNull() // Vi forventer en næringsgruppe av verdien Uoppgitt med kode 00.000
                filterverdier.neringsgrupper.size shouldBe 3
                filterverdier.neringsgrupper.all { næringsgruppe -> næringsgruppe.kode.length == 6 }.shouldBeTrue()
                filterverdier.statuser shouldBe IAProsessStatus.filtrerbareStatuser()
            }, failure = { fail(it.message) })
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
        val virksomhet = BERGEN
        hentSykefravær(kommuner = kommunenummer, success = { response ->
            response.data shouldHaveSize 1
            response.data.forAtLeastOne { testVirksomhet ->
                testVirksomhet.virksomhetsnavn shouldBe virksomhet.navn
                testVirksomhet.orgnr shouldBe virksomhet.orgnr
                testVirksomhet.kommune.navn shouldBe virksomhet.beliggenhet?.kommune
                testVirksomhet.kommune.nummer shouldBe virksomhet.beliggenhet?.kommunenummer
            }
        })
    }

    @Test
    fun `skal kunne hente alle virksomheter i Vestland fylke`() {
        val fylkesnummer = "46"

        hentSykefravær(fylker = fylkesnummer, success = { response ->
            response.data shouldHaveAtLeastSize 1
            response.data.forAll { testVirksomhet ->
                testVirksomhet.kommune.navn shouldBe BERGEN.beliggenhet?.kommune
                testVirksomhet.kommune.nummer shouldStartWith fylkesnummer
            }
        })
    }

    @Test
    fun `skal kunne hente alle virksomheter i et gitt fylke og en gitt kommune`() {
        val fylkesnummer = "46" // Vestland fylke
        val kommunenummer = "0301" // Oslo kommune

        hentSykefravær(fylker = fylkesnummer, kommuner = kommunenummer, success = { response ->
            response.data.map { it.orgnr }.toSet() shouldContainAll setOf(
                BERGEN.orgnr,
                OSLO.orgnr
            )
            response.data.map { it.kommune.nummer.substring(0..1) }.toSet() shouldBe setOf("46", "03")
        })
    }

    @Test
    fun `skal kunne hente alle virksomheter i en gitt næring`() {
        hentSykefravær(næringsgrupper = SCENEKUNST.kode, success = { response ->
            response.data.map { it.orgnr } shouldContainExactly listOf(
                BERGEN.orgnr,
                OSLO.orgnr
            )
        })
    }

    @Test
    fun `tomme søkeparametre skal ikke filtrere på noen parametre`() {
        val resultatMedTommeParametre =
            lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/?neringsgrupper=&fylker=&kommuner=")
                .authentication().bearer(mockOAuth2Server.lydiaApiToken)
                .responseObject<ListResponse<SykefraversstatistikkVirksomhetDto>>().third


        val resultatUtenParametre =
            lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/")
                .authentication().bearer(mockOAuth2Server.lydiaApiToken)
                .responseObject<ListResponse<SykefraversstatistikkVirksomhetDto>>().third

        resultatMedTommeParametre.get().data shouldContainAll resultatUtenParametre.get().data
    }

    @Test
    fun `skal kunne hente virksomheter filtrert på kommune og næring`() {
        val oslo = "0301"
        val nordreFollo = "3020"

        hentSykefravær(
            kommuner = "$oslo,$nordreFollo",
            næringsgrupper = "${SCENEKUNST.kode},${BEDRIFTSRÅDGIVNING.kode}",
            success = { response ->
                response.data.map { it.orgnr } shouldContainExactly listOf(OSLO.orgnr)
            })
    }

    @Test
    fun `skal bare få statistikk for siste periode hvis periode er uspesifisert`() {
        val gjeldendePeriode = Periode.gjeldenePeriode()
        hentSykefravær(success = { response ->
            response.data shouldHaveAtLeastSize 1
            response.data.forAll {
                it.kvartal shouldBe gjeldendePeriode.kvartal
                it.arstall shouldBe gjeldendePeriode.årstall
            }
        })
    }

    @Test
    fun `skal kunne hente virksomheter for et bestemt år og kvartal`() {
        val forrigePeriode = Periode.forrigePeriode()
        hentSykefravær(
            årstall = forrigePeriode.årstall.toString(),
            kvartal = forrigePeriode.kvartal.toString(),
            success = { response ->
                response.data shouldHaveAtLeastSize 1
                response.data.forAll {
                    it.kvartal shouldBe forrigePeriode.kvartal
                    it.arstall shouldBe forrigePeriode.årstall
                }
            })
    }

    @Test
    fun `skal kunne hente alle virksomheter`() {
        hentSykefravær(success = { response ->
            response.data shouldHaveAtLeastSize 1
        })
    }

    @Test
    fun `kan hente kommuner basert på fylkesnummer`() {
        val fylkesnummer = listOf("46", "03") // Vestland og Oslo fylke
        val geografiService = GeografiService()
        val kommuner = geografiService.hentKommunerFraFylkesnummer(fylkesnummer)
        kommuner shouldHaveSize 44
    }

    @Test
    fun `skal kunne filtrere virksomheter på status`() {
        postgresContainer.performUpdate("DELETE FROM ia_sak")

        hentSykefravær(iaStatus = IAProsessStatus.PRIORITERT.name, success = { response ->
            response.data shouldHaveSize 0
        })

        val orgnummer = OSLO.orgnr
        val sak = lydiaApiContainer.performPost("$IA_SAK_RADGIVER_PATH/$orgnummer")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<IASakDto>().third.fold(success = { respons -> respons }, failure = { fail(it.message) })

        lydiaApiContainer.performPost("$IA_SAK_RADGIVER_PATH/$SAK_HENDELSE_SUB_PATH")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .jsonBody(
                IASakshendelseDto(
                    orgnummer = orgnummer,
                    saksnummer = sak.saksnummer,
                    hendelsesType = SaksHendelsestype.VIRKSOMHET_PRIORITERES,
                    endretAvHendelsesId = sak.endretAvHendelseId
                )
            )
            .responseObject<IASakDto>().third.fold(success = { respons -> respons }, failure = { fail(it.message) })

        hentSykefravær(iaStatus = IAProsessStatus.PRIORITERT.name, success = { response ->
            response.data shouldHaveSize 1
        })

        hentSykefravær(iaStatus = IAProsessStatus.IKKE_AKTIV.name, success = { response ->
            response.data shouldHaveSize 1
        })
    }

    @Test
    fun `skal kunne paginere på ett statistikkresultat`() {


        hentSykefravær(side = "1", success = { response ->

        })
    }

    @Test
    fun `skal kunne filtrere virksomheter basert på sykefraværsprosent`() {
        hentSykefravær(sykefraværsprosentFra = "3.0", success = { response ->
            response.data shouldHaveAtLeastSize 1
            response.data.forAll { sykefraversstatistikkVirksomhetDto ->
                sykefraversstatistikkVirksomhetDto.sykefraversprosent shouldBeGreaterThanOrEqual 3.0
            }
        })

        hentSykefravær(sykefraværsprosentTil = "5.0", success = { response ->
            response.data shouldHaveAtLeastSize 1
            response.data.forAll { sykefraversstatistikkVirksomhetDto ->
                sykefraversstatistikkVirksomhetDto.sykefraversprosent shouldBeLessThanOrEqual 5.0
            }
        })
    }

    private fun hentSykefravær(
        success: (ListResponse<SykefraversstatistikkVirksomhetDto>) -> Unit,
        kvartal: String = "",
        årstall: String = "",
        kommuner: String = "",
        fylker: String = "",
        næringsgrupper: String = "",
        sorteringsnokkel: String = "",
        sorteringsretning: String = "",
        sykefraværsprosentFra: String = "",
        sykefraværsprosentTil: String = "",
        iaStatus: String = "",
        side: String = ""
    ) =
        lydiaApiContainer.performGet(
            "$SYKEFRAVERSSTATISTIKK_PATH" +
                    "?$KVARTAL=$kvartal" +
                    "&$ÅRSTALL=$årstall" +
                    "&$KOMMUNER=$kommuner" +
                    "&$FYLKER=$fylker" +
                    "&$NÆRINGSGRUPPER=$næringsgrupper" +
                    "&$SORTERINGSNØKKEL=$sorteringsnokkel" +
                    "&$SORTERINGSRETNING=$sorteringsretning" +
                    "&$SYKEFRAVÆRSPROSENT_FRA=$sykefraværsprosentFra" +
                    "&$SYKEFRAVÆRSPROSENT_TIL=$sykefraværsprosentTil" +
                    "&$IA_STATUS=$iaStatus" +
                    "&$SIDE=$side"
        )
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<ListResponse<SykefraversstatistikkVirksomhetDto>>().third
            .fold(success = { response -> success.invoke(response) }, failure = { fail(it.message) })
}