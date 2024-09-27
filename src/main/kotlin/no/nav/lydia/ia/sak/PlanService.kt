package no.nav.lydia.ia.sak

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import arrow.core.raise.either
import arrow.core.right
import io.ktor.http.HttpStatusCode
import java.util.UUID
import no.nav.lydia.Observer
import no.nav.lydia.appstatus.PlanHendelseType
import no.nav.lydia.appstatus.PlanMetric
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.plan.EndreTemaRequest
import no.nav.lydia.ia.sak.api.plan.EndreUndertemaRequest
import no.nav.lydia.ia.sak.db.PlanRepository
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.plan.Plan
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.ia.sak.domene.plan.PlanTema
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema.Status.AVBRUTT
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt

class PlanService(
    val iaProsessService: IAProsessService,
    val planObservers: List<Observer<PlanMetric>>,
    val planRepository: PlanRepository,
) {
    fun opprettPlan(
        iaSak: IASak,
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
        prosessId: Int? = null,
        mal: PlanMalDto,
    ): Either<Feil, Plan> =
        iaProsessService.hentEllerOpprettIAProsesser(iaSak).flatMap { prosesser ->
            planRepository.opprettPlan(
                planId = UUID.randomUUID(),
                prosessId = prosessId ?: prosesser.first().id,
                saksbehandler = saksbehandler,
                mal = mal,
            )
        }.onRight { plan ->
            planObservers.forEach { it.receive(PlanMetric(hendelsesType = PlanHendelseType.OPPRETT, plan = plan)) }
        }

    fun hentPlan(
        iaSak: IASak,
        prosessId: Int? = null,
    ): Either<Feil, Plan> =
        iaProsessService.hentEllerOpprettIAProsesser(iaSak).flatMap { prosesser ->
            planRepository.hentPlan(
                prosessId = prosessId ?: prosesser.first().id,
            )?.right() ?: PlanFeil.`fant ikke plan`.left()
        }

    fun endreUndertemaerTilTema(
        temaId: Int,
        iaSak: IASak,
        prosessId: Int? = null,
        planlagt: Boolean? = null,
        endredeUndertemaer: List<EndreUndertemaRequest>,
    ): Either<Feil, PlanTema> =
        hentPlan(iaSak = iaSak, prosessId = prosessId).flatMap { plan ->
            val tema = plan.temaer.firstOrNull { it.id == temaId } ?: return PlanFeil.`fant ikke tema`.left()

            val oppdaterteUndertemaer: List<PlanUndertema> =
                tema.undertemaer.map { lagretUndertema ->
                    endredeUndertemaer.firstOrNull { redigert -> redigert.id == lagretUndertema.id }?.let { redigert ->
                        lagretUndertema.copy(
                            planlagt = redigert.planlagt,
                            status = if (redigert.planlagt) lagretUndertema.status
                                ?: PlanUndertema.Status.PLANLAGT else null,
                            startDato = if (redigert.planlagt) redigert.startDato else null,
                            sluttDato = if (redigert.planlagt) redigert.sluttDato else null,
                        )
                    } ?: return PlanFeil.`feil inndata i forespørsel`.left()
                }

            val ret = planRepository.oppdaterTema(
                planId = plan.id,
                temaId = temaId,
                planlagt = planlagt ?: tema.planlagt,
                undertemaer = oppdaterteUndertemaer,
            )?.right() ?: PlanFeil.`fikk ikke oppdatert tema`.left()

            ret.onRight {
                planObservers.forEach { it.receive(PlanMetric(hendelsesType = PlanHendelseType.OPPDATER, plan = plan)) }
            }
        }

    fun endreFlereTema(
        iaSak: IASak,
        prosessId: Int? = null,
        endredeTema: List<EndreTemaRequest>,
    ): Either<Feil, List<PlanTema>> =
        endredeTema.map { tema ->
            endreUndertemaerTilTema(
                iaSak = iaSak,
                prosessId = prosessId,
                temaId = tema.id,
                planlagt = tema.planlagt,
                endredeUndertemaer = tema.undertemaer,
            )
        }.let { l -> either { l.bindAll() } }

    fun endreStatus(
        temaId: Int,
        undertemaId: Int,
        iaSak: IASak,
        prosessId: Int? = null,
        nyStatus: PlanUndertema.Status,
    ): Either<Feil, PlanUndertema> {
        return hentPlan(iaSak = iaSak, prosessId = prosessId).flatMap { plan ->
            val lagredeUndertemaer =
                plan.temaer.firstOrNull { it.id == temaId }?.undertemaer ?: return PlanFeil.`fant ikke tema`.left()
            val lagretUndertema = lagredeUndertemaer.firstOrNull { it.id == undertemaId }

            if (nyStatus == AVBRUTT && lagretUndertema != null && lagretUndertema.starterIFremtiden())
                return Feil(
                    feilmelding = "Kan ikke endre status til '${nyStatus.name}' " +
                            "fordi '${lagretUndertema.navn}' ikke har startet enda",
                    httpStatusCode = HttpStatusCode.BadRequest
                ).left()

            val oppdatertUndertema: PlanUndertema =
                lagretUndertema?.copy(status = nyStatus)
                    ?: return PlanFeil.`fant ikke undertema`.left()

            val ret = planRepository.oppdaterUndertema(
                planId = plan.id,
                temaId = temaId,
                undertema = oppdatertUndertema,
            )?.right() ?: return PlanFeil.`fikk ikke oppdatert undertema`.left()

            ret.onRight {
                planObservers.forEach { it.receive(PlanMetric(hendelsesType = PlanHendelseType.OPPDATER, plan = plan)) }
            }
        }
    }
}

object PlanFeil {
    val `fant ikke plan` = Feil(
        feilmelding = "Fant ikke plan",
        httpStatusCode = HttpStatusCode.BadRequest,
    )
    val `fant ikke tema` = Feil(
        feilmelding = "Fant ikke tema",
        httpStatusCode = HttpStatusCode.BadRequest,
    )
    val `fant ikke undertema` = Feil(
        feilmelding = "Fant ikke undertema",
        httpStatusCode = HttpStatusCode.BadRequest,
    )
    val `feil inndata i forespørsel` = Feil(
        feilmelding = "Feil inndata i forespørsel",
        httpStatusCode = HttpStatusCode.BadRequest,
    )
    val `fikk ikke oppdatert tema` = Feil(
        feilmelding = "Feil ved oppdatering av tema",
        httpStatusCode = HttpStatusCode.InternalServerError,
    )
    val `fikk ikke oppdatert undertema` = Feil(
        feilmelding = "Feil ved oppdatering av undertema",
        httpStatusCode = HttpStatusCode.InternalServerError,
    )
}
