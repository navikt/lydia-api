package no.nav.lydia.container.ia.sak

import com.github.guepardoapps.kulid.ULID
import io.kotest.assertions.json.shouldEqualSpecifiedJson
import io.kotest.assertions.shouldFail
import io.kotest.inspectors.forAll
import io.kotest.inspectors.forAtLeastOne
import io.kotest.inspectors.shouldForAtLeastOne
import io.kotest.matchers.collections.*
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.ktor.http.*
import kotlinx.datetime.toKotlinLocalDate
import no.nav.lydia.helper.SakHelper.Companion.hentSaker
import no.nav.lydia.helper.SakHelper.Companion.hentSakerRespons
import no.nav.lydia.helper.SakHelper.Companion.hentSamarbeidshistorikk
import no.nav.lydia.helper.SakHelper.Companion.hentSamarbeidshistorikkForOrgnrRespons
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.nyHendelsePåSak
import no.nav.lydia.helper.SakHelper.Companion.nyHendelsePåSakMedRespons
import no.nav.lydia.helper.SakHelper.Companion.nyHendelsePåSakRequest
import no.nav.lydia.helper.SakHelper.Companion.nyHendelseRespons
import no.nav.lydia.helper.SakHelper.Companion.nyIkkeAktuellHendelse
import no.nav.lydia.helper.SakHelper.Companion.oppdaterHendelsesTidspunkter
import no.nav.lydia.helper.SakHelper.Companion.opprettSakForVirksomhet
import no.nav.lydia.helper.SakHelper.Companion.opprettSakForVirksomhetRespons
import no.nav.lydia.helper.SakHelper.Companion.slettSak
import no.nav.lydia.helper.SakHelper.Companion.toJson
import no.nav.lydia.helper.StatistikkHelper.Companion.hentSykefravær
import no.nav.lydia.helper.TestContainerHelper.Companion.oauth2ServerContainer
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper.Companion.lastInnNyVirksomhet
import no.nav.lydia.helper.VirksomhetHelper.Companion.nyttOrgnummer
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.statuskode
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.IASakshendelseDto
import no.nav.lydia.ia.sak.domene.ANTALL_DAGER_FØR_SAK_LÅSES
import no.nav.lydia.ia.sak.domene.IAProsessStatus.*
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.IASakshendelseType.*
import no.nav.lydia.ia.årsak.domene.BegrunnelseType.*
import no.nav.lydia.ia.årsak.domene.GyldigBegrunnelse.Companion.somBegrunnelseType
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.ia.årsak.domene.ÅrsakType.NAV_IGANGSETTER_IKKE_TILTAK
import no.nav.lydia.ia.årsak.domene.ÅrsakType.VIRKSOMHETEN_TAKKET_NEI
import no.nav.lydia.sykefraversstatistikk.api.geografi.Kommune
import kotlin.test.Test
import kotlin.test.assertTrue

class IASakApiTest {
    private val mockOAuth2Server = oauth2ServerContainer

    @Test
    fun `skal validere at begrunnelse tilhører riktig årsak`() {
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelseRespons(hendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL, payload = ValgtÅrsak(
                type = NAV_IGANGSETTER_IKKE_TILTAK,
                begrunnelser = listOf(HAR_IKKE_KAPASITET)
            ).toJson()).statuskode() shouldBe 400
    }

    @Test
    fun `skal kunne åpne en ny sak etter at en sak er slettet`() {
        val orgnummer = nyttOrgnummer()
        opprettSakForVirksomhet(orgnummer = orgnummer).slettSak()
        hentSaker(orgnummer = orgnummer).shouldBeEmpty()
        opprettSakForVirksomhet(orgnummer = orgnummer).also {
            it.status shouldBe VURDERES
        }
        hentSaker(orgnummer = orgnummer).shouldHaveSize(1)
    }

    @Test
    fun `skal kunne slette en sak med status Vurderes (uten eier)`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer()).slettSak()
        hentSaker(sak.orgnr).none { it.saksnummer == sak.saksnummer } shouldBe true
    }

    @Test
    fun `skal ikke kunne slette sak dersom man ikke er superbruker`() {
        shouldFail {
            opprettSakForVirksomhet(orgnummer = nyttOrgnummer(), token = mockOAuth2Server.superbruker1.token)
                .nyHendelse(hendelsestype = SLETT_SAK, token = mockOAuth2Server.saksbehandler1.token)
        }
        shouldFail {
            opprettSakForVirksomhet(orgnummer = nyttOrgnummer(), token = mockOAuth2Server.superbruker1.token)
                .nyHendelse(hendelsestype = SLETT_SAK, token = mockOAuth2Server.lesebruker.token)
        }
    }

    @Test
    fun `skal ikke kunne slette sak med annen status enn Vurderes (uten eier)`() {
        var sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
        val kanIkkeSletteEtterHendelser = IASakshendelseType.values()
            .filter { it != OPPRETT_SAK_FOR_VIRKSOMHET && it != VIRKSOMHET_VURDERES && it != SLETT_SAK }

        kanIkkeSletteEtterHendelser.forEach {
            sak = if (it == VIRKSOMHET_ER_IKKE_AKTUELL) {
                sak.nyHendelse(
                    it, payload = ValgtÅrsak(
                        type = VIRKSOMHETEN_TAKKET_NEI,
                        begrunnelser = listOf(HAR_IKKE_KAPASITET)
                    ).toJson()
                )
            } else {
                sak.nyHendelse(it)
            }

            shouldFail {
                sak.slettSak()
            }
        }
    }

    @Test
    fun `skal kunne sette en virksomhet i kontaktes status`() {
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .also {
                it.status shouldBe KONTAKTES
            }
    }

    @Test
    fun `en virksomhet skal ikke kunne kontaktes før saken har et eierskap`() {
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .also {
                shouldFail {
                    it.nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
                }
            }
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .also {
                it.status shouldBe KONTAKTES
            }
    }

    @Test
    fun `skal kunne vise at en virksomhet vurderes og vise status i listevisning`() {
        val utsiraKommune = Kommune(navn = "Utsira", nummer = "1151")
        val virksomhet =
            lastInnNyVirksomhet(TestVirksomhet.nyVirksomhet(TestVirksomhet.beliggenhet(kommune = utsiraKommune)))
        hentSykefravær(success = { listeFørVirksomhetVurderes ->
            listeFørVirksomhetVurderes.data shouldHaveAtLeastSize 1
            listeFørVirksomhetVurderes.data.shouldForAtLeastOne { sykefraversstatistikkVirksomhetDto ->
                sykefraversstatistikkVirksomhetDto.orgnr shouldBe virksomhet.orgnr
                sykefraversstatistikkVirksomhetDto.status shouldBe IKKE_AKTIV
                sykefraversstatistikkVirksomhetDto.sistEndret shouldBe null
            }
        }, kommuner = utsiraKommune.nummer)
        val sak = opprettSakForVirksomhet(orgnummer = virksomhet.orgnr)
        assertTrue(ULID.isValid(ulid = sak.saksnummer))
        hentSykefravær(success = { listeEtterVirksomhetVurderes ->
            listeEtterVirksomhetVurderes.data shouldHaveAtLeastSize 1
            listeEtterVirksomhetVurderes.data.shouldForAtLeastOne { sykefraversstatistikkVirksomhetDto ->
                sykefraversstatistikkVirksomhetDto.orgnr shouldBe virksomhet.orgnr
                sykefraversstatistikkVirksomhetDto.status shouldBe VURDERES
                sykefraversstatistikkVirksomhetDto.sistEndret shouldBe java.time.LocalDate.now().toKotlinLocalDate()
            }
        }, kommuner = utsiraKommune.nummer)

    }

    @Test
    fun `skal ikke kunne opprette ny sak hvis det allerede finnes en åpen sak`() {
        val orgnummer = nyttOrgnummer()
        opprettSakForVirksomhetRespons(
            orgnummer = orgnummer,
            token = mockOAuth2Server.superbruker1.token
        ).statuskode() shouldBe 201

        opprettSakForVirksomhetRespons(
            orgnummer = orgnummer,
            token = mockOAuth2Server.superbruker1.token
        ).statuskode() shouldBe 501
    }

    @Test
    fun `skal kunne opprette ny sak dersom de andre sakene anses som ikke aktuell`() {
        val orgnummer = nyttOrgnummer()
        var sak = opprettSakForVirksomhet(orgnummer = orgnummer)
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(VIRKSOMHET_KARTLEGGES)
            .also { sak ->
                shouldFail {
                    sak.nyHendelse(FULLFØR_BISTAND)
                }
            }
            .nyHendelse(VIRKSOMHET_SKAL_BISTÅS)
        sak.status shouldBe VI_BISTÅR

        opprettSakForVirksomhetRespons(orgnummer = orgnummer, token = mockOAuth2Server.superbruker1.token)
            .statuskode() shouldBe 501

        sak = sak.nyHendelse(
            hendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL, payload = ValgtÅrsak(
                type = VIRKSOMHETEN_TAKKET_NEI,
                begrunnelser = listOf(HAR_IKKE_KAPASITET)
            ).toJson()
        )
        sak.status shouldBe IKKE_AKTUELL

        opprettSakForVirksomhetRespons(orgnummer = orgnummer, token = mockOAuth2Server.superbruker1.token)
            .statuskode() shouldBe 201

        hentSaker(orgnummer = orgnummer).size shouldBe 2
    }

    @Test
    fun `skal kunne opprette ny sak dersom de andre sakene anses som ikke fullført`() {
        val orgnummer = nyttOrgnummer()
        var sak = opprettSakForVirksomhet(orgnummer = orgnummer)
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(VIRKSOMHET_KARTLEGGES)
            .also { sak ->
                shouldFail {
                    sak.nyHendelse(FULLFØR_BISTAND)
                }
            }
            .nyHendelse(VIRKSOMHET_SKAL_BISTÅS)
        sak.status shouldBe VI_BISTÅR

        opprettSakForVirksomhetRespons(orgnummer = orgnummer, token = mockOAuth2Server.superbruker1.token)
            .statuskode() shouldBe 501

        sak = sak.nyHendelse(FULLFØR_BISTAND)
        sak.status shouldBe FULLFØRT

        val sak2Respons =
            opprettSakForVirksomhetRespons(orgnummer = orgnummer, token = mockOAuth2Server.superbruker1.token)
        sak2Respons.statuskode() shouldBe 201
        val sak2 = sak2Respons.third.get()

        val sakerForVirksomheten = hentSaker(orgnummer = orgnummer)
        sakerForVirksomheten.size shouldBe 2
        sakerForVirksomheten.map(IASakDto::saksnummer) shouldContainExactly listOf(sak2.saksnummer, sak.saksnummer)
    }

    @Test
    fun `tilgangskontroll - en virksomhet skal bare kunne vurderes for oppfølging av en superbruker`() {
        val orgnr = nyttOrgnummer()
        opprettSakForVirksomhetRespons(
            orgnummer = orgnr,
            token = mockOAuth2Server.lesebruker.token
        ).statuskode() shouldBe 403
        opprettSakForVirksomhetRespons(
            orgnummer = orgnr,
            token = mockOAuth2Server.saksbehandler1.token
        ).statuskode() shouldBe 403
        opprettSakForVirksomhetRespons(
            orgnummer = orgnr,
            token = mockOAuth2Server.superbruker1.token
        ).statuskode() shouldBe 201
    }

    @Test
    fun `tilgangskontroll - en sak skal ikke kunne oppdateres av brukere med lesetilgang`() {
        val orgnummer = nyttOrgnummer()
        opprettSakForVirksomhet(orgnummer = orgnummer, token = mockOAuth2Server.superbruker1.token).also {

            nyHendelsePåSakMedRespons(
                sak = it,
                hendelsestype = TA_EIERSKAP_I_SAK,
                token = mockOAuth2Server.lesebrukerAudit.token
            ).statuskode() shouldBe 403

            nyHendelsePåSakMedRespons(
                sak = it,
                hendelsestype = TA_EIERSKAP_I_SAK,
                token = mockOAuth2Server.saksbehandler1.token
            ).statuskode() shouldBe 201

        }
    }

    @Test
    fun `tilgangskontroll - en sak skal ikke kunne oppdateres av andre enn de som eier den`() {
        val orgnummer = nyttOrgnummer()
        opprettSakForVirksomhet(orgnummer = orgnummer, token = mockOAuth2Server.superbruker1.token).also { sak ->
            nyHendelsePåSak(
                sak = sak,
                hendelsestype = TA_EIERSKAP_I_SAK, token = mockOAuth2Server.saksbehandler1.token
            ).also { sakEtterTattEierskap ->
                nyHendelsePåSakMedRespons(
                    sak = sakEtterTattEierskap,
                    hendelsestype = VIRKSOMHET_SKAL_KONTAKTES,
                    token = mockOAuth2Server.saksbehandler2.token
                )
                    .statuskode() shouldBe 422
                nyHendelsePåSakMedRespons(
                    sak = sakEtterTattEierskap,
                    hendelsestype = VIRKSOMHET_SKAL_KONTAKTES,
                    token = mockOAuth2Server.saksbehandler1.token
                )
                    .statuskode() shouldBe 201
            }
        }
    }

    @Test
    fun `tilgangskontroll - en sak UTEN eier skal kunne vises av alle med tilgangsrolle`() {
        val orgnummer = nyttOrgnummer()
        opprettSakForVirksomhet(orgnummer = orgnummer, token = mockOAuth2Server.superbruker1.token).also {
            hentSakerRespons(orgnummer = orgnummer, token = mockOAuth2Server.lesebruker.token).statuskode() shouldBe 200
            hentSakerRespons(
                orgnummer = orgnummer,
                token = mockOAuth2Server.saksbehandler1.token
            ).statuskode() shouldBe 200
            hentSakerRespons(
                orgnummer = orgnummer,
                token = mockOAuth2Server.superbruker1.token
            ).statuskode() shouldBe 200
            hentSakerRespons(
                orgnummer = orgnummer,
                token = mockOAuth2Server.brukerUtenTilgangsrolle.token
            ).statuskode() shouldBe 403

            hentSamarbeidshistorikkForOrgnrRespons(
                orgnr = orgnummer,
                token = mockOAuth2Server.lesebruker.token
            ).statuskode() shouldBe 200
            hentSamarbeidshistorikkForOrgnrRespons(
                orgnr = orgnummer,
                token = mockOAuth2Server.saksbehandler1.token
            ).statuskode() shouldBe 200
            hentSamarbeidshistorikkForOrgnrRespons(
                orgnr = orgnummer,
                token = mockOAuth2Server.superbruker1.token
            ).statuskode() shouldBe 200
            hentSamarbeidshistorikkForOrgnrRespons(
                orgnr = orgnummer,
                token = mockOAuth2Server.brukerUtenTilgangsrolle.token
            ).statuskode() shouldBe 403
        }
    }

    @Test
    fun `tilgangskontroll - en sak MED eier skal kunne vises av alle med tilgangsrolle`() {
        val orgnummer = nyttOrgnummer()
        opprettSakForVirksomhet(orgnummer = orgnummer, token = mockOAuth2Server.superbruker1.token).also { sak ->
            nyHendelsePåSak(sak, TA_EIERSKAP_I_SAK, token = mockOAuth2Server.saksbehandler1.token).also {
                hentSakerRespons(
                    orgnummer = orgnummer,
                    token = mockOAuth2Server.lesebruker.token
                ).statuskode() shouldBe 200
                hentSakerRespons(
                    orgnummer = orgnummer,
                    token = mockOAuth2Server.saksbehandler1.token
                ).statuskode() shouldBe 200
                hentSakerRespons(
                    orgnummer = orgnummer,
                    token = mockOAuth2Server.superbruker1.token
                ).statuskode() shouldBe 200
                hentSakerRespons(
                    orgnummer = orgnummer,
                    token = mockOAuth2Server.brukerUtenTilgangsrolle.token
                ).statuskode() shouldBe 403

                hentSamarbeidshistorikkForOrgnrRespons(
                    orgnr = orgnummer,
                    token = mockOAuth2Server.lesebruker.token
                ).statuskode() shouldBe 200
                hentSamarbeidshistorikkForOrgnrRespons(
                    orgnr = orgnummer,
                    token = mockOAuth2Server.saksbehandler1.token
                ).statuskode() shouldBe 200
                hentSamarbeidshistorikkForOrgnrRespons(
                    orgnr = orgnummer,
                    token = mockOAuth2Server.superbruker1.token
                ).statuskode() shouldBe 200
                hentSamarbeidshistorikkForOrgnrRespons(
                    orgnr = orgnummer,
                    token = mockOAuth2Server.brukerUtenTilgangsrolle.token
                ).statuskode() shouldBe 403
            }
        }
    }

    @Test
    fun `tilgangskontroll - man skal kunne se en sak man selv eier`() {
        nyttOrgnummer().also { orgnummer ->
            opprettSakForVirksomhet(orgnummer, token = mockOAuth2Server.superbruker2.token)
                .nyHendelse(TA_EIERSKAP_I_SAK, token = mockOAuth2Server.saksbehandler1.token).also {
                    hentSakerRespons(
                        orgnummer = orgnummer,
                        token = mockOAuth2Server.saksbehandler1.token
                    ).statuskode() shouldBe 200
                    hentSamarbeidshistorikkForOrgnrRespons(
                        orgnr = orgnummer,
                        token = mockOAuth2Server.saksbehandler1.token
                    ).statuskode() shouldBe 200
                }
        }

        nyttOrgnummer().also { orgnummer ->
            opprettSakForVirksomhet(orgnummer, token = mockOAuth2Server.superbruker2.token)
                .nyHendelse(TA_EIERSKAP_I_SAK, token = mockOAuth2Server.superbruker1.token).also {
                    hentSakerRespons(
                        orgnummer = orgnummer,
                        token = mockOAuth2Server.superbruker1.token
                    ).statuskode() shouldBe 200
                    hentSamarbeidshistorikkForOrgnrRespons(
                        orgnr = orgnummer,
                        token = mockOAuth2Server.superbruker1.token
                    ).statuskode() shouldBe 200
                }
        }
        // PS: lesebruker kan ikke eie en sak, derfor tester vi ikke dette tilfellet
    }

    @Test
    fun `skal kunne spore endringene som har skjedd på en sak`() {
        val orgnummer = nyttOrgnummer()
        val sak = opprettSakForVirksomhet(orgnummer = orgnummer)

        val iaSaker = hentSaker(orgnummer)
        iaSaker.forAtLeastOne {
            it.orgnr shouldBe orgnummer
            it.status shouldBe VURDERES
            it.opprettetAv shouldBe mockOAuth2Server.superbruker1.navIdent
            it.saksnummer shouldBe sak.saksnummer
        }

        nyHendelsePåSak(sak, TA_EIERSKAP_I_SAK, token = mockOAuth2Server.saksbehandler1.token).also {
            it.orgnr shouldBe orgnummer
            it.saksnummer shouldBe sak.saksnummer
            it.status shouldBe VURDERES
            it.opprettetAv shouldBe sak.opprettetAv
            it.eidAv shouldBe mockOAuth2Server.saksbehandler1.navIdent
            it.endretAvHendelseId shouldNotBe sak.endretAvHendelseId
        }
    }

    @Test
    fun `skal kunne hente en oppsummering av alle hendelsene som har skjedd på en sak`() {
        val orgnummer = nyttOrgnummer()
        opprettSakForVirksomhet(orgnummer = orgnummer).also { sak ->
            val valgtÅrsak = ValgtÅrsak(
                type = VIRKSOMHETEN_TAKKET_NEI,
                begrunnelser = listOf(GJENNOMFØRER_TILTAK_MED_BHT, HAR_IKKE_KAPASITET)
            )
            val sakIkkeAktuell = sak
                .nyHendelse(TA_EIERSKAP_I_SAK)
                .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
                .nyHendelse(
                    hendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL,
                    payload = valgtÅrsak.toJson()
                )
            val alleHendelsesTyper = listOf(
                OPPRETT_SAK_FOR_VIRKSOMHET,
                VIRKSOMHET_VURDERES,
                TA_EIERSKAP_I_SAK,
                VIRKSOMHET_SKAL_KONTAKTES,
                VIRKSOMHET_ER_IKKE_AKTUELL
            )
            hentSamarbeidshistorikk(orgnummer, mockOAuth2Server.superbruker1.token).also { sakshistorikkForVirksomhet ->
                val historikkForSak = sakshistorikkForVirksomhet.find { it.saksnummer == sakIkkeAktuell.saksnummer }
                historikkForSak shouldNotBe null
                historikkForSak!!.sakshendelser.map { it.hendelsestype } shouldContainExactly alleHendelsesTyper
                historikkForSak.sakshendelser.forAtLeastOne {
                    it.hendelsestype shouldBe OPPRETT_SAK_FOR_VIRKSOMHET
                    it.tidspunktForSnapshot shouldBe sakIkkeAktuell.opprettetTidspunkt
                }
            }
        }
    }

    @Test
    fun `skal få samarbeidshistorikken til en virksomhet`() {
        val valgtÅrsak = ValgtÅrsak(
            type = NAV_IGANGSETTER_IKKE_TILTAK,
            begrunnelser = listOf(MINDRE_VIRKSOMHET, FOR_LAVT_SYKEFRAVÆR)
        )
        val orgnummer = nyttOrgnummer()
        opprettSakForVirksomhet(orgnummer = orgnummer)
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(
                hendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL,
                payload = valgtÅrsak.toJson()
            )

        hentSamarbeidshistorikk(orgnummer = orgnummer).also { samarbeidshistorikk ->
            samarbeidshistorikk shouldHaveSize 1
            val sakshistorikk = samarbeidshistorikk.first()
            sakshistorikk.sakshendelser.map { it.status } shouldContainExactly listOf(
                NY,
                VURDERES,
                VURDERES,
                KONTAKTES,
                IKKE_AKTUELL
            )
            sakshistorikk.sakshendelser.map { it.hendelsestype } shouldContainExactly listOf(
                OPPRETT_SAK_FOR_VIRKSOMHET,
                VIRKSOMHET_VURDERES,
                TA_EIERSKAP_I_SAK,
                VIRKSOMHET_SKAL_KONTAKTES,
                VIRKSOMHET_ER_IKKE_AKTUELL
            )
            sakshistorikk.sakshendelser.forExactlyOne { sakSnapshot ->
                sakSnapshot.begrunnelser shouldBe valgtÅrsak.begrunnelser.map { it.navn }
            }
        }
    }

    @Test
    fun `skal kunne ta eierskap i en sak`() {
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer()).also { sak ->
            sak.eidAv shouldBe null

            val sakEtterTattEierskap = sak.nyHendelse(hendelsestype = TA_EIERSKAP_I_SAK)
            sakEtterTattEierskap.eidAv shouldBe mockOAuth2Server.saksbehandler1.navIdent

            sakEtterTattEierskap.nyHendelse(
                hendelsestype = TA_EIERSKAP_I_SAK,
                token = mockOAuth2Server.saksbehandler2.token
            ).also {
                it.eidAv shouldBe mockOAuth2Server.saksbehandler2.navIdent
            }

        }
    }

    @Test
    fun `skal få gyldige neste hendelser i retur - avhengig av hvem man er`() {
        val orgnummer = nyttOrgnummer()
        opprettSakForVirksomhet(orgnummer = orgnummer, token = mockOAuth2Server.superbruker1.token).also { sak ->
            hentSaker(
                sak.orgnr,
                token = mockOAuth2Server.superbruker1.token
            ).filter { it.saksnummer == sak.saksnummer }
                .forEach {
                    it.gyldigeNesteHendelser.map { it.saksHendelsestype }
                        .shouldContainExactlyInAnyOrder(TA_EIERSKAP_I_SAK, SLETT_SAK)
                }
            hentSaker(
                sak.orgnr,
                token = mockOAuth2Server.saksbehandler1.token
            ).filter { it.saksnummer == sak.saksnummer }
                .forEach {
                    it.gyldigeNesteHendelser.forAll {
                        it.saksHendelsestype shouldBe TA_EIERSKAP_I_SAK
                    }
                }
            hentSaker(orgnummer, token = mockOAuth2Server.lesebruker.token).filter { it.saksnummer == sak.saksnummer }
                .forEach {
                    it.gyldigeNesteHendelser.shouldBeEmpty()
                }
        }
    }

    @Test
    fun `skal få liste med mulige årsaker og begrunnelser sammen med virksomhet ikke aktuell-hendelsen`() {
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK).also { sakEtterTattEierskap ->
                sakEtterTattEierskap.gyldigeNesteHendelser
                    .shouldForAtLeastOne {
                        it.saksHendelsestype shouldBe VIRKSOMHET_ER_IKKE_AKTUELL
                        it.gyldigeÅrsaker.shouldForAtLeastOne {
                            it.type shouldBe NAV_IGANGSETTER_IKKE_TILTAK
                            it.navn shouldBe NAV_IGANGSETTER_IKKE_TILTAK.navn
                            it.begrunnelser.somBegrunnelseType().shouldContainAll(
                                MANGLER_PARTSGRUPPE,
                                IKKE_TILFREDSSTILLENDE_SAMARBEID,
                                FOR_LAVT_SYKEFRAVÆR,
                                IKKE_TID,
                                MINDRE_VIRKSOMHET
                            )
                        }
                        it.gyldigeÅrsaker.shouldForAtLeastOne {
                            it.type shouldBe VIRKSOMHETEN_TAKKET_NEI
                            it.navn shouldBe VIRKSOMHETEN_TAKKET_NEI.navn
                            it.begrunnelser.somBegrunnelseType().shouldContainAll(
                                HAR_IKKE_KAPASITET,
                                GJENNOMFØRER_TILTAK_PÅ_EGENHÅND,
                                GJENNOMFØRER_TILTAK_MED_BHT
                            )
                        }
                    }.shouldForAtLeastOne {
                        it.saksHendelsestype shouldBe VIRKSOMHET_SKAL_KONTAKTES
                        it.gyldigeÅrsaker.shouldBeEmpty()
                    }
            }
    }

    @Test
    fun `skal få korrekt json for listen med mulige årsaker og begrunnelser`() {
        val sakForVirksomhet = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())

        val sakJson = nyHendelsePåSakRequest(
            sak = sakForVirksomhet,
            hendelsestype = TA_EIERSKAP_I_SAK,
            payload = null,
            token = mockOAuth2Server.saksbehandler1.token,
        ).responseString().third.get()

        sakJson.shouldEqualSpecifiedJson(
            """
              {
                  "gyldigeNesteHendelser": [
                    {
                      "saksHendelsestype": "VIRKSOMHET_SKAL_KONTAKTES",
                      "gyldigeÅrsaker": []
                    },
                    {
                      "saksHendelsestype": "VIRKSOMHET_ER_IKKE_AKTUELL",
                      "gyldigeÅrsaker": [
                        {
                          "type": "NAV_IGANGSETTER_IKKE_TILTAK",
                          "navn": "${NAV_IGANGSETTER_IKKE_TILTAK.navn}",
                          "begrunnelser": [
                            {
                              "type": "MANGLER_PARTSGRUPPE",
                              "navn": "${MANGLER_PARTSGRUPPE.navn}"
                            },
                            {
                              "type": "IKKE_TILFREDSSTILLENDE_SAMARBEID",
                              "navn": "${IKKE_TILFREDSSTILLENDE_SAMARBEID.navn}"
                            },
                            {
                              "type": "FOR_LAVT_SYKEFRAVÆR",
                              "navn": "${FOR_LAVT_SYKEFRAVÆR.navn}"
                            },
                            {
                              "type": "IKKE_TID",
                              "navn": "${IKKE_TID.navn}"
                            },
                            {
                              "type": "MINDRE_VIRKSOMHET",
                              "navn": "${MINDRE_VIRKSOMHET.navn}"
                            }
                          ]
                        },
                        {
                          "type": "VIRKSOMHETEN_TAKKET_NEI",
                          "navn": "${VIRKSOMHETEN_TAKKET_NEI.navn}",
                          "begrunnelser": [
                            {
                              "type": "HAR_IKKE_KAPASITET",
                              "navn": "${HAR_IKKE_KAPASITET.navn}"
                            },
                            {
                              "type": "GJENNOMFØRER_TILTAK_PÅ_EGENHÅND",
                              "navn": "${GJENNOMFØRER_TILTAK_PÅ_EGENHÅND.navn}"
                            },
                            {
                              "type": "GJENNOMFØRER_TILTAK_MED_BHT",
                              "navn": "${GJENNOMFØRER_TILTAK_MED_BHT.navn}"
                            }
                          ]
                        }
                      ]
                    }
                  ]
              }
            """.trimIndent()
        )
    }

    @Test
    fun `skal kunne se valgte begrunnelser for når en virksomhet ikke er aktuell`() {
        val begrunnelser = listOf(GJENNOMFØRER_TILTAK_MED_BHT, HAR_IKKE_KAPASITET)
        val orgnummer = nyttOrgnummer()
        opprettSakForVirksomhet(orgnummer = orgnummer).also { sak ->
            val sakIkkeAktuell = sak
                .nyHendelse(TA_EIERSKAP_I_SAK)
                .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
                .nyHendelse(
                    hendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL,
                    payload = ValgtÅrsak(
                        type = VIRKSOMHETEN_TAKKET_NEI,
                        begrunnelser = begrunnelser
                    ).toJson()
                )
            hentSamarbeidshistorikk(orgnummer, mockOAuth2Server.superbruker1.token).first().sakshendelser
                .forAtLeastOne { hendelseOppsummering ->
                    hendelseOppsummering.hendelsestype shouldBe VIRKSOMHET_ER_IKKE_AKTUELL
                    hendelseOppsummering.tidspunktForSnapshot shouldBe sakIkkeAktuell.endretTidspunkt
                    hendelseOppsummering.begrunnelser shouldContainAll begrunnelser.map { it.navn }
                }
        }
    }

    @Test
    fun `skal ikke kunne legge til hendelser på en sak som er oppdatert av en annen hendelse`() {
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer()).also { sak ->
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

    @Test
    fun `for å sette en sak til ikke aktuell må man ha en begrunnelse`() {
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelseRespons(
                hendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL,
                payload = ValgtÅrsak(
                    type = VIRKSOMHETEN_TAKKET_NEI,
                    begrunnelser = emptyList()
                ).toJson()
            ).statuskode() shouldBe HttpStatusCode.UnprocessableEntity.value
    }

    @Test
    fun `en sak skal bare godta gyldige begrunnelser`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
        shouldFail {
            sak.nyHendelse(
                hendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL,
                payload = """
                    {"type":"VIRKSOMHETEN_TAKKET_NEI","begrunnelser":["IKKE_ET_FAKTISK_TILTAK"]}
                """.trimIndent()
            )
        }
    }

    @Test
    fun `saksbehandler som eier sak skal kunne gå tilbake i prosessflyten`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(TILBAKE)
        sak.status shouldBe VURDERES
    }

    @Test
    fun `tilgangskontroll - saksbehandler som ikke eier sak skal ikke kunne gå tilbake i prosessflyten`() {
        val saksbehandler1 = mockOAuth2Server.saksbehandler1.token
        val saksbehandler2 = mockOAuth2Server.saksbehandler2.token
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(hendelsestype = TA_EIERSKAP_I_SAK, token = saksbehandler1)
            .nyHendelse(hendelsestype = VIRKSOMHET_SKAL_KONTAKTES, token = saksbehandler1)
        shouldFail {
            sak.nyHendelse(hendelsestype = TILBAKE, token = saksbehandler2)
        }
    }

    @Test
    fun `skal ikke kunne gå tilbake i prosessflyten dersom man er i vurderes status`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
        shouldFail {
            sak.nyHendelse(TILBAKE)
        }
    }

    @Test
    fun `skal kunne gå tilbake til vurderes fra ikke aktuell`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(
                hendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL, payload = ValgtÅrsak(
                    type = VIRKSOMHETEN_TAKKET_NEI,
                    begrunnelser = listOf(HAR_IKKE_KAPASITET)
                ).toJson()
            )
            .nyHendelse(TILBAKE)
        sak.status shouldBe VURDERES
    }

    @Test
    fun `skal IKKE kunne gå tilbake til vi bistår fra fullført etter fristen har gått`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(VIRKSOMHET_KARTLEGGES)
            .nyHendelse(VIRKSOMHET_SKAL_BISTÅS)
            .nyHendelse(FULLFØR_BISTAND)
            .oppdaterHendelsesTidspunkter(antallDagerTilbake = ANTALL_DAGER_FØR_SAK_LÅSES + 1)

        shouldFail {
            sak.nyHendelse(TILBAKE)
        }

        hentSaker(orgnummer = sak.orgnr).filter { it.saksnummer == sak.saksnummer }.forExactlyOne { enSak ->
            enSak.status shouldBe FULLFØRT
            enSak.gyldigeNesteHendelser.map { it.saksHendelsestype } shouldBe listOf()
        }
    }

    @Test
    fun `skal IKKE kunne gå tilbake til forrige tilstand fra ikke aktuell etter fristen har gått`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyIkkeAktuellHendelse()
            .oppdaterHendelsesTidspunkter(antallDagerTilbake = ANTALL_DAGER_FØR_SAK_LÅSES + 1)

        shouldFail {
            sak.nyHendelse(TILBAKE)
        }

        hentSaker(orgnummer = sak.orgnr).filter { it.saksnummer == sak.saksnummer }.forExactlyOne { enSak ->
            enSak.status shouldBe IKKE_AKTUELL
            enSak.gyldigeNesteHendelser.map { it.saksHendelsestype } shouldBe listOf()
        }
    }

    @Test
    fun `skal ikke få OPPRETT_SAK_FOR_VIRKSOMHET som gyldig neste hendelse`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyIkkeAktuellHendelse()
        sak.gyldigeNesteHendelser.map { it.saksHendelsestype } shouldBe listOf(TILBAKE)

        hentSaker(sak.orgnr, token = oauth2ServerContainer.superbruker1.token)
            .filter { it.saksnummer == sak.saksnummer }
            .forExactlyOne { sakDto ->
                sakDto.gyldigeNesteHendelser.map { it.saksHendelsestype } shouldBe listOf(TA_EIERSKAP_I_SAK)
            }

        sak.oppdaterHendelsesTidspunkter(
            antallDagerTilbake = ANTALL_DAGER_FØR_SAK_LÅSES + 1,
            token = oauth2ServerContainer.superbruker1.token).also { sakDto ->
            sakDto.gyldigeNesteHendelser.map { it.saksHendelsestype } shouldBe  emptyList()
        }
    }

    @Test
    fun `skal kunne gå tilbake til vi bistår fra fullført`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(VIRKSOMHET_KARTLEGGES)
            .nyHendelse(VIRKSOMHET_SKAL_BISTÅS)
            .nyHendelse(FULLFØR_BISTAND)
            .nyHendelse(TILBAKE)
        sak.status shouldBe VI_BISTÅR
    }

    @Test
    fun `skal kunne overta sak som står som fullført og deretter tilbake til vi bistår`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK, token = oauth2ServerContainer.saksbehandler1.token)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(VIRKSOMHET_KARTLEGGES)
            .nyHendelse(VIRKSOMHET_SKAL_BISTÅS)
            .nyHendelse(FULLFØR_BISTAND)

        val sakEtterOvertakelse = sak.nyHendelse(TA_EIERSKAP_I_SAK, token = oauth2ServerContainer.saksbehandler2.token)

        sakEtterOvertakelse.status shouldBe FULLFØRT
        sakEtterOvertakelse.eidAv shouldBe oauth2ServerContainer.saksbehandler2.navIdent

        val sakEtterTilbake =
            sakEtterOvertakelse.nyHendelse(TILBAKE, token = oauth2ServerContainer.saksbehandler2.token)

        sakEtterTilbake.status shouldBe VI_BISTÅR
        sakEtterTilbake.eidAv shouldBe oauth2ServerContainer.saksbehandler2.navIdent
    }

    @Test
    fun `skal ikke kunne gå tilbake fra fullført status dersom virksomheten har en annen åpen sak`() {
        val virksomhet = lastInnNyVirksomhet()
        val fullførtSak = opprettSakForVirksomhet(orgnummer = virksomhet.orgnr)
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(VIRKSOMHET_KARTLEGGES)
            .nyHendelse(VIRKSOMHET_SKAL_BISTÅS)
            .nyHendelse(FULLFØR_BISTAND)

        opprettSakForVirksomhet(orgnummer = virksomhet.orgnr)

        shouldFail {
            fullførtSak.nyHendelse(TILBAKE)
        }
    }

    @Test
    fun `skal kunne sette en sak i 'Vi bistår'`() {
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .also { sak -> shouldFail { sak.nyHendelse(VIRKSOMHET_SKAL_BISTÅS) } }
            .nyHendelse(VIRKSOMHET_KARTLEGGES)
            .also { sak -> sak.status shouldBe KARTLEGGES }
            .nyHendelse(VIRKSOMHET_SKAL_BISTÅS)
            .also { sak -> sak.status shouldBe VI_BISTÅR }
    }

    @Test
    fun `skal kunne fullføre en sak fra 'Vi Bistår' status`() {
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(VIRKSOMHET_KARTLEGGES)
            .also { sak ->
                shouldFail {
                    sak.nyHendelse(FULLFØR_BISTAND)
                }
            }
            .nyHendelse(VIRKSOMHET_SKAL_BISTÅS)
            .nyHendelse(FULLFØR_BISTAND)
            .also { sak -> sak.status shouldBe FULLFØRT }
    }

    @Test
    fun `skal kunne sette en sak til ikke aktuell fra 'Vi bistår'`() {
        val orgnummer = nyttOrgnummer()
        val begrunnelser = listOf(HAR_IKKE_KAPASITET)


        val sakIStatusViBistår = opprettSakForVirksomhet(orgnummer = orgnummer)
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(VIRKSOMHET_KARTLEGGES)
            .nyHendelse(VIRKSOMHET_SKAL_BISTÅS)
            .also { sak -> sak.status shouldBe VI_BISTÅR }

        // Sjekk at 'Ikke aktuell' er en gyldig neste hendelse
        sakIStatusViBistår.gyldigeNesteHendelser.map { it.saksHendelsestype } shouldContain VIRKSOMHET_ER_IKKE_AKTUELL

        // Trykk på 'Ikke aktuell', med begrunnelse
        val sakIkkeAktuell = sakIStatusViBistår.nyHendelse(
            hendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL, payload = ValgtÅrsak(
                type = VIRKSOMHETEN_TAKKET_NEI,
                begrunnelser = begrunnelser
            ).toJson()
        ).also { sak -> sak.status shouldBe IKKE_AKTUELL }

        // Sjekk at begrunnelsen blir lagret
        hentSamarbeidshistorikk(orgnummer, mockOAuth2Server.superbruker1.token).first().sakshendelser
            .forAtLeastOne { hendelseOppsummering ->
                hendelseOppsummering.hendelsestype shouldBe VIRKSOMHET_ER_IKKE_AKTUELL
                hendelseOppsummering.tidspunktForSnapshot shouldBe sakIkkeAktuell.endretTidspunkt
                hendelseOppsummering.begrunnelser shouldContainAll begrunnelser.map { it.navn }
            }
    }

    @Test
    fun `skal kunne sette en sak til ikke aktuell fra 'Kartlegges'`() {
        val orgnummer = nyttOrgnummer()
        val begrunnelser = listOf(HAR_IKKE_KAPASITET)


        val sakIStatusKartlegges = opprettSakForVirksomhet(orgnummer = orgnummer)
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(VIRKSOMHET_KARTLEGGES)
            .also { sak -> sak.status shouldBe KARTLEGGES }

        // Sjekk at 'Ikke aktuell' er en gyldig neste hendelse
        sakIStatusKartlegges.gyldigeNesteHendelser.map { it.saksHendelsestype } shouldContain VIRKSOMHET_ER_IKKE_AKTUELL

        // Trykk på 'Ikke aktuell', med begrunnelse
        val sakIkkeAktuell = sakIStatusKartlegges.nyHendelse(
            hendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL, payload = ValgtÅrsak(
                type = VIRKSOMHETEN_TAKKET_NEI,
                begrunnelser = begrunnelser
            ).toJson()
        ).also { sak -> sak.status shouldBe IKKE_AKTUELL }

        // Sjekk at begrunnelsen blir lagret
        hentSamarbeidshistorikk(orgnummer, mockOAuth2Server.superbruker1.token).first().sakshendelser
            .forAtLeastOne { hendelseOppsummering ->
                hendelseOppsummering.hendelsestype shouldBe VIRKSOMHET_ER_IKKE_AKTUELL
                hendelseOppsummering.tidspunktForSnapshot shouldBe sakIkkeAktuell.endretTidspunkt
                hendelseOppsummering.begrunnelser shouldContainAll begrunnelser.map { it.navn }
            }
    }

    @Test
    fun `skal vise bare èn riktig status gjennom livsløpet til en ny sak`() {
        hentSykefravær(
            token = mockOAuth2Server.superbruker1.token,
            success = { response ->
                val org = response.data.filter { it.status == IKKE_AKTIV }.random()
                val sak = opprettSakForVirksomhet(orgnummer = org.orgnr)
                    .nyHendelse(TA_EIERSKAP_I_SAK)
                    .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
                    .nyHendelse(VIRKSOMHET_KARTLEGGES)
                    .nyHendelse(VIRKSOMHET_SKAL_BISTÅS)
                    .nyHendelse(FULLFØR_BISTAND)
                hentSykefravær( // Tester at vi får se FULLFØRT intil fristen går ut
                    token = mockOAuth2Server.superbruker1.token,
                    success = { response ->
                        response.data.filter { it.orgnr == org.orgnr }.forExactlyOne { it.status shouldBe FULLFØRT }
                    }
                )

                sak.oppdaterHendelsesTidspunkter(ANTALL_DAGER_FØR_SAK_LÅSES + 1)
                hentSykefravær( // Tester at vi faller tilbake til IKKE_AKTIV når fristen har gått ut
                    token = mockOAuth2Server.superbruker1.token,
                    success = { response ->
                        response.data.filter { it.orgnr == org.orgnr }.forExactlyOne { it.status shouldBe IKKE_AKTIV }
                    }
                )

                opprettSakForVirksomhet(orgnummer = org.orgnr)
                    .nyHendelse(TA_EIERSKAP_I_SAK)
                    .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
                    .nyHendelse(VIRKSOMHET_KARTLEGGES)

                hentSykefravær( // Viser siste status når vi har fått en ny sak
                    token = mockOAuth2Server.superbruker1.token,
                    success = { response ->
                        response.data.filter { it.orgnr == org.orgnr }.forExactlyOne { it.status shouldBe KARTLEGGES }
                    }
                )
            }
        )
    }

    @Test
    fun `nye versjoner av tilstandsmaskinen skal ikke gi andre statuser for gammel evntrekke`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(TILBAKE)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(VIRKSOMHET_KARTLEGGES)
            .nyHendelse(TILBAKE)
            .nyHendelse(VIRKSOMHET_KARTLEGGES)
            .nyHendelse(
                hendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL,
                payload = ValgtÅrsak(
                    type = VIRKSOMHETEN_TAKKET_NEI,
                    begrunnelser = listOf(GJENNOMFØRER_TILTAK_MED_BHT, HAR_IKKE_KAPASITET)
                ).toJson())
            .nyHendelse(TILBAKE)
            .nyHendelse(VIRKSOMHET_SKAL_BISTÅS)
            .nyHendelse(TILBAKE)
            .nyHendelse(VIRKSOMHET_SKAL_BISTÅS)
            .nyHendelse(FULLFØR_BISTAND)

        hentSaker(orgnummer = sak.orgnr).filter { it.saksnummer == sak.saksnummer }.forExactlyOne { enSak ->
            enSak.status shouldBe FULLFØRT
        }
    }

}
