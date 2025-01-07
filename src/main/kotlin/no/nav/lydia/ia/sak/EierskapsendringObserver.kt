package no.nav.lydia.ia.sak

import no.nav.lydia.EndringsObserver
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.team.IATeamService
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt

class EierskapsendringObserver(
    val iaTeamService: IATeamService,
) : EndringsObserver<IASak, IASakshendelse> {
    override fun recieve(
        før: IASak,
        endring: IASakshendelse,
        etter: IASak,
    ) {
        val eierskapFørEndring = før.eidAv
        if (
            endring.hendelsesType == IASakshendelseType.TA_EIERSKAP_I_SAK &&
            eierskapFørEndring != null
        ) {
            iaTeamService.knyttBrukerTilSak(
                etter,
                NavAnsatt.NavAnsattMedSaksbehandlerRolle.Saksbehandler(
                    navIdent = eierskapFørEndring,
                    navn = "",
                    token = "",
                    ansattesGrupper = emptySet(),
                ),
            )
        }
    }
}
