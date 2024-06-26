package no.nav.lydia.ia.sak

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.db.BrukerITeam
import no.nav.lydia.ia.sak.db.IASakTeamRepository
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt

class IASakTeamService(val iaSakTeamRepository: IASakTeamRepository) {
    fun knyttBrukerTilSak(iaSak: IASak, navAnsatt: NavAnsatt): Either<Feil, BrukerITeam> =
        iaSakTeamRepository.leggBrukerTilTeam(iaSak = iaSak, navAnsatt = navAnsatt)?.right() ?: IASakError.`ikke eier av sak`.left()
}
