package no.nav.lydia.ia.sak.api.ny.flyt

import arrow.core.Either
import com.github.guepardoapps.kulid.ULID
import kotlinx.datetime.toKotlinLocalDateTime
import no.nav.lydia.Observer
import no.nav.lydia.ia.sak.IASamarbeidFeil
import no.nav.lydia.ia.sak.MAKS_ANTALL_TEGN_I_SAMARBEIDSNAVN
import no.nav.lydia.ia.sak.PlanService
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.plan.PlanMedPubliseringStatusDto
import no.nav.lydia.ia.sak.api.plan.tilDtoMedPubliseringStatus
import no.nav.lydia.ia.sak.api.samarbeid.IASamarbeidDto
import no.nav.lydia.ia.sak.api.samarbeid.tilDto
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
import no.nav.lydia.ia.sak.db.IASamarbeidRepository
import no.nav.lydia.ia.sak.domene.IASak.Status.AKTIV
import no.nav.lydia.ia.sak.domene.IASak.Status.NY
import no.nav.lydia.ia.sak.domene.IASak.Status.SLETTET
import no.nav.lydia.ia.sak.domene.IASak.Status.VURDERES
import no.nav.lydia.ia.sak.domene.IASak.Status.VURDERT
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VURDERING_FULLFØRT_UTEN_SAMARBEID
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.ia.team.IATeamService
import no.nav.lydia.ia.årsak.db.ÅrsakRepository
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker
import java.time.LocalDateTime

class NyFlytService(
    val iaSakRepository: IASakRepository,
    val iaSakshendelseRepository: IASakshendelseRepository,
    val årsakRepository: ÅrsakRepository,
    val iaSamarbeidRepository: IASamarbeidRepository,
    val iaTeamService: IATeamService,
    val planService: PlanService,
    val iaSakObservers: List<Observer<IASakDto>>,
    val iaSamarbeidObservers: List<Observer<IASamarbeid>>,
) {
    private fun varsleIASakObservers(sakDto: IASakDto) {
        iaSakObservers.forEach { observer -> observer.receive(input = sakDto) }
    }

    private fun IASakDto.nyHendelseBasertPåSak(
        hendelsestype: IASakshendelseType,
        superbruker: Superbruker,
        navEnhet: NavEnhet,
    ) = IASakshendelse(
        id = ULID.random(),
        opprettetTidspunkt = LocalDateTime.now(),
        saksnummer = this.saksnummer,
        hendelsesType = hendelsestype,
        orgnummer = this.orgnr,
        opprettetAv = superbruker.navIdent,
        opprettetAvRolle = superbruker.rolle,
        navEnhet = navEnhet,
        resulterendeStatus = null,
    )

    private fun fraFørsteHendelse(hendelse: IASakshendelse): IASakDto =
        IASakDto(
            saksnummer = hendelse.saksnummer,
            orgnr = hendelse.orgnummer,
            opprettetTidspunkt = hendelse.opprettetTidspunkt.toKotlinLocalDateTime(),
            opprettetAv = hendelse.opprettetAv,
            eidAv = null,
            endretTidspunkt = null,
            endretAv = null,
            endretAvHendelseId = hendelse.id,
            status = NY,
            gyldigeNesteHendelser = emptyList(),
            lukket = false,
        )

    fun opprettSakOgMerkSomVurdert(
        orgnummer: String,
        superbruker: Superbruker,
        navEnhet: NavEnhet,
    ): Either<Feil, IASakDto> {
        if (!iaSakRepository.hentSaker(orgnummer).all { it.status.regnesSomAvsluttet() }) {
            return Either.Left(IASakError.`det finnes flere saker på dette orgnummeret som ikke regnes som avsluttet`)
        }

        // Steg #1 lagre i DB en ny hendelse OPPRETT_SAK_FOR_VIRKSOMHET, og en ny SakDto med status NY
        val iaSakHendelseOpprettSak = IASakshendelse.nyFørsteHendelse(
            orgnummer = orgnummer,
            superbruker = superbruker,
            navEnhet = navEnhet,
        )
        iaSakshendelseRepository.lagreHendelse(
            hendelse = iaSakHendelseOpprettSak,
            sistEndretAvHendelseId = null,
            resulterendeStatus = NY,
        )
        val iaSakDto: IASakDto = iaSakRepository.opprettSak(
            iaSakDto = fraFørsteHendelse(iaSakHendelseOpprettSak),
        ).also(::varsleIASakObservers)

        // Steg #2 lagre i DB en ny hendelse VIRKSOMHET_VURDERES, og oppdater SakDto med status VURDERES
        val iaSakshendelseVurderes = iaSakshendelseRepository.lagreHendelse(
            hendelse = iaSakDto.nyHendelseBasertPåSak(
                hendelsestype = IASakshendelseType.VIRKSOMHET_VURDERES,
                superbruker = superbruker,
                navEnhet = navEnhet,
            ),
            sistEndretAvHendelseId = null,
            resulterendeStatus = VURDERES,
        )
        val oppdatertIaSakDto = iaSakRepository.oppdaterStatusPåSak(
            saksnummer = iaSakDto.saksnummer,
            status = VURDERES,
            endretAv = superbruker.navIdent,
            endretAvHendelseId = iaSakshendelseVurderes.id,
        ).onRight(::varsleIASakObservers)

        return oppdatertIaSakDto
    }

    fun fullførVurderingAvVirksomhetUtenSamarbeid(
        orgnummer: String,
        saksnummer: String,
        årsak: ValgtÅrsak,
        saksbehandler: NavAnsattMedSaksbehandlerRolle,
        navEnhet: NavEnhet,
    ): Either<Feil, Any?> {
        val iASakshendelse = IASakshendelse(
            id = ULID.random(),
            opprettetTidspunkt = LocalDateTime.now(),
            saksnummer = saksnummer,
            hendelsesType = VURDERING_FULLFØRT_UTEN_SAMARBEID,
            orgnummer = orgnummer,
            opprettetAv = saksbehandler.navIdent,
            opprettetAvRolle = saksbehandler.rolle,
            navEnhet = navEnhet,
            resulterendeStatus = null,
        )
        iaSakshendelseRepository.lagreHendelse(
            hendelse = iASakshendelse,
            sistEndretAvHendelseId = null,
            resulterendeStatus = VURDERT,
        )

        årsakRepository.lagreÅrsakForHendelse(
            hendelseId = iASakshendelse.id,
            valgtÅrsak = årsak,
        )
        val oppdatertSak = iaSakRepository.oppdaterStatusPåSak(
            saksnummer = saksnummer,
            status = VURDERT,
            endretAvHendelseId = iASakshendelse.id,
            endretAv = saksbehandler.navIdent,
        ).onRight(::varsleIASakObservers)

        return oppdatertSak
    }

    fun hentAktivIASakDto(orgnummer: String): IASakDto? =
        iaSakRepository.hentAlleSakerForVirksomhet(orgnummer = orgnummer)
            .sortedByDescending { it.opprettetTidspunkt }
            .firstOrNull { !it.lukket }

    fun slettSakOgVarsleObservers(sakDto: IASakDto): Either<Feil, IASakDto> =
        slettSak(sakDto).also { iaSakEither ->
            iaSakEither.onRight { varsleIASakObservers(it) }
        }

    fun opprettNyttSamarbeid(
        orgnummer: String,
        saksnummer: String,
        navn: String,
        saksbehandler: NavAnsattMedSaksbehandlerRolle,
        navEnhet: NavEnhet,
    ): Either<Feil, IASamarbeidDto> {
        val aktivSakDto = hentAktivIASakDto(orgnummer = orgnummer)
            ?: return Either.Left(IASakError.`generell feil under uthenting`)
        val alleSamarbeid = hentSamarbeid(saksnummer = saksnummer)

        if (navn.trim().isEmpty() || navn.length > MAKS_ANTALL_TEGN_I_SAMARBEIDSNAVN) {
            return Either.Left(IASamarbeidFeil.`ugyldig samarbeidsnavn`)
        }
        alleSamarbeid.getOrNull()
            ?.find { it.navn.equals(navn, ignoreCase = true) }
            ?.let { return Either.Left(IASamarbeidFeil.`samarbeidsnavn finnes allerede`) }

        val erEierEllerFølgerAvSak = iaTeamService.erEierEllerFølgerAvSak(
            saksnummer = aktivSakDto.saksnummer,
            eierAvSak = aktivSakDto.eidAv,
            saksbehandler = saksbehandler,
        )
        if (!erEierEllerFølgerAvSak) {
            return Either.Left(IASakError.`er ikke følger eller eier av sak`)
        }

        val iASakshendelse = IASakshendelse(
            id = ULID.random(),
            opprettetTidspunkt = LocalDateTime.now(),
            saksnummer = saksnummer,
            hendelsesType = IASakshendelseType.NY_PROSESS,
            orgnummer = orgnummer,
            opprettetAv = saksbehandler.navIdent,
            opprettetAvRolle = saksbehandler.rolle,
            navEnhet = navEnhet,
            resulterendeStatus = null,
        )
        iaSakshendelseRepository.lagreHendelse(
            hendelse = iASakshendelse,
            sistEndretAvHendelseId = null,
            resulterendeStatus = aktivSakDto.status, // Opprett samarbeid skal ikke endre status
        )
        val opprettetSamarbeid = iaSamarbeidRepository.opprettNyttSamarbeid(
            saksnummer = saksnummer,
            navn = navn,
        ).also { samarbeid ->
            iaSamarbeidObservers.forEach { it.receive(input = samarbeid) }
        }

        return Either.Right(opprettetSamarbeid.tilDto())
    }

    fun opprettNySamarbeidsplan(
        orgnummer: String,
        saksnummer: String,
        samarbeidId: Int,
        plan: PlanMalDto,
        saksbehandler: NavAnsattMedSaksbehandlerRolle,
        navEnhet: NavEnhet,
    ): Either<Feil, PlanMedPubliseringStatusDto> {
        val plan = planService.opprettPlan(
            samarbeidId = samarbeidId,
            saksbehandler = saksbehandler,
            mal = plan,
        ).map {
            it.tilDtoMedPubliseringStatus()
        }.onRight {
            val iASakshendelse = IASakshendelse(
                id = ULID.random(),
                opprettetTidspunkt = LocalDateTime.now(),
                saksnummer = saksnummer,
                hendelsesType = IASakshendelseType.OPPRETT_SAMARBEIDSPLAN,
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

        return plan
    }

    fun slettSamarbeidsplan(
        orgnummer: String,
        saksnummer: String,
        samarbeidId: Int,
        saksbehandler: NavAnsattMedSaksbehandlerRolle,
        navEnhet: NavEnhet,
    ): Either<Feil, Int> =
        planService.slettPlan(
            samarbeidId = samarbeidId,
        ).map {
            hentAntallAktivePlaner(saksnummer = saksnummer)
        }.onRight { antallAktivePlaner ->
            val harResterendeAktivePlaner = antallAktivePlaner > 0
            val resulterendeStatus = if (harResterendeAktivePlaner) AKTIV else VURDERES

            val iASakshendelse = IASakshendelse(
                id = ULID.random(),
                opprettetTidspunkt = LocalDateTime.now(),
                saksnummer = saksnummer, // TODO: hvordan henter vi dette?
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
                resulterendeStatus = resulterendeStatus,
            )

            iaSakRepository.oppdaterStatusPåSak(
                saksnummer = saksnummer,
                status = resulterendeStatus,
                endretAv = saksbehandler.navIdent,
                endretAvHendelseId = iASakshendelse.id,
            )
            // TODO: varsle observers etc.
        }

    private fun hentAntallAktivePlaner(saksnummer: String) = planService.hentAntallAktiveSamarbeidsplaner(saksnummer) ?: 0

    private fun slettSak(sakDto: IASakDto): Either<Feil, IASakDto> =
        try {
            iaSakRepository.slettSak(saksnummer = sakDto.saksnummer, sistEndretAvHendelseId = null)
            Either.Right(sakDto.settStatusTilSlettet())
        } catch (_: Exception) {
            Either.Left(IASakError.`fikk ikke slettet sak`)
        }

    private fun IASakDto.settStatusTilSlettet(): IASakDto = this.copy(status = SLETTET, endretAvHendelseId = ULID.random())

    private fun hentSamarbeid(saksnummer: String): Either<Feil, List<IASamarbeid>> =
        Either.catch {
            iaSamarbeidRepository.hentSamarbeid(saksnummer = saksnummer)
        }.mapLeft {
            IASamarbeidFeil.`feil ved henting av samarbeid`
        }
}
