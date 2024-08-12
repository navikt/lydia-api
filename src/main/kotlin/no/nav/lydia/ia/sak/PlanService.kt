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
                httpStatusCode = HttpStatusCode.BadRequest,
            ).left()
        }

    fun endreUndertemaerTilTema(
        temaId: Int,
        iaSak: IASak,
        planlagt: Boolean? = null,
        endredeUndertemaer: List<EndreUndertemaRequest>,
    ): Either<Feil, PlanTema> =
        hentPlan(iaSak = iaSak).flatMap { plan ->

            val tema = plan.temaer.firstOrNull { it.id == temaId } ?: return Feil(
                feilmelding = "Fant ikke tema",
                httpStatusCode = HttpStatusCode.BadRequest,
            ).left()

            val oppdaterteUndertemaer: List<PlanUndertema> =
                tema.undertemaer.map { lagretUndertema ->
                    endredeUndertemaer.firstOrNull { redigert -> redigert.id == lagretUndertema.id }?.let { redigert ->
                        lagretUndertema.copy(
                            planlagt = redigert.planlagt,
                            status = if (redigert.planlagt) PlanUndertema.Status.PLANLAGT else null,
                            startDato = if (redigert.planlagt) redigert.startDato else null,
                            sluttDato = if (redigert.planlagt) redigert.sluttDato else null,
                        )
                    } ?: return Feil(
                        feilmelding = "Fikk ikke undertema fra forespørsel",
                        httpStatusCode = HttpStatusCode.BadRequest,
                    ).left()
                }

            planRepository.oppdaterTema(
                planId = plan.id,
                temaId = temaId,
                planlagt = planlagt ?: tema.planlagt,
                undertemaer = oppdaterteUndertemaer,
            )?.right() ?: Feil(
                feilmelding = "Kunne ikke oppdatere tema",
                httpStatusCode = HttpStatusCode.InternalServerError,
            ).left()
        }

    fun endreFlereTema(
        iaSak: IASak,
        endredeTema: List<EndreTemaRequest>,
    ): Either<Feil, List<PlanTema>> =
        endredeTema.map { tema ->
            endreUndertemaerTilTema(
                iaSak = iaSak,
                temaId = tema.id,
                planlagt = tema.planlagt,
                endredeUndertemaer = tema.undertemaer,
            )
        }.let { l -> either { l.bindAll() } }

    fun endreStatus(
        temaId: Int,
        undertemaId: Int,
        iaSak: IASak,
        nyStatus: PlanUndertema.Status,
    ): Either<Feil, PlanUndertema> {
        return hentPlan(iaSak = iaSak).flatMap { plan ->
            val lagredeUndertemaer =
                plan.temaer.firstOrNull { it.id == temaId }?.undertemaer ?: return Feil(
                    feilmelding = "Fant ikke tema",
                    httpStatusCode = HttpStatusCode.BadRequest,
                ).left()

            val oppdatertUndertema: PlanUndertema =
                lagredeUndertemaer.firstOrNull { it.id == undertemaId }?.copy(status = nyStatus) ?: return Feil(
                    feilmelding = "Fant ikke undertema",
                    httpStatusCode = HttpStatusCode.BadRequest,
                ).left()

            planRepository.oppdaterUndertema(
                planId = plan.id,
                temaId = temaId,
                undertema = oppdatertUndertema,
            )?.right() ?: return Feil(
                feilmelding = "Feil ved oppdatering av undertema",
                httpStatusCode = HttpStatusCode.InternalServerError,
            ).left()
        }
    }
}
