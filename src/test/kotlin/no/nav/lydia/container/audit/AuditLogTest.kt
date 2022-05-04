package no.nav.lydia.container.virksomhet

import com.github.kittinunf.fuel.core.Request
import no.nav.lydia.AuditType
import no.nav.lydia.Tillat
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.ia.sak.domene.SaksHendelsestype
import kotlin.test.Test

class AuditLogTest {
    val lydiaApiContainer = TestContainerHelper.lydiaApiContainer
    val mockOAuth2Server = TestContainerHelper.oauth2ServerContainer

    @Test
    fun `auditlogger opprettelse av IA-sak`() {
        val orgnummer = TestVirksomhet.OSLO.orgnr
        SakHelper.opprettSakForVirksomhetRespons(orgnummer, token = mockOAuth2Server.superbruker1.token).also {
            lydiaApiContainer shouldContainLog auditLog(
                request = it.first,
                navIdent = mockOAuth2Server.superbruker1.navIdent,
                orgnummer = orgnummer,
                auditType = AuditType.create,
                tillat = Tillat.Ja,
                saksnummer = it.third.get().saksnummer
            )
        }
        SakHelper.opprettSakForVirksomhetRespons(orgnummer, token = mockOAuth2Server.saksbehandler1.token).also {
            lydiaApiContainer shouldContainLog auditLog(
                request = it.first,
                navIdent = mockOAuth2Server.saksbehandler1.navIdent,
                orgnummer = orgnummer,
                auditType = AuditType.create,
                tillat = Tillat.Nei,
            )
        }
        SakHelper.opprettSakForVirksomhetRespons(orgnummer, token = mockOAuth2Server.brukerUtenTilgangsrolle.token).also {
            lydiaApiContainer shouldContainLog auditLog(
                request = it.first,
                navIdent = mockOAuth2Server.brukerUtenTilgangsrolle.navIdent,
                orgnummer = orgnummer,
                auditType = AuditType.create,
                tillat = Tillat.Nei,
            )
        }
    }
    @Test
    fun `auditlogger oppdatering av IA-sak`() {
        val orgnummer = TestVirksomhet.OSLO.orgnr
        SakHelper.opprettSakForVirksomhetRespons(orgnummer, token = mockOAuth2Server.superbruker1.token).also {
            lydiaApiContainer shouldContainLog auditLog(
                request = it.first,
                navIdent = mockOAuth2Server.superbruker1.navIdent,
                orgnummer = orgnummer,
                auditType = AuditType.create,
                tillat = Tillat.Ja,
                saksnummer = it.third.get().saksnummer
            )
            SakHelper.nyHendelsePåSakMedRespons(
                it.third.get(),
                SaksHendelsestype.TA_EIERSKAP_I_SAK,
                token = mockOAuth2Server.lesebrukerAudit.token
            )
            lydiaApiContainer shouldContainLog auditLog(
                request  = it.first,
                navIdent = mockOAuth2Server.lesebrukerAudit.navIdent,
                orgnummer = orgnummer,
                auditType = AuditType.update,
                tillat = Tillat.Nei,
                saksnummer = it.third.get().saksnummer
            )
            SakHelper.nyHendelsePåSakMedRespons(
                it.third.get(),
                SaksHendelsestype.TA_EIERSKAP_I_SAK,
                token = mockOAuth2Server.saksbehandler1.token
            )
            lydiaApiContainer shouldContainLog auditLog(
                request = it.first,
                navIdent = mockOAuth2Server.saksbehandler1.navIdent,
                orgnummer = orgnummer,
                auditType = AuditType.update,
                tillat = Tillat.Ja,
                saksnummer = it.third.get().saksnummer
            )
        }
    }

    @Test
    fun `auditlogger uthenting av IA-sak`() {
        val orgnummer = TestVirksomhet.OSLO.orgnr
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

    private fun auditLog(
        request: Request,
        navIdent: String,
        orgnummer: String,
        auditType: AuditType,
        tillat: Tillat,
        saksnummer: String? = null
    ) =
        ("CEF:0\\|lydia-api\\|auditLog\\|1.0\\|audit:${auditType.name}\\|lydia-api\\|INFO\\|end=[0-9]+ " +
                "suid=$navIdent " +
                "duid=$orgnummer " +
                "sproc=.{26} " +
                "requestMethod=${request.method} " +
                "request=${request.url.path} " +
                "flexString1Label=Decision " +
                "flexString1=${tillat.tillat}" +
                (saksnummer?.let { " flexString2Label=saksnummer flexString2=$it" } ?: "")).toRegex()
}
