package no.nav.lydia.ia.sak.api.ny.flyt

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import kotlinx.datetime.toKotlinLocalDateTime
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.ny.flyt.Tilstand.VirksomhetKlarTilVurdering
import no.nav.lydia.ia.sak.domene.IASak.Status.NY
import no.nav.lydia.ia.sak.domene.IASak.Status.SLETTET
import no.nav.lydia.ia.sak.domene.IASak.Status.VURDERES
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt

sealed class SideEffect<T> {
    context(nyFlytService: NyFlytService)
    abstract fun apply(): Either<Feil, T>
}

object IngenSideEffect : SideEffect<Unit>() {
    context(nyFlytService: NyFlytService)
    override fun apply(): Either<Feil, Unit> = Either.Left(Feil("Ikke håndtert enda", HttpStatusCode.BadRequest))
}

class VirksomhetVurderesSideEffect(
    val orgnummer: String,
    val superbruker: NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker,
    val navEnhet: NavEnhet,
) : SideEffect<IASakDto>() {
    context(nyFlytService: NyFlytService)
    override fun apply(): Either<Feil, IASakDto> =
        try {
            Transaction(nyFlytService.dataSource).transactional { tx ->
                with(tx) {
                    // Steg #1 lagre i DB en ny hendelse OPPRETT_SAK_FOR_VIRKSOMHET, og en ny SakDto med status NY
                    val iaSakHendelseOpprettSak = IASakshendelse.nyFørsteHendelse(
                        orgnummer = orgnummer,
                        superbruker = superbruker,
                        navEnhet = navEnhet,
                    )
                    lagreHendelse(
                        hendelse = iaSakHendelseOpprettSak,
                        sistEndretAvHendelseId = null,
                        resulterendeStatus = NY,
                    )
                    val iaSakDto: IASakDto = opprettSak(
                        iaSakDto = iaSakHendelseOpprettSak.tilIASakDto(),
                    )

                    // Steg #2 lagre i DB en ny hendelse VIRKSOMHET_VURDERES, og oppdatere SakDto til status VURDERES
                    val iaSakshendelseVurderes = lagreHendelse(
                        hendelse = iaSakDto.nyHendelseBasertPåSak(
                            hendelsestype = IASakshendelseType.VIRKSOMHET_VURDERES,
                            superbruker = superbruker,
                            navEnhet = navEnhet,
                        ),
                        sistEndretAvHendelseId = null,
                        resulterendeStatus = VURDERES,
                    )
                    val oppdatertIaSakDto = oppdaterStatusPåSak(
                        saksnummer = iaSakDto.saksnummer,
                        status = VURDERES,
                        endretAv = superbruker.navIdent,
                        endretAvHendelseId = iaSakshendelseVurderes.id,
                    )
                    lagreEllerOppdaterVirksomhetTilstand(
                        orgnr = orgnummer,
                        tilstand = VirksomhetIATilstand.VirksomhetVurderes,
                    )
                    oppdatertIaSakDto
                }
            }.also { nyFlytService.varsleIASakObservers(it) }
                .right()
        } catch (e: Exception) {
            Feil("Feil ved vurdering av virksomhet: ${e.message}", HttpStatusCode.InternalServerError).left()
        }
}

class AngreVurderVirksomhetSideEffect(
    val orgnummer: String,
) : SideEffect<IASakDto>() {
    context(nyFlytService: NyFlytService)
    override fun apply(): Either<Feil, IASakDto> =
        try {
            Transaction(nyFlytService.dataSource).transactional { tx ->
                with(tx) {
                    val sakDto = hentSisteIASakDto(orgnummer = orgnummer)
                        ?: throw IllegalStateException("Fant ingen sak for virksomhet $orgnummer")

                    val alleSaker = hentAlleSakerDtoForVirksomhet(orgnummer = orgnummer)
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

                    if (sakHarFølgere(saksnummer = sakDto.saksnummer)) {
                        slettAlleFølgereForSak(saksnummer = sakDto.saksnummer)
                    }

                    // TODO: if (nyFlytService.harSamarbeid) nyFlytService.slettAlleSamarbeid (ia_prosess)

                    slettSak(saksnummer = sakDto.saksnummer)
                    sakDto.copy(status = SLETTET)
                }
            }.also { nyFlytService.varsleIASakObservers(it) }
                .right()
        } catch (e: Exception) {
            Feil("Feil ved angring av vurdering: ${e.message}", HttpStatusCode.InternalServerError).left()
        }
}

private fun IASakshendelse.tilIASakDto(): IASakDto =
    IASakDto(
        saksnummer = this.saksnummer,
        orgnr = this.orgnummer,
        opprettetTidspunkt = this.opprettetTidspunkt.toKotlinLocalDateTime(),
        opprettetAv = this.opprettetAv,
        eidAv = null,
        endretTidspunkt = null,
        endretAv = null,
        endretAvHendelseId = this.id,
        status = NY,
        gyldigeNesteHendelser = emptyList(),
        lukket = false,
    )
