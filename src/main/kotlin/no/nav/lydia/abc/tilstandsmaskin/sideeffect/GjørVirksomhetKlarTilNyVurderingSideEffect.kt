package no.nav.lydia.abc.tilstandsmaskin.sideeffect

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import no.nav.lydia.abc.felles.Feil
import no.nav.lydia.abc.tilstandsmaskin.NyFlytService
import no.nav.lydia.abc.tilstandsmaskin.Transaction
import no.nav.lydia.abc.tilstandsmaskin.VirksomhetIATilstand
import no.nav.lydia.abc.tilstandsmaskin.VirksomhetTilstandDto
import no.nav.lydia.abc.tilstandsmaskin.lagreEllerOppdaterVirksomhetTilstand

class GjørVirksomhetKlarTilNyVurderingSideEffect(
    val orgnummer: String,
) : SideEffect<VirksomhetTilstandDto?>() {
    context(nyFlytService: NyFlytService)
    override fun apply(): Either<Feil, VirksomhetTilstandDto?> =
        try {
            Transaction(nyFlytService.dataSource).transactional { tx ->
                with(tx) {
                    lagreEllerOppdaterVirksomhetTilstand(
                        orgnr = orgnummer,
                        tilstand = VirksomhetIATilstand.VirksomhetKlarTilVurdering,
                    )
                }
            }.right()
        } catch (e: Exception) {
            Feil(
                feilmelding = "Feil ved gjør virksomhet klar til vurdering for virksomhet med orgnr: '$orgnummer' med melding: '${e.message}'",
                httpStatusCode = HttpStatusCode.InternalServerError,
            ).left()
        }
}
