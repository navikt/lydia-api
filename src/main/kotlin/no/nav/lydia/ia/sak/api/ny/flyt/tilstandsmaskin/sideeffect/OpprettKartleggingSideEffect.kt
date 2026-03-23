package no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.sideeffect

import arrow.core.Either
import com.github.guepardoapps.kulid.ULID
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.ny.flyt.NyFlytService
import no.nav.lydia.ia.sak.api.ny.flyt.Transaction
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetIATilstand
import no.nav.lydia.ia.sak.api.ny.flyt.hentSpørreundersøkelse
import no.nav.lydia.ia.sak.api.ny.flyt.lagreEllerOppdaterVirksomhetTilstand
import no.nav.lydia.ia.sak.api.ny.flyt.lagreHendelse
import no.nav.lydia.ia.sak.api.ny.flyt.leggTilTemaTilKartlegging
import no.nav.lydia.ia.sak.api.ny.flyt.leggTilUndertemaTilKartlegging
import no.nav.lydia.ia.sak.api.ny.flyt.oppdaterStatusPåSak
import no.nav.lydia.ia.sak.api.ny.flyt.opprettKartlegging
import no.nav.lydia.ia.sak.domene.IASak.Status.AKTIV
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import java.time.LocalDateTime
import java.util.UUID

class OpprettKartleggingSideEffect(
    val orgnummer: String,
    val saksnummer: String,
    val samarbeidId: Int,
    val type: Spørreundersøkelse.Type,
    val saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
    val navEnhet: NavEnhet,
) : SideEffect<Spørreundersøkelse>() {
    context(nyFlytService: NyFlytService)
    override fun apply(): Either<Feil, Spørreundersøkelse> {
        val kartleggingId = UUID.randomUUID()

        return nyFlytService.validerOpprettelseAvKartlegging(
            saksnummer = saksnummer,
            samarbeidId = samarbeidId,
            type = type,
        ).map { temaer ->
            Transaction(nyFlytService.dataSource).transactional { tx ->
                with(tx) {
                    opprettKartlegging(
                        kartleggingId = kartleggingId,
                        orgnummer = orgnummer,
                        prosessId = samarbeidId,
                        opprettetAv = saksbehandler.navIdent,
                        type = type,
                    )

                    temaer.sortedBy { tema -> tema.rekkefølge }.forEach { tema ->
                        leggTilTemaTilKartlegging(kartleggingId, tema.id)
                        tema.undertemaer.sortedBy { undertema -> undertema.rekkefølge }.forEach { undertema ->
                            leggTilUndertemaTilKartlegging(kartleggingId, tema.id, undertema.id)
                        }
                    }

                    val hendelse = lagreHendelse(
                        hendelse = IASakshendelse(
                            id = ULID.random(),
                            opprettetTidspunkt = LocalDateTime.now(),
                            saksnummer = saksnummer,
                            hendelsesType = IASakshendelseType.OPPRETT_KARTLEGGING,
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

                    val opprettetKartlegging = hentSpørreundersøkelse(kartleggingId)
                        ?: error("Kunne ikke hente opprettet kartlegging")

                    Pair(oppdatertSakDto, opprettetKartlegging)
                }
            }.also { kartlegging ->
                nyFlytService.varsleIASakObservers(kartlegging.first)
                nyFlytService.spørreundersøkelseService.spørreundersøkelseObservers.forEach { observer ->
                    observer.receive(kartlegging.second)
                }
            }.second
        }
    }
}
