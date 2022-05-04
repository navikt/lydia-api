package no.nav.lydia.container.ia.sak

import com.github.guepardoapps.kulid.ULID
import io.kotest.assertions.shouldFail
import io.kotest.inspectors.forAtLeastOne
import io.kotest.inspectors.shouldForAtLeastOne
import io.kotest.matchers.collections.shouldBeEmpty
import io.kotest.matchers.collections.shouldContainExactly
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import no.nav.lydia.AuditType
import no.nav.lydia.Tillat
import no.nav.lydia.helper.SakHelper.Companion.hentHendelserPåSak
import no.nav.lydia.helper.SakHelper.Companion.hentHendelserPåSakRespons
import no.nav.lydia.helper.SakHelper.Companion.hentSaker
import no.nav.lydia.helper.SakHelper.Companion.hentSakerRespons
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.nyHendelsePåSak
import no.nav.lydia.helper.SakHelper.Companion.nyHendelsePåSakMedRespons
import no.nav.lydia.helper.SakHelper.Companion.opprettSakForVirksomhet
import no.nav.lydia.helper.SakHelper.Companion.opprettSakForVirksomhetRespons
import no.nav.lydia.helper.StatistikkHelper.Companion.hentSykefravær
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.TestVirksomhet.Companion.BERGEN
import no.nav.lydia.helper.TestVirksomhet.Companion.OSLO
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.statuskode
import no.nav.lydia.ia.sak.api.IASakshendelseDto
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.SaksHendelsestype.*
import kotlin.test.Test
import kotlin.test.assertTrue

class IASakApiTest {
    val lydiaApiContainer = TestContainerHelper.lydiaApiContainer
    val mockOAuth2Server = TestContainerHelper.oauth2ServerContainer

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

        hentSykefravær(success = { listeFørVirksomhetVurderes ->
            listeFørVirksomhetVurderes.data shouldHaveAtLeastSize 1
            listeFørVirksomhetVurderes.data.shouldForAtLeastOne { sykefraversstatistikkVirksomhetDto ->
                sykefraversstatistikkVirksomhetDto.orgnr shouldBe orgnr
                sykefraversstatistikkVirksomhetDto.status shouldBe IAProsessStatus.IKKE_AKTIV
            }
        })

        val sak = opprettSakForVirksomhet(orgnummer = orgnr)
        assertTrue(ULID.isValid(ulid = sak.saksnummer))

        hentSykefravær(success = { listeEtterVirksomhetVurderes ->
            listeEtterVirksomhetVurderes.data shouldHaveAtLeastSize 1
            listeEtterVirksomhetVurderes.data.shouldForAtLeastOne { sykefraversstatistikkVirksomhetDto ->
                sykefraversstatistikkVirksomhetDto.orgnr shouldBe orgnr
                sykefraversstatistikkVirksomhetDto.status shouldBe IAProsessStatus.VURDERES
            }
        })

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
            nyHendelsePåSakMedRespons(it, TA_EIERSKAP_I_SAK, token = mockOAuth2Server.lesebrukerAudit.token).statuskode() shouldBe 403
            nyHendelsePåSakMedRespons(it, TA_EIERSKAP_I_SAK, token = mockOAuth2Server.saksbehandler1.token).statuskode() shouldBe 201
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
}
