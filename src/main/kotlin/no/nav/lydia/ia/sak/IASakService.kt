package no.nav.lydia.ia.sak

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.getOrElse
import arrow.core.left
import arrow.core.right
import com.github.guepardoapps.kulid.ULID
import kotlinx.serialization.json.Json
import no.nav.lydia.EndringsObserver
import no.nav.lydia.Observer
import no.nav.lydia.appstatus.Metrics
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.Feil.Companion.tilFeilMedHttpFeilkode
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.IASakDto.Companion.erLukket
import no.nav.lydia.ia.sak.api.IASakDto.Companion.toDto
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.IASakshendelseDto
import no.nav.lydia.ia.sak.api.SaksStatusDto
import no.nav.lydia.ia.sak.api.samarbeid.IASamarbeidDto
import no.nav.lydia.ia.sak.api.samarbeid.tilDto
import no.nav.lydia.ia.sak.api.ÅrsakTilAtSakIkkeKanAvsluttes
import no.nav.lydia.ia.sak.api.ÅrsaksType
import no.nav.lydia.ia.sak.db.IASakLeveranseRepository
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
import no.nav.lydia.ia.sak.db.PlanRepository
import no.nav.lydia.ia.sak.db.SpørreundersøkelseRepository
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASak.Companion.kopier
import no.nav.lydia.ia.sak.domene.IASak.Companion.maskineltBehandleSamarbeidsHendelse
import no.nav.lydia.ia.sak.domene.IASak.Companion.medHendelser
import no.nav.lydia.ia.sak.domene.IASak.Companion.tilbakeførSak
import no.nav.lydia.ia.sak.domene.IASak.Companion.utførHendelsePåSak
import no.nav.lydia.ia.sak.domene.IASakLeveranse
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelse.Companion.nyHendelseBasertPåSak
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.ProsessHendelse
import no.nav.lydia.ia.sak.domene.VirksomhetIkkeAktuellHendelse
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.ia.team.IATeamService
import no.nav.lydia.ia.årsak.domene.BegrunnelseType
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.ia.årsak.domene.ÅrsakType
import no.nav.lydia.ia.årsak.ÅrsakService
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.integrasjoner.journalpost.JournalpostService
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker
import no.nav.lydia.tilgangskontroll.fia.Rolle
import no.nav.lydia.vedlikehold.IASakStatusOppdaterer
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.time.LocalDateTime

class IASakService(
    private val iaSakRepository: IASakRepository,
    private val iaSakshendelseRepository: IASakshendelseRepository,
    private val iaSakLeveranseRepository: IASakLeveranseRepository,
    private val årsakService: ÅrsakService,
    private val journalpostService: JournalpostService,
    private val samarbeidService: IASamarbeidService,
    private val iaSakObservers: List<Observer<IASak>>,
    private val planRepository: PlanRepository,
    private val endringsObservers: List<EndringsObserver<IASak, IASakshendelse>>,
    private val spørreundersøkelseRepository: SpørreundersøkelseRepository,
    private val spørreundersøkelseObservers: List<Observer<Spørreundersøkelse>>,
    private val iaTeamService: IATeamService,
) {
    private val log: Logger = LoggerFactory.getLogger(this.javaClass)

    private fun IASakshendelse.lagre(
        sistEndretAvHendelseId: String?,
        resulterendeStatus: IASak.Status,
    ): IASakshendelse =
        iaSakshendelseRepository.lagreHendelse(hendelse = this, sistEndretAvHendelseId = sistEndretAvHendelseId, resulterendeStatus = resulterendeStatus)

    private fun IASak.lagre(): IASak = iaSakRepository.opprettSak(iaSak = this).also(::varsleIASakObservers)

    private fun IASak.lagreOppdatering(sistEndretAvHendelseId: String?): Either<Feil, IASak> {
        if (this.status == IASak.Status.SLETTET) {
            return slettSak(sak = this, sistEndretAvHendelseId = sistEndretAvHendelseId).onRight(::varsleIASakObservers)
        }
        return iaSakRepository.oppdaterSak(iaSak = this, sistOppdatertAvHendelseId = sistEndretAvHendelseId).onRight(::varsleIASakObservers)
    }

    private fun varsleIASakObservers(sak: IASak) {
        iaSakObservers.forEach { observer -> observer.receive(input = sak) }
    }

    fun opprettSakOgMerkSomVurdert(
        orgnummer: String,
        superbruker: Superbruker,
        navEnhet: NavEnhet,
    ): Either<Feil, IASak> {
        if (!iaSakRepository.hentSaker(orgnummer).all { it.status.regnesSomAvsluttet() }) {
            return Either.Left(IASakError.`det finnes flere saker på dette orgnummeret som ikke regnes som avsluttet`)
        }
        val sak = IASak.fraFørsteHendelse(
            hendelse = IASakshendelse.nyFørsteHendelse(
                orgnummer = orgnummer,
                superbruker = superbruker,
                navEnhet = navEnhet,
            ).lagre(sistEndretAvHendelseId = null, resulterendeStatus = IASak.Status.NY),
        ).lagre()
        val sistEndretAvHendelseId = sak.endretAvHendelseId

        return sak.nyHendelseBasertPåSak(
            hendelsestype = IASakshendelseType.VIRKSOMHET_VURDERES,
            superbruker = superbruker,
            navEnhet = navEnhet,
        ).lagre(sistEndretAvHendelseId = null, resulterendeStatus = IASak.Status.VURDERES)
            .let { vurderesHendelse -> superbruker.utførHendelsePåSak(sak = sak, hendelse = vurderesHendelse, false) }
            .mapLeft { tilstandsmaskinFeil -> tilstandsmaskinFeil.tilFeilMedHttpFeilkode() }
            .flatMap { oppdatertSak ->
                oppdatertSak.lagreOppdatering(sistEndretAvHendelseId)
            }
            .onRight { Metrics.virksomheterPrioritert.inc() }
    }

    fun behandleHendelse(
        hendelseDto: IASakshendelseDto,
        saksbehandler: NavAnsattMedSaksbehandlerRolle,
        navEnhet: NavEnhet,
    ): Either<Feil, IASak> {
        val aktiveSaker = iaSakRepository.hentSaker(orgnummer = hendelseDto.orgnummer).filter { !it.status.regnesSomAvsluttet() }
        if (aktiveSaker.isNotEmpty() && hendelseDto.saksnummer != aktiveSaker.first().saksnummer) {
            return Either.Left(IASakError.`det finnes flere saker på dette orgnummeret som ikke regnes som avsluttet`)
        }

        if (
            hendelseDto.hendelsesType == IASakshendelseType.FULLFØR_BISTAND ||
            hendelseDto.hendelsesType == IASakshendelseType.VIRKSOMHET_ER_IKKE_AKTUELL
        ) {
            val aktivSak = iaSakRepository.hentIASak(saksnummer = hendelseDto.saksnummer) ?: return IASakError.`generell feil under uthenting`.left()
            val alleAktiveSamarbeidPåSak = samarbeidService.hentAktiveSamarbeid(sak = aktivSak)
            if (alleAktiveSamarbeidPåSak.isNotEmpty()) {
                return IASakError.`kan ikke fullføre sak med aktive samarbeid`.left()
            }
        }

        when (hendelseDto.hendelsesType) {
            IASakshendelseType.AVBRYT_PROSESS -> {
                val samarbeidDto = Json.decodeFromString<IASamarbeidDto>(hendelseDto.payload!!)
                val aktivSak = iaSakRepository.hentIASak(saksnummer = hendelseDto.saksnummer) ?: return IASakError.`generell feil under uthenting`.left()
                if (!samarbeidService.kanAvbryteSamarbeid(sak = aktivSak, samarbeidId = samarbeidDto.id).kanGjennomføres) {
                    return IASamarbeidFeil.`kan ikke avbryte samarbeid`.left()
                }
            }

            IASakshendelseType.SLETT_PROSESS -> {
                val samarbeidDto = Json.decodeFromString<IASamarbeidDto>(hendelseDto.payload!!)
                val aktivSak = iaSakRepository.hentIASak(saksnummer = hendelseDto.saksnummer) ?: return IASakError.`generell feil under uthenting`.left()
                if (!samarbeidService.kanSletteSamarbeid(sak = aktivSak, samarbeidId = samarbeidDto.id).kanGjennomføres) {
                    return IASamarbeidFeil.`kan ikke slette samarbeid som inneholder behovsvurdering eller samarbeidsplan`.left()
                }
            }

            IASakshendelseType.FULLFØR_PROSESS -> {
                val samarbeidDto = Json.decodeFromString<IASamarbeidDto>(hendelseDto.payload!!)
                val aktivSak = iaSakRepository.hentIASak(saksnummer = hendelseDto.saksnummer) ?: return IASakError.`generell feil under uthenting`.left()
                if (!samarbeidService.kanFullføreSamarbeid(sak = aktivSak, samarbeidId = samarbeidDto.id).kanGjennomføres) {
                    return IASamarbeidFeil.`kan ikke fullføre samarbeid`.left()
                }
            }

            IASakshendelseType.ENDRE_PROSESS, IASakshendelseType.NY_PROSESS -> {
                val samarbeidDto = Json.decodeFromString<IASamarbeidDto>(hendelseDto.payload!!)
                val aktivSak = iaSakRepository.hentIASak(saksnummer = hendelseDto.saksnummer) ?: return IASakError.`generell feil under uthenting`.left()
                val alleProsesser = samarbeidService.hentSamarbeid(aktivSak)

                if (samarbeidDto.navn.trim().isEmpty() || samarbeidDto.navn.length > MAKS_ANTALL_TEGN_I_SAMARBEIDSNAVN) {
                    return IASamarbeidFeil.`ugyldig samarbeidsnavn`.left()
                }

                alleProsesser.getOrNull()
                    ?.find { it.navn.equals(samarbeidDto.navn, ignoreCase = true) }
                    ?.let { return IASamarbeidFeil.`samarbeidsnavn finnes allerede`.left() }
            }

            else -> {}
        }

        return IASakshendelse.fromDto(hendelseDto, saksbehandler, navEnhet)
            .flatMap { sakshendelse ->
                val hendelser = iaSakshendelseRepository.hentHendelserForSaksnummer(saksnummer = sakshendelse.saksnummer)
                if (hendelser.isEmpty()) {
                    return IASakError.`prøvde å legge til en hendelse på en tom sak`.left()
                }
                if (hendelser.last().id != hendelseDto.endretAvHendelseId) {
                    return IASakError.`prøvde å legge til en hendelse på en gammel sak`.left()
                }

                val sak = iaSakRepository.hentIASak(saksnummer = hendelseDto.saksnummer).medHendelser(hendelser)
                    ?: return IASakError.`generell feil under uthenting`.left()
                val sistEndretAvHendelseId = sak.endretAvHendelseId

                val umodifisertIaSak = sak.kopier() // siden vi muterer state i utførhende -> behandleHendelse

                val følgerSak = iaTeamService.erFølgerAvSak(sak, saksbehandler)

                saksbehandler.utførHendelsePåSak(
                    sak = sak,
                    hendelse = sakshendelse,
                    følgerSak = følgerSak,
                ).map { oppdatertSak ->
                    val nyStatus = oppdatertSak.status
                    sakshendelse.lagre(sistEndretAvHendelseId = sistEndretAvHendelseId, resulterendeStatus = nyStatus)
                    årsakService.lagreÅrsak(sakshendelse)
                    samarbeidService.oppdaterSamarbeid(sakshendelse, sak)
                    when (sakshendelse.hendelsesType) {
                        IASakshendelseType.VIRKSOMHET_SKAL_BISTÅS -> journalpostService.journalfør(
                            sakshendelse = sakshendelse,
                            navAnsattMedSaksbehandlerRolle = saksbehandler,
                        )
                            .onLeft {
                                log.error("Feil ved journalføring av hendelseid: '${sakshendelse.id}'. Feil: ${it.feilmelding}")
                            }

                        else -> {}
                    }
                    return oppdatertSak.lagreOppdatering(sistEndretAvHendelseId = sistEndretAvHendelseId)
                        .onRight { lagretSak ->
                            endringsObservers.forEach { it.receive(før = umodifisertIaSak, endring = sakshendelse, etter = lagretSak) }
                        }
                }
                    .mapLeft { it.tilFeilMedHttpFeilkode() }
            }
    }

    fun hentAktivSak(
        orgnummer: String,
        navAnsatt: NavAnsatt,
    ): IASakDto? =
        hentSakerForOrgnummer(orgnummer)
            .sortedByDescending { it.opprettetTidspunkt }
            .toDto(navAnsatt = navAnsatt)
            .firstOrNull { !it.lukket }

    fun hentAktivSak(orgnummer: String): IASak? =
        hentSakerForOrgnummer(orgnummer = orgnummer)
            .sortedByDescending { it.opprettetTidspunkt }
            .firstOrNull { !it.erLukket() }

    fun tilbakeførSaker(tørrKjør: Boolean): Int =
        iaSakRepository.hentUrørteSakerIVurderesUtenEier().map {
            it.maskineltSettSakTilIkkeAktuell(tørrKjør = tørrKjør)
        }.size

    private fun IASak.maskineltSettSakTilIkkeAktuell(tørrKjør: Boolean) {
        val tilbakeføringsHendelse = this.nyTilbakeføringsHendelse()
        val sistEndretAvHendelseId = this.endretAvHendelseId
        val endretTidspunkt = this.endretTidspunkt
        if (!tørrKjør) {
            tilbakeføringsHendelse.lagre(sistEndretAvHendelseId = sistEndretAvHendelseId, resulterendeStatus = IASak.Status.IKKE_AKTUELL)
            val oppdatertSak = tilbakeførSak(iaSak = this, hendelse = tilbakeføringsHendelse)
            årsakService.lagreÅrsak(sakshendelse = tilbakeføringsHendelse)
            oppdatertSak.lagreOppdatering(sistEndretAvHendelseId = sistEndretAvHendelseId)
        }
        log.info(
            "${if (tørrKjør) "Skulle tilbakeføre" else "Tilbakeførte"} sak med saksnummer ${this.saksnummer}, sist oppdatert: $endretTidspunkt",
        )
    }

    private fun IASak.maskineltAvsluttProsess(iaSamarbeidDto: IASamarbeidDto) {
        val hendelse = nyMaskineltOppdaterSamarbeidHendelse(
            iaSamarbeidDto = iaSamarbeidDto,
            iASakshendelseType = IASakshendelseType.AVBRYT_PROSESS,
            resulterendeStatus = this.status,
        )
        val sistEndretAvHendelseId = this.endretAvHendelseId
        hendelse.lagre(sistEndretAvHendelseId = sistEndretAvHendelseId, resulterendeStatus = this.status)
        samarbeidService.oppdaterSamarbeid(sakshendelse = hendelse, sak = this)
        val oppdatertSak = maskineltBehandleSamarbeidsHendelse(
            iaSak = this,
            hendelse = hendelse,
        )
        oppdatertSak.lagreOppdatering(sistEndretAvHendelseId = sistEndretAvHendelseId)
    }

    private fun IASak.nyTilbakeføringsHendelse(): VirksomhetIkkeAktuellHendelse =
        VirksomhetIkkeAktuellHendelse(
            id = ULID.random(),
            opprettetTidspunkt = LocalDateTime.now(),
            saksnummer = this.saksnummer,
            orgnummer = this.orgnr,
            opprettetAv = "Fia system",
            opprettetAvRolle = Rolle.SUPERBRUKER,
            navEnhet = IASakStatusOppdaterer.NAV_ENHET_FOR_MASKINELT_OPPDATERING,
            valgtÅrsak = ValgtÅrsak(
                type = ÅrsakType.NAV_IGANGSETTER_IKKE_TILTAK,
                begrunnelser = listOf(BegrunnelseType.AUTOMATISK_LUKKET),
            ),
            resulterendeStatus = IASak.Status.IKKE_AKTUELL,
        )

    fun avbrytMaskineltSamarbeidIIkkeAktuelleSaker(tørrKjør: Boolean): Int =
        iaSakRepository.hentIkkeAktuelleSakerMedAktiveSamarbeid().map { iaSak ->
            val alleAktiveSamarbeidPåSak = samarbeidService.hentSamarbeid(iaSak).getOrElse { emptyList() }
                .filter { it.status == IASamarbeid.Status.AKTIV }

            if (alleAktiveSamarbeidPåSak.isNotEmpty()) {
                alleAktiveSamarbeidPåSak.forEach { samarbeid: IASamarbeid ->
                    val oppdatertSakMedSisteHendelse = iaSakRepository.hentIASak(saksnummer = iaSak.saksnummer)!!
                    val sistEndretAvHendelseId = oppdatertSakMedSisteHendelse.endretAvHendelseId
                    val endretTidspunkt = oppdatertSakMedSisteHendelse.endretTidspunkt

                    val maskineltOppdaterSamarbeidHendelse: ProsessHendelse = oppdatertSakMedSisteHendelse.nyMaskineltOppdaterSamarbeidHendelse(
                        iaSamarbeidDto = samarbeid.tilDto(),
                        iASakshendelseType = IASakshendelseType.AVBRYT_PROSESS,
                        resulterendeStatus = IASak.Status.FULLFØRT,
                    )

                    val spørreundersøkelser = spørreundersøkelseRepository.hentSpørreundersøkelser(
                        samarbeid = samarbeid,
                        type = Spørreundersøkelse.Type.Behovsvurdering,
                    ).plus(
                        spørreundersøkelseRepository.hentSpørreundersøkelser(
                            samarbeid = samarbeid,
                            type = Spørreundersøkelse.Type.Evaluering,
                        ),
                    ).filter { it.status != Spørreundersøkelse.Status.AVSLUTTET }

                    if (!tørrKjør) {
                        spørreundersøkelser.forEach { spørreundersøkelse ->
                            spørreundersøkelseRepository.slettSpørreundersøkelse(
                                spørreundersøkelseId = spørreundersøkelse.id,
                            )?.let { oppdatertSpørreundersøkelse ->
                                spørreundersøkelseObservers.forEach {
                                    it.receive(input = oppdatertSpørreundersøkelse)
                                }
                            }
                        }

                        maskineltOppdaterSamarbeidHendelse.lagre(
                            sistEndretAvHendelseId = sistEndretAvHendelseId,
                            resulterendeStatus = IASak.Status.IKKE_AKTUELL,
                        )
                        samarbeidService.oppdaterSamarbeid(sakshendelse = maskineltOppdaterSamarbeidHendelse, sak = oppdatertSakMedSisteHendelse)
                        val oppdatertSak = maskineltBehandleSamarbeidsHendelse(iaSak = oppdatertSakMedSisteHendelse, maskineltOppdaterSamarbeidHendelse)
                        oppdatertSak.lagreOppdatering(sistEndretAvHendelseId = sistEndretAvHendelseId)
                    }
                    log.info(
                        "${if (tørrKjør) "Skulle avbryte" else "Avbrøt"} " +
                            "samarbeid med id ${samarbeid.id} og status ${samarbeid.status} på sak med saksnummer ${oppdatertSakMedSisteHendelse.saksnummer}, sist oppdatert: $endretTidspunkt",
                    )
                }
            }
            log.info(
                "${if (tørrKjør) "Skulle oppdatere" else "Oppdaterte"} " +
                    "${alleAktiveSamarbeidPåSak.size} samarbeid på sak med saksnummer ${iaSak.saksnummer}",
            )
        }.size.also { size ->
            log.info(
                "${if (tørrKjør) "Skulle oppdatere" else "Oppdaterte"} status til samarbeid i $size ${if (size > 1) "saker" else "sak"}",
            )
        }

    private fun IASak.nyMaskineltOppdaterSamarbeidHendelse(
        iaSamarbeidDto: IASamarbeidDto,
        iASakshendelseType: IASakshendelseType,
        resulterendeStatus: IASak.Status,
    ) = ProsessHendelse(
        id = ULID.random(),
        opprettetTidspunkt = LocalDateTime.now(),
        saksnummer = this.saksnummer,
        orgnummer = this.orgnr,
        opprettetAv = "Fia system",
        opprettetAvRolle = Rolle.SUPERBRUKER,
        navEnhet = IASakStatusOppdaterer.NAV_ENHET_FOR_MASKINELT_OPPDATERING,
        hendelsesType = iASakshendelseType,
        resulterendeStatus = resulterendeStatus,
        samarbeidDto = iaSamarbeidDto,
    )

    private fun slettSak(
        sak: IASak,
        sistEndretAvHendelseId: String?,
    ): Either<Feil, IASak> =
        try {
            iaSakRepository.slettSak(saksnummer = sak.saksnummer, sistEndretAvHendelseId = sistEndretAvHendelseId)
            Either.Right(sak)
        } catch (_: Exception) {
            Either.Left(IASakError.`fikk ikke slettet sak`)
        }

    fun hentSakerForOrgnummer(orgnummer: String): List<IASak> = iaSakRepository.hentSaker(orgnummer)

    fun hentHendelserForOrgnummer(orgnr: String): List<IASakshendelse> = iaSakshendelseRepository.hentHendelserForOrgnummer(orgnr = orgnr)

    fun hentIASakLeveranser(saksnummer: String): Either<Feil, List<IASakLeveranse>> =
        try {
            iaSakLeveranseRepository.hentIASakLeveranser(saksnummer = saksnummer).right()
        } catch (e: Exception) {
            log.error("Noe gikk feil ved uthenting av leveranser: ${e.message}", e)
            IASakError.`generell feil under uthenting`.left()
        }

    fun hentIASak(saksnummer: String): Either<Feil, IASak> =
        iaSakRepository.hentIASak(saksnummer = saksnummer)?.right() ?: IASakError.`ugyldig saksnummer`.left()

    fun hentMal(): Either<Feil, PlanMalDto> = PlanMalDto().right()

    fun hentSaksStatus(saksnummer: String): Either<Feil, SaksStatusDto> {
        val årsaker = mutableListOf<ÅrsakTilAtSakIkkeKanAvsluttes>()
        val sak = hentIASak(saksnummer).getOrNull()
            ?: return IASakError.`generell feil under uthenting`.left()
        val samarbeid = samarbeidService.hentSamarbeid(sak).getOrNull()
            ?: return IASamarbeidFeil.`feil ved henting av samarbeid`.left()

        samarbeid.forEach { prosess ->
            årsaker.addAll(sjekkBehovsvurderinger(prosess))
            sjekkPlan(prosess)?.let { årsaker.add(it) }
        }

        return SaksStatusDto(
            årsaker = årsaker.toList(),
        ).right()
    }

    private fun sjekkPlan(prosess: IASamarbeid): ÅrsakTilAtSakIkkeKanAvsluttes? {
        val plan = planRepository.hentPlan(samarbeidId = prosess.id) ?: return ÅrsakTilAtSakIkkeKanAvsluttes(
            samarbeidsId = prosess.id,
            samarbeidsNavn = prosess.navn,
            type = ÅrsaksType.INGEN_FULLFØRT_SAMARBEIDSPLAN,
        )

        val ingenPlanlagteUndertemaer = plan.temaer.map { tema ->
            tema.undertemaer.all { undertema -> !undertema.inkludert }
        }.all { it }

        if (ingenPlanlagteUndertemaer) {
            return ÅrsakTilAtSakIkkeKanAvsluttes(
                samarbeidsId = prosess.id,
                samarbeidsNavn = prosess.navn,
                type = ÅrsaksType.SAMARBEIDSPLAN_IKKE_FULLFØRT,
                id = plan.id.toString(),
            )
        }

        val erPlanFullført = plan.temaer.map { tema ->
            tema.undertemaer.filter { it.inkludert }.all { undertema ->
                undertema.status == PlanUndertema.Status.FULLFØRT
            }
        }.all { it }

        return when (erPlanFullført) {
            true -> null
            false -> ÅrsakTilAtSakIkkeKanAvsluttes(
                samarbeidsId = prosess.id,
                samarbeidsNavn = prosess.navn,
                type = ÅrsaksType.SAMARBEIDSPLAN_IKKE_FULLFØRT,
                id = plan.id.toString(),
            )
        }
    }

    private fun sjekkBehovsvurderinger(samarbeid: IASamarbeid): List<ÅrsakTilAtSakIkkeKanAvsluttes> {
        val årsaker = mutableListOf<ÅrsakTilAtSakIkkeKanAvsluttes>()
        val statusForBehovsvurderinger =
            iaSakRepository.hentStatusForBehovsvurderinger(samarbeidId = samarbeid.id)
        if (statusForBehovsvurderinger.isEmpty()) {
            return emptyList()
        }

        statusForBehovsvurderinger.forEach {
            when (it.second) {
                Spørreundersøkelse.Status.AVSLUTTET,
                Spørreundersøkelse.Status.SLETTET,
                -> {}
                else -> årsaker.add(
                    ÅrsakTilAtSakIkkeKanAvsluttes(
                        samarbeidsId = samarbeid.id,
                        samarbeidsNavn = samarbeid.navn,
                        id = it.first,
                        type = ÅrsaksType.BEHOVSVURDERING_IKKE_FULLFØRT,
                    ),
                )
            }
        }
        return årsaker
    }

    fun avsluttSakForSlettetVirksomhet(orgnr: String) {
        hentAktivSak(orgnummer = orgnr)?.let { iaSak ->
            if (iaSak.status != IASak.Status.FULLFØRT && iaSak.status != IASak.Status.IKKE_AKTUELL) {
                // avslutt alle samarbeid
                samarbeidService.hentAktiveSamarbeid(iaSak).forEach { samarbeid ->
                    // avslutt eventuelle spørreundersøkelser i samarbeid
                    spørreundersøkelseRepository.hentSpørreundersøkelser(samarbeid = samarbeid, type = Spørreundersøkelse.Type.Behovsvurdering)
                        .plus(spørreundersøkelseRepository.hentSpørreundersøkelser(samarbeid = samarbeid, type = Spørreundersøkelse.Type.Evaluering))
                        .filter { it.status != Spørreundersøkelse.Status.AVSLUTTET }
                        .forEach { spørreundersøkelseRepository.slettSpørreundersøkelse(spørreundersøkelseId = it.id) }

                    // slett eventuell plan for samarbeid
                    planRepository.hentPlan(samarbeidId = samarbeid.id)
                        ?.let { planRepository.settPlanTilAvbrutt(it) }

                    // sett samarbeid til AVBRYTT
                    val oppdatertSak = iaSakRepository.hentIASak(saksnummer = iaSak.saksnummer)!!
                    oppdatertSak.maskineltAvsluttProsess(iaSamarbeidDto = samarbeid.tilDto())
                }
                val oppdatertSak = iaSakRepository.hentIASak(saksnummer = iaSak.saksnummer)!!
                // sett sak til Ikke aktuell
                oppdatertSak.maskineltSettSakTilIkkeAktuell(tørrKjør = false)
            }
        }
    }
}
