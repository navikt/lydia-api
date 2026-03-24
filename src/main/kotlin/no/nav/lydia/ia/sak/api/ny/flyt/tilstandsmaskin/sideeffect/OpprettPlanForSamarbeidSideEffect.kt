package no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.sideeffect

import arrow.core.Either
import com.github.guepardoapps.kulid.ULID
import no.nav.lydia.appstatus.PlanHendelseType
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.ny.flyt.NyFlytService
import no.nav.lydia.ia.sak.api.ny.flyt.Transaction
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetIATilstand
import no.nav.lydia.ia.sak.api.ny.flyt.hentSisteIASakDto
import no.nav.lydia.ia.sak.api.ny.flyt.lagreEllerOppdaterVirksomhetTilstand
import no.nav.lydia.ia.sak.api.ny.flyt.lagreHendelse
import no.nav.lydia.ia.sak.api.ny.flyt.oppdaterStatusPåSak
import no.nav.lydia.ia.sak.api.ny.flyt.opprettSamarbeidsplan
import no.nav.lydia.ia.sak.api.plan.PlanMedPubliseringStatusDto
import no.nav.lydia.ia.sak.api.plan.tilDtoMedPubliseringStatus
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.plan.Plan
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle
import java.time.LocalDateTime
import java.util.UUID

class OpprettPlanForSamarbeidSideEffect(
    val orgnummer: String,
    val saksnummer: String,
    val samarbeidId: Int,
    val plan: PlanMalDto,
    val saksbehandler: NavAnsattMedSaksbehandlerRolle,
    val navEnhet: NavEnhet,
) : SideEffect<PlanMedPubliseringStatusDto>() {
    context(nyFlytService: NyFlytService)
    override fun apply(): Either<Feil, PlanMedPubliseringStatusDto> {
        val nyPlanId = UUID.randomUUID()

        return nyFlytService.validerOpprettelseAvSamarbeidsplan(
            samarbeidId = samarbeidId,
            mal = plan,
        ).map { planMalDto ->
            Transaction(nyFlytService.dataSource).transactional { tx ->
                with(receiver = tx) {
                    val sakDto = hentSisteIASakDto(orgnummer = orgnummer)!!

                    val opprettetSamarbeidsplan: Plan = opprettSamarbeidsplan(
                        planId = nyPlanId,
                        samarbeidId = samarbeidId,
                        saksbehandler = saksbehandler,
                        mal = planMalDto,
                    ) ?: error("Kunne ikke opprette samarbeidsplan for samarbeid $samarbeidId i sak $saksnummer")

                    val planMedPubliseringStatusDto: PlanMedPubliseringStatusDto =
                        opprettetSamarbeidsplan.tilDtoMedPubliseringStatus()

                    val opprettPlanHendelse = lagreHendelse(
                        hendelse = IASakshendelse(
                            id = ULID.random(),
                            opprettetTidspunkt = LocalDateTime.now(),
                            saksnummer = saksnummer,
                            hendelsesType = IASakshendelseType.OPPRETT_SAMARBEIDSPLAN,
                            orgnummer = orgnummer,
                            opprettetAv = saksbehandler.navIdent,
                            opprettetAvRolle = saksbehandler.rolle,
                            navEnhet = navEnhet,
                            resulterendeStatus = null,
                        ),
                        sistEndretAvHendelseId = null,
                        resulterendeStatus = sakDto.status,
                    )
                    val oppdatertSakDto = oppdaterStatusPåSak(
                        saksnummer = saksnummer,
                        status = sakDto.status,
                        endretAvHendelseId = opprettPlanHendelse.id,
                        endretAv = saksbehandler.navIdent,
                        oppdaterSistEndretPåSak = false,
                    )
                    lagreEllerOppdaterVirksomhetTilstand(
                        orgnr = orgnummer,
                        tilstand = VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid,
                    )
                    Triple(opprettetSamarbeidsplan, planMedPubliseringStatusDto, oppdatertSakDto)
                }
            }.also { planOgIASak: Triple<Plan, PlanMedPubliseringStatusDto, IASakDto> ->
                nyFlytService.varsleIASakObservers(sakDto = planOgIASak.third)
                nyFlytService.planService.varslePlanObservers(planOgIASak.first, PlanHendelseType.OPPRETT)
            }.second
        }
    }
}
