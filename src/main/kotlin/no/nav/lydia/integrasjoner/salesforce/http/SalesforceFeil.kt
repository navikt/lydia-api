package no.nav.lydia.integrasjoner.salesforce.http

import io.ktor.http.HttpStatusCode
import no.nav.lydia.ia.sak.api.Feil

object SalesforceFeil {
    val `feil ved uthenting av token` =
        Feil("Feil ved uthenting av token", httpStatusCode = HttpStatusCode.InternalServerError)
    val `feil ved parsing av token` =
        Feil("Feil ved parsing av token", httpStatusCode = HttpStatusCode.InternalServerError)
    val `feil ved uthenting av av data fra salesforce` =
        Feil("Feil ved uthenting av av data fra salesforce", httpStatusCode = HttpStatusCode.InternalServerError)
    val `fant ingen data i salesforce` =
        Feil("Fant ingen data i Salesforce", httpStatusCode = HttpStatusCode.NotFound)
}
