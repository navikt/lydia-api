package no.nav.lydia.ia.sak.api.ny.flyt

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import arrow.core.raise.either
import arrow.core.raise.ensure
import arrow.core.right
import com.github.guepardoapps.kulid.ULID
import io.ktor.http.HttpStatusCode
import no.nav.lydia.Observer
import no.nav.lydia.ia.sak.IASamarbeidFeil
import no.nav.lydia.ia.sak.IASamarbeidService
import no.nav.lydia.ia.sak.MAKS_ANTALL_TEGN_I_SAMARBEIDSNAVN
import no.nav.lydia.ia.sak.PlanFeil
import no.nav.lydia.ia.sak.PlanService
import no.nav.lydia.ia.sak.PlanService.Companion.erGyldig
import no.nav.lydia.ia.sak.SpørreundersøkelseService
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringDto.Companion.tilDokumentTilPubliseringType
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringService
import no.nav.lydia.ia.sak.api.plan.EndreTemaRequest
import no.nav.lydia.ia.sak.api.plan.EndreUndertemaRequest
import no.nav.lydia.ia.sak.api.plan.PlanDto
import no.nav.lydia.ia.sak.api.plan.tilDto
import no.nav.lydia.ia.sak.api.samarbeid.IASamarbeidDto
import no.nav.lydia.ia.sak.api.samarbeid.tilDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.IASakSpørreundersøkelseError
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.tilDto
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
import no.nav.lydia.ia.sak.db.IASamarbeidRepository
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASak.Status.AKTIV
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.plan.Plan
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.TemaInfo
import no.nav.lydia.ia.team.IATeamService
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.time.LocalDateTime
import java.util.UUID
import javax.sql.DataSource

class NyFlytService(
    val dataSource: DataSource,
    val tilstandVirksomhetRepository: TilstandVirksomhetRepository,
    val iaSakRepository: IASakRepository,
    val iaSakshendelseRepository: IASakshendelseRepository,
    val iaSamarbeidService: IASamarbeidService,
    val iaSamarbeidRepository: IASamarbeidRepository, // TODO: bruk Service i stedet
    val iaTeamService: IATeamService,
    val spørreundersøkelseService: SpørreundersøkelseService,
    val planService: PlanService,
    val iaSakObservers: List<Observer<IASakDto>>,
    val iaSamarbeidObservers: List<Observer<IASamarbeid>>,
    val dokumentPubliseringService: DokumentPubliseringService,
) {
    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun varsleIASakObservers(sakDto: IASakDto) {
        iaSakObservers.forEach { observer -> observer.receive(input = sakDto) }
    }

    fun hentAlleAndreIASakDto(
        orgnummer: String,
        saksnummer: String,
    ): List<IASakDto> =
        iaSakRepository.hentAlleSakerForVirksomhet(orgnummer = orgnummer)
            .sortedByDescending { it.opprettetTidspunkt }
            .filter { it.status.regnesSomAvsluttet() }
            .filterNot { it.saksnummer == saksnummer }

    fun hentSisteIASakDto(orgnummer: String): IASakDto? =
        iaSakRepository.hentAlleSakerForVirksomhet(orgnummer = orgnummer).maxByOrNull { it.opprettetTidspunkt }

    fun hentAlleSisteIASakDtoForFylke(fylkenummer: String): List<IASakDto> {
        val sakerGruppertPåOrgnr: Map<String, List<IASakDto>> = iaSakRepository.hentAlleSakerDtoForFylke(fylkenummer = fylkenummer).groupBy { it.orgnr }
        return sakerGruppertPåOrgnr.map { it.value.maxBy { it.opprettetTidspunkt } }.toList()
    }

    fun hentTilstandVirksomhet(orgnummer: String): VirksomhetTilstandDto? = tilstandVirksomhetRepository.hentVirksomhetTilstand(orgnr = orgnummer)

    fun lagreHendelseOgOppdaterIaSakDto(
        orgnummer: String,
        saksnummer: String,
        hendelsesType: IASakshendelseType,
        saksbehandler: NavAnsattMedSaksbehandlerRolle,
        navEnhet: NavEnhet,
        resulterendeSakStatus: IASak.Status,
        oppdaterSistEndretPåSak: Boolean = true,
    ): Either<Feil, IASakDto> {
        val iASakshendelse = IASakshendelse(
            id = ULID.random(),
            opprettetTidspunkt = LocalDateTime.now(),
            saksnummer = saksnummer,
            hendelsesType = hendelsesType,
            orgnummer = orgnummer,
            opprettetAv = saksbehandler.navIdent,
            opprettetAvRolle = saksbehandler.rolle,
            navEnhet = navEnhet,
            resulterendeStatus = null,
        )
        iaSakshendelseRepository.lagreHendelse(
            hendelse = iASakshendelse,
            sistEndretAvHendelseId = null,
            resulterendeStatus = resulterendeSakStatus,
        )
        return iaSakRepository.oppdaterStatusPåSak(
            saksnummer = saksnummer,
            status = resulterendeSakStatus,
            endretAv = saksbehandler.navIdent,
            endretAvHendelseId = iASakshendelse.id,
            oppdaterSistEndretPåSak = oppdaterSistEndretPåSak,
        ).onRight(::varsleIASakObservers)
    }

    fun slettSamarbeidsplan(
        orgnummer: String,
        saksnummer: String,
        samarbeidId: Int,
        saksbehandler: NavAnsattMedSaksbehandlerRolle,
        navEnhet: NavEnhet,
    ): Either<Feil, Plan> =
        planService.slettPlan(
            samarbeidId = samarbeidId,
        ).onRight {
            val iASakshendelse = IASakshendelse(
                id = ULID.random(),
                opprettetTidspunkt = LocalDateTime.now(),
                saksnummer = saksnummer,
                hendelsesType = IASakshendelseType.SLETT_SAMARBEIDSPLAN,
                orgnummer = orgnummer,
                opprettetAv = saksbehandler.navIdent,
                opprettetAvRolle = saksbehandler.rolle,
                navEnhet = navEnhet,
                resulterendeStatus = null,
            )

            iaSakshendelseRepository.lagreHendelse(
                hendelse = iASakshendelse,
                sistEndretAvHendelseId = null,
                resulterendeStatus = AKTIV,
            )

            iaSakRepository.oppdaterStatusPåSak(
                saksnummer = saksnummer,
                status = AKTIV,
                endretAv = saksbehandler.navIdent,
                endretAvHendelseId = iASakshendelse.id,
            ).onRight(::varsleIASakObservers)
        }

    fun endrePlanlagtDatoForNesteTilstand(
        orgnummer: String,
        saksnummer: String,
        nyPlanlagtDato: java.time.LocalDate,
        saksbehandler: NavAnsattMedSaksbehandlerRolle,
        navEnhet: NavEnhet,
        resulterendeSakStatus: IASak.Status,
    ): Either<Feil, VirksomhetTilstandAutomatiskOppdateringDto> {
        if (!nyPlanlagtDato.isAfter(java.time.LocalDate.now())) {
            return Feil("Planlagt dato må være etter dagens dato", HttpStatusCode.BadRequest).left()
        }

        val automatiskOppdatering = tilstandVirksomhetRepository.endrePlanlagtDatoForNesteTilstand(
            orgnr = orgnummer,
            nyPlanlagtDato = nyPlanlagtDato,
        ) ?: return Feil(
            "Fant ingen planlagt tilstandsoppdatering for virksomhet $orgnummer",
            HttpStatusCode.NotFound,
        ).left()

        lagreHendelseOgOppdaterIaSakDto(
            orgnummer = orgnummer,
            saksnummer = saksnummer,
            hendelsesType = IASakshendelseType.ENDRE_PLANLAGT_DATO,
            saksbehandler = saksbehandler,
            navEnhet = navEnhet,
            resulterendeSakStatus = resulterendeSakStatus,
            oppdaterSistEndretPåSak = false,
        )

        return automatiskOppdatering.right()
    }

    fun bliEier(
        orgnr: String,
        navAnsatt: NavAnsattMedSaksbehandlerRolle,
    ): Either<Feil, IASakDto> {
        val aktivSak = hentSisteIASakDto(orgnummer = orgnr)
        if (aktivSak == null || aktivSak.status.regnesSomAvsluttet()) {
            return IASakError.`kan ikke ta eierskap da det ikke finnes noen aktiv sak`.left()
        }
        if (aktivSak.eidAv == navAnsatt.navIdent) {
            return aktivSak.right()
        }
        return iaSakRepository.oppdaterEierPåSak(aktivSak.saksnummer, navAnsatt.navIdent)?.right() ?: IASakError.`fikk ikke oppdatert sak`.left()
    }

    fun hentSamarbeidSomIkkeErSlettet(saksnummer: String): Either<Feil, List<IASamarbeid>> =
        Either.catch {
            iaSamarbeidRepository.hentSamarbeidSomIkkeErSlettet(saksnummer = saksnummer)
        }.mapLeft {
            IASamarbeidFeil.`feil ved henting av samarbeid`
        }

    fun hentAlleVirksomhetTilstanderMedPlanlagtDatoFørEllerIDag(): List<VirksomhetTilstandDto> =
        tilstandVirksomhetRepository.hentAlleVirksomhetTilstanderMedPlanlagtDatoFørEllerIDag()

    fun slettVirksomhetTilstandAutomatiskOppdatering(orgnr: String) = tilstandVirksomhetRepository.slettVirksomhetTilstandAutomatiskOppdatering(orgnr = orgnr)

    // Valideringer
    fun validerSlettingAvSamarbeid(
        saksnummer: String,
        samarbeidId: Int,
        saksbehandler: NavAnsattMedSaksbehandlerRolle,
    ): Either<Feil, Unit> =
        either {
            val eier = iaSakRepository.hentIASakDto(saksnummer)?.eidAv
            val erFølgerAvSak = iaTeamService.erEierEllerFølgerAvSak(
                saksnummer = saksnummer,
                saksbehandler = saksbehandler,
                eierAvSak = eier,
            )
            ensure(erFølgerAvSak) { IASakError.`er ikke følger av sak` }
            val kanSlettes = iaSamarbeidService.kanSletteSamarbeid(
                saksnummer = saksnummer,
                samarbeidId = samarbeidId,
            )
            ensure(kanSlettes.kanGjennomføres) {
                IASamarbeidFeil.`kan ikke slette samarbeid som inneholder behovsvurdering eller samarbeidsplan`
            }
        }

    fun validerEndringAvSamarbeid(
        navn: String,
        saksnummer: String,
        saksbehandler: NavAnsattMedSaksbehandlerRolle,
    ): Either<Feil, Unit> =
        either {
            val eier = iaSakRepository.hentIASakDto(saksnummer)?.eidAv
            val erFølgerAvSak = iaTeamService.erEierEllerFølgerAvSak(
                saksnummer = saksnummer,
                saksbehandler = saksbehandler,
                eierAvSak = eier,
            )
            ensure(erFølgerAvSak) { IASakError.`er ikke følger av sak` }
            val ugyldigNavn = navn.trim().isEmpty() || navn.length > MAKS_ANTALL_TEGN_I_SAMARBEIDSNAVN
            ensure(!ugyldigNavn) { IASamarbeidFeil.`ugyldig samarbeidsnavn` }
            val navnFinnesAllerede = hentSamarbeidSomIkkeErSlettet(saksnummer = saksnummer).map { alleSamarbeid ->
                alleSamarbeid.any { it.navn.equals(navn, ignoreCase = true) }
            }.getOrNull() ?: false
            ensure(!navnFinnesAllerede) { IASamarbeidFeil.`samarbeidsnavn finnes allerede` }
        }

    fun validerAvslutningAvSamarbeid(
        saksnummer: String,
        samarbeidId: Int,
        typeAvslutning: IASamarbeid.Status, // Burde ha sin egen type
    ): Either<Feil, Pair<IASamarbeidDto, Plan?>> =
        either {
            ensure(typeAvslutning == IASamarbeid.Status.AVBRUTT || typeAvslutning == IASamarbeid.Status.FULLFØRT) {
                Feil(
                    "feil ved avslutning",
                    HttpStatusCode.BadRequest,
                )
            }

            val samarbeid = iaSamarbeidService.hentSamarbeid(saksnummer = saksnummer, samarbeidId = samarbeidId).bind().tilDto()
            if (typeAvslutning == IASamarbeid.Status.AVBRUTT) {
                val kanAvbryteSamarbeid = iaSamarbeidService.kanAvbryteSamarbeid(saksnummer = saksnummer, samarbeidId = samarbeidId).kanGjennomføres
                ensure(kanAvbryteSamarbeid) { IASamarbeidFeil.`kan ikke avbryte samarbeid` }
                Pair(samarbeid, null)
            } else {
                val kamFullføreSamarbeid = iaSamarbeidService.kanFullføreSamarbeid(saksnummer = saksnummer, samarbeidId = samarbeidId).kanGjennomføres
                ensure(kamFullføreSamarbeid) { IASamarbeidFeil.`kan ikke fullføre samarbeid` }
                val plan = planService.hentPlan(samarbeidId = samarbeidId).bind()
                Pair(samarbeid, plan)
            }
        }

    fun validerOpprettelseAvKartlegging(
        saksnummer: String,
        samarbeidId: Int,
        type: Spørreundersøkelse.Type,
    ): Either<Feil, List<TemaInfo>> =
        either {
            iaSamarbeidService.hentSamarbeid(saksnummer = saksnummer, samarbeidId = samarbeidId).bind()

            when (type) {
                Spørreundersøkelse.Type.Behovsvurdering -> {
                    spørreundersøkelseService.hentAktiveTemaer(type)
                }

                Spørreundersøkelse.Type.Evaluering -> {
                    val sakStatus = iaSakRepository.hentStatusForSaksnummer(saksnummer)
                    ensure(sakStatus == IASak.Status.VI_BISTÅR || sakStatus == AKTIV) {
                        IASakSpørreundersøkelseError.`sak ikke i rett status`
                    }
                    val plan = planService.hentPlan(samarbeidId = samarbeidId).bind()
                    val temaerInkludertIPlan = plan.temaer.filter { planTema -> planTema.inkludert }
                    ensure(temaerInkludertIPlan.isNotEmpty()) {
                        Feil(
                            feilmelding = "Kan ikke opprette en evaluering basert på en tom plan",
                            httpStatusCode = HttpStatusCode.BadRequest,
                        )
                    }
                    val temaNavnInkludertIPlan = temaerInkludertIPlan.map { planTema -> planTema.navn }
                    val aktiveTemaer = spørreundersøkelseService.hentAktiveTemaer(type)
                    val temaerSomSkalEvalueres = aktiveTemaer.filter { tema -> temaNavnInkludertIPlan.contains(tema.navn) }
                    val undertemaNavnInkludertIPlan = temaerInkludertIPlan
                        .flatMap { planTema -> planTema.undertemaer }
                        .filter { undertema -> undertema.inkludert }
                        .map { undertema -> undertema.navn }
                    temaerSomSkalEvalueres.map { tema ->
                        tema.copy(
                            undertemaer = tema.undertemaer.filter { u -> undertemaNavnInkludertIPlan.contains(u.navn) } +
                                spørreundersøkelseService.hentObligatoriskeAktiveUndertemaer(tema.id),
                        )
                    }
                }
            }
        }

    fun validerSlettingAvKartlegging(
        saksnummer: String,
        spørreundersøkelseId: UUID,
    ): Either<Feil, SpørreundersøkelseDto> =
        either {
            val spørreundersøkelse = spørreundersøkelseService.hentSpørreundersøkelse(spørreundersøkelseId).bind()
            ensure(spørreundersøkelse.id == spørreundersøkelseId) {
                Feil(
                    "Fant ikke spørreundersøkelse med id '$spørreundersøkelseId'",
                    HttpStatusCode.BadRequest,
                )
            }
            ensure(spørreundersøkelse.saksnummer == saksnummer) {
                Feil(
                    "Spørreundersøkelse med id '$spørreundersøkelseId' matcher ikke saksnummer '$saksnummer'",
                    HttpStatusCode.BadRequest,
                )
            }

            ensure(spørreundersøkelse.status != Spørreundersøkelse.Status.SLETTET) {
                IASakSpørreundersøkelseError.`allerede slettet`
            }

            val erPublisertEllerUnderPublisering = spørreundersøkelseService.erPublisertEllerUnderPublisering(spørreundersøkelse)
            ensure(!erPublisertEllerUnderPublisering) {
                IASakSpørreundersøkelseError.`publisert, kan ikke slettes`
            }

            val erAvsluttetOgHarMinstEttResultat = spørreundersøkelse.status == Spørreundersøkelse.Status.AVSLUTTET && spørreundersøkelse.harMinstEttResultat()
            ensure(!erAvsluttetOgHarMinstEttResultat) {
                IASakSpørreundersøkelseError.`kan ikke slettes`
            }
            spørreundersøkelse.let {
                it.tilDto(
                    dokumentPubliseringService.hentPubliseringStatus(
                        referanseId = it.id,
                        type = it.type.name.tilDokumentTilPubliseringType(),
                    ),
                )
            }
        }

    fun validerStartAvKartlegging(spørreundersøkelseId: UUID): Either<Feil, Spørreundersøkelse> =
        spørreundersøkelseService.hentSpørreundersøkelse(spørreundersøkelseId)
            .flatMap { eksisterende ->
                if (eksisterende.status != Spørreundersøkelse.Status.OPPRETTET) {
                    IASakSpørreundersøkelseError.`feil status kan ikke starte`.left()
                } else {
                    eksisterende.right()
                }
            }

    fun validerFullføringAvKartlegging(spørreundersøkelseId: UUID): Either<Feil, Spørreundersøkelse> =
        spørreundersøkelseService.hentSpørreundersøkelse(spørreundersøkelseId)
            .flatMap { eksisterende ->
                if (eksisterende.status != Spørreundersøkelse.Status.PÅBEGYNT) {
                    IASakSpørreundersøkelseError.`ikke påbegynt`.left()
                } else {
                    eksisterende.right()
                }
            }

    fun validerOpprettelseAvSamarbeidsplan(
        samarbeidId: Int,
        mal: PlanMalDto,
    ): Either<Feil, PlanMalDto> =
        either {
            ensure(condition = planService.hentPlan(samarbeidId = samarbeidId).isLeft()) {
                Feil(
                    feilmelding = "Plan eksisterer allerede for dette samarbeidet: '$samarbeidId'",
                    httpStatusCode = HttpStatusCode.BadRequest,
                )
            }
            ensure(condition = mal.erGyldig()) {
                PlanFeil.`feil inndata i forespørsel`
            }
            mal
        }

    fun validerOppdateringAvSamarbeidsplan(
        samarbeidId: Int,
        planId: UUID,
        endringAvPlan: List<EndreTemaRequest>,
    ): Either<Feil, PlanDto> =
        either {
            val plan: Plan = planService.hentPlan(samarbeidId = samarbeidId)
                .mapLeft {
                    Feil(
                        feilmelding = "Ingen plan funnet for dette samarbeidet: '$samarbeidId'",
                        httpStatusCode = HttpStatusCode.BadRequest,
                    )
                }
                .bind()

            val planDto = plan.tilDto()
            ensure(condition = planId.toString() == planDto.id) {
                Feil(
                    feilmelding = "Ønsket endring på plan med id '$planId' som ikke er riktig plan " +
                        "for samarbeidet: '$samarbeidId' (funnet plan med id='${planDto.id}')",
                    httpStatusCode = HttpStatusCode.BadRequest,
                )
            }

            ensure(condition = endringAvPlan.erGyldig(lagretPlan = plan)) {
                Feil(
                    feilmelding = "Ønsket endring på plan med id '$planId' er ikke gyldig " +
                        "for samarbeidet: '$samarbeidId'",
                    httpStatusCode = HttpStatusCode.BadRequest,
                )
            }

            val erAlleUndertemaerSomErForsøktFjernetUtenAktiviteterISalesforce = endringAvPlan.all { endring ->
                val harAktiviteterFraSalesforce = planService.harAktiviteterFraSalesforce(
                    lagretPlan = plan,
                    endringAvPlan = endring.undertemaer,
                )
                !harAktiviteterFraSalesforce
            }

            ensure(condition = erAlleUndertemaerSomErForsøktFjernetUtenAktiviteterISalesforce) {
                PlanFeil.`aktiviteter i salesforce`
            }
            planDto
        }

    fun validerOppdateringAvTemaISamarbeidsplan(
        samarbeidId: Int,
        planId: UUID,
        temaId: Int,
        endringAvUndertema: List<EndreUndertemaRequest>,
    ): Either<Feil, PlanDto> =
        either {
            val plan: Plan = planService.hentPlan(samarbeidId = samarbeidId)
                .mapLeft {
                    Feil(
                        feilmelding = "Ingen plan funnet for dette samarbeidet: '$samarbeidId'",
                        httpStatusCode = HttpStatusCode.BadRequest,
                    )
                }
                .bind()

            val lagretTema = plan.temaer.firstOrNull { it.id == temaId }
                ?: return PlanFeil.`fant ikke tema`.left()

            val planDto = plan.tilDto()
            ensure(condition = planId.toString() == planDto.id) {
                Feil(
                    feilmelding = "Ønsket endring på plan med id '$planId' som ikke er riktig plan " +
                        "for samarbeidet: '$samarbeidId' (funnet plan med id='${planDto.id}')",
                    httpStatusCode = HttpStatusCode.BadRequest,
                )
            }

            ensure(condition = endringAvUndertema.erGyldig(lagretTema = lagretTema)) {
                Feil(
                    feilmelding = "Ønsket endring på tema med temaId '$temaId' i plan med id '$planId' er ikke gyldig " +
                        "for samarbeidet: '$samarbeidId'",
                    httpStatusCode = HttpStatusCode.BadRequest,
                )
            }

            val harAktiviteterFraSalesforce = planService.harAktiviteterFraSalesforce(
                lagretPlan = plan,
                endringAvPlan = endringAvUndertema,
            )

            ensure(condition = !harAktiviteterFraSalesforce) {
                PlanFeil.`aktiviteter i salesforce`
            }
            planDto
        }

    fun validerEndringAvStatusPåUndertema(
        samarbeidId: Int,
        planId: UUID,
        temaId: Int,
        undertemaId: Int,
        nyStatus: PlanUndertema.Status,
    ): Either<Feil, Plan> =
        either {
            val plan: Plan = planService.hentPlan(samarbeidId = samarbeidId)
                .mapLeft {
                    Feil(
                        feilmelding = "Ingen plan funnet for dette samarbeidet: '$samarbeidId'",
                        httpStatusCode = HttpStatusCode.BadRequest,
                    )
                }
                .bind()

            ensure(condition = planId.toString() == plan.id.toString()) {
                Feil(
                    feilmelding = "Ønsket endring på plan med id '$planId' som ikke er riktig plan " +
                        "for samarbeidet: '$samarbeidId' (funnet plan med id='${plan.id}')",
                    httpStatusCode = HttpStatusCode.BadRequest,
                )
            }

            val undertema = plan.temaer.firstOrNull { it.id == temaId }
                ?.undertemaer?.firstOrNull { it.id == undertemaId }
                ?: raise(PlanFeil.`fant ikke undertema`)

            ensure(undertema.inkludert) {
                PlanFeil.`innhold er ikke inkludert`
            }

            ensure(!(nyStatus == PlanUndertema.Status.AVBRUTT && undertema.starterIFremtiden())) {
                PlanFeil.`innhold starter i fremtiden`
            }

            plan
        }
}
