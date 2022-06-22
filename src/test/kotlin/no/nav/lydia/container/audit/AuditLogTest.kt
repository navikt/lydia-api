package no.nav.lydia.container.audit

import com.github.kittinunf.fuel.core.Request
import no.nav.lydia.AuditType
import no.nav.lydia.Tillat
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.StatistikkHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.helper.VirksomhetHelper.Companion.nyttOrgnummer
import no.nav.lydia.ia.sak.domene.SaksHendelsestype
import kotlin.test.Test

class AuditLogTest {
    private val lydiaApiContainer = TestContainerHelper.lydiaApiContainer
    private val mockOAuth2Server = TestContainerHelper.oauth2ServerContainer

    @Test
    fun `auditlogger opprettelse av IA-sak`() {
        nyttOrgnummer().also { orgnummer ->
            SakHelper.opprettSakForVirksomhetRespons(
                orgnummer = orgnummer,
                token = mockOAuth2Server.superbruker1.token
            ).also {
                lydiaApiContainer shouldContainLog auditLog(
                    request = it.first,
                    navIdent = mockOAuth2Server.superbruker1.navIdent,
                    orgnummer = orgnummer,
                    auditType = AuditType.create,
                    tillat = Tillat.Ja,
                    saksnummer = it.third.get().saksnummer
                )
            }
        }

        nyttOrgnummer().also { orgnummer ->
            SakHelper.opprettSakForVirksomhetRespons(
                orgnummer = orgnummer,
                token = mockOAuth2Server.saksbehandler1.token
            ).also {
                lydiaApiContainer shouldContainLog auditLog(
                    request = it.first,
                    navIdent = mockOAuth2Server.saksbehandler1.navIdent,
                    orgnummer = orgnummer,
                    auditType = AuditType.create,
                    tillat = Tillat.Nei,
                )
            }
        }

        nyttOrgnummer().also { orgnummer ->
            SakHelper.opprettSakForVirksomhetRespons(
                orgnummer = orgnummer,
                token = mockOAuth2Server.brukerUtenTilgangsrolle.token
            )
                .also {
                    lydiaApiContainer shouldContainLog auditLog(
                        request = it.first,
                        navIdent = mockOAuth2Server.brukerUtenTilgangsrolle.navIdent,
                        orgnummer = orgnummer,
                        auditType = AuditType.create,
                        tillat = Tillat.Nei,
                    )
                }
        }
    }

    @Test
    fun `auditlogger oppdatering av IA-sak`() {
        val orgnummer = nyttOrgnummer()
        SakHelper.opprettSakForVirksomhetRespons(orgnummer = orgnummer, token = mockOAuth2Server.superbruker1.token)
            .also { responsForOpprettSakForVirksomhetMedSuperbruker ->
                val iaSak = responsForOpprettSakForVirksomhetMedSuperbruker.third.get()
                lydiaApiContainer shouldContainLog auditLog(
                    request = responsForOpprettSakForVirksomhetMedSuperbruker.first,
                    navIdent = mockOAuth2Server.superbruker1.navIdent,
                    orgnummer = orgnummer,
                    auditType = AuditType.create,
                    tillat = Tillat.Ja,
                    saksnummer = iaSak.saksnummer
                )
                SakHelper.nyHendelsePåSakMedRespons(
                    iaSak,
                    SaksHendelsestype.TA_EIERSKAP_I_SAK,
                    token = mockOAuth2Server.lesebrukerAudit.token
                ).also { responsPåTaEierskapMedLesebruker ->
                    lydiaApiContainer shouldContainLog auditLog(
                        request = responsPåTaEierskapMedLesebruker.first,
                        navIdent = mockOAuth2Server.lesebrukerAudit.navIdent,
                        orgnummer = orgnummer,
                        auditType = AuditType.update,
                        tillat = Tillat.Nei,
                        saksnummer = iaSak.saksnummer
                    )
                }

                SakHelper.nyHendelsePåSakMedRespons(
                    iaSak,
                    SaksHendelsestype.TA_EIERSKAP_I_SAK,
                    token = mockOAuth2Server.saksbehandler1.token
                ).also { responsPåTaEierskapMedSaksbehandler ->
                    lydiaApiContainer shouldContainLog auditLog(
                        request = responsPåTaEierskapMedSaksbehandler.first,
                        navIdent = mockOAuth2Server.saksbehandler1.navIdent,
                        orgnummer = orgnummer,
                        auditType = AuditType.update,
                        tillat = Tillat.Ja,
                        saksnummer = iaSak.saksnummer
                    )
                }
            }
    }

    @Test
    fun `auditlogger uthenting av IA-sak på orgnummer`() {
        val orgnummer = "139139139"
        SakHelper.hentSakerRespons(orgnummer = orgnummer, token = mockOAuth2Server.superbruker1.token).also {
            lydiaApiContainer shouldContainLog auditLog(
                request = it.first,
                navIdent = mockOAuth2Server.superbruker1.navIdent,
                orgnummer = orgnummer,
                auditType = AuditType.access,
                tillat = Tillat.Ja,
            )
        }
        SakHelper.hentSakerRespons(orgnummer = orgnummer, token = mockOAuth2Server.brukerUtenTilgangsrolle.token).also {
            lydiaApiContainer shouldContainLog auditLog(
                request = it.first,
                navIdent = mockOAuth2Server.brukerUtenTilgangsrolle.navIdent,
                orgnummer = orgnummer,
                auditType = AuditType.access,
                tillat = Tillat.Nei,
            )
        }
    }

    @Test
    fun `auditlogger uthenting av hendelser på IA-sak på et gyldig saksnummer`() {
        val orgnummer = nyttOrgnummer()
        val sak = SakHelper.opprettSakForVirksomhet(orgnummer = orgnummer, token = mockOAuth2Server.superbruker1.token)
        SakHelper.hentSamarbeidsHistorikkRespons(orgnummer = orgnummer, token = mockOAuth2Server.superbruker1.token).also {
            lydiaApiContainer shouldContainLog auditLog(
                request = it.first,
                navIdent = mockOAuth2Server.superbruker1.navIdent,
                orgnummer = orgnummer,
                auditType = AuditType.access,
                tillat = Tillat.Ja,
                saksnummer = sak.saksnummer
            )
        }
        SakHelper.hentSamarbeidsHistorikkRespons(orgnummer = orgnummer, token = mockOAuth2Server.brukerUtenTilgangsrolle.token)
            .also {
                lydiaApiContainer shouldContainLog auditLog(
                    request = it.first,
                    navIdent = mockOAuth2Server.brukerUtenTilgangsrolle.navIdent,
                    orgnummer = orgnummer, // Vi auditlogger ikke hvilket orgnummer man ikke hadde tilgang til
                    auditType = AuditType.access,
                    tillat = Tillat.Nei,
                )
            }
    }


    @Test
    fun `auditlogger uthenting av sykefraværsstatistikk på en enkelt virksomhet`() {
        val orgnummer = "917482498"
        StatistikkHelper.hentSykefraværForVirksomhetRespons(orgnummer, token = mockOAuth2Server.lesebruker.token).also {
            lydiaApiContainer shouldContainLog auditLog(
                request = it.first,
                navIdent = mockOAuth2Server.lesebruker.navIdent,
                orgnummer = orgnummer,
                auditType = AuditType.access,
                tillat = Tillat.Ja,
            )
        }
        StatistikkHelper.hentSykefraværForVirksomhetRespons(
            orgnummer,
            token = mockOAuth2Server.brukerUtenTilgangsrolle.token
        ).also {
            lydiaApiContainer shouldContainLog auditLog(
                request = it.first,
                navIdent = mockOAuth2Server.brukerUtenTilgangsrolle.navIdent,
                orgnummer = orgnummer,
                auditType = AuditType.access,
                tillat = Tillat.Nei,
            )
        }
    }

    @Test
    fun `auditlogger uthenting av virksomhetsdata for en spesifikk virksomhet`() {
        val orgnummer = TestVirksomhet.BERGEN.orgnr
        val superbruker = mockOAuth2Server.superbruker1
        VirksomhetHelper.hentVirksomhetsinformasjonRespons(
            orgnummer,
            token = superbruker.token
        ).also {
            lydiaApiContainer shouldContainLog auditLog(
                request = it.first,
                navIdent = superbruker.navIdent,
                orgnummer = orgnummer,
                auditType = AuditType.access,
                tillat = Tillat.Ja,
            )
        }
        val brukerUtenTilgangsrolle = mockOAuth2Server.brukerUtenTilgangsrolle
        VirksomhetHelper.hentVirksomhetsinformasjonRespons(
            orgnummer,
            token = brukerUtenTilgangsrolle.token
        ).also {
            lydiaApiContainer shouldContainLog auditLog(
                request = it.first,
                navIdent = brukerUtenTilgangsrolle.navIdent,
                orgnummer = orgnummer,
                auditType = AuditType.access,
                tillat = Tillat.Nei,
            )
        }
    }


    private fun auditLog(
        request: Request,
        navIdent: String,
        orgnummer: String?,
        auditType: AuditType,
        tillat: Tillat,
        saksnummer: String? = null,
        severity: String = "INFO"
    ) =
        ("CEF:0\\|fia-api\\|auditLog\\|1.0\\|audit:${auditType.name}\\|fia-api\\|$severity\\|end=[0-9]+ " +
                "suid=$navIdent " +
                (orgnummer?.let { "duid=$it " } ?: "") +
                "sproc=.{26} " +
                "requestMethod=${request.method} " +
                "request=${request.url.path} " +
                "flexString1Label=Decision " +
                "flexString1=${tillat.tillat}" +
                (saksnummer?.let { " flexString2Label=saksnummer flexString2=$it" } ?: "")).toRegex()
}
