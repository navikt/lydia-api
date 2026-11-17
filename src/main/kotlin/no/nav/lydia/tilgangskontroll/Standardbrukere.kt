package no.nav.lydia.tilgangskontroll

import no.nav.lydia.tilgangskontroll.fia.NavAnsatt

object Standardbrukere {
    val fiaSystemSuperbruker =
        NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker(
            navIdent = "Fia system",
            navn = "Fia system",
            token = "",
            ansattesGrupper = emptySet(),
        )
}
