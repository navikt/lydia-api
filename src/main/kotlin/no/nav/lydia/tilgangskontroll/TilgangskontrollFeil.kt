package no.nav.lydia.tilgangskontroll

import io.ktor.http.*
import no.nav.lydia.ia.sak.api.Feil

object TilgangskontrollFeil {
    val IkkeAutorisert = Feil("Ikke autorisert", HttpStatusCode.Forbidden)
    val FantIkkeToken = Feil("Fant ikke token i autentisering header", HttpStatusCode.BadRequest)
    val FantIkkeNavIdent = Feil("Fant ikke NAV-ident på tokenet", HttpStatusCode.Forbidden)
    val FantIkkeNavn = Feil("Fant ikke navn på tokenet", HttpStatusCode.Forbidden)
    val FantIngenADGrupper = Feil("Fant ingen AD-grupper på tokenet", HttpStatusCode.Forbidden)
    val KunneIkkeVeksleToken = Feil("Kunne ikke veksle inn token", HttpStatusCode.InternalServerError)
}