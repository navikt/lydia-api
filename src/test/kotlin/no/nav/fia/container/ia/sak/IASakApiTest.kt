package no.nav.fia.container.ia.sak

import com.github.guepardoapps.kulid.ULID
import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.gson.jsonBody
import com.github.kittinunf.fuel.gson.responseObject
import io.kotest.assertions.shouldFail
import io.kotest.inspectors.forAtLeastOne
import io.kotest.inspectors.shouldForAtLeastOne
import io.kotest.matchers.collections.shouldBeEmpty
import io.kotest.matchers.collections.shouldContainExactly
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import no.nav.fia.AuditType
import no.nav.fia.Tillat
import no.nav.fia.helper.HttpMock
import no.nav.fia.helper.IntegrationsHelper
import no.nav.fia.helper.TestContainerHelper
import no.nav.fia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.fia.helper.TestContainerHelper.Companion.performGet
import no.nav.fia.helper.TestContainerHelper.Companion.performPost
import no.nav.fia.helper.TestContainerHelper.Companion.postgresContainer
import no.nav.fia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.fia.helper.TestData
import no.nav.fia.helper.TestVirksomhet.Companion.BERGEN
import no.nav.fia.helper.TestVirksomhet.Companion.OSLO
import no.nav.fia.helper.forExactlyOne
import no.nav.fia.helper.localDateTimeTypeAdapter
import no.nav.fia.helper.statuskode
import no.nav.fia.ia.sak.api.IASakDto
import no.nav.fia.ia.sak.api.IASakshendelseDto
import no.nav.fia.ia.sak.api.IASakshendelseOppsummeringDto
import no.nav.fia.ia.sak.api.IA_SAK_RADGIVER_PATH
import no.nav.fia.ia.sak.api.SAK_HENDELSER_SUB_PATH
import no.nav.fia.ia.sak.api.SAK_HENDELSE_SUB_PATH
import no.nav.fia.ia.sak.domene.IAProsessStatus
import no.nav.fia.ia.sak.domene.SaksHendelsestype
import no.nav.fia.ia.sak.domene.SaksHendelsestype.*
import no.nav.fia.integrasjoner.brreg.BrregDownloader
import no.nav.fia.integrasjoner.ssb.NæringsDownloader
import no.nav.fia.integrasjoner.ssb.NæringsRepository
import no.nav.fia.sykefraversstatistikk.api.ListResponse
import no.nav.fia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import no.nav.fia.sykefraversstatistikk.api.SykefraversstatistikkVirksomhetDto
import no.nav.fia.virksomhet.VirksomhetRepository
import kotlin.test.Test
import kotlin.test.assertTrue
import kotlin.test.fail

class IASakApiTest {
    val fiaApiContainer = TestContainerHelper.fiaApiContainer
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
        val orgnr = BERGEN.orgnr
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
    fun `tilgangskontroll - en virksomhet skal bare kunne vurderes for oppfølging av en superbruker`() {
        val orgnr = OSLO.orgnr
        opprettSakForVirksomhetRespons(orgnummer = orgnr, token = mockOAuth2Server.lesebruker.token).statuskode() shouldBe 403
        opprettSakForVirksomhetRespons(orgnummer = orgnr, token = mockOAuth2Server.saksbehandler1.token).statuskode() shouldBe 403
        opprettSakForVirksomhetRespons(orgnummer = orgnr, token = mockOAuth2Server.superbruker1.token).statuskode() shouldBe 201
    }

    @Test
    fun `tilgangskontroll - en sak skal ikke kunne oppdateres av brukere med lesetilgang`() {
        val orgnummer = OSLO.orgnr
        opprettSakForVirksomhet(orgnummer, token = mockOAuth2Server.superbruker1.token).also {
            fiaApiContainer shouldContainLog auditLog(navIdent = mockOAuth2Server.superbruker1.navIdent, orgnummer = orgnummer, auditType = AuditType.create, tillat = Tillat.Ja, saksnummer = it.saksnummer)
            nyHendelsePåSakMedRespons(it, TA_EIERSKAP_I_SAK, token = mockOAuth2Server.lesebrukerAudit.token).statuskode() shouldBe 403
            fiaApiContainer shouldContainLog auditLog(navIdent = mockOAuth2Server.lesebrukerAudit.navIdent, orgnummer = orgnummer, auditType = AuditType.update, tillat = Tillat.Nei, saksnummer = it.saksnummer)
            nyHendelsePåSakMedRespons(it, TA_EIERSKAP_I_SAK, token = mockOAuth2Server.saksbehandler1.token).statuskode() shouldBe 201
            fiaApiContainer shouldContainLog auditLog(navIdent = mockOAuth2Server.saksbehandler1.navIdent, orgnummer = orgnummer, auditType = AuditType.update, tillat = Tillat.Ja, saksnummer = it.saksnummer)
        }
    }

    @Test
    fun `tilgangskontroll - en sak skal ikke kunne oppdateres av andre enn de som eier den`() {
        val orgnummer = OSLO.orgnr
        opprettSakForVirksomhet(orgnummer, token = mockOAuth2Server.superbruker1.token).also { sak ->
            nyHendelsePåSak(sak, TA_EIERSKAP_I_SAK, token = mockOAuth2Server.saksbehandler1.token).also { sakEtterTattEierskap ->
                nyHendelsePåSakMedRespons(
                    sakEtterTattEierskap, VIRKSOMHET_SKAL_KONTAKTES, token = mockOAuth2Server.saksbehandler2.token)
                    .statuskode() shouldBe 422
                nyHendelsePåSakMedRespons(
                    sakEtterTattEierskap, VIRKSOMHET_SKAL_KONTAKTES, token = mockOAuth2Server.saksbehandler1.token)
                    .statuskode() shouldBe 201
            }
        }
    }

    @Test
    fun `tilgangskontroll - en sak UTEN eier skal kunne vises av alle med tilgangsrolle`() {
        val orgnummer = OSLO.orgnr
        opprettSakForVirksomhet(orgnummer, token = mockOAuth2Server.superbruker1.token).also { sak ->
            hentSakerRespons(orgnummer = orgnummer, token = mockOAuth2Server.lesebruker.token).statuskode() shouldBe 200
            hentSakerRespons(orgnummer = orgnummer, token = mockOAuth2Server.saksbehandler1.token).statuskode() shouldBe 200
            hentSakerRespons(orgnummer = orgnummer, token = mockOAuth2Server.superbruker1.token).statuskode() shouldBe 200
            hentSakerRespons(orgnummer = orgnummer, token = mockOAuth2Server.brukerUtenTilgangsrolle.token).statuskode() shouldBe 403

            hentHendelserPåSakRespons(saksnummer = sak.saksnummer, token = mockOAuth2Server.lesebruker.token).statuskode() shouldBe 200
            hentHendelserPåSakRespons(saksnummer = sak.saksnummer, token = mockOAuth2Server.saksbehandler1.token).statuskode() shouldBe 200
            hentHendelserPåSakRespons(saksnummer = sak.saksnummer, token = mockOAuth2Server.superbruker1.token).statuskode() shouldBe 200
            hentHendelserPåSakRespons(saksnummer = sak.saksnummer, token = mockOAuth2Server.brukerUtenTilgangsrolle.token).statuskode() shouldBe 403
        }
    }

    @Test
    fun `tilgangskontroll - en sak MED eier skal kunne vises av alle med tilgangsrolle`() {
        val orgnummer = OSLO.orgnr
        opprettSakForVirksomhet(orgnummer, token = mockOAuth2Server.superbruker1.token).also { sak ->
            nyHendelsePåSak(sak, TA_EIERSKAP_I_SAK, token = mockOAuth2Server.saksbehandler1.token).also {
                hentSakerRespons(orgnummer = orgnummer, token = mockOAuth2Server.lesebruker.token).statuskode() shouldBe 200
                hentSakerRespons(orgnummer = orgnummer, token = mockOAuth2Server.saksbehandler1.token).statuskode() shouldBe 200
                hentSakerRespons(orgnummer = orgnummer, token = mockOAuth2Server.superbruker1.token).statuskode() shouldBe 200
                hentSakerRespons(orgnummer = orgnummer, token = mockOAuth2Server.brukerUtenTilgangsrolle.token).statuskode() shouldBe 403

                hentHendelserPåSakRespons(saksnummer = sak.saksnummer, token = mockOAuth2Server.lesebruker.token).statuskode() shouldBe 200
                hentHendelserPåSakRespons(saksnummer = sak.saksnummer, token = mockOAuth2Server.saksbehandler1.token).statuskode() shouldBe 200
                hentHendelserPåSakRespons(saksnummer = sak.saksnummer, token = mockOAuth2Server.superbruker1.token).statuskode() shouldBe 200
                hentHendelserPåSakRespons(saksnummer = sak.saksnummer, token = mockOAuth2Server.brukerUtenTilgangsrolle.token).statuskode() shouldBe 403
            }
        }
    }

    @Test
    fun `tilgangskontroll - man skal kunne se en sak man selv eier`() {
        val orgnummer = OSLO.orgnr
        opprettSakForVirksomhet(orgnummer, token = mockOAuth2Server.superbruker2.token)
            .nyHendelse(TA_EIERSKAP_I_SAK, token = mockOAuth2Server.saksbehandler1.token).also { sak ->
                hentSakerRespons(orgnummer = orgnummer, token = mockOAuth2Server.saksbehandler1.token).statuskode() shouldBe 200
                hentHendelserPåSakRespons(saksnummer = sak.saksnummer, token = mockOAuth2Server.saksbehandler1.token).statuskode() shouldBe 200
            }
        opprettSakForVirksomhet(orgnummer, token = mockOAuth2Server.superbruker2.token)
            .nyHendelse(TA_EIERSKAP_I_SAK, token = mockOAuth2Server.superbruker1.token).also { sak ->
                hentSakerRespons(orgnummer = orgnummer, token = mockOAuth2Server.superbruker1.token).statuskode() shouldBe 200
                hentHendelserPåSakRespons(saksnummer = sak.saksnummer, token = mockOAuth2Server.superbruker1.token).statuskode() shouldBe 200
            }
        // PS: lesebruker kan ikke eie en sak, derfor tester vi ikke dette tilfellet
    }

    @Test
    fun `skal kunne spore endringene som har skjedd på en sak`() {
        val sak = opprettSakForVirksomhet(orgnummer = BERGEN.orgnr)

        val iaSaker = hentSaker(BERGEN.orgnr)
        iaSaker.forAtLeastOne {
            it.orgnr shouldBe BERGEN.orgnr
            it.status shouldBe IAProsessStatus.VURDERES
            it.opprettetAv shouldBe mockOAuth2Server.superbruker1.navIdent
            it.saksnummer shouldBe sak.saksnummer
        }

        nyHendelsePåSak(sak, TA_EIERSKAP_I_SAK, token = mockOAuth2Server.saksbehandler1.token).also {
            it.orgnr shouldBe BERGEN.orgnr
            it.saksnummer shouldBe sak.saksnummer
            it.status shouldBe IAProsessStatus.VURDERES
            it.opprettetAv shouldBe sak.opprettetAv
            it.eidAv shouldBe mockOAuth2Server.saksbehandler1.navIdent
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
            sakEtterTattEierskap.eidAv shouldBe mockOAuth2Server.saksbehandler1.navIdent

            sakEtterTattEierskap.nyHendelse(TA_EIERSKAP_I_SAK, mockOAuth2Server.saksbehandler2.token).also {
                it.eidAv shouldBe mockOAuth2Server.saksbehandler2.navIdent
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
    fun `skal få gyldige neste hendelser i retur - avhengig av hvem man er`() {
        opprettSakForVirksomhet(OSLO.orgnr, token = mockOAuth2Server.superbruker1.token).also { sak ->
            hentSaker(sak.orgnr, token = mockOAuth2Server.saksbehandler1.token).filter { it.saksnummer == sak.saksnummer }
                .forEach {
                    it.gyldigeNesteHendelser shouldContainExactly listOf(TA_EIERSKAP_I_SAK)
                }
            hentSaker(OSLO.orgnr, token = mockOAuth2Server.lesebruker.token).filter { it.saksnummer == sak.saksnummer }
                .forEach {
                    it.gyldigeNesteHendelser.shouldBeEmpty()
                }
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

    private fun auditLog(navIdent: String, orgnummer: String, auditType: AuditType, tillat: Tillat, saksnummer: String? = null) =
        ("CEF:0\\|fia-api\\|auditLog\\|1.0\\|audit:${auditType.name}\\|fia-api\\|INFO|end=[0-9]\\+ " +
            "suid=$navIdent " +
            "duid=$orgnummer " +
            "sproc=.{26} " +
            "requestMethod=POST " +
            "request=/iasak/radgiver/hendelse " +
            "flexString1Label=Decision " +
            "flexString1=$tillat" +
            saksnummer?.let { " flexString2Label=saksnummer flexString2=$it" }).toRegex()

    private fun hentSaker(orgnummer: String, token: String = mockOAuth2Server.saksbehandler1.token) =
        hentSakerRespons(orgnummer = orgnummer, token = token).third.fold(
                success = { respons -> respons },
                failure = {
                    fail(it.message)
                })

    private fun hentSakerRespons(orgnummer: String, token: String = mockOAuth2Server.saksbehandler1.token) =
        fiaApiContainer.performGet("$IA_SAK_RADGIVER_PATH/$orgnummer")
            .authentication().bearer(token = token)
            .responseObject<List<IASakDto>>(localDateTimeTypeAdapter)

    private fun hentHendelserPåSakRespons(saksnummer: String, token: String = mockOAuth2Server.saksbehandler1.token) =
        fiaApiContainer.performGet("$IA_SAK_RADGIVER_PATH/$SAK_HENDELSER_SUB_PATH/$saksnummer")
            .authentication().bearer(token = token)
            .responseObject<List<IASakshendelseOppsummeringDto>>(localDateTimeTypeAdapter)
    

    
    private fun hentHendelserPåSak(saksnummer: String, token: String = mockOAuth2Server.saksbehandler1.token) =
       hentHendelserPåSakRespons(saksnummer = saksnummer, token = token).third.fold(
                success = { respons -> respons },
                failure = {
                    fail(it.message)
                })

    private fun opprettSakForVirksomhetRespons(
        orgnummer: String,
        token : String
    ) = fiaApiContainer.performPost("$IA_SAK_RADGIVER_PATH/$orgnummer")
            .authentication().bearer(token = token)
            .responseObject<IASakDto>(localDateTimeTypeAdapter)

    private fun opprettSakForVirksomhet(
        orgnummer: String,
        token: String = mockOAuth2Server.superbruker1.token,
    ): IASakDto = opprettSakForVirksomhetRespons(orgnummer, token).third.fold(
            success = { respons -> respons },
            failure = { fail(it.message )}
        )

    private fun nyHendelse(sakshendelse: IASakshendelseDto, token: String = mockOAuth2Server.saksbehandler1.token) =
        fiaApiContainer.performPost("$IA_SAK_RADGIVER_PATH/$SAK_HENDELSE_SUB_PATH")
            .authentication().bearer(token)
            .jsonBody(
                sakshendelse,
                localDateTimeTypeAdapter
            )
            .responseObject<IASakDto>(localDateTimeTypeAdapter).third.fold(success = { respons -> respons }, failure = {
                fail(it.message)
            })

    private fun nyHendelsePåSakMedRespons(
        sak: IASakDto,
        hendelsestype: SaksHendelsestype,
        token: String = mockOAuth2Server.saksbehandler1.token
    ) = fiaApiContainer.performPost("$IA_SAK_RADGIVER_PATH/$SAK_HENDELSE_SUB_PATH")
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
        .responseObject<IASakDto>(localDateTimeTypeAdapter)


    private fun nyHendelsePåSak(
        sak: IASakDto,
        hendelsestype: SaksHendelsestype,
        token: String = mockOAuth2Server.saksbehandler1.token
    ) =
        nyHendelsePåSakMedRespons(sak, hendelsestype, token)
            .third.fold(success = { respons -> respons }, failure = {
                fail(it.message)
            })

    private fun IASakDto.nyHendelse(
        hendelsestype: SaksHendelsestype,
        token: String = mockOAuth2Server.saksbehandler1.token
    ) =
        nyHendelsePåSak(this, hendelsestype, token)

    private fun hentSykefraværsstatistikk(token: String = mockOAuth2Server.saksbehandler1.token) =
        fiaApiContainer.performGet("${SYKEFRAVERSSTATISTIKK_PATH}/")
            .authentication().bearer(token = token)
            .responseObject<ListResponse<SykefraversstatistikkVirksomhetDto>>(
                localDateTimeTypeAdapter
            ).third.fold(
                success = { respons -> respons },
                failure = {
                    fail(it.message)
                })
}
