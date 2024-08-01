package no.nav.lydia.ia.sak

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import no.nav.lydia.Observer
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.db.PlanRepository
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.plan.Plan
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import java.util.UUID

class PlanService(
    val iaProsessService: IAProsessService,
    val planObserverers: List<Observer<Plan>>,
    val planRepository: PlanRepository,
) {
    fun opprettPlan(
        iaSak: IASak,
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
    ): Either<Feil, Plan> =
        iaProsessService.hentEllerOpprettIAProsess(iaSak).flatMap { prosess ->
            planRepository.opprettPlan(
                planId = UUID.randomUUID(),
                prosessId = prosess.id,
                saksbehandler = saksbehandler,
            )
        }.onRight { plan ->
            planObserverers.forEach { it.receive(plan) }
        }

    fun hentPlan(iaSak: IASak): Either<Feil, Plan> =
        iaProsessService.hentEllerOpprettIAProsess(iaSak).flatMap { prosess ->
            planRepository.hentPlan(prosessId = prosess.id)?.right() ?: Feil(
                feilmelding = "Fant ikke plan",
                httpStatusCode = HttpStatusCode.NotFound,
            ).left()
        }
}
