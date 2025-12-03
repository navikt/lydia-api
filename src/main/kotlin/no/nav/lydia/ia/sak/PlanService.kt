package no.nav.lydia.ia.sak

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import no.nav.lydia.Observer
import no.nav.lydia.appstatus.ObservedPlan
import no.nav.lydia.appstatus.PlanHendelseType
import no.nav.lydia.appstatus.PlanHendelseType.ENDRE_STATUS
import no.nav.lydia.appstatus.PlanHendelseType.OPPRETT
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
    val samarbeidService: IASamarbeidService,
    val planObservers: List<Observer<ObservedPlan>>,
    val planRepository: PlanRepository,
) {
    private val logger: Logger = LoggerFactory.getLogger(this::class.java)

    fun hentPlan(samarbeidId: Int): Either<Feil, Plan> = planRepository.hentPlan(samarbeidId = samarbeidId)?.right() ?: PlanFeil.`fant ikke plan`.left()

    fun opprettPlan(
        iaSak: IASak,
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
        prosessId: Int,
        mal: PlanMalDto,
    ): Either<Feil, Plan> =
        samarbeidService.hentSamarbeid(iaSak, prosessId).flatMap { samarbeid ->
            opprettPlan(
                samarbeidId = samarbeid.id,
                saksbehandler = saksbehandler,
                mal = mal,
            )
        }

    fun opprettPlan(
        samarbeidId: Int,
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
        mal: PlanMalDto,
    ): Either<Feil, Plan> {
        val planEksistererAllerede = hentPlan(samarbeidId = samarbeidId).isRight()

        if (planEksistererAllerede) {
            return Feil(
                feilmelding = "Plan eksisterer allerede for dette samarbeidet: '$samarbeidId'",
                httpStatusCode = HttpStatusCode.BadRequest,
            ).left()
        }

        if (!mal.erGyldig()) {
            logger.warn("Feil inndata i forespørsel. Mal er ikke gyldig.")
            return PlanFeil.`feil inndata i forespørsel`.left()
        }

        val plan = planRepository.opprettPlan(
            planId = UUID.randomUUID(),
            prosessId = samarbeidId,
            saksbehandler = saksbehandler,
            mal = mal,
        ).onRight { plan ->
            planObservers.forEach { it.receive(ObservedPlan(hendelsesType = OPPRETT, plan = plan)) }
            logger.info("Opprettet plan med Id '${plan.id}'")
        }
        return plan
    }

    fun endreFlereTemaer(
        lagretPlan: Plan,
        endringAvPlan: List<EndreTemaRequest>,
    ): Either<Feil, Plan> {
        // valider endring
        if (!endringAvPlan.erGyldig(lagretPlan)) {
            logger.warn("Endring av plan med id '${lagretPlan.id}' er ikke gyldig")
            return PlanFeil.`feil inndata i forespørsel`.left()
        }

        if (harAktiviteterFraSalesforce(lagretPlan, endringAvPlan.flatMap { it.undertemaer })) {
            logger.warn("Endring av plan med id '${lagretPlan.id}' kan ikke gjennomføres, da det finner aktiviteter i SF")
            return PlanFeil.`aktiviteter i salesforce`.left()
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

    private fun harAktiviteterFraSalesforce(
        lagretPlan: Plan,
        endringAvPlan: List<EndreUndertemaRequest>,
    ): Boolean {
        val undertemaerMedAktiviteterOgInkludert = lagretPlan.temaer.flatMap {
            it.undertemaer
        }.filter { it.inkludert }.filter {
            planRepository.hentAktiviterISalesforce(
                lagretPlan.id.toString(),
                it.id,
            ).isNotEmpty()
        }.map { it.id }
        return endringAvPlan
            .any {
                !it.inkludert && undertemaerMedAktiviteterOgInkludert.contains(it.id)
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

        if (harAktiviteterFraSalesforce(lagretPlan, nyttInnholdListe)) {
            logger.warn("Endring av plan med id '${lagretPlan.id}' kan ikke gjennomføres, da det finnes aktiviteter i SF")
            return PlanFeil.`aktiviteter i salesforce`.left()
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
            status = if (nyttInnhold.inkludert) this.status ?: PlanUndertema.Status.PLANLAGT else null,
            startDato = if (nyttInnhold.inkludert) nyttInnhold.startDato else null,
            sluttDato = if (nyttInnhold.inkludert) nyttInnhold.sluttDato else null,
        )

    fun endreStatus(
        temaId: Int,
        undertemaId: Int,
        lagretPlan: Plan,
        nyStatus: PlanUndertema.Status,
    ): Either<Feil, Plan> {
        val lagretInnhold = lagretPlan.temaer.firstOrNull { it.id == temaId }?.undertemaer?.firstOrNull { it.id == undertemaId }
            ?: return PlanFeil.`fant ikke undertema`.left()

        if (!lagretInnhold.inkludert) {
            return PlanFeil.`innhold er ikke inkludert`.left()
        }

        if (nyStatus == PlanUndertema.Status.AVBRUTT && lagretInnhold.starterIFremtiden()) {
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
                        hendelsesType = ENDRE_STATUS,
                        plan = oppdatertPlan,
                    ),
                )
            }
        }
    }

    fun slettPlan(samarbeidId: Int): Either<Feil, Plan> {
        // hent plan og valider
        val plan = planRepository.hentPlan(samarbeidId) ?: return PlanFeil.`fant ikke plan`.left()

        val finnesSalesforceAktivitet = plan.temaer.any { tema ->
            tema.undertemaer.any { undertema -> undertema.aktiviteterISalesforce.isNotEmpty() }
        }
        if (finnesSalesforceAktivitet) {
            return PlanFeil.`aktiviteter i salesforce`.left()
        }

        // oppdater status og notify observers
        return planRepository.settPlanTilSlettet(plan).onRight { oppdatertPlan ->
            planObservers.forEach {
                it.receive(
                    ObservedPlan(
                        plan = oppdatertPlan,
                        ENDRE_STATUS,
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

        fun List<EndreUndertemaRequest>.erGyldig(lagretTema: PlanTema) = harGyldigeFelter() && erInnholdITema(lagretTema) && lagretTema.inkludert

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
        httpStatusCode = HttpStatusCode.NotFound,
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
    val `aktiviteter i salesforce` = Feil(
        feilmelding = "Det finnes aktiviteter registrert på dette undertemaet i Salesforce.",
        httpStatusCode = HttpStatusCode.Conflict,
    )
}
