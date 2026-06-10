package no.nav.lydia.samarbeidsplan

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import no.nav.lydia.Observer
import no.nav.lydia.appstatus.ObservedPlan
import no.nav.lydia.appstatus.PlanHendelseType
import no.nav.lydia.felles.Feil

class PlanService(
    val planObservers: List<Observer<ObservedPlan>>,
    val planRepository: PlanRepository,
) {
    fun hentPlan(samarbeidId: Int): Either<Feil, Plan> = planRepository.hentPlan(samarbeidId = samarbeidId)?.right() ?: PlanFeil.`fant ikke plan`.left()

    fun varslePlanObservers(
        plan: Plan,
        type: PlanHendelseType,
    ) {
        planObservers.forEach {
            it.receive(
                input =
                    ObservedPlan(hendelsesType = type, plan = plan),
            )
        }
    }

    fun harAktiviteterFraSalesforce(
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

    companion object {
        fun PlanMalDto.erGyldig(): Boolean =
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

        fun List<EndreTemaRequest>.erGyldig(lagretPlan: Plan): Boolean =
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
    val `aktiviteter i salesforce` = Feil(
        feilmelding = "Det finnes aktiviteter registrert på dette undertemaet i Salesforce.",
        httpStatusCode = HttpStatusCode.Conflict,
    )
}
