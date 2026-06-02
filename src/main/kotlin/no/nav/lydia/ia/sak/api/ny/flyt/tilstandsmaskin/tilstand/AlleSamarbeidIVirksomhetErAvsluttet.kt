package no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.tilstand

import arrow.core.Either
import io.ktor.http.HttpStatusCode
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.ny.flyt.FiaKontekst
import no.nav.lydia.ia.sak.api.ny.flyt.tilVirksomhetIATilstand
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.Konsekvens
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.EndrePlanlagtDatoForNesteTilstand
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.GjørVirksomhetKlarTilNyVurdering
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.Hendelse
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.VurderVirksomhet
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.sideeffect.EndrePlanlagtDatoForNesteTilstandSideEffect
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.sideeffect.GjørVirksomhetKlarTilNyVurderingSideEffect
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.sideeffect.VirksomhetVurderesSideEffect
import no.nav.lydia.ia.sak.domene.IASak

object AlleSamarbeidIVirksomhetErAvsluttet : Tilstand() { // AVSLUTTET
    override fun utførTransisjon(
        hendelse: Hendelse,
        fiaKontekst: FiaKontekst,
    ): Konsekvens {
        val endring: Either<Feil, IASakDto> = when (hendelse) {
            is VurderVirksomhet -> {
                val sideEffect = VirksomhetVurderesSideEffect(
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
                        sideEffect = sideEffect,
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
                        sideEffect = sideEffect,
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
                        sideEffect = sideEffect,
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
