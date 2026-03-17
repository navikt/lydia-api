package no.nav.lydia.ia.sak.api.ny.flyt

import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.IASamarbeidService
import no.nav.lydia.ia.sak.PlanService
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringService

data class FiaKontekst(
    val iaSakService: IASakService,
    val iASamarbeidService: IASamarbeidService,
    val dokumentPubliseringService: DokumentPubliseringService,
    val planService: PlanService,
    val nyFlytService: NyFlytService,
    val tilstandVirksomhetRepository: TilstandVirksomhetRepository,
    val saksnummer: String?,
)
