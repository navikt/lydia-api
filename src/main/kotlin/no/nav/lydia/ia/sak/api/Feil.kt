package no.nav.lydia.ia.sak.api

import io.ktor.http.HttpStatusCode

class Feil(
    val feilmelding: String,
    val httpStatusCode: HttpStatusCode,
)
