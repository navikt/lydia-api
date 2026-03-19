package no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.sideeffect

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.ny.flyt.NyFlytService
import no.nav.lydia.ia.sak.api.ny.flyt.Transaction
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetIATilstand
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetTilstandDto
import no.nav.lydia.ia.sak.api.ny.flyt.lagreEllerOppdaterVirksomhetTilstand

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
            Feil("Feil ved vurdering av virksomhet: ${e.message}", HttpStatusCode.InternalServerError).left()
        }
}
