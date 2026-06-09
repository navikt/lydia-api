package no.nav.lydia.abc.tilstandsmaskin.tilstand

import arrow.core.Either
import io.ktor.http.HttpStatusCode
import no.nav.lydia.abc.samarbeidsperiode.IASak
import no.nav.lydia.abc.samarbeidsperiode.IASakDto
import no.nav.lydia.abc.tilstandsmaskin.FiaKontekst
import no.nav.lydia.abc.tilstandsmaskin.Konsekvens
import no.nav.lydia.abc.tilstandsmaskin.hendelse.EndrePlanlagtDatoForNesteTilstand
import no.nav.lydia.abc.tilstandsmaskin.hendelse.GjørVirksomhetKlarTilNyVurdering
import no.nav.lydia.abc.tilstandsmaskin.hendelse.Hendelse
import no.nav.lydia.abc.tilstandsmaskin.hendelse.VurderVirksomhet
import no.nav.lydia.abc.tilstandsmaskin.sideeffect.EndrePlanlagtDatoForNesteTilstandSideEffect
import no.nav.lydia.abc.tilstandsmaskin.sideeffect.GjørVirksomhetKlarTilNyVurderingSideEffect
import no.nav.lydia.abc.tilstandsmaskin.sideeffect.VurderVirksomhetSideEffect
import no.nav.lydia.abc.tilstandsmaskin.tilVirksomhetIATilstand
import no.nav.lydia.ia.sak.api.Feil

object VirksomhetErVurdert : Tilstand() { // VURDERT
    override fun utførTransisjon(
        hendelse: Hendelse,
        fiaKontekst: FiaKontekst,
    ): Konsekvens {
        val endring: Either<Feil, IASakDto> = when (hendelse) {
            is VurderVirksomhet -> {
                val sideEffect = VurderVirksomhetSideEffect(
                    orgnummer = hendelse.orgnr,
                    superbruker = hendelse.superbruker,
                    navEnhet = hendelse.navEnhet,
                    valgtÅrsak = hendelse.valgtÅrsak,
                )
                with(fiaKontekst.nyFlytService) {
                    val resultat = sideEffect.apply()
                    return Konsekvens(
                        nyTilstand = if (resultat.isRight()) VirksomhetErVurdert else VirksomhetKlarTilVurdering,
                        endring = resultat,
                    )
                }
            }

            is GjørVirksomhetKlarTilNyVurdering -> {
                val sideEffect = GjørVirksomhetKlarTilNyVurderingSideEffect(
                    orgnummer = hendelse.orgnr,
                )
                with(fiaKontekst.nyFlytService) {
                    val resultat = sideEffect.apply()
                    return Konsekvens(
                        nyTilstand = if (resultat.isRight()) VirksomhetKlarTilVurdering else VirksomhetErVurdert,
                        endring = resultat,
                    )
                }
            }

            is EndrePlanlagtDatoForNesteTilstand -> {
                val sideEffect = EndrePlanlagtDatoForNesteTilstandSideEffect(
                    orgnummer = hendelse.orgnr,
                    saksnummer = fiaKontekst.saksnummer!!,
                    nyPlanlagtDato = hendelse.nyPlanlagtDato,
                    resulterendeSakStatus = IASak.Status.VURDERT,
                    saksbehandler = hendelse.saksbehandler,
                    navEnhet = hendelse.navEnhet,
                )
                with(receiver = fiaKontekst.nyFlytService) {
                    val resultat = sideEffect.apply()
                    return Konsekvens(
                        nyTilstand = VirksomhetErVurdert,
                        endring = resultat,
                    )
                }
            }

            else -> {
                Either.Left(
                    Feil("'${hendelse.navn()}' er ikke gjennomførbar for '${VirksomhetErVurdert.tilVirksomhetIATilstand()}'", HttpStatusCode.BadRequest),
                )
            }
        }

        return Konsekvens(
            nyTilstand = VirksomhetErVurdert,
            endring = endring,
        )
    }
}
