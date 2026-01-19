package no.nav.lydia.ia.team

import arrow.core.Either
import arrow.core.getOrElse
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import org.slf4j.Logger
import org.slf4j.LoggerFactory

class IATeamService(
    val iaTeamRepository: IATeamRepository,
) {
    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun erFølgerAvSak(
        saksnummer: String,
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
    ) = hentBrukereITeam(saksnummer = saksnummer).map { alleFølgere ->
        alleFølgere.any { følgerAvSak ->
            følgerAvSak == saksbehandler.navIdent
        }
    }.getOrElse {
        false
    }

    fun erEierEllerFølgerAvSak(
        saksnummer: String,
        eierAvSak: String?,
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
    ): Boolean {
        val erEierAvSak = eierAvSak == saksbehandler.navIdent
        return erFølgerAvSak(saksnummer = saksnummer, saksbehandler = saksbehandler) || erEierAvSak
    }

    fun hentBrukereITeam(iaSakDto: IASakDto) = hentBrukereITeam(iaSakDto.saksnummer)

    fun hentBrukereITeam(saksnummer: String) =
        try {
            iaTeamRepository.brukereITeam(saksnummer = saksnummer).right()
        } catch (e: Exception) {
            log.error("Feil ved henting av en saks brukere. Feilmelding: ${e.message}", e)
            Feil("Feil ved henting av brukere i team", httpStatusCode = HttpStatusCode.InternalServerError).left()
        }

    fun knyttBrukerTilSak(
        iaSakDto: IASakDto,
        navAnsatt: NavAnsatt,
    ): Either<Feil, BrukerITeamDto> =
        iaTeamRepository.leggBrukerTilTeam(saksnummer = iaSakDto.saksnummer, navAnsatt = navAnsatt)?.right()
            ?: Feil("Feil ved knytting av bruker til sak", HttpStatusCode.BadRequest).left()

    fun fjernBrukerFraSak(
        iaSakDto: IASakDto,
        navAnsatt: NavAnsatt,
    ): Either<Feil, BrukerITeamDto> =
        iaTeamRepository.slettBrukerFraTeam(saksnummer = iaSakDto.saksnummer, navAnsatt = navAnsatt)?.right()
            ?: Feil("Feil ved fjerning av bruker som følger sak", HttpStatusCode.BadRequest).left()

    fun hentSakerTilBruker(navAnsatt: NavAnsatt): Either<Feil, List<Pair<IASakDto, String>>> =
        try {
            iaTeamRepository.hentSakerBrukerEierEllerFølger(navAnsatt = navAnsatt).right()
        } catch (e: Exception) {
            log.error("Feil ved henting av en brukers saker. Feilmelding: ${e.message}", e)
            Feil("Feil ved henting av en brukers saker", httpStatusCode = HttpStatusCode.InternalServerError).left()
        }
}
