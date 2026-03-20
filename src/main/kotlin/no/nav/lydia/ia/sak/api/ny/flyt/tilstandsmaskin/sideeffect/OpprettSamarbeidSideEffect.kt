package no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.sideeffect

import arrow.core.Either
import com.github.guepardoapps.kulid.ULID
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.ny.flyt.NyFlytService
import no.nav.lydia.ia.sak.api.ny.flyt.Transaction
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetIATilstand
import no.nav.lydia.ia.sak.api.ny.flyt.lagreEllerOppdaterVirksomhetTilstand
import no.nav.lydia.ia.sak.api.ny.flyt.lagreHendelse
import no.nav.lydia.ia.sak.api.ny.flyt.oppdaterStatusPåSak
import no.nav.lydia.ia.sak.api.ny.flyt.opprettNyttSamarbeid
import no.nav.lydia.ia.sak.api.samarbeid.IASamarbeidDto
import no.nav.lydia.ia.sak.api.samarbeid.tilDto
import no.nav.lydia.ia.sak.domene.IASak.Status.AKTIV
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle
import java.time.LocalDateTime

class OpprettSamarbeidSideEffect(
    val orgnummer: String,
    val saksnummer: String,
    val samarbeidsNavn: String,
    val saksbehandler: NavAnsattMedSaksbehandlerRolle,
    val navEnhet: NavEnhet,
) : SideEffect<IASamarbeidDto>() {
    context(nyFlytService: NyFlytService)
    override fun apply(): Either<Feil, IASamarbeidDto> {
        // -- validering burde ikke ligge her, men hvor? ¯\_(ツ)_/¯
        return nyFlytService.validerOpprettelseAvSamarbeid(
            navn = samarbeidsNavn,
            saksnummer = saksnummer,
            saksbehandler = saksbehandler,
        ).map {
            Transaction(nyFlytService.dataSource).transactional { tx ->
                with(tx) {
                    val iASakshendelse = IASakshendelse(
                        id = ULID.random(),
                        opprettetTidspunkt = LocalDateTime.now(),
                        saksnummer = saksnummer,
                        hendelsesType = IASakshendelseType.NY_PROSESS,
                        orgnummer = orgnummer,
                        opprettetAv = saksbehandler.navIdent,
                        opprettetAvRolle = saksbehandler.rolle,
                        navEnhet = navEnhet,
                        resulterendeStatus = null,
                    )
                    lagreHendelse(
                        hendelse = iASakshendelse,
                        sistEndretAvHendelseId = null,
                        resulterendeStatus = AKTIV,
                    )

                    val opprettetSamarbeid = opprettNyttSamarbeid(
                        saksnummer = saksnummer,
                        navn = samarbeidsNavn,
                    )

                    oppdaterStatusPåSak(
                        saksnummer = saksnummer,
                        status = AKTIV,
                        endretAvHendelseId = iASakshendelse.id,
                        endretAv = saksbehandler.navIdent,
                    )

                    lagreEllerOppdaterVirksomhetTilstand(
                        orgnr = orgnummer,
                        tilstand = VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid,
                    )

                    opprettetSamarbeid
                }
            }.also { samarbeid ->
                nyFlytService.iaSamarbeidObservers.forEach { it.receive(samarbeid) }
                nyFlytService.iaSakRepository.hentIASakDto(saksnummer)!!.also {
                    nyFlytService.varsleIASakObservers(it)
                }
            }.tilDto()
        }
    }
}
