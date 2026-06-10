package no.nav.lydia.felles

import io.ktor.http.HttpStatusCode

class Feil(
    val feilmelding: String,
    val httpStatusCode: HttpStatusCode,
)
