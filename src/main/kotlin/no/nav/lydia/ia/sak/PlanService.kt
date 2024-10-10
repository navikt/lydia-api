package no.nav.lydia.ia.sak

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import arrow.core.raise.either
import arrow.core.right
import io.ktor.http.HttpStatusCode
import java.util.UUID
import no.nav.lydia.Observer
import no.nav.lydia.appstatus.ObservedPlan
import no.nav.lydia.appstatus.PlanHendelseType
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
import org.slf4j.Logger
import org.slf4j.LoggerFactory

class PlanService(
    val iaProsessService: IAProsessService,
    val planObservers: List<Observer<ObservedPlan>>,
    val planRepository: PlanRepository,
) {
    private val logger: Logger = LoggerFactory.getLogger(this::class.java)

    fun opprettPlan(
        iaSak: IASak,
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
        prosessId: Int,
        mal: PlanMalDto,
    ): Either<Feil, Plan> =
        iaProsessService.hentIAProsess(iaSak, prosessId).flatMap { prosess ->
            planRepository.opprettPlan(
                planId = UUID.randomUUID(),
                prosessId = prosess.id,
                saksbehandler = saksbehandler,
                mal = mal,
            )
        }.onRight { plan ->
            planObservers.forEach { it.receive(ObservedPlan(hendelsesType = PlanHendelseType.OPPRETT, plan = plan)) }
            logger.info("Opprettet plan med Id '${plan.id}'")
        }

    fun hentPlan(
        iaSak: IASak,
        prosessId: Int,
    ): Either<Feil, Plan> =
        iaProsessService.hentIAProsess(iaSak, prosessId).flatMap { prosess ->
            planRepository.hentPlan(
                prosessId = prosess.id,
            )?.right() ?: PlanFeil.`fant ikke plan`.left()
        }

    fun endreUndertemaerTilTema(
        temaId: Int,
        iaSak: IASak,
        prosessId: Int,
        inkludert: Boolean? = null,
        endredeUndertemaer: List<EndreUndertemaRequest>,
    ): Either<Feil, PlanTema> =
        hentPlan(iaSak = iaSak, prosessId = prosessId).flatMap { plan ->
            val tema = plan.temaer.firstOrNull { it.id == temaId } ?: return PlanFeil.`fant ikke tema`.left()

            val oppdaterteUndertemaer: List<PlanUndertema> =
                tema.undertemaer.map { lagretUndertema ->
                    endredeUndertemaer.firstOrNull { redigert -> redigert.id == lagretUndertema.id }?.let { redigert ->
                        lagretUndertema.copy(
                            inkludert = redigert.inkludert,
                            status = if (redigert.inkludert) lagretUndertema.status
                                ?: PlanUndertema.Status.PLANLAGT else null,
                            startDato = if (redigert.inkludert) redigert.startDato else null,
                            sluttDato = if (redigert.inkludert) redigert.sluttDato else null,
                        )
                    } ?: return PlanFeil.`feil inndata i forespørsel`.left()
                }

            val ret = planRepository.oppdaterTema(
                planId = plan.id,
                temaId = temaId,
                inkludert = inkludert ?: tema.inkludert,
                undertemaer = oppdaterteUndertemaer,
            )?.right() ?: PlanFeil.`fikk ikke oppdatert tema`.left()

            ret.onRight {
                planObservers.forEach {
                    it.receive(
                        ObservedPlan(
                            hendelsesType = PlanHendelseType.OPPDATER,
                            plan = plan
                        )
                    )
                }
            }
        }

    fun endreFlereTema(
        iaSak: IASak,
        prosessId: Int,
        endredeTema: List<EndreTemaRequest>,
    ): Either<Feil, List<PlanTema>> =
        endredeTema.map { tema ->
            endreUndertemaerTilTema(
                iaSak = iaSak,
                prosessId = prosessId,
                temaId = tema.id,
                inkludert = tema.inkludert,
                endredeUndertemaer = tema.undertemaer,
            )
        }.let { l -> either { l.bindAll() } }

    fun endreStatus(
        temaId: Int,
        undertemaId: Int,
        iaSak: IASak,
        prosessId: Int,
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
                planObservers.forEach {
                    it.receive(
                        ObservedPlan(
                            hendelsesType = PlanHendelseType.OPPDATER,
                            plan = plan
                        )
                    )
                }
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
