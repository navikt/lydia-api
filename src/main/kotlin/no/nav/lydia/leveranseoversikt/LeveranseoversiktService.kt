package no.nav.lydia.leveranseoversikt

import arrow.core.Either
import io.ktor.http.*
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.tilgangskontroll.NavAnsatt
import org.slf4j.LoggerFactory

class LeveranseoversiktService(val leveranseoversiktRepository: LeveranseoversiktRepository) {
    val log = LoggerFactory.getLogger(this.javaClass)

    fun hentMineLeveranser(saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle): Either<Feil, List<LeveranseoversiktDto>> {
        return try {
            Either.Right(leveranseoversiktRepository.hentLeveranser(saksbehandler = saksbehandler))
        } catch (e: Exception) {
            log.error("Kunne ikke hente leveranser for bruker. Feilmelding: ${e.message}", e)
            Either.Left(Feil("Kunne ikke hente leveransene dine", HttpStatusCode.InternalServerError))
        }
    }

}
