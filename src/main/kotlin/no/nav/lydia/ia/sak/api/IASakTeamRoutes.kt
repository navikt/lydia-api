package no.nav.lydia.ia.sak.api

import io.ktor.server.routing.*
import no.nav.lydia.ADGrupper
import no.nav.lydia.AuditLog
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.IASakTeamService
import no.nav.lydia.integrasjoner.azure.AzureService


fun Route.iaSakTeam(
    iaSakTeamService: IASakTeamService,
    iaSakService: IASakService,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
    azureService: AzureService,
) {

}