package no.nav.lydia.ia.sak.api.ny.flyt

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import com.github.guepardoapps.kulid.ULID
import io.ktor.http.HttpStatusCode
import kotlinx.datetime.LocalDate
import kotlinx.datetime.toKotlinLocalDate
import kotlinx.datetime.toKotlinLocalDateTime
import no.nav.lydia.Observer
import no.nav.lydia.ia.sak.IASamarbeidFeil
import no.nav.lydia.ia.sak.IASamarbeidService
import no.nav.lydia.ia.sak.MAKS_ANTALL_TEGN_I_SAMARBEIDSNAVN
import no.nav.lydia.ia.sak.PlanService
import no.nav.lydia.ia.sak.SpørreundersøkelseService
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
import no.nav.lydia.ia.sak.domene.IASak.Status.AVSLUTTET
import no.nav.lydia.ia.sak.domene.IASak.Status.NY
import no.nav.lydia.ia.sak.domene.IASak.Status.SLETTET
import no.nav.lydia.ia.sak.domene.IASak.Status.VURDERES
import no.nav.lydia.ia.sak.domene.IASak.Status.VURDERT
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VURDERING_FULLFØRT_UTEN_SAMARBEID
import no.nav.lydia.ia.sak.domene.plan.Plan
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.ia.team.IATeamService
import no.nav.lydia.ia.årsak.db.ÅrsakRepository
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker
import java.time.LocalDate.now
import java.time.LocalDateTime
import java.util.UUID

class NyFlytService(
    val tilstandVirksomhetRepository: TilstandVirksomhetRepository,
    val iaSakRepository: IASakRepository,
    val iaSakshendelseRepository: IASakshendelseRepository,
    val årsakRepository: ÅrsakRepository,
    val iaSamarbeidService: IASamarbeidService,
    val iaSamarbeidRepository: IASamarbeidRepository, // TODO: bruk Service i stedet
    val iaTeamService: IATeamService,
    val spørreundersøkelseService: SpørreundersøkelseService,
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
        if (!iaSakRepository.hentAlleSakerDtoForVirksomhet(orgnummer).all { it.status.regnesSomAvsluttet() }) {
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

        // Steg #2 lagre i DB en ny hendelse VIRKSOMHET_VURDERES, og oppdatere SakDto til status VURDERES
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

    fun avsluttVurderingAvVirksomhetUtenSamarbeid(
        orgnummer: String,
        saksnummer: String,
        årsak: ValgtÅrsak,
        saksbehandler: NavAnsattMedSaksbehandlerRolle,
        navEnhet: NavEnhet,
    ): Either<Feil, IASakDto> {
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

    fun hentSisteIASakDto(orgnummer: String): IASakDto? =
        iaSakRepository.hentAlleSakerForVirksomhet(orgnummer = orgnummer).maxByOrNull { it.opprettetTidspunkt }

    fun slettEllerOppdaterTilstandVirksomhet(orgnummer: String): Either<Feil, VirksomhetTilstandDto?> {
        tilstandVirksomhetRepository.hentVirksomhetTilstand(orgnr = orgnummer)
            ?: return Feil(
                "kunne ikke finne tilstand for virksomhet",
                HttpStatusCode.BadRequest,
            ).left()

        val nestSisteSakDto: IASakDto = hentNestSisteIASakDto(orgnummer = orgnummer)
            ?: return slettVirksomhetTilstand(orgnr = orgnummer)

        return tilstandVirksomhetRepository.oppdaterVirksomhetTilstand(
            orgnr = orgnummer,
            samarbeidsperiodeId = nestSisteSakDto.saksnummer,
            tilstand = Tilstand.VirksomhetKlarTilVurdering.tilVirksomhetIATilstand(),
        ).right()
    }

    private fun slettVirksomhetTilstand(orgnr: String): Either<Feil, VirksomhetTilstandDto?> =
        try {
            val slettetTilstand = tilstandVirksomhetRepository.slettVirksomhetTilstand(orgnr = orgnr)
            Either.Right(slettetTilstand)
        } catch (_: Exception) {
            Either.Left(Feil("kunne ikke slette tilstand for virksomhet", HttpStatusCode.BadRequest))
        }

    private fun hentNestSisteIASakDto(orgnummer: String): IASakDto? {
        val alleSaker = iaSakRepository.hentAlleSakerDtoForVirksomhet(orgnummer = orgnummer).sortedByDescending { it.opprettetTidspunkt }
        if (alleSaker.size < 2) return null
        return alleSaker[alleSaker.size - 2]
    }

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
        val erFølgerAvSak = iaTeamService.erFølgerAvSak(
            saksnummer = saksnummer,
            saksbehandler = saksbehandler,
        )
        if (!erFølgerAvSak) {
            return Either.Left(IASakError.`er ikke følger av sak`)
        }

        val alleSamarbeid = hentSamarbeid(saksnummer = saksnummer)

        if (navn.trim().isEmpty() || navn.length > MAKS_ANTALL_TEGN_I_SAMARBEIDSNAVN) {
            return Either.Left(IASamarbeidFeil.`ugyldig samarbeidsnavn`)
        }
        alleSamarbeid.getOrNull()?.find { it.navn.equals(navn, ignoreCase = true) }
            ?.let { return Either.Left(IASamarbeidFeil.`samarbeidsnavn finnes allerede`) }

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
            resulterendeStatus = AKTIV,
        )
        val opprettetSamarbeid = iaSamarbeidRepository.opprettNyttSamarbeid(
            saksnummer = saksnummer,
            navn = navn,
        ).also { samarbeid ->
            iaSamarbeidObservers.forEach { it.receive(input = samarbeid) }
        }

        iaSakRepository.oppdaterStatusPåSak(
            saksnummer = saksnummer,
            status = AKTIV,
            endretAvHendelseId = iASakshendelse.id,
            endretAv = saksbehandler.navIdent,
        ).onRight(::varsleIASakObservers)

        return Either.Right(opprettetSamarbeid.tilDto())
    }

    fun opprettNyKartlegging(
        orgnummer: String,
        saksnummer: String,
        samarbeidId: Int,
        type: Spørreundersøkelse.Type,
        saksbehandler: NavAnsattMedSaksbehandlerRolle,
        navEnhet: NavEnhet,
    ): Either<Feil, Spørreundersøkelse> =
        spørreundersøkelseService.opprettSpørreundersøkelse(
            orgnummer = orgnummer,
            saksnummer = saksnummer,
            samarbeidId = samarbeidId,
            type = type,
            saksbehandler = saksbehandler,
        ).apply {
            onRight {
                loggKartleggingshendelse(
                    orgnummer = orgnummer,
                    saksnummer = saksnummer,
                    hendelsesType = IASakshendelseType.OPPRETT_KARTLEGGING,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                )
            }
        }

    fun startNyKartlegging(
        orgnummer: String,
        saksnummer: String,
        spørreundersøkelseId: UUID,
        saksbehandler: NavAnsattMedSaksbehandlerRolle,
        navEnhet: NavEnhet,
    ): Either<Feil, Spørreundersøkelse> =
        spørreundersøkelseService.endreSpørreundersøkelseStatus(
            spørreundersøkelseId = spørreundersøkelseId,
            statusViSkalEndreTil = Spørreundersøkelse.Status.PÅBEGYNT,
        ).apply {
            onRight {
                loggKartleggingshendelse(
                    orgnummer = orgnummer,
                    saksnummer = saksnummer,
                    hendelsesType = IASakshendelseType.START_KARTLEGGING,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                )
            }
        }

    fun fullførNyKartlegging(
        orgnummer: String,
        saksnummer: String,
        spørreundersøkelseId: UUID,
        saksbehandler: NavAnsattMedSaksbehandlerRolle,
        navEnhet: NavEnhet,
    ): Either<Feil, Spørreundersøkelse> =
        spørreundersøkelseService.endreSpørreundersøkelseStatus(
            spørreundersøkelseId = spørreundersøkelseId,
            statusViSkalEndreTil = Spørreundersøkelse.Status.AVSLUTTET,
        ).apply {
            onRight {
                loggKartleggingshendelse(
                    orgnummer = orgnummer,
                    saksnummer = saksnummer,
                    hendelsesType = IASakshendelseType.FULLFØR_KARTLEGGING,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                )
            }
        }

    fun slettNyKartlegging(
        orgnummer: String,
        saksnummer: String,
        spørreundersøkelseId: UUID,
        saksbehandler: NavAnsattMedSaksbehandlerRolle,
        navEnhet: NavEnhet,
    ): Either<Feil, Spørreundersøkelse> =
        spørreundersøkelseService.slettSpørreundersøkelse(
            spørreundersøkelseId = spørreundersøkelseId,
        ).apply {
            onRight {
                loggKartleggingshendelse(
                    orgnummer = orgnummer,
                    saksnummer = saksnummer,
                    hendelsesType = IASakshendelseType.SLETT_KARTLEGGING,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                )
            }
        }

    private fun loggKartleggingshendelse(
        orgnummer: String,
        saksnummer: String,
        hendelsesType: IASakshendelseType,
        saksbehandler: NavAnsattMedSaksbehandlerRolle,
        navEnhet: NavEnhet,
    ) {
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
            resulterendeStatus = AKTIV,
        )
        iaSakRepository.oppdaterStatusPåSak(
            saksnummer = saksnummer,
            status = AKTIV,
            endretAv = saksbehandler.navIdent,
            endretAvHendelseId = iASakshendelse.id,
        ).onRight(::varsleIASakObservers)
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

    fun slettSamarbeid(
        orgnummer: String,
        saksnummer: String,
        samarbeidId: Int,
        saksbehandler: NavAnsattMedSaksbehandlerRolle,
        navEnhet: NavEnhet,
    ): Either<Feil, IASamarbeidDto?> {
        val samarbeidDto = IASamarbeidDto(
            id = samarbeidId,
            saksnummer = saksnummer,
            navn = "",
        )

        val iaSamarbeidDto = iaSamarbeidService.slettSamarbeid(samarbeidDto = samarbeidDto, saksnummer = saksnummer)?.also { iaSamarbeid ->
            val iASakshendelse = IASakshendelse(
                id = ULID.random(),
                opprettetTidspunkt = LocalDateTime.now(),
                saksnummer = saksnummer,
                hendelsesType = IASakshendelseType.SLETT_PROSESS,
                orgnummer = orgnummer,
                opprettetAv = saksbehandler.navIdent,
                opprettetAvRolle = saksbehandler.rolle,
                navEnhet = navEnhet,
                resulterendeStatus = null,
            )

            val alleSamarbeid = iaSamarbeidRepository.hentSamarbeid(saksnummer = saksnummer)
            val ingenAndreSamarbeid = alleSamarbeid.isEmpty()
            val alleAndreSamarbeidErAvsluttet = alleSamarbeid
                .all { it.status == IASamarbeid.Status.AVBRUTT || it.status == IASamarbeid.Status.FULLFØRT }

            val resulterendeStatus = when {
                ingenAndreSamarbeid -> VURDERES
                alleAndreSamarbeidErAvsluttet -> AVSLUTTET
                else -> AKTIV
            }

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
            ).onRight(::varsleIASakObservers)

            iaSamarbeidObservers.forEach {
                it.receive(
                    input = iaSamarbeid,
                )
            }
        }?.tilDto().right()

        return iaSamarbeidDto
    }

    fun avsluttSamarbeid(
        orgnummer: String,
        saksnummer: String,
        samarbeidId: Int,
        typeAvslutning: IASamarbeid.Status,
        saksbehandler: NavAnsattMedSaksbehandlerRolle,
        navEnhet: NavEnhet,
    ): Either<Feil, IASamarbeidDto?> {
        val samarbeidDto = IASamarbeidDto(
            id = samarbeidId,
            saksnummer = saksnummer,
            navn = "",
        )

        if (typeAvslutning == IASamarbeid.Status.AVBRUTT) {
            if (!iaSamarbeidService.kanAvbryteSamarbeid(saksnummer = saksnummer, samarbeidId = samarbeidId).kanGjennomføres) {
                return IASamarbeidFeil.`kan ikke fullføre samarbeid`.left()
            }
            val iaSamarbeidDto = iaSamarbeidService.avbrytSamarbeid(
                samarbeidDto = samarbeidDto,
                saksnummer = saksnummer,
            )?.also { iaSamarbeid ->
                avslutningAvSamarbeid(
                    saksnummer = saksnummer,
                    orgnummer = orgnummer,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                    iaSamarbeid = iaSamarbeid,
                    typeAvslutning = IASakshendelseType.AVBRYT_PROSESS,
                )
            }

            return iaSamarbeidDto?.tilDto().right()
        } else if (typeAvslutning == IASamarbeid.Status.FULLFØRT) {
            if (!iaSamarbeidService.kanFullføreSamarbeid(saksnummer = saksnummer, samarbeidId = samarbeidId).kanGjennomføres) {
                return IASamarbeidFeil.`kan ikke fullføre samarbeid`.left()
            }

            val iaSamarbeidDto = iaSamarbeidService.fullførSamarbeid(samarbeidDto = samarbeidDto, saksnummer = saksnummer)?.also { iaSamarbeid ->
                avslutningAvSamarbeid(
                    saksnummer = saksnummer,
                    orgnummer = orgnummer,
                    saksbehandler = saksbehandler,
                    navEnhet = navEnhet,
                    iaSamarbeid = iaSamarbeid,
                    typeAvslutning = IASakshendelseType.FULLFØR_PROSESS,
                )
            }
            return iaSamarbeidDto?.tilDto().right()
        } else {
            return Feil("feil ved avslutning", HttpStatusCode.BadRequest).left()
        }
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

    private fun avslutningAvSamarbeid(
        saksnummer: String,
        orgnummer: String,
        saksbehandler: NavAnsattMedSaksbehandlerRolle,
        navEnhet: NavEnhet,
        iaSamarbeid: IASamarbeid,
        typeAvslutning: IASakshendelseType,
    ) {
        val iASakshendelse = IASakshendelse(
            id = ULID.random(),
            opprettetTidspunkt = LocalDateTime.now(),
            saksnummer = saksnummer,
            hendelsesType = typeAvslutning,
            orgnummer = orgnummer,
            opprettetAv = saksbehandler.navIdent,
            opprettetAvRolle = saksbehandler.rolle,
            navEnhet = navEnhet,
            resulterendeStatus = null,
        )

        val ingenAktiveSamarbeid = iaSamarbeidRepository.hentAktiveSamarbeid(saksnummer = saksnummer).isEmpty()
        val status = if (ingenAktiveSamarbeid) AVSLUTTET else AKTIV
        iaSakshendelseRepository.lagreHendelse(
            hendelse = iASakshendelse,
            sistEndretAvHendelseId = null,
            resulterendeStatus = status,
        )

        iaSakRepository.oppdaterStatusPåSak(
            saksnummer = saksnummer,
            status = status,
            endretAv = saksbehandler.navIdent,
            endretAvHendelseId = iASakshendelse.id,
        )

        iaSamarbeidObservers.forEach {
            it.receive(
                input = iaSamarbeid,
            )
        }
    }

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

    fun oppdaterTilstandOgSamarbeidsperiode(
        orgnr: String,
        nySamarbeidsperiodeId: String,
        nyTilstand: Tilstand,
    ): Either<Feil, Tilstand> {
        val oppdatertTilstand = tilstandVirksomhetRepository.oppdaterVirksomhetTilstand(
            orgnr = orgnr,
            samarbeidsperiodeId = nySamarbeidsperiodeId,
            tilstand = nyTilstand.tilVirksomhetIATilstand(),
        )
        return oppdatertTilstand?.tilstand?.tilTilstand()?.right() ?: Feil("kunne ikke oppdatere tilstand", HttpStatusCode.BadRequest).left()
    }

    fun prosesserPlanlagteHendelser() {
        val alleVirksomhetTilstand = tilstandVirksomhetRepository.hentAlleVirksomhetTilstand()

      // gå gjennom alle virksomheter med tilstand.nesteTilstand.planlagtDato != null og returner orgnr
        alleVirksomhetTilstand.forEach { virksomhetTilstand ->
            val orgnr = virksomhetTilstand.orgnr

        // hvis d finnes i til_au_opp
        val tilstand = tilstandVirksomhetRepository.hentVirksomhetTilstand(orgnr = "") //TODO: hent orgnr

        val iDag = now().toKotlinLocalDate()

        if ((tilstand?.nesteTilstand != null) && (tilstand.nesteTilstand.planlagtDato == iDag)) {
            tilstandVirksomhetRepository.oppdaterVirksomhetTilstand(
                orgnr = orgnr,
                samarbeidsperiodeId = "",
                tilstand = tilstand.nesteTilstand.nyTilstand,
            )

            tilstandVirksomhetRepository.slettVirksomhetTilstandAutomatisk(orgnr = orgnr)
        }
    }
}
