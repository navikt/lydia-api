package no.nav.lydia.abc.tilstandsmaskin

import no.nav.lydia.abc.dokument.DokumentPubliseringService
import no.nav.lydia.abc.samarbeid.IASamarbeidService
import no.nav.lydia.abc.samarbeidsperiode.IASakService
import no.nav.lydia.ia.sak.PlanService

data class FiaKontekst(
    val iaSakService: IASakService,
    val iASamarbeidService: IASamarbeidService,
    val dokumentPubliseringService: DokumentPubliseringService,
    val planService: PlanService,
    val nyFlytService: NyFlytService,
    val tilstandVirksomhetRepository: TilstandVirksomhetRepository,
    val saksnummer: String?,
)
