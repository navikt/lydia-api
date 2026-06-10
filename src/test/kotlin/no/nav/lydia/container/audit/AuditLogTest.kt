package no.nav.lydia.container.audit

import com.github.kittinunf.fuel.core.Request
import io.ktor.http.HttpStatusCode
import no.nav.lydia.AuditType
import no.nav.lydia.Tillat
import no.nav.lydia.abc.api.SYKEFRAVÆRSSTATISTIKK_PATH
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.opprettSamarbeidResponse
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.vurderVirksomhet
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.vurderVirksomhetResponse
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.SakHelper.Companion.leggTilFolger
import no.nav.lydia.helper.StatistikkHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.helper.VirksomhetHelper.Companion.lastInnNyVirksomhet
import no.nav.lydia.sykefraværsstatistikk.api.Søkeparametere.Companion.FYLKER
import no.nav.lydia.sykefraværsstatistikk.api.Søkeparametere.Companion.KOMMUNER
import no.nav.lydia.sykefraværsstatistikk.api.Søkeparametere.Companion.NÆRINGSGRUPPER
import no.nav.lydia.sykefraværsstatistikk.api.Søkeparametere.Companion.SORTERINGSNØKKEL
import kotlin.test.Test

class AuditLogTest {
    @Test
    fun `auditlogger opprettelse av IA-sak`() {
        val virksomhet = lastInnNyVirksomhet()

        vurderVirksomhetResponse(virksomhet = virksomhet, token = authContainerHelper.saksbehandler1.token)
            .also {
                applikasjon shouldContainLog auditLog(
                    request = it.first,
                    navIdent = authContainerHelper.saksbehandler1.navIdent,
                    orgnummer = virksomhet.orgnr,
                    auditType = AuditType.create,
                    tillat = Tillat.Nei,
                )
            }

        vurderVirksomhetResponse(virksomhet = virksomhet, token = authContainerHelper.brukerUtenTilgangsrolle.token)
            .also {
                applikasjon shouldContainLog auditLog(
                    request = it.first,
                    navIdent = authContainerHelper.brukerUtenTilgangsrolle.navIdent,
                    orgnummer = virksomhet.orgnr,
                    auditType = AuditType.create,
                    tillat = Tillat.Nei,
                )
            }

        vurderVirksomhetResponse(token = authContainerHelper.superbruker1.token)
            .also {
                applikasjon shouldContainLog auditLog(
                    request = it.first,
                    navIdent = authContainerHelper.superbruker1.navIdent,
                    orgnummer = it.third.get().orgnr,
                    auditType = AuditType.create,
                    tillat = Tillat.Ja,
                    saksnummer = it.third.get().saksnummer,
                )
            }
    }

    @Test
    fun `auditlogger oppdatering av IA-sak`() {
        val samarbeidsperiode = vurderVirksomhet(token = authContainerHelper.superbruker1.token)

        val lesebrukerResponse = samarbeidsperiode.opprettSamarbeidResponse(token = authContainerHelper.lesebruker.token)
        applikasjon shouldContainLog auditLog(
            request = lesebrukerResponse.first,
            navIdent = authContainerHelper.lesebruker.navIdent,
            orgnummer = samarbeidsperiode.orgnr,
            auditType = AuditType.create,
            tillat = Tillat.Nei,
        )

        samarbeidsperiode.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val opprettSamarbeidResponse = samarbeidsperiode.opprettSamarbeidResponse(authContainerHelper.saksbehandler1.token)
        applikasjon shouldContainLog auditLog(
            request = opprettSamarbeidResponse.first,
            navIdent = authContainerHelper.saksbehandler1.navIdent,
            orgnummer = samarbeidsperiode.orgnr,
            auditType = AuditType.create,
            tillat = Tillat.Ja,
            saksnummer = samarbeidsperiode.saksnummer,
        )
    }

    @Test
    fun `auditlogger uthenting av hendelser på IA-sak på et gyldig saksnummer`() {
        val sak = vurderVirksomhet()
        SakHelper.hentSamarbeidshistorikkRespons(orgnummer = sak.orgnr, token = authContainerHelper.superbruker1.token)
            .also {
                applikasjon shouldContainLog auditLog(
                    request = it.first,
                    navIdent = authContainerHelper.superbruker1.navIdent,
                    orgnummer = sak.orgnr,
                    auditType = AuditType.access,
                    tillat = Tillat.Ja,
                    saksnummer = sak.saksnummer,
                )
            }
        SakHelper.hentSamarbeidshistorikkRespons(
            orgnummer = sak.orgnr,
            token = authContainerHelper.brukerUtenTilgangsrolle.token,
        )
            .also {
                applikasjon shouldContainLog auditLog(
                    request = it.first,
                    navIdent = authContainerHelper.brukerUtenTilgangsrolle.navIdent,
                    orgnummer = sak.orgnr,
                    auditType = AuditType.access,
                    tillat = Tillat.Nei,
                )
            }
    }

    @Test
    fun `auditlogger uthenting av sykefraværsstatistikk på en enkelt virksomhet`() {
        val orgnummer = "917482498"
        StatistikkHelper.hentSykefraværForVirksomhetSiste4KvartalerRespons(
            orgnummer = orgnummer,
            token = authContainerHelper.lesebruker.token,
        ).also {
            applikasjon shouldContainLog auditLog(
                request = it.first,
                navIdent = authContainerHelper.lesebruker.navIdent,
                orgnummer = orgnummer,
                auditType = AuditType.access,
                tillat = Tillat.Ja,
            )
        }
        StatistikkHelper.hentSykefraværForVirksomhetSiste4KvartalerRespons(
            orgnummer = orgnummer,
            token = authContainerHelper.brukerUtenTilgangsrolle.token,
        ).also {
            applikasjon shouldContainLog auditLog(
                request = it.first,
                navIdent = authContainerHelper.brukerUtenTilgangsrolle.navIdent,
                orgnummer = orgnummer,
                auditType = AuditType.access,
                tillat = Tillat.Nei,
            )
        }
    }

    @Test
    fun `auditlogger uthenting av sykefraværsstatistikk med feilkode på en ikke eksisterende virksomhet`() {
        val orgnummer = "ikke_org_nr"
        StatistikkHelper.hentSykefraværForVirksomhetSiste4KvartalerRespons(
            orgnummer = orgnummer,
            token = authContainerHelper.lesebruker.token,
        ).also {
            applikasjon shouldContainLog auditLog(
                request = it.first,
                navIdent = authContainerHelper.lesebruker.navIdent,
                orgnummer = orgnummer,
                auditType = AuditType.access,
                tillat = Tillat.Ja,
                feilkode = HttpStatusCode.NotFound.value.toString(),
            )
        }
    }

    @Test
    fun `auditlogger uthenting av virksomhetsdata for en spesifikk virksomhet`() {
        val orgnummer = TestVirksomhet.BERGEN.orgnr
        val superbruker = authContainerHelper.superbruker1
        VirksomhetHelper.hentVirksomhetsinformasjonRespons(
            orgnummer,
            token = superbruker.token,
        ).also {
            applikasjon shouldContainLog auditLog(
                request = it.first,
                navIdent = superbruker.navIdent,
                orgnummer = orgnummer,
                auditType = AuditType.access,
                tillat = Tillat.Ja,
            )
        }
        val brukerUtenTilgangsrolle = authContainerHelper.brukerUtenTilgangsrolle
        VirksomhetHelper.hentVirksomhetsinformasjonRespons(
            orgnummer,
            token = brukerUtenTilgangsrolle.token,
        ).also {
            applikasjon shouldContainLog auditLog(
                request = it.first,
                navIdent = brukerUtenTilgangsrolle.navIdent,
                orgnummer = orgnummer,
                auditType = AuditType.access,
                tillat = Tillat.Nei,
            )
        }
    }

    @Test
    fun `auditlogger søk med få parametere`() {
        val saksbehandler = authContainerHelper.saksbehandler1
        StatistikkHelper.hentSykefravær()
            .also {
                applikasjon shouldContainLog auditLog(
                    path = "/$SYKEFRAVÆRSSTATISTIKK_PATH?$KOMMUNER=&$FYLKER=&$NÆRINGSGRUPPER=&$SORTERINGSNØKKEL".substring(
                        0,
                        70,
                    ),
                    method = "GET",
                    navIdent = saksbehandler.navIdent,
                    auditType = AuditType.access,
                    tillat = Tillat.Ja,
                    melding = "Søk med parametere: sorteringsnokkel=tapte_dagsverk sorteringsretning=desc side=1",
                )
            }
    }

    @Test
    fun `auditlogger søk med masse parametere`() {
        val saksbehandler = authContainerHelper.saksbehandler1
        StatistikkHelper.hentSykefravær(
            kommuner = "1750",
            fylker = "17",
            næringsgrupper = "bil",
            sorteringsnokkel = "båt",
            sorteringsretning = "asc",
            sykefraværsprosentFra = "5",
            sykefraværsprosentTil = "30",
            ansatteFra = "10",
            ansatteTil = "50",
            iaStatus = "FULLFØRT",
            side = "2",
            bransjeProgram = "fly",
            eiere = "N123",
        )
            .also {
                applikasjon shouldContainLog auditLog(
                    path = "/$SYKEFRAVÆRSSTATISTIKK_PATH?kommuner=1750&fylker=17&naringsgrupper=bil&sort",
                    method = "GET",
                    navIdent = saksbehandler.navIdent,
                    auditType = AuditType.access,
                    tillat = Tillat.Ja,
                    melding =
                        "Søk med parametere: sykefravarsprosentFra=5.0 sykefravarsprosentTil=30.0 ansatteFra=10 ansatteTil=50 kommuner=[1750] naringsgrupper=[bil] iaStatus=FULLFØRT sorteringsnokkel=tapte_dagsverk sorteringsretning=asc side=2",
                )
            }
    }

    private fun auditLog(
        request: Request,
        navIdent: String,
        orgnummer: String? = null,
        auditType: AuditType,
        tillat: Tillat,
        saksnummer: String? = null,
        severity: String = "INFO",
        feilkode: String? = null,
    ): Regex =
        auditLog(
            method = request.method.toString(),
            path = request.url.path,
            navIdent = navIdent,
            orgnummer = orgnummer,
            auditType = auditType,
            tillat = tillat,
            saksnummer = saksnummer,
            severity = severity,
            feilkode = feilkode,
        )

    private fun auditLog(
        method: String,
        path: String,
        navIdent: String,
        orgnummer: String? = null,
        auditType: AuditType,
        tillat: Tillat,
        saksnummer: String? = null,
        melding: String? = null,
        severity: String = "INFO",
        feilkode: String? = null,
    ) = (
        "CEF:0|fia-api|auditLog|1.0|audit:${auditType.name}|fia-api|$severity|end=[0-9]+ " +
            "suid=$navIdent " +
            (orgnummer?.let { "duid=$it " } ?: "") +
            "sproc=.{26} " +
            "requestMethod=$method " +
            "request=$path " +
            "flexString1Label=Decision " +
            "flexString1=${tillat.tillat}" +
            (saksnummer?.let { " flexString2Label=saksnummer flexString2=$it" } ?: "") +
            (feilkode?.let { " flexString3Label=feilkode flexString3=$it" } ?: "") +
            (melding?.let { " msg=${it.replace("[", "\\[").replace("]", "\\]")}" } ?: "")
    ).replace("|", "\\|").replace("?", "\\?").toRegex()
}
