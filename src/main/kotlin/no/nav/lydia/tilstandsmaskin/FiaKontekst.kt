package no.nav.lydia.tilstandsmaskin

import no.nav.lydia.dokumentpublisering.DokumentPubliseringService
import no.nav.lydia.samarbeid.IASamarbeidService
import no.nav.lydia.samarbeidsperiode.IASakService
import no.nav.lydia.samarbeidsplan.PlanService

data class FiaKontekst(
    val iaSakService: IASakService,
    val iASamarbeidService: IASamarbeidService,
    val dokumentPubliseringService: DokumentPubliseringService,
    val planService: PlanService,
    val nyFlytService: NyFlytService,
    val tilstandVirksomhetRepository: TilstandVirksomhetRepository,
    val saksnummer: String?,
)
