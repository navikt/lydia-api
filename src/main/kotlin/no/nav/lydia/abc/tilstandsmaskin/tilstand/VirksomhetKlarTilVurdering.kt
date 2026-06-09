package no.nav.lydia.abc.tilstandsmaskin.tilstand

import arrow.core.Either
import io.ktor.http.HttpStatusCode
import no.nav.lydia.abc.tilstandsmaskin.FiaKontekst
import no.nav.lydia.abc.tilstandsmaskin.Konsekvens
import no.nav.lydia.abc.tilstandsmaskin.hendelse.Hendelse
import no.nav.lydia.abc.tilstandsmaskin.hendelse.VurderVirksomhet
import no.nav.lydia.abc.tilstandsmaskin.sideeffect.VurderVirksomhetSideEffect
import no.nav.lydia.abc.tilstandsmaskin.tilVirksomhetIATilstand
import no.nav.lydia.ia.sak.api.Feil

object VirksomhetKlarTilVurdering : Tilstand() { // IKKE_AKTIV
    override fun utførTransisjon(
        hendelse: Hendelse,
        fiaKontekst: FiaKontekst,
    ): Konsekvens =
        when (hendelse) {
            is VurderVirksomhet -> {
                val sideEffect = VurderVirksomhetSideEffect(
                    orgnummer = hendelse.orgnr,
                    superbruker = hendelse.superbruker,
                    navEnhet = hendelse.navEnhet,
                    valgtÅrsak = hendelse.valgtÅrsak,
                )
                with(fiaKontekst.nyFlytService) {
                    val resultat = sideEffect.apply()
                    Konsekvens(
                        nyTilstand = if (resultat.isRight()) VirksomhetVurderes else VirksomhetKlarTilVurdering,
                        endring = resultat,
                    )
                }
            }

            else -> {
                Konsekvens(
                    nyTilstand = VirksomhetKlarTilVurdering,
                    endring = Either.Left(
                        Feil(
                            "'${hendelse.navn()}' er ikke gjennomførbar for '${VirksomhetKlarTilVurdering.tilVirksomhetIATilstand()}'",
                            HttpStatusCode.BadRequest,
                        ),
                    ),
                )
            }
        }
}
