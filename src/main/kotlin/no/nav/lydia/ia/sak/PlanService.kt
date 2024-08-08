package no.nav.lydia.ia.sak

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import arrow.core.raise.either
import arrow.core.right
import io.ktor.http.HttpStatusCode
import no.nav.lydia.Observer
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.plan.EndreTemaRequest
import no.nav.lydia.ia.sak.api.plan.EndreUndertemaRequest
import no.nav.lydia.ia.sak.db.PlanRepository
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.plan.Plan
import no.nav.lydia.ia.sak.domene.plan.PlanTema
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema
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

    fun endreTema(
        temaId: Int,
        iaSak: IASak,
        endredeUndertemaer: List<EndreUndertemaRequest>,
    ): Either<Feil, PlanTema> =
        hentPlan(iaSak = iaSak).flatMap { plan ->
            val lagredeUndertemaer =
                plan.temaer.firstOrNull { it.id == temaId }?.undertemaer ?: return Feil(
                    feilmelding = "Fant ikke tema",
                    httpStatusCode = HttpStatusCode.BadRequest,
                ).left()

            val oppdaterteUndertemaer: List<PlanUndertema> =
                lagredeUndertemaer.map { lagretUndertema ->
                    endredeUndertemaer.firstOrNull { redigert -> redigert.id == lagretUndertema.id }?.let { redigert ->
                        lagretUndertema.copy(
                            planlagt = redigert.planlagt,
                            startDato = if (redigert.planlagt) redigert.startDato else null,
                            sluttDato = if (redigert.planlagt) redigert.sluttDato else null,
                            status = if (redigert.planlagt) PlanUndertema.Status.PLANLAGT else null,
                        )
                    } ?: return Feil(
                        feilmelding = "Fikk ikke undertema fra forespørsel",
                        httpStatusCode = HttpStatusCode.BadRequest,
                    ).left()
                }

            planRepository.oppdaterTema(
                temaId = temaId,
                undertemaer = oppdaterteUndertemaer,
            ).right()
        }

    fun endreTemaer(
        iaSak: IASak,
        endredeTema: List<EndreTemaRequest>,
    ): Either<Feil, List<PlanTema>> =
        endredeTema.map { tema ->
            endreTema(
                temaId = tema.id,
                iaSak = iaSak,
                endredeUndertemaer = tema.undertemaer,
            )
        }.let { l -> either { l.bindAll() } }
}
