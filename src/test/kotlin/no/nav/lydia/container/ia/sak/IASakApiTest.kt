package no.nav.lydia.container.ia.sak

import com.github.guepardoapps.kulid.ULID
import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.gson.jsonBody
import com.github.kittinunf.fuel.gson.responseObject
import com.google.gson.Gson
import com.google.gson.GsonBuilder
import io.kotest.assertions.shouldFail
import io.kotest.inspectors.forAtLeastOne
import io.kotest.inspectors.shouldForAtLeastOne
import io.kotest.matchers.collections.shouldContainExactly
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.should
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import no.nav.lydia.helper.*
import no.nav.lydia.helper.AuthContainerHelper.Companion.NAV_IDENT
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
import no.nav.lydia.helper.TestVirksomhet.Companion.BERGEN
import no.nav.lydia.helper.TestVirksomhet.Companion.OSLO
import no.nav.lydia.ia.sak.api.*
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.SaksHendelsestype
import no.nav.lydia.ia.sak.domene.SaksHendelsestype.*
import no.nav.lydia.integrasjoner.brreg.BrregDownloader
import no.nav.lydia.integrasjoner.ssb.NæringsDownloader
import no.nav.lydia.integrasjoner.ssb.NæringsRepository
import no.nav.lydia.sykefraversstatistikk.api.ListResponse
import no.nav.lydia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import no.nav.lydia.sykefraversstatistikk.api.SykefraversstatistikkVirksomhetDto
import no.nav.lydia.virksomhet.VirksomhetRepository
import java.time.LocalDateTime
import kotlin.test.Test
import kotlin.test.assertTrue
import kotlin.test.fail

class IASakApiTest {
    val lydiaApiContainer = TestContainerHelper.lydiaApiContainer
    val mockOAuth2Server = TestContainerHelper.oauth2ServerContainer

    companion object {
        init {
            val testData = TestData(inkluderStandardVirksomheter = true)
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
    fun `skal kunne sette en virksomhet i kontaktes status`() {
        val orgnr = OSLO.orgnr
        postgresContainer.performUpdate("DELETE FROM ia_sak WHERE orgnr = '$orgnr'")

        val sak = opprettSakForVirksomhet(orgnummer = orgnr)

        shouldFail {
            nyHendelsePåSak(sak, VIRKSOMHET_SKAL_KONTAKTES) // skal ikke kunne sette status kontaktes før den er vurdert
        }

        nyHendelsePåSak(nyHendelsePåSak(sak, VIRKSOMHET_VURDERES), VIRKSOMHET_SKAL_KONTAKTES).also {
            it.status shouldBe IAProsessStatus.KONTAKTES
        }
    }


    @Test
    fun `skal kunne vise at en virksomhet vurderes og vise status i listevisning`() {
        val orgnr = OSLO.orgnr
        postgresContainer.performUpdate("DELETE FROM ia_sak WHERE orgnr = '$orgnr'")

        val (_, _, listeResultatFørVirksomhetVurderes) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<ListResponse<SykefraversstatistikkVirksomhetDto>>(localDateTimeTypeAdapter)

        listeResultatFørVirksomhetVurderes.fold(
            success = { response ->
                response.data shouldHaveAtLeastSize 1
                response.data.shouldForAtLeastOne { sykefraversstatistikkVirksomhetDto ->
                    sykefraversstatistikkVirksomhetDto.orgnr shouldBe orgnr
                    sykefraversstatistikkVirksomhetDto.status shouldBe IAProsessStatus.IKKE_AKTIV
                }
            }, failure = {
                fail(it.message)
            })

        val sak = opprettSakForVirksomhet(orgnummer = orgnr)
        assertTrue(ULID.isValid(ulid = sak.saksnummer))

        val (_, _, listeResultatEtterVirksomhetVurderes) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<ListResponse<SykefraversstatistikkVirksomhetDto>>(localDateTimeTypeAdapter)

        listeResultatEtterVirksomhetVurderes.fold(
            success = { response ->
                response.data shouldHaveAtLeastSize 1
                response.data.shouldForAtLeastOne { sykefraversstatistikkVirksomhetDto ->
                    sykefraversstatistikkVirksomhetDto.orgnr shouldBe orgnr
                    sykefraversstatistikkVirksomhetDto.status shouldBe IAProsessStatus.NY
                }
            }, failure = {
                fail(it.message)
            })
    }


    @Test
    fun `skal kunne spore endringene som har skjedd på en sak`() {
        val sak = opprettSakForVirksomhet(orgnummer = BERGEN.orgnr)

        val iaSaker = hentIASaker(BERGEN.orgnr)
        iaSaker.forAtLeastOne {
            it.orgnr shouldBe BERGEN.orgnr
            it.status shouldBe IAProsessStatus.NY
            it.opprettetAv shouldBe NAV_IDENT
            it.saksnummer shouldBe sak.saksnummer
        }

        val sakEtterAtVirksomhetErVurdert = nyHendelsePåSak(sak, VIRKSOMHET_VURDERES).also {
            it.orgnr shouldBe BERGEN.orgnr
            it.saksnummer shouldBe sak.saksnummer
            it.status shouldBe IAProsessStatus.VURDERES
            it.opprettetAv shouldBe sak.opprettetAv
            it.endretAvHendelseId shouldNotBe sak.endretAvHendelseId
        }

        nyHendelsePåSak(sakEtterAtVirksomhetErVurdert, VIRKSOMHET_ER_IKKE_AKTUELL).also {
            it.orgnr shouldBe BERGEN.orgnr
            it.saksnummer shouldBe sak.saksnummer
            it.status shouldBe IAProsessStatus.IKKE_AKTUELL
            it.opprettetAv shouldBe sak.opprettetAv
            it.endretAvHendelseId shouldNotBe sak.endretAvHendelseId
        }
    }

    @Test
    fun `skal kunne hente en oppsummering av alle hendelsene som har skjedd på en sak`() {
        opprettSakForVirksomhet(orgnummer = BERGEN.orgnr).also { sak ->
            val sakVurderes = sak.nyHendelse(VIRKSOMHET_VURDERES)
            val sakKontaktes = sakVurderes.nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            val sakIkkeAktuell = sakKontaktes.nyHendelse(VIRKSOMHET_ER_IKKE_AKTUELL)
            val alleHendelsesTyper = listOf(
                OPPRETT_SAK_FOR_VIRKSOMHET,
                VIRKSOMHET_VURDERES,
                VIRKSOMHET_SKAL_KONTAKTES,
                VIRKSOMHET_ER_IKKE_AKTUELL
            )
            hentHendelserPåSak(sakIkkeAktuell.saksnummer).also { oppsummering ->
                oppsummering.map { it.hendelsestype } shouldContainExactly alleHendelsesTyper
                oppsummering.forExactlyOne {
                    it.hendelsestype shouldBe OPPRETT_SAK_FOR_VIRKSOMHET
                    it.opprettetTidspunkt shouldBe sakIkkeAktuell.opprettetTidspunkt
                }
            }
        }
    }

    private fun hentIASaker(orgnummer: String) =
        lydiaApiContainer.performGet("$IA_SAK_RADGIVER_PATH/$orgnummer")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<List<IASakDto>>(localDateTimeTypeAdapter).third.fold(success = { respons -> respons }, failure = {
                fail(it.message)
            })

    private fun hentHendelserPåSak(saksnummer: String) =
        lydiaApiContainer.performGet("$IA_SAK_RADGIVER_PATH/$SAK_HENDELSER_SUB_PATH/$saksnummer")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<List<IASakshendelseOppsummeringDto>>(localDateTimeTypeAdapter).third.fold(
                success = { respons -> respons },
                failure = {
                    fail(it.message)
                })

    private fun opprettSakForVirksomhet(orgnummer: String) =
        lydiaApiContainer.performPost("$IA_SAK_RADGIVER_PATH/$orgnummer")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<IASakDto>(localDateTimeTypeAdapter).third.fold(success = { respons -> respons }, failure = {
                fail(it.message)
            })

    private fun nyHendelsePåSak(sak: IASakDto, hendelsestype: SaksHendelsestype) =
        lydiaApiContainer.performPost("$IA_SAK_RADGIVER_PATH/$SAK_HENDELSE_SUB_PATH")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .jsonBody(
                IASakshendelseDto(
                    orgnummer = sak.orgnr,
                    saksnummer = sak.saksnummer,
                    hendelsesType = hendelsestype,
                    endretAvHendelsesId = sak.endretAvHendelseId
                ),
                localDateTimeTypeAdapter
            )
            .responseObject<IASakDto>(localDateTimeTypeAdapter).third.fold(success = { respons -> respons }, failure = {
                fail(it.message)
            })

    private fun IASakDto.nyHendelse(hendelsestype: SaksHendelsestype) = nyHendelsePåSak(this, hendelsestype)
}
