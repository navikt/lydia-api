package no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.tilstand

import arrow.core.Either
import io.ktor.http.HttpStatusCode
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.ny.flyt.FiaKontekst
import no.nav.lydia.ia.sak.api.ny.flyt.tilVirksomhetIATilstand
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.Konsekvens
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.Hendelse
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.VurderVirksomhet
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.sideeffect.VirksomhetVurderesSideEffect

object VirksomhetKlarTilVurdering : Tilstand() { // IKKE_AKTIV
    override fun utførTransisjon(
        hendelse: Hendelse,
        fiaKontekst: FiaKontekst,
    ): Konsekvens =
        when (hendelse) {
            is VurderVirksomhet -> {
                val sideEffect = VirksomhetVurderesSideEffect(
                    orgnummer = hendelse.orgnr,
                    superbruker = hendelse.superbruker,
                    navEnhet = hendelse.navEnhet,
                )
                with(fiaKontekst.nyFlytService) {
                    val resultat = sideEffect.apply()
                    Konsekvens(
                        nyTilstand = if (resultat.isRight()) VirksomhetVurderes else VirksomhetKlarTilVurdering,
                        endring = resultat,
                        sideEffect = sideEffect,
                    )
                }
            }

            else -> {
                Konsekvens(
                    nyTilstand = VirksomhetKlarTilVurdering,
                    endring = Either.Left(
                        Feil(
                            "'$hendelse' er ikke gjennomførbar for '${VirksomhetKlarTilVurdering.tilVirksomhetIATilstand()}'",
                            HttpStatusCode.Companion.BadRequest,
                        ),
                    ),
                )
            }
        }
}
