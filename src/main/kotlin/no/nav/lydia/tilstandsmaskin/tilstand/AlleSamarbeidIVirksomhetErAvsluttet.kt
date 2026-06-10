package no.nav.lydia.tilstandsmaskin.tilstand

import arrow.core.Either
import io.ktor.http.HttpStatusCode
import no.nav.lydia.felles.Feil
import no.nav.lydia.samarbeidsperiode.IASak
import no.nav.lydia.samarbeidsperiode.IASakDto
import no.nav.lydia.tilstandsmaskin.FiaKontekst
import no.nav.lydia.tilstandsmaskin.Konsekvens
import no.nav.lydia.tilstandsmaskin.hendelse.EndrePlanlagtDatoForNesteTilstand
import no.nav.lydia.tilstandsmaskin.hendelse.GjørVirksomhetKlarTilNyVurdering
import no.nav.lydia.tilstandsmaskin.hendelse.Hendelse
import no.nav.lydia.tilstandsmaskin.hendelse.VurderVirksomhet
import no.nav.lydia.tilstandsmaskin.sideeffect.EndrePlanlagtDatoForNesteTilstandSideEffect
import no.nav.lydia.tilstandsmaskin.sideeffect.GjørVirksomhetKlarTilNyVurderingSideEffect
import no.nav.lydia.tilstandsmaskin.sideeffect.VurderVirksomhetSideEffect
import no.nav.lydia.tilstandsmaskin.tilVirksomhetIATilstand

object AlleSamarbeidIVirksomhetErAvsluttet : Tilstand() { // AVSLUTTET
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
                        nyTilstand = if (resultat.isRight()) VirksomhetVurderes else VirksomhetKlarTilVurdering,
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
                        nyTilstand = if (resultat.isRight()) VirksomhetKlarTilVurdering else AlleSamarbeidIVirksomhetErAvsluttet,
                        endring = resultat,
                    )
                }
            }

            is EndrePlanlagtDatoForNesteTilstand -> {
                val sideEffect = EndrePlanlagtDatoForNesteTilstandSideEffect(
                    orgnummer = hendelse.orgnr,
                    saksnummer = fiaKontekst.saksnummer!!,
                    nyPlanlagtDato = hendelse.nyPlanlagtDato,
                    resulterendeSakStatus = IASak.Status.AVSLUTTET,
                    saksbehandler = hendelse.saksbehandler,
                    navEnhet = hendelse.navEnhet,
                )
                with(receiver = fiaKontekst.nyFlytService) {
                    val resultat = sideEffect.apply()
                    return Konsekvens(
                        nyTilstand = AlleSamarbeidIVirksomhetErAvsluttet,
                        endring = resultat,
                    )
                }
            }

            else -> {
                Either.Left(
                    Feil(
                        "'${hendelse.navn()}' er ikke gjennomførbar for '${AlleSamarbeidIVirksomhetErAvsluttet.tilVirksomhetIATilstand()}'",
                        HttpStatusCode.BadRequest,
                    ),
                )
            }
        }

        return Konsekvens(
            nyTilstand = AlleSamarbeidIVirksomhetErAvsluttet,
            endring = endring,
        )
    }
}
