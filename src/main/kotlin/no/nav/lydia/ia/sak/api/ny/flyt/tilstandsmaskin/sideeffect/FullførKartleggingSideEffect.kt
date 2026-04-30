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
import no.nav.lydia.ia.sak.api.ny.flyt.oppdaterStatusTilSpørreundersøkelse
import no.nav.lydia.ia.sak.domene.IASak.Status.AKTIV
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import java.time.LocalDateTime
import java.util.UUID

class FullførKartleggingSideEffect(
    val orgnummer: String,
    val saksnummer: String,
    val spørreundersøkelseId: UUID,
    val saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
    val navEnhet: NavEnhet,
) : SideEffect<Spørreundersøkelse>() {
    context(nyFlytService: NyFlytService)
    override fun apply(): Either<Feil, Spørreundersøkelse> =
        nyFlytService.validerFullføringAvKartlegging(spørreundersøkelseId)
            .map {
                Transaction(nyFlytService.dataSource).transactional { tx ->
                    with(tx) {
                        val oppdatertKartlegging =
                            oppdaterStatusTilSpørreundersøkelse(spørreundersøkelseId = spørreundersøkelseId, status = Spørreundersøkelse.Status.AVSLUTTET)
                                ?: error("Kunne ikke fullføre kartlegging")

                        val hendelse = lagreHendelse(
                            hendelse = IASakshendelse(
                                id = ULID.random(),
                                opprettetTidspunkt = LocalDateTime.now(),
                                saksnummer = saksnummer,
                                hendelsesType = IASakshendelseType.FULLFØR_KARTLEGGING,
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
