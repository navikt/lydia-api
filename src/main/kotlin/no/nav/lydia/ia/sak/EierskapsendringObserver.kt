package no.nav.lydia.ia.sak

import no.nav.lydia.EndringsObserver
import no.nav.lydia.abc.samarbeidsperiode.IASakDto
import no.nav.lydia.abc.samarbeidsperiode.IASakshendelse
import no.nav.lydia.abc.samarbeidsperiode.IASakshendelseType
import no.nav.lydia.abc.team.IATeamService
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt

class EierskapsendringObserver(
    val iaTeamService: IATeamService,
) : EndringsObserver<IASakDto, IASakshendelse> {
    override fun receive(
        før: IASakDto,
        endring: IASakshendelse,
        etter: IASakDto,
    ) {
        val eierskapFørEndring = før.eidAv
        if (
            endring.hendelsesType == IASakshendelseType.TA_EIERSKAP_I_SAK &&
            eierskapFørEndring != null
        ) {
            iaTeamService.knyttBrukerTilSak(
                iaSakDto = etter,
                navAnsatt = NavAnsatt.NavAnsattMedSaksbehandlerRolle.Saksbehandler(
                    navIdent = eierskapFørEndring,
                    navn = "",
                    token = "",
                    ansattesGrupper = emptySet(),
                ),
            )
        }
    }
}
