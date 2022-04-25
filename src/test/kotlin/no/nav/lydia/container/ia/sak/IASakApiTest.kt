package no.nav.lydia.container.ia.sak

import com.github.guepardoapps.kulid.ULID
import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.gson.jsonBody
import com.github.kittinunf.fuel.gson.responseObject
import io.kotest.assertions.shouldFail
import io.kotest.inspectors.forAtLeastOne
import io.kotest.inspectors.shouldForAtLeastOne
import io.kotest.matchers.collections.shouldContainExactly
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import no.nav.lydia.helper.*
import no.nav.lydia.helper.AuthContainerHelper.Companion.NAV_IDENT_X12345
import no.nav.lydia.helper.AuthContainerHelper.Companion.NAV_IDENT_Y54321
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
        opprettSakForVirksomhet(orgnummer = OSLO.orgnr)
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .also {
                it.status shouldBe IAProsessStatus.KONTAKTES
            }
    }

    @Test
    fun `en virksomhet skal ikke kunne kontaktes før saken har et eierskap`() {
        opprettSakForVirksomhet(orgnummer = OSLO.orgnr)
            .also {
                shouldFail {
                    it.nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
                }
            }
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .also {
                it.status shouldBe IAProsessStatus.KONTAKTES
            }
    }


    @Test
    fun `skal kunne vise at en virksomhet vurderes og vise status i listevisning`() {
        val orgnr = OSLO.orgnr
        postgresContainer.performUpdate("DELETE FROM ia_sak WHERE orgnr = '$orgnr'")

        hentSykefraværsstatistikk().also { listeFørVirksomhetVurderes ->
            listeFørVirksomhetVurderes.data shouldHaveAtLeastSize 1
            listeFørVirksomhetVurderes.data.shouldForAtLeastOne { sykefraversstatistikkVirksomhetDto ->
                sykefraversstatistikkVirksomhetDto.orgnr shouldBe orgnr
                sykefraversstatistikkVirksomhetDto.status shouldBe IAProsessStatus.IKKE_AKTIV
            }
        }

        val sak = opprettSakForVirksomhet(orgnummer = orgnr)
        assertTrue(ULID.isValid(ulid = sak.saksnummer))

        hentSykefraværsstatistikk().also { listeEtterVirksomhetVurderes ->
            listeEtterVirksomhetVurderes.data shouldHaveAtLeastSize 1
            listeEtterVirksomhetVurderes.data.shouldForAtLeastOne { sykefraversstatistikkVirksomhetDto ->
                sykefraversstatistikkVirksomhetDto.orgnr shouldBe orgnr
                sykefraversstatistikkVirksomhetDto.status shouldBe IAProsessStatus.VURDERES
            }
        }

    }


    @Test
    fun `skal kunne spore endringene som har skjedd på en sak`() {
        val sak = opprettSakForVirksomhet(orgnummer = BERGEN.orgnr)

        val iaSaker = hentIASaker(BERGEN.orgnr)
        iaSaker.forAtLeastOne {
            it.orgnr shouldBe BERGEN.orgnr
            it.status shouldBe IAProsessStatus.VURDERES
            it.opprettetAv shouldBe NAV_IDENT_X12345
            it.saksnummer shouldBe sak.saksnummer
        }

        nyHendelsePåSak(sak, VIRKSOMHET_ER_IKKE_AKTUELL).also {
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
            val sakIkkeAktuell = sak
                .nyHendelse(TA_EIERSKAP_I_SAK)
                .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
                .nyHendelse(VIRKSOMHET_ER_IKKE_AKTUELL)
            val alleHendelsesTyper = listOf(
                OPPRETT_SAK_FOR_VIRKSOMHET,
                VIRKSOMHET_VURDERES,
                TA_EIERSKAP_I_SAK,
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

    @Test
    fun `skal kunne ta eierskap i en sak`() {
        opprettSakForVirksomhet(OSLO.orgnr).also { sak ->
            sak.eidAv shouldBe null

            val sakEtterTattEierskap = sak.nyHendelse(TA_EIERSKAP_I_SAK)
            sakEtterTattEierskap.eidAv shouldBe NAV_IDENT_X12345

            sakEtterTattEierskap.nyHendelse(TA_EIERSKAP_I_SAK, mockOAuth2Server.lydiaApiTokenY).also {
                it.eidAv shouldBe NAV_IDENT_Y54321
            }.also {
                hentHendelserPåSak(it.saksnummer).map { hendelse -> hendelse.hendelsestype }.shouldContainExactly(
                    OPPRETT_SAK_FOR_VIRKSOMHET,
                    VIRKSOMHET_VURDERES,
                    TA_EIERSKAP_I_SAK,
                    TA_EIERSKAP_I_SAK
                )
            }

        }
    }

    @Test
    fun `skal få gyldige neste hendelser i retur`() {
        opprettSakForVirksomhet(OSLO.orgnr).also { sak ->
            sak.gyldigeNesteHendelser shouldContainExactly listOf(VIRKSOMHET_ER_IKKE_AKTUELL, TA_EIERSKAP_I_SAK)
        }
    }

    @Test
    fun `skal ikke kunne legge til hendelser på en sak som er oppdatert av en annen hendelse`() {
        opprettSakForVirksomhet(OSLO.orgnr).also { sak ->
            val gammelSakshendelse = IASakshendelseDto(
                orgnummer = sak.orgnr,
                saksnummer = sak.saksnummer,
                hendelsesType = VIRKSOMHET_ER_IKKE_AKTUELL,
                endretAvHendelseId = "ugyldig ID"
            )
            shouldFail {
                nyHendelse(gammelSakshendelse)
            }
        }
    }

    private fun hentIASaker(orgnummer: String) =
        lydiaApiContainer.performGet("$IA_SAK_RADGIVER_PATH/$orgnummer")
            .authentication().bearer(mockOAuth2Server.lydiaApiTokenX)
            .responseObject<List<IASakDto>>(localDateTimeTypeAdapter).third.fold(success = { respons -> respons }, failure = {
                fail(it.message)
            })

    private fun hentHendelserPåSak(saksnummer: String) =
        lydiaApiContainer.performGet("$IA_SAK_RADGIVER_PATH/$SAK_HENDELSER_SUB_PATH/$saksnummer")
            .authentication().bearer(mockOAuth2Server.lydiaApiTokenX)
            .responseObject<List<IASakshendelseOppsummeringDto>>(localDateTimeTypeAdapter).third.fold(
                success = { respons -> respons },
                failure = {
                    fail(it.message)
                })

    private fun opprettSakForVirksomhet(orgnummer: String) =
        lydiaApiContainer.performPost("$IA_SAK_RADGIVER_PATH/$orgnummer")
            .authentication().bearer(mockOAuth2Server.lydiaApiTokenX)
            .responseObject<IASakDto>(localDateTimeTypeAdapter).third.fold(success = { respons -> respons }, failure = {
                fail(it.message)
            })

    private fun nyHendelse(sakshendelse: IASakshendelseDto, token: String = mockOAuth2Server.lydiaApiTokenX) =
        lydiaApiContainer.performPost("$IA_SAK_RADGIVER_PATH/$SAK_HENDELSE_SUB_PATH")
            .authentication().bearer(token)
            .jsonBody(
                sakshendelse,
                localDateTimeTypeAdapter
            )
            .responseObject<IASakDto>(localDateTimeTypeAdapter).third.fold(success = { respons -> respons }, failure = {
                fail(it.message)
            })

    private fun nyHendelsePåSak(sak: IASakDto, hendelsestype: SaksHendelsestype, token: String = mockOAuth2Server.lydiaApiTokenX) =
        lydiaApiContainer.performPost("$IA_SAK_RADGIVER_PATH/$SAK_HENDELSE_SUB_PATH")
            .authentication().bearer(token)
            .jsonBody(
                IASakshendelseDto(
                    orgnummer = sak.orgnr,
                    saksnummer = sak.saksnummer,
                    hendelsesType = hendelsestype,
                    endretAvHendelseId = sak.endretAvHendelseId
                ),
                localDateTimeTypeAdapter
            )
            .responseObject<IASakDto>(localDateTimeTypeAdapter).third.fold(success = { respons -> respons }, failure = {
                fail(it.message)
            })

    private fun IASakDto.nyHendelse(hendelsestype: SaksHendelsestype, token: String = mockOAuth2Server.lydiaApiTokenX) =
        nyHendelsePåSak(this, hendelsestype, token)

    private fun hentSykefraværsstatistikk() = lydiaApiContainer.performGet("${SYKEFRAVERSSTATISTIKK_PATH}/")
        .authentication().bearer(mockOAuth2Server.lydiaApiTokenX)
        .responseObject<ListResponse<SykefraversstatistikkVirksomhetDto>>(
            localDateTimeTypeAdapter
        ).third.fold(
                success = { respons -> respons },
                failure = {
                    fail(it.message)
            })
}
