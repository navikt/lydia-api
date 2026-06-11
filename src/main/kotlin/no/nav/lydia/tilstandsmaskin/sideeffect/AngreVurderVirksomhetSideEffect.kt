package no.nav.lydia.tilstandsmaskin.sideeffect

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import no.nav.lydia.felles.Feil
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.samarbeidsperiode.IASak
import no.nav.lydia.samarbeidsperiode.IASakDto
import no.nav.lydia.samarbeidsperiode.IASakshendelseType
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import no.nav.lydia.tilstandsmaskin.NyFlytService
import no.nav.lydia.tilstandsmaskin.Transaction
import no.nav.lydia.tilstandsmaskin.nyHendelseBasertPåSak
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidsperiodeTransactional.Companion.hentAlleSakerDtoForVirksomhet
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidsperiodeTransactional.Companion.hentSisteIASakDto
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidsperiodeTransactional.Companion.lagreHendelse
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidsperiodeTransactional.Companion.settSakTilSlettet
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.TilstandVirksomhetTransactional.Companion.oppdaterVirksomhetTilstand
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.TilstandVirksomhetTransactional.Companion.slettVirksomhetTilstand
import no.nav.lydia.tilstandsmaskin.tilVirksomhetIATilstand
import no.nav.lydia.tilstandsmaskin.tilstand.VirksomhetKlarTilVurdering
import org.slf4j.Logger
import org.slf4j.LoggerFactory

class AngreVurderVirksomhetSideEffect(
    val orgnummer: String,
    val superbruker: NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker,
    val navEnhet: NavEnhet,
) : SideEffect<IASakDto>() {
    val logger: Logger = LoggerFactory.getLogger(this::class.java)

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
            logger.warn("Feil ved angring av vurdering for virksomhet '$orgnummer': ${e.message}", e)
            Feil("Feil ved angring av vurdering: ${e.message}", HttpStatusCode.InternalServerError).left()
        }
}
