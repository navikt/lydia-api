package no.nav.lydia.ia.sak

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import arrow.core.right
import ia.felles.integrasjoner.kafkameldinger.eksport.InnholdStatus
import ia.felles.integrasjoner.kafkameldinger.eksport.InnholdStatus.AVBRUTT
import ia.felles.integrasjoner.kafkameldinger.eksport.InnholdStatus.PLANLAGT
import io.ktor.http.HttpStatusCode
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
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.util.UUID

class PlanService(
    val iaProsessService: IAProsessService,
    val planObservers: List<Observer<ObservedPlan>>,
    val planRepository: PlanRepository,
) {
    private val logger: Logger = LoggerFactory.getLogger(this::class.java)

    fun hentPlan(samarbeidId: Int): Either<Feil, Plan> =
        planRepository.hentPlan(prosessId = samarbeidId)?.right() ?: PlanFeil.`fant ikke plan`.left()

    fun opprettPlan(
        iaSak: IASak,
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
        prosessId: Int,
        mal: PlanMalDto,
    ): Either<Feil, Plan> =
        iaProsessService.hentIAProsess(iaSak, prosessId).flatMap { prosess ->
            val planEksistererAllerede = hentPlan(samarbeidId = prosess.id).isRight()

            if (planEksistererAllerede) {
                return Feil(
                    feilmelding = "Plan eksisterer allerede for dette samarbeidet: '$prosessId'",
                    httpStatusCode = HttpStatusCode.BadRequest,
                ).left()
            }

            if (!mal.erGyldig()) {
                logger.warn("Feil inndata i forespørsel")
                return PlanFeil.`feil inndata i forespørsel`.left()
            }

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

    fun endreFlereTemaer(
        lagretPlan: Plan,
        endringAvPlan: List<EndreTemaRequest>,
    ): Either<Feil, Plan> {
        // valider endring
        if (!endringAvPlan.erGyldig(lagretPlan)) {
            return PlanFeil.`feil inndata i forespørsel`.left()
        }

        endringAvPlan.forEach { tema ->
            planRepository.oppdaterTema(
                planId = lagretPlan.id,
                temaId = tema.id,
                inkludert = tema.inkludert,
            )?.right() ?: PlanFeil.`fikk ikke oppdatert tema`.left()
            // oppdater status på tema ^

            endreInnhold(
                samarbeidId = lagretPlan.samarbeidId,
                lagretTema = lagretPlan.temaer.first { it.id == tema.id },
                nyttInnholdListe = tema.undertemaer,
            )
            // oppdater status på undertemaene ^
        }

        return hentPlan(samarbeidId = lagretPlan.samarbeidId).onRight { oppdatertPlan ->
            planObservers.forEach {
                it.receive(
                    ObservedPlan(
                        hendelsesType = PlanHendelseType.OPPDATER,
                        plan = oppdatertPlan,
                    ),
                )
            }
        }
    }

    fun endreEttTema(
        lagretPlan: Plan,
        temaId: Int,
        nyttInnholdListe: List<EndreUndertemaRequest>,
    ): Either<Feil, Plan> {
        // valider endring
        val lagretTema = lagretPlan.temaer.firstOrNull { it.id == temaId } ?: return PlanFeil.`fant ikke tema`.left()

        if (!nyttInnholdListe.erGyldig(lagretTema)) {
            return PlanFeil.`feil inndata i forespørsel`.left()
        }

        // gjør endring
        return endreInnhold(
            samarbeidId = lagretPlan.samarbeidId,
            lagretTema = lagretTema,
            nyttInnholdListe = nyttInnholdListe,
        ).onRight { oppdatertPlan ->
            planObservers.forEach {
                it.receive(
                    ObservedPlan(
                        hendelsesType = PlanHendelseType.OPPDATER,
                        plan = oppdatertPlan,
                    ),
                )
            }
        }
    }

    private fun endreInnhold(
        samarbeidId: Int,
        lagretTema: PlanTema,
        nyttInnholdListe: List<EndreUndertemaRequest>,
    ): Either<Feil, Plan> {
        val innholdSomSkalEndres: List<PlanUndertema> =
            lagretTema.undertemaer.map { lagretInnhold ->
                if (nyttInnholdListe.map { it.id }.contains(lagretInnhold.id)) {
                    lagretInnhold.endreInnhold(nyttInnholdListe.first { it.id == lagretInnhold.id })
                } else {
                    lagretInnhold
                }
            }

        innholdSomSkalEndres.forEach { innhold ->
            planRepository.oppdaterUndertema(temaId = lagretTema.id, undertema = innhold)
                ?: return PlanFeil.`fikk ikke oppdatert undertema`.left()
        }
        return hentPlan(samarbeidId = samarbeidId)
    }

    private fun PlanUndertema.endreInnhold(nyttInnhold: EndreUndertemaRequest) =
        this.copy(
            inkludert = nyttInnhold.inkludert,
            status = if (nyttInnhold.inkludert) this.status ?: PLANLAGT else null,
            startDato = if (nyttInnhold.inkludert) nyttInnhold.startDato else null,
            sluttDato = if (nyttInnhold.inkludert) nyttInnhold.sluttDato else null,
        )

    fun endreStatus(
        temaId: Int,
        undertemaId: Int,
        lagretPlan: Plan,
        nyStatus: InnholdStatus,
    ): Either<Feil, Plan> {
        val lagretInnhold = lagretPlan.temaer.firstOrNull { it.id == temaId }?.undertemaer?.firstOrNull { it.id == undertemaId }
            ?: return PlanFeil.`fant ikke undertema`.left()

        if (!lagretInnhold.inkludert) {
            return PlanFeil.`innhold er ikke inkludert`.left()
        }

        if (nyStatus == AVBRUTT && lagretInnhold.starterIFremtiden()) {
            return PlanFeil.`innhold starter i fremtiden`.left()
        }

        val innholdMedNyStatus: PlanUndertema = lagretInnhold.copy(status = nyStatus)

        planRepository.oppdaterUndertema(
            temaId = temaId,
            undertema = innholdMedNyStatus,
        ) ?: return PlanFeil.`fikk ikke oppdatert undertema`.left()

        return hentPlan(samarbeidId = lagretPlan.samarbeidId).onRight { oppdatertPlan ->
            planObservers.forEach {
                it.receive(
                    ObservedPlan(
                        hendelsesType = PlanHendelseType.ENDRE_STATUS,
                        plan = oppdatertPlan,
                    ),
                )
            }
        }
    }

    companion object {
        private fun PlanMalDto.erGyldig(): Boolean =
            tema.all {
                it.innhold.all { innhold ->
                    if (innhold.sluttDato == null || innhold.startDato == null) true else innhold.sluttDato > innhold.startDato
                }
            } &&
                tema.all {
                    if (it.inkludert) {
                        it.innhold.any { innhold ->
                            innhold.sluttDato != null && innhold.startDato != null && innhold.inkludert
                        }
                    } else {
                        it.innhold.all { innhold ->
                            innhold.sluttDato == null && innhold.startDato == null && !innhold.inkludert
                        }
                    }
                }

        private fun List<EndreTemaRequest>.erGyldig(lagretPlan: Plan): Boolean =
            this.all { tema ->
                tema.undertemaer.harGyldigeFelter() &&
                    tema.id in lagretPlan.temaer.map { lagretTema -> lagretTema.id } &&
                    tema.undertemaer.erInnholdITema(lagretPlan.temaer.first { lagretTema -> lagretTema.id == tema.id })
            }

        fun List<EndreUndertemaRequest>.erGyldig(lagretTema: PlanTema) =
            harGyldigeFelter() && erInnholdITema(lagretTema) && lagretTema.inkludert

        private fun List<EndreUndertemaRequest>.erInnholdITema(lagretTeam: PlanTema): Boolean =
            this.all { it.id in lagretTeam.undertemaer.map { innhold -> innhold.id } }

        private fun List<EndreUndertemaRequest>.harGyldigeFelter() =
            this.all { innhold ->
                if (innhold.inkludert) {
                    (innhold.sluttDato != null && innhold.startDato != null) && innhold.sluttDato > innhold.startDato
                } else {
                    innhold.sluttDato == null && innhold.startDato == null
                }
            }
    }
}

object PlanFeil {
    val `innhold starter i fremtiden` = Feil(
        feilmelding = "Kan ikke endre status til 'AVBRUTT' om innholdet ikke har startet enda",
        httpStatusCode = HttpStatusCode.BadRequest,
    )
    val `innhold er ikke inkludert` = Feil(
        feilmelding = "Kan ikke endre status på innhold som ikke er inkludert",
        httpStatusCode = HttpStatusCode.BadRequest,
    )
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
