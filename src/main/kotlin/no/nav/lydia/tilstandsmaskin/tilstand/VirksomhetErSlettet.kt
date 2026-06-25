package no.nav.lydia.tilstandsmaskin.tilstand

import arrow.core.Either
import arrow.core.left
import io.ktor.http.HttpStatusCode
import no.nav.lydia.felles.Feil
import no.nav.lydia.tilstandsmaskin.FiaKontekst
import no.nav.lydia.tilstandsmaskin.Konsekvens
import no.nav.lydia.tilstandsmaskin.hendelse.Hendelse
import no.nav.lydia.tilstandsmaskin.tilVirksomhetIATilstand

object VirksomhetErSlettet : Tilstand() {
    override fun utførTransisjon(
        hendelse: Hendelse,
        fiaKontekst: FiaKontekst,
    ): Either<Feil, Konsekvens> =
        Feil(
            feilmelding = "'${hendelse.navn()}' er ikke gjennomførbar for '${VirksomhetErSlettet.tilVirksomhetIATilstand()}'",
            httpStatusCode = HttpStatusCode.BadRequest,
        ).left()
}
