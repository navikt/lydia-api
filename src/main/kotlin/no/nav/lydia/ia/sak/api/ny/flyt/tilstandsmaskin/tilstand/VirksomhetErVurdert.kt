package no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.tilstand

import arrow.core.Either
import io.ktor.http.HttpStatusCode
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.ny.flyt.FiaKontekst
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.Konsekvens
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.EndrePlanlagtDatoForNesteTilstand
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.GjørVirksomhetKlarTilNyVurdering
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.Hendelse
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.VurderVirksomhet
import no.nav.lydia.ia.sak.domene.IASak

object VirksomhetErVurdert : Tilstand() { // VURDERT
    override fun utførTransisjon(
        hendelse: Hendelse,
        fiaKontekst: FiaKontekst,
    ): Konsekvens {
        val endring: Either<Feil, IASakDto> = when (hendelse) {
            is VurderVirksomhet -> {
                fiaKontekst.nyFlytService.opprettSakOgMerkSomVurdert(
                    orgnummer = hendelse.orgnr,
                    superbruker = hendelse.superbruker,
                    navEnhet = hendelse.navEnhet,
                ).also {
                    fiaKontekst.nyFlytService.slettVirksomhetTilstandAutomatiskOppdatering(
                        orgnr = hendelse.orgnr,
                    )
                }
            }

            is `GjørVirksomhetKlarTilNyVurdering` -> {
                return Konsekvens(
                    nyTilstand = VirksomhetKlarTilVurdering,
                    endring = Either.Right(null),
                )
            }

            is EndrePlanlagtDatoForNesteTilstand -> {
                val endring = fiaKontekst.nyFlytService.endrePlanlagtDatoForNesteTilstand(
                    orgnummer = hendelse.orgnr,
                    saksnummer = fiaKontekst.saksnummer!!,
                    nyPlanlagtDato = hendelse.nyPlanlagtDato,
                    saksbehandler = hendelse.saksbehandler,
                    navEnhet = hendelse.navEnhet,
                    resulterendeSakStatus = IASak.Status.VURDERT,
                )
                return Konsekvens(
                    endring = endring,
                    nyTilstand = VirksomhetErVurdert,
                )
            }

            else -> {
                Either.Left(Feil("Something odd happened", HttpStatusCode.Companion.BadRequest))
            }
        }

        return Konsekvens(
            nyTilstand = if (endring.isRight()) VirksomhetVurderes else VirksomhetErVurdert,
            endring = endring,
        )
    }
}
