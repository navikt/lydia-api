package no.nav.lydia.ia.sak

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.getOrElse
import arrow.core.left
import arrow.core.right
import com.github.guepardoapps.kulid.ULID
import ia.felles.integrasjoner.kafkameldinger.eksport.InnholdStatus.FULLFØRT
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus
import io.ktor.http.HttpStatusCode
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
import no.nav.lydia.ia.sak.api.IASakLeveranseOppdateringsDto
import no.nav.lydia.ia.sak.api.IASakLeveranseOpprettelsesDto
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
import no.nav.lydia.ia.sak.domene.IASakLeveranseStatus
import no.nav.lydia.ia.sak.domene.IASakStatus
import no.nav.lydia.ia.sak.domene.IASakStatus.IKKE_AKTUELL
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelse.Companion.nyHendelseBasertPåSak
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.IATjeneste
import no.nav.lydia.ia.sak.domene.Modul
import no.nav.lydia.ia.sak.domene.ProsessHendelse
import no.nav.lydia.ia.sak.domene.VirksomhetIkkeAktuellHendelse
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
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
    private val iaSaksLeveranseObservers: List<Observer<IASakLeveranse>>,
    private val planRepository: PlanRepository,
    private val endringsObservers: List<EndringsObserver<IASak, IASakshendelse>>,
    private val spørreundersøkelseRepository: SpørreundersøkelseRepository,
    private val spørreundersøkelseObservers: List<Observer<Spørreundersøkelse>>,
) {
    private val log: Logger = LoggerFactory.getLogger(this.javaClass)

    private fun IASakshendelse.lagre(
        sistEndretAvHendelseId: String?,
        resulterendeStatus: IASakStatus,
    ): IASakshendelse =
        iaSakshendelseRepository.lagreHendelse(hendelse = this, sistEndretAvHendelseId = sistEndretAvHendelseId, resulterendeStatus = resulterendeStatus)

    private fun IASak.lagre(): IASak = iaSakRepository.opprettSak(iaSak = this).also(::varsleIASakObservers)

    private fun IASak.lagreOppdatering(sistEndretAvHendelseId: String?): Either<Feil, IASak> {
        if (this.status == IASakStatus.SLETTET) {
            return slettSak(sak = this, sistEndretAvHendelseId = sistEndretAvHendelseId).onRight(::varsleIASakObservers)
        }
        return iaSakRepository.oppdaterSak(iaSak = this, sistOppdatertAvHendelseId = sistEndretAvHendelseId).onRight(::varsleIASakObservers)
    }

    private fun varsleIASakObservers(sak: IASak) {
        iaSakObservers.forEach { observer -> observer.receive(input = sak) }
    }

    private fun varsleIASakLeveranseObservers(leveranse: IASakLeveranse) {
        iaSaksLeveranseObservers.forEach { observer -> observer.receive(input = leveranse) }
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
            ).lagre(sistEndretAvHendelseId = null, resulterendeStatus = IASakStatus.NY),
        ).lagre()
        val sistEndretAvHendelseId = sak.endretAvHendelseId

        return sak.nyHendelseBasertPåSak(
            hendelsestype = IASakshendelseType.VIRKSOMHET_VURDERES,
            superbruker = superbruker,
            navEnhet = navEnhet,
        ).lagre(sistEndretAvHendelseId = null, resulterendeStatus = IASakStatus.VURDERES)
            .let { vurderesHendelse -> superbruker.utførHendelsePåSak(sak = sak, hendelse = vurderesHendelse) }
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

            val alleLeveranserPåEnSak = iaSakLeveranseRepository.hentIASakLeveranser(saksnummer = hendelseDto.saksnummer)
            val aktiveLeveranserPåEnSak = alleLeveranserPåEnSak.filter { it.status == IASakLeveranseStatus.UNDER_ARBEID }
            if (aktiveLeveranserPåEnSak.isNotEmpty()) {
                return IASakError.`kan ikke fullføre med gjenstående leveranser`.left()
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

                saksbehandler.utførHendelsePåSak(sak = sak, hendelse = sakshendelse)
                    .map { oppdatertSak ->
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
            tilbakeføringsHendelse.lagre(sistEndretAvHendelseId = sistEndretAvHendelseId, resulterendeStatus = IKKE_AKTUELL)
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
            resulterendeStatus = IKKE_AKTUELL,
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
                        resulterendeStatus = IASakStatus.FULLFØRT,
                    )

                    val spørreundersøkelser = spørreundersøkelseRepository.hentSpørreundersøkelser(
                        samarbeid = samarbeid,
                        type = Spørreundersøkelse.Companion.Type.Behovsvurdering,
                    ).plus(
                        spørreundersøkelseRepository.hentSpørreundersøkelser(
                            samarbeid = samarbeid,
                            type = Spørreundersøkelse.Companion.Type.Evaluering,
                        ),
                    ).filter { it.status != SpørreundersøkelseStatus.AVSLUTTET }

                    if (!tørrKjør) {
                        spørreundersøkelser.forEach { spørreundersøkelse ->
                            spørreundersøkelseRepository.slettSpørreundersøkelse(
                                spørreundersøkelseId = spørreundersøkelse.id.toString(),
                            )?.let { oppdatertSpørreundersøkelse ->
                                spørreundersøkelseObservers.forEach {
                                    it.receive(input = oppdatertSpørreundersøkelse)
                                }
                            }
                        }

                        maskineltOppdaterSamarbeidHendelse.lagre(
                            sistEndretAvHendelseId = sistEndretAvHendelseId,
                            resulterendeStatus = IKKE_AKTUELL,
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
        resulterendeStatus: IASakStatus,
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
        } catch (exception: Exception) {
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

    fun opprettIASakLeveranse(
        leveranse: IASakLeveranseOpprettelsesDto,
        saksbehandler: NavAnsattMedSaksbehandlerRolle,
    ): Either<Feil, IASakLeveranse> {
        return try {
            val moduler = iaSakLeveranseRepository.hentModuler()
            moduler.firstOrNull { it.id == leveranse.modulId } ?: return IASakError.`ugyldig modul`.left()

            val finnesFraFør = iaSakLeveranseRepository.hentIASakLeveranser(saksnummer = leveranse.saksnummer)
                .any { it.modul.id == leveranse.modulId }
            if (finnesFraFør) {
                return Feil(feilmelding = "Det finnes allerede en leveranse med denne modulen", httpStatusCode = HttpStatusCode.Conflict).left()
            }

            somEierAvSakIViBistår(saksnummer = leveranse.saksnummer, saksbehandler = saksbehandler) {
                iaSakLeveranseRepository.opprettIASakLeveranse(iaSakleveranse = leveranse, saksbehandler = saksbehandler)
                    .onRight(::varsleIASakLeveranseObservers)
            }
        } catch (e: Exception) {
            log.error("Noe gikk feil ved opprettelse av leveranse: ${e.message}", e)
            Feil(feilmelding = "Feil ved opprettelse av leveranse", httpStatusCode = HttpStatusCode.InternalServerError).left()
        }
    }

    fun slettIASakLeveranse(
        iaSakLeveranseId: Int,
        saksbehandler: NavAnsattMedSaksbehandlerRolle,
    ): Either<Feil, Int> {
        return try {
            val iaSakLeveranse = iaSakLeveranseRepository.hentIASakLeveranse(iaSakLeveranseId = iaSakLeveranseId)
            val saksnummer = iaSakLeveranse?.saksnummer ?: return IASakError.`ugyldig iaSakLeveranseId`.left()
            somEierAvSakIViBistår(saksnummer = saksnummer, saksbehandler = saksbehandler) {
                iaSakLeveranseRepository.slettIASakLeveranse(iaSakLeveranseId = iaSakLeveranseId).right()
                    .onRight { varsleIASakLeveranseObservers(leveranse = iaSakLeveranse.slettet()) }
            }
        } catch (e: Exception) {
            log.error("Noe gikk feil ved letting av leveranse med id $iaSakLeveranseId: ${e.message}", e)
            Feil(feilmelding = "Feil ved sletting av leveranse", httpStatusCode = HttpStatusCode.InternalServerError).left()
        }
    }

    fun oppdaterIASakLeveranse(
        iaSakLeveranseId: Int,
        oppdateringsDto: IASakLeveranseOppdateringsDto,
        saksbehandler: NavAnsattMedSaksbehandlerRolle,
    ): Either<Feil, IASakLeveranse> {
        return try {
            val saksnummer =
                iaSakLeveranseRepository.hentIASakLeveranse(iaSakLeveranseId = iaSakLeveranseId)?.saksnummer
                    ?: return IASakError.`ugyldig iaSakLeveranseId`.left()
            somEierAvSakIViBistår(saksnummer = saksnummer, saksbehandler = saksbehandler) {
                iaSakLeveranseRepository.oppdaterIASakLeveranse(
                    iaSakLeveranseId = iaSakLeveranseId,
                    oppdateringsDto = oppdateringsDto,
                    saksbehandler = saksbehandler,
                )
                    .onRight(::varsleIASakLeveranseObservers)
            }
        } catch (e: Exception) {
            log.error("Noe gikk feil ved oppdatering av IASakLeveranse: ${e.message}", e)
            Feil(feilmelding = "Feil ved oppdatering av leveranse", httpStatusCode = HttpStatusCode.InternalServerError).left()
        }
    }

    fun hentTjenester(): Either<Feil, List<IATjeneste>> =
        try {
            iaSakLeveranseRepository.hentIATjenster().right()
        } catch (e: Exception) {
            log.error("Noe gikk feil ved henting av tjenester: ${e.message}", e)
            IASakError.`generell feil under uthenting`.left()
        }

    fun hentModuler(): Either<Feil, List<Modul>> =
        try {
            iaSakLeveranseRepository.hentModuler().right()
        } catch (e: Exception) {
            log.error("Noe gikk feil ved henting av moduler: ${e.message}", e)
            IASakError.`generell feil under uthenting`.left()
        }

    fun hentIASak(saksnummer: String): Either<Feil, IASak> =
        iaSakRepository.hentIASak(saksnummer = saksnummer)?.right() ?: IASakError.`ugyldig saksnummer`.left()

    private fun <T> somEierAvSak(
        saksnummer: String,
        saksbehandler: NavAnsattMedSaksbehandlerRolle,
        block: (IASak) -> Either<Feil, T>,
    ): Either<Feil, T> =
        hentIASak(saksnummer = saksnummer)
            .flatMap { sak ->
                if (sak.eidAv == saksbehandler.navIdent) {
                    block(sak)
                } else {
                    IASakError.`ikke eier av sak`.left()
                }
            }

    private fun <T> somEierAvSakIViBistår(
        saksnummer: String,
        saksbehandler: NavAnsattMedSaksbehandlerRolle,
        block: (IASak) -> Either<Feil, T>,
    ): Either<Feil, T> =
        somEierAvSak(saksnummer = saksnummer, saksbehandler = saksbehandler) { sak ->
            if (sak.status == IASakStatus.VI_BISTÅR) {
                block(sak)
            } else {
                IASakError.`fikk ikke oppdatert leveranse`.left()
            }
        }

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
                undertema.status == FULLFØRT
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
                SpørreundersøkelseStatus.AVSLUTTET,
                SpørreundersøkelseStatus.SLETTET,
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

    fun avsluttSakForSlettetVirksomhet(iaSak: IASak) {
        // avslutt alle samarbeid
        samarbeidService.hentAktiveSamarbeid(iaSak).forEach { samarbeid ->
            // avslutt eventuelle spørreundersøkelser i samarbeid
            spørreundersøkelseRepository.hentSpørreundersøkelser(samarbeid = samarbeid, type = Spørreundersøkelse.Companion.Type.Behovsvurdering)
                .plus(spørreundersøkelseRepository.hentSpørreundersøkelser(samarbeid = samarbeid, type = Spørreundersøkelse.Companion.Type.Evaluering))
                .filter { it.status != SpørreundersøkelseStatus.AVSLUTTET }
                .forEach { spørreundersøkelseRepository.slettSpørreundersøkelse(spørreundersøkelseId = it.id.toString()) }

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
