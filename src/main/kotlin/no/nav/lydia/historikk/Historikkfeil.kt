package no.nav.lydia.historikk

import io.ktor.http.HttpStatusCode
import no.nav.lydia.felles.Feil

object Historikkfeil {
    val `ugyldig orgnummer` =
        Feil(feilmelding = "Ugyldig orgnummer", httpStatusCode = HttpStatusCode.BadRequest)

    val `fant ikke samarbeid` = Feil(
        feilmelding = "Fant ikke samarbeid",
        httpStatusCode = HttpStatusCode.NotFound,
    )
}
