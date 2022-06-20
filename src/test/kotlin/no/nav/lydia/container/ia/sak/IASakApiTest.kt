package no.nav.lydia.container.ia.sak

import com.github.guepardoapps.kulid.ULID
import io.kotest.assertions.json.shouldEqualSpecifiedJson
import io.kotest.assertions.shouldFail
import io.kotest.inspectors.forAll
import io.kotest.inspectors.forAtLeastOne
import io.kotest.inspectors.shouldForAtLeastOne
import io.kotest.matchers.collections.*
import io.kotest.matchers.equality.shouldBeEqualToComparingFields
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.ktor.http.*
import no.nav.lydia.helper.*
import no.nav.lydia.helper.SakHelper.Companion.hentHendelserPåSak
import no.nav.lydia.helper.SakHelper.Companion.hentHendelserPåSakRespons
import no.nav.lydia.helper.SakHelper.Companion.hentSaker
import no.nav.lydia.helper.SakHelper.Companion.hentSakerRespons
import no.nav.lydia.helper.SakHelper.Companion.hentSamarbeidsHistorikk
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.nyHendelsePåSak
import no.nav.lydia.helper.SakHelper.Companion.nyHendelsePåSakMedRespons
import no.nav.lydia.helper.SakHelper.Companion.nyHendelsePåSakRequest
import no.nav.lydia.helper.SakHelper.Companion.nyHendelseRespons
import no.nav.lydia.helper.SakHelper.Companion.opprettSakForVirksomhet
import no.nav.lydia.helper.SakHelper.Companion.opprettSakForVirksomhetRespons
import no.nav.lydia.helper.SakHelper.Companion.toJson
import no.nav.lydia.helper.StatistikkHelper.Companion.hentSykefravær
import no.nav.lydia.helper.TestContainerHelper.Companion.oauth2ServerContainer
import no.nav.lydia.helper.VirksomhetHelper.Companion.nyttOrgnummer
import no.nav.lydia.ia.sak.api.IASakshendelseDto
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.SaksHendelsestype.*
import no.nav.lydia.ia.årsak.domene.BegrunnelseType.*
import no.nav.lydia.ia.årsak.domene.GyldigBegrunnelse.Companion.somBegrunnelseType
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.ia.årsak.domene.ÅrsakType.NAV_IGANGSETTER_IKKE_TILTAK
import no.nav.lydia.ia.årsak.domene.ÅrsakType.VIRKSOMHETEN_TAKKET_NEI
import no.nav.lydia.sykefraversstatistikk.api.geografi.Kommune
import kotlin.test.Test
import kotlin.test.assertTrue

class IASakApiTest {
    val mockOAuth2Server = oauth2ServerContainer
    val postgresContainer = TestContainerHelper.postgresContainer

    @Test
    fun `skal kunne sette en virksomhet i kontaktes status`() {
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .also {
                it.status shouldBe IAProsessStatus.KONTAKTES
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
                it.status shouldBe IAProsessStatus.KONTAKTES
            }
    }


    @Test
    fun `skal kunne vise at en virksomhet vurderes og vise status i listevisning`() {
        val utsiraKommune = Kommune(navn = "Utsira", nummer = "1151")
        val virksomhet =
            VirksomhetHelper.lastInnNyVirksomhet(TestVirksomhet.nyVirksomhet(TestVirksomhet.beliggenhet(kommune = utsiraKommune)))
        hentSykefravær(success = { listeFørVirksomhetVurderes ->
            listeFørVirksomhetVurderes.data shouldHaveAtLeastSize 1
            listeFørVirksomhetVurderes.data.shouldForAtLeastOne { sykefraversstatistikkVirksomhetDto ->
                sykefraversstatistikkVirksomhetDto.orgnr shouldBe virksomhet.orgnr
                sykefraversstatistikkVirksomhetDto.status shouldBe IAProsessStatus.IKKE_AKTIV
            }
        }, kommuner = utsiraKommune.nummer)
        val sak = opprettSakForVirksomhet(orgnummer = virksomhet.orgnr)
        assertTrue(ULID.isValid(ulid = sak.saksnummer))
        hentSykefravær(success = { listeEtterVirksomhetVurderes ->
            listeEtterVirksomhetVurderes.data shouldHaveAtLeastSize 1
            listeEtterVirksomhetVurderes.data.shouldForAtLeastOne { sykefraversstatistikkVirksomhetDto ->
                sykefraversstatistikkVirksomhetDto.orgnr shouldBe virksomhet.orgnr
                sykefraversstatistikkVirksomhetDto.status shouldBe IAProsessStatus.VURDERES
            }
        }, kommuner = utsiraKommune.nummer)

    }

    @Test
    fun `skal ikke kunne opprette to saker på en virksomhet i første MVP (Men bør kunne gjøre det på sikt)`() {
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
        opprettSakForVirksomhet(orgnummer = orgnummer, token = mockOAuth2Server.superbruker1.token).also { sak ->
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

            hentHendelserPåSakRespons(
                saksnummer = sak.saksnummer,
                token = mockOAuth2Server.lesebruker.token
            ).statuskode() shouldBe 200
            hentHendelserPåSakRespons(
                saksnummer = sak.saksnummer,
                token = mockOAuth2Server.saksbehandler1.token
            ).statuskode() shouldBe 200
            hentHendelserPåSakRespons(
                saksnummer = sak.saksnummer,
                token = mockOAuth2Server.superbruker1.token
            ).statuskode() shouldBe 200
            hentHendelserPåSakRespons(
                saksnummer = sak.saksnummer,
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

                hentHendelserPåSakRespons(
                    saksnummer = sak.saksnummer,
                    token = mockOAuth2Server.lesebruker.token
                ).statuskode() shouldBe 200
                hentHendelserPåSakRespons(
                    saksnummer = sak.saksnummer,
                    token = mockOAuth2Server.saksbehandler1.token
                ).statuskode() shouldBe 200
                hentHendelserPåSakRespons(
                    saksnummer = sak.saksnummer,
                    token = mockOAuth2Server.superbruker1.token
                ).statuskode() shouldBe 200
                hentHendelserPåSakRespons(
                    saksnummer = sak.saksnummer,
                    token = mockOAuth2Server.brukerUtenTilgangsrolle.token
                ).statuskode() shouldBe 403
            }
        }
    }

    @Test
    fun `tilgangskontroll - man skal kunne se en sak man selv eier`() {
        nyttOrgnummer().also { orgnummer ->
            opprettSakForVirksomhet(orgnummer, token = mockOAuth2Server.superbruker2.token)
                .nyHendelse(TA_EIERSKAP_I_SAK, token = mockOAuth2Server.saksbehandler1.token).also { sak ->
                    hentSakerRespons(
                        orgnummer = orgnummer,
                        token = mockOAuth2Server.saksbehandler1.token
                    ).statuskode() shouldBe 200
                    hentHendelserPåSakRespons(
                        saksnummer = sak.saksnummer,
                        token = mockOAuth2Server.saksbehandler1.token
                    ).statuskode() shouldBe 200
                }
        }

        nyttOrgnummer().also { orgnummer ->
            opprettSakForVirksomhet(orgnummer, token = mockOAuth2Server.superbruker2.token)
                .nyHendelse(TA_EIERSKAP_I_SAK, token = mockOAuth2Server.superbruker1.token).also { sak ->
                    hentSakerRespons(
                        orgnummer = orgnummer,
                        token = mockOAuth2Server.superbruker1.token
                    ).statuskode() shouldBe 200
                    hentHendelserPåSakRespons(
                        saksnummer = sak.saksnummer,
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
            it.status shouldBe IAProsessStatus.VURDERES
            it.opprettetAv shouldBe mockOAuth2Server.superbruker1.navIdent
            it.saksnummer shouldBe sak.saksnummer
        }

        nyHendelsePåSak(sak, TA_EIERSKAP_I_SAK, token = mockOAuth2Server.saksbehandler1.token).also {
            it.orgnr shouldBe orgnummer
            it.saksnummer shouldBe sak.saksnummer
            it.status shouldBe IAProsessStatus.VURDERES
            it.opprettetAv shouldBe sak.opprettetAv
            it.eidAv shouldBe mockOAuth2Server.saksbehandler1.navIdent
            it.endretAvHendelseId shouldNotBe sak.endretAvHendelseId
        }
    }

    @Test
    fun `skal kunne hente en oppsummering av alle hendelsene som har skjedd på en sak`() {
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer()).also { sak ->
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
            hentHendelserPåSak(sakIkkeAktuell.saksnummer).also { oppsummering ->
                oppsummering.map { it.hendelsestype } shouldContainExactly alleHendelsesTyper
                oppsummering.forExactlyOne {
                    it.hendelsestype shouldBe OPPRETT_SAK_FOR_VIRKSOMHET
                    it.opprettetTidspunkt shouldBe sakIkkeAktuell.opprettetTidspunkt
                    it.valgtÅrsak shouldBe null
                }
                oppsummering.forExactlyOne {
                    it.hendelsestype shouldBe VIRKSOMHET_ER_IKKE_AKTUELL
                    it.valgtÅrsak shouldNotBe null
                    it.valgtÅrsak!! shouldBeEqualToComparingFields valgtÅrsak
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

        hentSamarbeidsHistorikk(orgnummer = orgnummer).also { samarbeidshistorikk ->
            samarbeidshistorikk shouldHaveSize 1
            val sakshistorikk = samarbeidshistorikk.first()
            sakshistorikk.sakshendelser.map { it.status } shouldContainExactly listOf(
                IAProsessStatus.VURDERES,
                IAProsessStatus.VURDERES,
                IAProsessStatus.KONTAKTES,
                IAProsessStatus.IKKE_AKTUELL
            )
            sakshistorikk.sakshendelser.map { it.hendelsestype } shouldContainExactly listOf(
                VIRKSOMHET_VURDERES,
                TA_EIERSKAP_I_SAK,
                VIRKSOMHET_SKAL_KONTAKTES,
                VIRKSOMHET_ER_IKKE_AKTUELL
            )
            sakshistorikk.sakshendelser.forExactlyOne {
                it.begrunnelser shouldBe valgtÅrsak.begrunnelser
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
            token = oauth2ServerContainer.saksbehandler1.token,
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
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer()).also { sak ->
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
            hentHendelserPåSak(sakIkkeAktuell.saksnummer)
                .forAtLeastOne { hendelseOppsummering ->
                    hendelseOppsummering.hendelsestype shouldBe VIRKSOMHET_ER_IKKE_AKTUELL
                    hendelseOppsummering.opprettetTidspunkt shouldBe sakIkkeAktuell.endretTidspunkt
                    postgresContainer.performQuery(
                        "select * from hendelse_begrunnelse where hendelse_id = '${hendelseOppsummering.id}'"
                    ).also { rs ->
                        rs.row shouldBe 1
                        rs.getString("begrunnelse") shouldBe begrunnelser.first().navn
                        rs.next()
                        rs.getString("begrunnelse") shouldBe begrunnelser[1].navn
                    }
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
        sak.status shouldBe IAProsessStatus.VURDERES
    }

    @Test
    fun `tilgangskontroll - saksbehandler som ikke eier sak skal ikke kunne gå tilbake i prosessflyten`() {
        val saksbehandler1 = oauth2ServerContainer.saksbehandler1.token
        val saksbehandler2 = oauth2ServerContainer.saksbehandler2.token
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
        sak.status shouldBe IAProsessStatus.VURDERES
    }
}
