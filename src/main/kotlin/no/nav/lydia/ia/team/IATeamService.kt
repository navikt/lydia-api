package no.nav.lydia.ia.team

import arrow.core.Either
import arrow.core.getOrElse
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import org.slf4j.Logger
import org.slf4j.LoggerFactory

class IATeamService(
    val iaTeamRepository: IATeamRepository,
) {
    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun erFølgerAvSak(
        iaSak: IASak,
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
    ) = erFølgerAvSak(saksnummer = iaSak.saksnummer, saksbehandler = saksbehandler)

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
        iaSak: IASak,
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
    ) = erEierEllerFølgerAvSak(
        saksnummer = iaSak.saksnummer,
        eierAvSak = iaSak.eidAv,
        saksbehandler = saksbehandler,
    )

    fun erEierEllerFølgerAvSak(
        saksnummer: String,
        eierAvSak: String?,
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
    ): Boolean {
        val erEierAvSak = eierAvSak == saksbehandler.navIdent
        return erFølgerAvSak(saksnummer = saksnummer, saksbehandler = saksbehandler) || erEierAvSak
    }

    fun hentBrukereITeam(iaSak: IASak) = hentBrukereITeam(iaSak.saksnummer)

    fun hentBrukereITeam(saksnummer: String) =
        try {
            iaTeamRepository.brukereITeam(saksnummer = saksnummer).right()
        } catch (e: Exception) {
            log.error("Feil ved henting av en saks brukere. Feilmelding: ${e.message}", e)
            Feil("Feil ved henting av brukere i team", httpStatusCode = HttpStatusCode.InternalServerError).left()
        }

    fun knyttBrukerTilSak(
        iaSak: IASak,
        navAnsatt: NavAnsatt,
    ): Either<Feil, BrukerITeamDto> =
        iaTeamRepository.leggBrukerTilTeam(iaSak = iaSak, navAnsatt = navAnsatt)?.right()
            ?: Feil("Feil ved knytting av bruker til sak", HttpStatusCode.BadRequest).left()

    fun fjernBrukerFraSak(
        iaSak: IASak,
        navAnsatt: NavAnsatt,
    ): Either<Feil, BrukerITeamDto> =
        iaTeamRepository.slettBrukerFraTeam(iaSak = iaSak, navAnsatt = navAnsatt)?.right()
            ?: Feil("Feil ved fjerning av bruker som følger sak", HttpStatusCode.BadRequest).left()

    fun hentSakerTilBruker(navAnsatt: NavAnsatt): Either<Feil, List<Pair<IASak, String>>> =
        try {
            iaTeamRepository.hentSakerBrukerEierEllerFølger(navAnsatt = navAnsatt).right()
        } catch (e: Exception) {
            log.error("Feil ved henting av en brukers saker. Feilmelding: ${e.message}", e)
            Feil("Feil ved henting av en brukers saker", httpStatusCode = HttpStatusCode.InternalServerError).left()
        }
}
