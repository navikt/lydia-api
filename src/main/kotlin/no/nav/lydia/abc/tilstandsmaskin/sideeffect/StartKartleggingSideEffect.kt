package no.nav.lydia.abc.tilstandsmaskin.sideeffect

import arrow.core.Either
import com.github.guepardoapps.kulid.ULID
import no.nav.lydia.abc.kartlegging.Spørreundersøkelse
import no.nav.lydia.abc.tilstandsmaskin.NyFlytService
import no.nav.lydia.abc.tilstandsmaskin.Transaction
import no.nav.lydia.abc.tilstandsmaskin.VirksomhetIATilstand
import no.nav.lydia.abc.tilstandsmaskin.lagreEllerOppdaterVirksomhetTilstand
import no.nav.lydia.abc.tilstandsmaskin.lagreHendelse
import no.nav.lydia.abc.tilstandsmaskin.oppdaterStatusPåSak
import no.nav.lydia.abc.tilstandsmaskin.startSpørreundersøkelse
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.domene.IASak.Status.AKTIV
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import java.time.LocalDateTime
import java.util.UUID

class StartKartleggingSideEffect(
    val orgnummer: String,
    val saksnummer: String,
    val spørreundersøkelseId: UUID,
    val saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
    val navEnhet: NavEnhet,
) : SideEffect<Spørreundersøkelse>() {
    context(nyFlytService: NyFlytService)
    override fun apply(): Either<Feil, Spørreundersøkelse> =
        nyFlytService.validerStartAvKartlegging(spørreundersøkelseId)
            .map {
                Transaction(nyFlytService.dataSource).transactional { tx ->
                    with(tx) {
                        val oppdatertKartlegging = startSpørreundersøkelse(spørreundersøkelseId)
                            ?: error("Kunne ikke starte kartlegging")

                        val hendelse = lagreHendelse(
                            hendelse = IASakshendelse(
                                id = ULID.random(),
                                opprettetTidspunkt = LocalDateTime.now(),
                                saksnummer = saksnummer,
                                hendelsesType = IASakshendelseType.START_KARTLEGGING,
                                orgnummer = orgnummer,
                                opprettetAv = saksbehandler.navIdent,
                                opprettetAvRolle = saksbehandler.rolle,
                                navEnhet = navEnhet,
                                resulterendeStatus = null,
                            ),
                            sistEndretAvHendelseId = null,
                            resulterendeStatus = AKTIV,
                        )

                        val oppdatertSakDto = oppdaterStatusPåSak(
                            saksnummer = saksnummer,
                            status = AKTIV,
                            endretAv = saksbehandler.navIdent,
                            endretAvHendelseId = hendelse.id,
                        )

                        lagreEllerOppdaterVirksomhetTilstand(
                            orgnr = orgnummer,
                            tilstand = VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid,
                        )

                        Pair(oppdatertSakDto, oppdatertKartlegging)
                    }
                }.also { kartlegging ->
                    nyFlytService.varsleIASakObservers(kartlegging.first)
                    nyFlytService.spørreundersøkelseService.spørreundersøkelseObservers.forEach { observer ->
                        observer.receive(kartlegging.second)
                    }
                }.second
            }
}
