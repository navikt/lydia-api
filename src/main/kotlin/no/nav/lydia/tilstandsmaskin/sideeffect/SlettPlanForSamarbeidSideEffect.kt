package no.nav.lydia.tilstandsmaskin.sideeffect

import arrow.core.Either
import com.github.guepardoapps.kulid.ULID
import no.nav.lydia.appstatus.PlanHendelseType
import no.nav.lydia.felles.Feil
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.samarbeidsperiode.IASak.Status.AKTIV
import no.nav.lydia.samarbeidsperiode.IASakshendelse
import no.nav.lydia.samarbeidsperiode.IASakshendelseType
import no.nav.lydia.samarbeidsplan.Plan
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle
import no.nav.lydia.tilstandsmaskin.NyFlytService
import no.nav.lydia.tilstandsmaskin.Transaction
import no.nav.lydia.tilstandsmaskin.VirksomhetIATilstand
import no.nav.lydia.tilstandsmaskin.lagreEllerOppdaterVirksomhetTilstand
import no.nav.lydia.tilstandsmaskin.lagreHendelse
import no.nav.lydia.tilstandsmaskin.oppdaterStatusPåSak
import no.nav.lydia.tilstandsmaskin.settPlanTilSlettet
import java.time.LocalDateTime

class SlettPlanForSamarbeidSideEffect(
    val orgnummer: String,
    val saksnummer: String,
    val samarbeidId: Int,
    val saksbehandler: NavAnsattMedSaksbehandlerRolle,
    val navEnhet: NavEnhet,
) : SideEffect<Plan>() {
    context(nyFlytService: NyFlytService)
    override fun apply(): Either<Feil, Plan> =
        nyFlytService.validerSlettingAvSamarbeidsplan(
            samarbeidId = samarbeidId,
        ).map { plan ->
            Transaction(nyFlytService.dataSource).transactional { tx ->
                with(receiver = tx) {
                    val slettetPlan = settPlanTilSlettet(planId = plan.id)

                    val slettPlanHendelse = lagreHendelse(
                        hendelse = IASakshendelse(
                            id = ULID.random(),
                            opprettetTidspunkt = LocalDateTime.now(),
                            saksnummer = saksnummer,
                            hendelsesType = IASakshendelseType.SLETT_SAMARBEIDSPLAN,
                            orgnummer = orgnummer,
                            opprettetAv = saksbehandler.navIdent,
                            opprettetAvRolle = saksbehandler.rolle,
                            navEnhet = navEnhet,
                            resulterendeStatus = null,
                        ),
                        sistEndretAvHendelseId = null,
                        resulterendeStatus = AKTIV,
                    )

                    val iaSakDto = oppdaterStatusPåSak(
                        saksnummer = saksnummer,
                        status = AKTIV,
                        endretAvHendelseId = slettPlanHendelse.id,
                        endretAv = saksbehandler.navIdent,
                    )

                    lagreEllerOppdaterVirksomhetTilstand(
                        orgnr = orgnummer,
                        tilstand = VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid,
                    )

                    Pair(slettetPlan, iaSakDto)
                }
            }.also { (slettetPlan, iaSakDto) ->
                nyFlytService.varsleIASakObservers(iaSakDto)
                nyFlytService.planService.varslePlanObservers(slettetPlan, PlanHendelseType.ENDRE_STATUS)
            }.first
        }
}
