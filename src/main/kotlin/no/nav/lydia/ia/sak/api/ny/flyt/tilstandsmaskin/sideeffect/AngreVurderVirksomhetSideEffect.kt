package no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.sideeffect

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.ny.flyt.NyFlytService
import no.nav.lydia.ia.sak.api.ny.flyt.Transaction
import no.nav.lydia.ia.sak.api.ny.flyt.hentAlleSakerDtoForVirksomhet
import no.nav.lydia.ia.sak.api.ny.flyt.hentSisteIASakDto
import no.nav.lydia.ia.sak.api.ny.flyt.lagreHendelse
import no.nav.lydia.ia.sak.api.ny.flyt.nyHendelseBasertPåSak
import no.nav.lydia.ia.sak.api.ny.flyt.oppdaterVirksomhetTilstand
import no.nav.lydia.ia.sak.api.ny.flyt.settSakTilSlettet
import no.nav.lydia.ia.sak.api.ny.flyt.slettVirksomhetTilstand
import no.nav.lydia.ia.sak.api.ny.flyt.tilVirksomhetIATilstand
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.tilstand.VirksomhetKlarTilVurdering
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt

class AngreVurderVirksomhetSideEffect(
    val orgnummer: String,
    val superbruker: NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker,
    val navEnhet: NavEnhet,
) : SideEffect<IASakDto>() {
    context(nyFlytService: NyFlytService)
    override fun apply(): Either<Feil, IASakDto> =
        try {
            Transaction(nyFlytService.dataSource).transactional { tx ->
                with(tx) {
                    val sakDto = hentSisteIASakDto(orgnummer = orgnummer)
                        ?: throw IllegalStateException("Fant ingen sak for virksomhet $orgnummer")

                    val alleSaker = hentAlleSakerDtoForVirksomhet(
                        orgnummer = orgnummer,
                    )
                        .sortedByDescending { it.opprettetTidspunkt }
                    val nestSisteSakDto = if (alleSaker.size >= 2) alleSaker[alleSaker.size - 2] else null

                    if (nestSisteSakDto != null) {
                        oppdaterVirksomhetTilstand(
                            orgnr = orgnummer,
                            tilstand = VirksomhetKlarTilVurdering.tilVirksomhetIATilstand(),
                        )
                    } else {
                        slettVirksomhetTilstand(orgnr = orgnummer)
                    }

                    val angreVurdering = lagreHendelse(
                        hendelse = sakDto.nyHendelseBasertPåSak(
                            hendelsestype = IASakshendelseType.SLETT_SAK,
                            superbruker = superbruker,
                            navEnhet = navEnhet,
                        ),
                        sistEndretAvHendelseId = null,
                        resulterendeStatus = IASak.Status.SLETTET,
                    )

                    settSakTilSlettet(
                        saksnummer = sakDto.saksnummer,
                        hendelse = angreVurdering,
                    )
                    sakDto.copy(status = IASak.Status.SLETTET)
                }
            }.also { nyFlytService.varsleIASakObservers(it) }
                .right()
        } catch (e: Exception) {
            Feil("Feil ved angring av vurdering: ${e.message}", HttpStatusCode.InternalServerError).left()
        }
}
