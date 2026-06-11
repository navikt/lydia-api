package no.nav.lydia.tilstandsmaskin.tilstand

import arrow.core.Either
import arrow.core.left
import io.ktor.http.HttpStatusCode
import no.nav.lydia.felles.Feil
import no.nav.lydia.tilstandsmaskin.FiaKontekst
import no.nav.lydia.tilstandsmaskin.Konsekvens
import no.nav.lydia.tilstandsmaskin.hendelse.Hendelse
import no.nav.lydia.tilstandsmaskin.hendelse.VurderVirksomhet
import no.nav.lydia.tilstandsmaskin.sideeffect.VurderVirksomhetSideEffect
import no.nav.lydia.tilstandsmaskin.tilVirksomhetIATilstand

object VirksomhetKlarTilVurdering : Tilstand() { // IKKE_AKTIV
    override fun utførTransisjon(
        hendelse: Hendelse,
        fiaKontekst: FiaKontekst,
    ): Either<Feil, Konsekvens> =
        when (hendelse) {
            is VurderVirksomhet -> {
                val sideEffect = VurderVirksomhetSideEffect(
                    orgnummer = hendelse.orgnr,
                    superbruker = hendelse.superbruker,
                    navEnhet = hendelse.navEnhet,
                    valgtÅrsak = hendelse.valgtÅrsak,
                )
                with(fiaKontekst.nyFlytService) {
                    sideEffect.apply().map {
                        Konsekvens(
                            nyTilstand = VirksomhetVurderes,
                            verdi = it,
                        )
                    }
                }
            }

            else -> {
                Feil(
                    "'${hendelse.navn()}' er ikke gjennomførbar for '${VirksomhetKlarTilVurdering.tilVirksomhetIATilstand()}'",
                    HttpStatusCode.BadRequest,
                ).left()
            }
        }
}
