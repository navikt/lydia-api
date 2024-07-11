package no.nav.lydia.ia.team

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import org.slf4j.LoggerFactory

class IATeamService(val iaTeamRepository: IATeamRepository) {
    val log = LoggerFactory.getLogger(this.javaClass)

    fun hentBrukereITeam(iaSak: IASak, navAnsatt: NavAnsatt) =
        try {
            iaTeamRepository.brukereITeam(iaSak = iaSak, navAnsatt = navAnsatt).right()
        } catch (e: Exception) {
            log.error("Feil ved henting av en saks brukere. Feilmelding: ${e.message}", e)
            Feil("Feil ved henting av brukere i team", httpStatusCode = HttpStatusCode.InternalServerError).left()
        }

    fun knyttBrukerTilSak(iaSak: IASak, navAnsatt: NavAnsatt): Either<Feil, BrukerITeamDto> =
        iaTeamRepository.leggBrukerTilTeam(iaSak = iaSak, navAnsatt = navAnsatt)?.right()
            ?: IASakError.`ugyldig saksnummer`.left()

    fun fjernBrukerFraSak(iaSak: IASak, navAnsatt: NavAnsatt): Either<Feil, BrukerITeamDto> =
        iaTeamRepository.slettBrukerFraTeam(iaSak = iaSak, navAnsatt = navAnsatt)?.right()
            ?: IASakError.`ugyldig saksnummer`.left()


    fun hentSakerTilBruker(navAnsatt: NavAnsatt): Either<Feil, List<MineSakerDto>> {
        return try {
            iaTeamRepository.hentSakerTilBruker(navAnsatt = navAnsatt).right()
        } catch (e: Exception) {
            log.error("Feil ved henting av en brukers saker. Feilmelding: ${e.message}", e)
            Feil("Feil ved henting av en brukers saker", httpStatusCode = HttpStatusCode.InternalServerError).left()
        }
    }
}
