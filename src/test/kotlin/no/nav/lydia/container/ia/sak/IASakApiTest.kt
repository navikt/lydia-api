package no.nav.lydia.container.ia.sak

import com.github.guepardoapps.kulid.ULID
import io.kotest.assertions.shouldFail
import io.kotest.inspectors.forAll
import io.kotest.inspectors.forAtLeastOne
import io.kotest.inspectors.shouldForAtLeastOne
import io.kotest.matchers.collections.shouldBeEmpty
import io.kotest.matchers.collections.shouldContainAll
import io.kotest.matchers.collections.shouldContainExactly
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.ktor.http.*
import no.nav.lydia.helper.SakHelper.Companion.hentHendelserPåSak
import no.nav.lydia.helper.SakHelper.Companion.hentHendelserPåSakRespons
import no.nav.lydia.helper.SakHelper.Companion.hentSaker
import no.nav.lydia.helper.SakHelper.Companion.hentSakerRespons
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.nyHendelsePåSak
import no.nav.lydia.helper.SakHelper.Companion.nyHendelsePåSakMedRespons
import no.nav.lydia.helper.SakHelper.Companion.nyHendelseRespons
import no.nav.lydia.helper.SakHelper.Companion.opprettSakForVirksomhet
import no.nav.lydia.helper.SakHelper.Companion.opprettSakForVirksomhetRespons
import no.nav.lydia.helper.SakHelper.Companion.toJson
import no.nav.lydia.helper.StatistikkHelper.Companion.hentSykefravær
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestVirksomhet.Companion.BERGEN
import no.nav.lydia.helper.TestVirksomhet.Companion.OSLO
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.statuskode
import no.nav.lydia.ia.sak.api.IASakshendelseDto
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.SaksHendelsestype.*
import no.nav.lydia.ia.årsak.domene.BegrunnelseType.GJENNOMFØRER_TILTAK_MED_BHT
import no.nav.lydia.ia.årsak.domene.BegrunnelseType.HAR_IKKE_KAPASITET
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.ia.årsak.domene.ÅrsakType.NAV_IGANGSETTER_IKKE_TILTAK
import no.nav.lydia.ia.årsak.domene.ÅrsakType.VIRKSOMHETEN_TAKKET_NEI
import kotlin.test.Test
import kotlin.test.assertTrue

class IASakApiTest {
    val mockOAuth2Server = TestContainerHelper.oauth2ServerContainer
    val postgresContainer = TestContainerHelper.postgresContainer

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
        postgresContainer.performUpdate("DELETE FROM sykefravar_statistikk_grunnlag WHERE orgnr = '$orgnr'")
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
        val orgnummer = OSLO.orgnr
        opprettSakForVirksomhet(orgnummer, token = mockOAuth2Server.superbruker1.token).also {

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
        val orgnummer = OSLO.orgnr
        opprettSakForVirksomhet(orgnummer, token = mockOAuth2Server.superbruker1.token).also { sak ->
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
        val orgnummer = OSLO.orgnr
        opprettSakForVirksomhet(orgnummer, token = mockOAuth2Server.superbruker1.token).also { sak ->
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
        val orgnummer = OSLO.orgnr
        opprettSakForVirksomhet(orgnummer, token = mockOAuth2Server.superbruker1.token).also { sak ->
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
        val orgnummer = OSLO.orgnr
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
                .nyHendelse(
                    hendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL,
                    payload = ValgtÅrsak(
                        type = VIRKSOMHETEN_TAKKET_NEI,
                        begrunnelser = listOf(GJENNOMFØRER_TILTAK_MED_BHT, HAR_IKKE_KAPASITET)
                    ).toJson()
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
                }
            }
        }
    }

    @Test
    fun `skal kunne ta eierskap i en sak`() {
        opprettSakForVirksomhet(OSLO.orgnr).also { sak ->
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
        opprettSakForVirksomhet(OSLO.orgnr, token = mockOAuth2Server.superbruker1.token).also { sak ->
            hentSaker(
                sak.orgnr,
                token = mockOAuth2Server.saksbehandler1.token
            ).filter { it.saksnummer == sak.saksnummer }
                .forEach {
                    it.gyldigeNesteHendelser.forAll {
                        it.saksHendelsestype shouldBe TA_EIERSKAP_I_SAK
                    }
                }
            hentSaker(OSLO.orgnr, token = mockOAuth2Server.lesebruker.token).filter { it.saksnummer == sak.saksnummer }
                .forEach {
                    it.gyldigeNesteHendelser.shouldBeEmpty()
                }
        }
    }

    @Test
    fun `skal få liste med mulige årsaker og begrunnelser sammen med virksomhet ikke aktuell-hendelsen`() {
        opprettSakForVirksomhet(orgnummer = BERGEN.orgnr)
            .nyHendelse(TA_EIERSKAP_I_SAK).also { sakEtterTattEierskap ->
                sakEtterTattEierskap.gyldigeNesteHendelser
                    .shouldForAtLeastOne { gyldigHendelse ->
                        gyldigHendelse.saksHendelsestype shouldBe VIRKSOMHET_ER_IKKE_AKTUELL
                        gyldigHendelse.gyldigeÅrsaker shouldContainAll listOf(
                            NAV_IGANGSETTER_IKKE_TILTAK,
                            VIRKSOMHETEN_TAKKET_NEI
                        )
                        gyldigHendelse.gyldigeÅrsaker.find { it == NAV_IGANGSETTER_IKKE_TILTAK }?.let { årsakType ->
                            årsakType.begrunnelser shouldContainAll NAV_IGANGSETTER_IKKE_TILTAK.begrunnelser
                        }
                        gyldigHendelse.gyldigeÅrsaker.find { it == VIRKSOMHETEN_TAKKET_NEI }?.let { årsakType ->
                            årsakType.begrunnelser shouldContainAll VIRKSOMHETEN_TAKKET_NEI.begrunnelser

                        }
                    }.shouldForAtLeastOne {
                        it.saksHendelsestype shouldBe VIRKSOMHET_SKAL_KONTAKTES
                        it.gyldigeÅrsaker.shouldBeEmpty()
                    }
            }
    }

    @Test
    fun `skal kunne se valgte begrunnelser for når en virksomhet ikke er aktuell`() {
        val begrunnelser = listOf(GJENNOMFØRER_TILTAK_MED_BHT, HAR_IKKE_KAPASITET)
        opprettSakForVirksomhet(orgnummer = BERGEN.orgnr).also { sak ->
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

    @Test
    fun `for å sette en sak til ikke aktuell må man ha en begrunnelse`() {
        opprettSakForVirksomhet(orgnummer = BERGEN.orgnr)
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
        val sak = opprettSakForVirksomhet(orgnummer = BERGEN.orgnr)
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
}
