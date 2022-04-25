package no.nav.lydia.tilgangskontroll

import io.ktor.server.application.*
import no.nav.lydia.AzureConfig

class TilgangskontrollService(private val azureConfig: AzureConfig) {
    fun harLesetilgang() = false
    fun harSaksbehandlertilgang() = false
    fun harSuperbrukertilgang() = false
}
