package no.nav.lydia.samarbeidsperiode

import io.ktor.http.HttpStatusCode
import no.nav.lydia.felles.Feil

object IASakError {
    val `fikk ikke oppdatert sak` =
        Feil(feilmelding = "Fikk ikke oppdatert sak", httpStatusCode = HttpStatusCode.Conflict)
    val `ugyldig orgnummer` =
        Feil(feilmelding = "Ugyldig orgnummer", httpStatusCode = HttpStatusCode.BadRequest)
    val `ugyldig saksnummer` =
        Feil(feilmelding = "Ugyldig saksnummer", httpStatusCode = HttpStatusCode.BadRequest)
    val `er ikke følger eller eier av sak` =
        Feil(feilmelding = "Er ikke følger eller eier av sak", httpStatusCode = HttpStatusCode.Forbidden)
    val `er ikke følger av sak` =
        Feil(feilmelding = "Er ikke følger av sak", httpStatusCode = HttpStatusCode.Forbidden)
    val `generell feil under uthenting` =
        Feil(feilmelding = "Generell feil under uthenting", httpStatusCode = HttpStatusCode.InternalServerError)
    val `kan ikke ta eierskap da det ikke finnes noen aktiv sak` =
        Feil(
            feilmelding = "kan ikke ta eierskap da det ikke finnes noen aktiv sak",
            httpStatusCode = HttpStatusCode.BadRequest,
        )
}
