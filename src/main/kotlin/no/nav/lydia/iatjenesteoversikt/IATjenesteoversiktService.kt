package no.nav.lydia.iatjenesteoversikt

import arrow.core.Either
import io.ktor.http.HttpStatusCode
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import org.slf4j.Logger
import org.slf4j.LoggerFactory

class IATjenesteoversiktService(
    val iaTjenesteoversiktRepository: IATjenesteoversiktRepository,
) {
    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun hentMineIATjenester(saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle): Either<Feil, List<IATjenesteoversiktDto>> =
        try {
            Either.Right(iaTjenesteoversiktRepository.hentIATjenester(saksbehandler = saksbehandler))
        } catch (e: Exception) {
            log.error("Kunne ikke hente IA-tjenester for bruker. Feilmelding: ${e.message}", e)
            Either.Left(Feil("Kunne ikke hente IA-tjenestene dine", HttpStatusCode.InternalServerError))
        }
}
