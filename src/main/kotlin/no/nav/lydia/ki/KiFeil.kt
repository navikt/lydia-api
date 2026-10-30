package no.nav.lydia.ki

import io.ktor.http.HttpStatusCode
import no.nav.lydia.felles.Feil

object KiFeil {
    val `kall mot KI feilet` =
        Feil(feilmelding = "Kall mot KI feilet", httpStatusCode = HttpStatusCode.InternalServerError)
    val `for mange forespørsler mot KI` =
        Feil(feilmelding = "For mange forespørsler mot KI", httpStatusCode = HttpStatusCode.InternalServerError)
    val `KI avslo å vurdere teksten` =
        Feil(feilmelding = "KI avslo å vurdere teksten", httpStatusCode = HttpStatusCode.InternalServerError)
    val `ufullstendig svar fra KI` =
        Feil(feilmelding = "Ufullstendig svar fra KI", httpStatusCode = HttpStatusCode.InternalServerError)
    val `ugyldig svar fra KI` =
        Feil(feilmelding = "Ugyldig svar fra KI", httpStatusCode = HttpStatusCode.InternalServerError)
    val `ugyldig systemprompt` =
        Feil(feilmelding = "Ugyldig systemprompt for KI", httpStatusCode = HttpStatusCode.InternalServerError)
}
