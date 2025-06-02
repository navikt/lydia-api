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
import no.nav.lydia.ia.sak.api.IASakDto.Companion.toDto
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.IASakLeveranseOppdateringsDto
import no.nav.lydia.ia.sak.api.IASakLeveranseOpprettelsesDto
import no.nav.lydia.ia.sak.api.IASakshendelseDto
import no.nav.lydia.ia.sak.api.SaksStatusDto
import no.nav.lydia.ia.sak.api.prosess.IAProsessDto
import no.nav.lydia.ia.sak.api.prosess.tilDto
import no.nav.lydia.ia.sak.api.ÅrsakTilAtSakIkkeKanAvsluttes
import no.nav.lydia.ia.sak.api.ÅrsaksType
import no.nav.lydia.ia.sak.db.IASakLeveranseRepository
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
import no.nav.lydia.ia.sak.db.PlanRepository
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASak.Companion.kopier
import no.nav.lydia.ia.sak.domene.IASak.Companion.medHendelser
import no.nav.lydia.ia.sak.domene.IASak.Companion.oppdaterSamarbeidPåFullførtSak
import no.nav.lydia.ia.sak.domene.IASak.Companion.tilbakeførSak
import no.nav.lydia.ia.sak.domene.IASak.Companion.utførHendelsePåSak
import no.nav.lydia.ia.sak.domene.IASakLeveranse
import no.nav.lydia.ia.sak.domene.IASakLeveranseStatus
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelse.Companion.nyHendelseBasertPåSak
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.ProsessHendelse
import no.nav.lydia.ia.sak.domene.VirksomhetIkkeAktuellHendelse
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.ia.sak.domene.prosess.IAProsess
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
import kotlin.Int
import kotlin.String

class IASakService(
    private val iaSakRepository: IASakRepository,
    private val iaSakshendelseRepository: IASakshendelseRepository,
    private val iaSakLeveranseRepository: IASakLeveranseRepository,
    private val årsakService: ÅrsakService,
    private val journalpostService: JournalpostService,
    private val iaProsessService: IAProsessService,
    private val iaSakObservers: List<Observer<IASak>>,
    private val iaSaksLeveranseObservers: List<Observer<IASakLeveranse>>,
    private val planRepository: PlanRepository,
    private val endringsObservers: List<EndringsObserver<IASak, IASakshendelse>>,
) {
    private val log: Logger = LoggerFactory.getLogger(this.javaClass)

    private fun IASakshendelse.lagre(
        sistEndretAvHendelseId: String?,
        resulterendeStatus: IAProsessStatus,
    ) = iaSakshendelseRepository.lagreHendelse(this, sistEndretAvHendelseId, resulterendeStatus)

    private fun IASak.lagre() = iaSakRepository.opprettSak(this).also(::varsleIASakObservers)

    private fun IASak.lagreOppdatering(sistEndretAvHendelseId: String?): Either<Feil, IASak> {
        if (this.status == IAProsessStatus.SLETTET) {
            return slettSak(this, sistEndretAvHendelseId).onRight(::varsleIASakObservers)
        }
        return iaSakRepository.oppdaterSak(this, sistEndretAvHendelseId).onRight(::varsleIASakObservers)
    }

    private fun varsleIASakObservers(sak: IASak) {
        iaSakObservers.forEach { observer -> observer.receive(sak) }
    }

    private fun varsleIASakLeveranseObservers(leveranse: IASakLeveranse) {
        iaSaksLeveranseObservers.forEach { observer -> observer.receive(leveranse) }
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
            IASakshendelse.nyFørsteHendelse(orgnummer = orgnummer, superbruker = superbruker, navEnhet = navEnhet)
                .lagre(null, IAProsessStatus.NY),
        ).lagre()
        val sistEndretAvHendelseId = sak.endretAvHendelseId

        return sak.nyHendelseBasertPåSak(
            hendelsestype = IASakshendelseType.VIRKSOMHET_VURDERES,
            superbruker = superbruker,
            navEnhet = navEnhet,
        ).lagre(null, IAProsessStatus.VURDERES)
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
        val aktiveSaker = iaSakRepository.hentSaker(hendelseDto.orgnummer).filter { !it.status.regnesSomAvsluttet() }
        if (aktiveSaker.isNotEmpty() && hendelseDto.saksnummer != aktiveSaker.first().saksnummer) {
            return Either.Left(IASakError.`det finnes flere saker på dette orgnummeret som ikke regnes som avsluttet`)
        }

        if (
            hendelseDto.hendelsesType == IASakshendelseType.FULLFØR_BISTAND ||
            hendelseDto.hendelsesType == IASakshendelseType.VIRKSOMHET_ER_IKKE_AKTUELL
        ) {
            val aktivSak = iaSakRepository.hentIASak(hendelseDto.saksnummer) ?: return IASakError.`generell feil under uthenting`.left()
            val alleAktiveSamarbeidPåSak = iaProsessService.hentAktiveIAProsesser(sak = aktivSak)
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
                val prosessDto = Json.decodeFromString<IAProsessDto>(hendelseDto.payload!!)
                val aktivSak = iaSakRepository.hentIASak(hendelseDto.saksnummer) ?: return IASakError.`generell feil under uthenting`.left()
                if (!iaProsessService.kanAvbryteSamarbeid(sak = aktivSak, samarbeidsId = prosessDto.id).kanGjennomføres) {
                    return IAProsessFeil.`kan ikke avbryte samarbeid`.left()
                }
            }

            IASakshendelseType.SLETT_PROSESS -> {
                val prosessDto = Json.decodeFromString<IAProsessDto>(hendelseDto.payload!!)
                val aktivSak = iaSakRepository.hentIASak(hendelseDto.saksnummer) ?: return IASakError.`generell feil under uthenting`.left()
                if (!iaProsessService.kanSletteProsess(sak = aktivSak, samarbeidsId = prosessDto.id).kanGjennomføres) {
                    return IAProsessFeil.`kan ikke slette samarbeid som inneholder behovsvurdering eller samarbeidsplan`.left()
                }
            }

            IASakshendelseType.FULLFØR_PROSESS -> {
                val prosessDto = Json.decodeFromString<IAProsessDto>(hendelseDto.payload!!)
                val aktivSak = iaSakRepository.hentIASak(hendelseDto.saksnummer) ?: return IASakError.`generell feil under uthenting`.left()
                if (!iaProsessService.kanFullføreProsess(sak = aktivSak, samarbeidsId = prosessDto.id).kanGjennomføres) {
                    return IAProsessFeil.`kan ikke fullføre samarbeid`.left()
                }
            }

            IASakshendelseType.ENDRE_PROSESS, IASakshendelseType.NY_PROSESS -> {
                val prosessDto = Json.decodeFromString<IAProsessDto>(hendelseDto.payload!!)
                val aktivSak = iaSakRepository.hentIASak(hendelseDto.saksnummer) ?: return IASakError.`generell feil under uthenting`.left()
                val alleProsesser = iaProsessService.hentIAProsesser(aktivSak)

                if (prosessDto.navn.trim().isEmpty() || prosessDto.navn.length > MAKS_ANTALL_TEGN_I_SAMARBEIDSNAVN) {
                    return IAProsessFeil.`ugyldig samarbeidsnavn`.left()
                }

                alleProsesser.getOrNull()
                    ?.find { it.navn.equals(prosessDto.navn, ignoreCase = true) }
                    ?.let { return IAProsessFeil.`samarbeidsnavn finnes allerede`.left() }
            }

            else -> {}
        }

        return IASakshendelse.fromDto(hendelseDto, saksbehandler, navEnhet)
            .flatMap { sakshendelse ->
                val hendelser = iaSakshendelseRepository.hentHendelserForSaksnummer(sakshendelse.saksnummer)
                if (hendelser.isEmpty()) {
                    return IASakError.`prøvde å legge til en hendelse på en tom sak`.left()
                }
                if (hendelser.last().id != hendelseDto.endretAvHendelseId) {
                    return IASakError.`prøvde å legge til en hendelse på en gammel sak`.left()
                }

                val sak = iaSakRepository.hentIASak(hendelseDto.saksnummer)
                    .medHendelser(hendelser) ?: return IASakError.`generell feil under uthenting`.left()
                val sistEndretAvHendelseId = sak.endretAvHendelseId

                val umodifisertIaSak = sak.kopier() // siden vi muterer state i utførhende -> behandleHendelse

                saksbehandler.utførHendelsePåSak(sak = sak, hendelse = sakshendelse)
                    .map { oppdatertSak ->
                        val nyStatus = oppdatertSak.status
                        sakshendelse.lagre(sistEndretAvHendelseId = sistEndretAvHendelseId, nyStatus)
                        årsakService.lagreÅrsak(sakshendelse)
                        iaProsessService.oppdaterSamarbeid(sakshendelse, sak)
                        when (sakshendelse.hendelsesType) {
                            IASakshendelseType.VIRKSOMHET_SKAL_BISTÅS -> journalpostService.journalfør(
                                sakshendelse,
                                saksbehandler,
                            )
                                .onLeft {
                                    log.error("Feil ved journalføring av hendelseid: '${sakshendelse.id}'. Feil: ${it.feilmelding}")
                                }

                            else -> {}
                        }
                        return oppdatertSak.lagreOppdatering(sistEndretAvHendelseId = sistEndretAvHendelseId)
                            .onRight { lagretSak -> endringsObservers.forEach { it.receive(umodifisertIaSak, sakshendelse, lagretSak) } }
                    }
                    .mapLeft { it.tilFeilMedHttpFeilkode() }
            }
    }

    fun hentAktivSak(
        orgnummer: String,
        navAnsatt: NavAnsatt,
    ) = hentSakerForOrgnummer(orgnummer)
        .sortedByDescending { it.opprettetTidspunkt }
        .toDto(navAnsatt = navAnsatt)
        .firstOrNull { !it.lukket }

    fun tilbakeførSaker(tørrKjør: Boolean) =
        iaSakRepository.hentUrørteSakerIVurderesUtenEier().map {
            val tilbakeføringsHendelse = it.nyTilbakeføringsHendelse()
            val sistEndretAvHendelseId = it.endretAvHendelseId
            val endretTidspunkt = it.endretTidspunkt
            if (!tørrKjør) {
                tilbakeføringsHendelse.lagre(sistEndretAvHendelseId = sistEndretAvHendelseId, IAProsessStatus.IKKE_AKTUELL)
                val oppdatertSak = tilbakeførSak(it, tilbakeføringsHendelse)
                årsakService.lagreÅrsak(tilbakeføringsHendelse)
                oppdatertSak.lagreOppdatering(sistEndretAvHendelseId = sistEndretAvHendelseId)
            }
            log.info(
                "${if (tørrKjør) "Skulle tilbakeføre" else "Tilbakeførte"} sak med saksnummer ${it.saksnummer}, sist oppdatert: $endretTidspunkt",
            )
        }.size

    private fun IASak.nyTilbakeføringsHendelse() =
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
            resulterendeStatus = IAProsessStatus.IKKE_AKTUELL,
        )

    fun fullførMaskineltSamarbeidIFulførteSaker(tørrKjør: Boolean) =
        iaSakRepository.hentFullførteSakerMedAktiveSamarbeid().map { iaSak ->
            val alleIkkeFullførteSamarbeidPåSak = iaProsessService.hentIAProsesser(iaSak).getOrElse { emptyList() }
                .filter { it.status != no.nav.lydia.ia.sak.domene.prosess.IAProsessStatus.FULLFØRT }

            if (alleIkkeFullførteSamarbeidPåSak.isNotEmpty()) {
                alleIkkeFullførteSamarbeidPåSak.forEach { iAProsess: IAProsess ->
                    val oppdatertSakMedSisteHendelse = iaSakRepository.hentIASak(iaSak.saksnummer)!!
                    val sistEndretAvHendelseId = oppdatertSakMedSisteHendelse.endretAvHendelseId
                    val endretTidspunkt = oppdatertSakMedSisteHendelse.endretTidspunkt

                    val maskineltOppdaterSamarbeidHendelse: ProsessHendelse = oppdatertSakMedSisteHendelse.nyMaskineltOppdaterSamarbeidHendelse(
                        iaProsessDto = iAProsess.tilDto(),
                        iASakshendelseType = IASakshendelseType.FULLFØR_PROSESS_MASKINELT_PÅ_EN_FULLFØRT_SAK,
                    )

                    if (!tørrKjør) {
                        maskineltOppdaterSamarbeidHendelse.lagre(
                            sistEndretAvHendelseId = sistEndretAvHendelseId,
                            IAProsessStatus.FULLFØRT,
                        )
                        iaProsessService.oppdaterSamarbeid(sakshendelse = maskineltOppdaterSamarbeidHendelse, sak = oppdatertSakMedSisteHendelse)
                        val oppdatertSak = oppdaterSamarbeidPåFullførtSak(oppdatertSakMedSisteHendelse, maskineltOppdaterSamarbeidHendelse)
                        oppdatertSak.lagreOppdatering(sistEndretAvHendelseId = sistEndretAvHendelseId)
                    }
                    log.info(
                        "${if (tørrKjør) "Skulle fullføre" else "Fullførte"} " +
                            "samarbeid med id ${iAProsess.id} og status ${iAProsess.status} på sak med saksnummer ${oppdatertSakMedSisteHendelse.saksnummer}, sist oppdatert: $endretTidspunkt",
                    )
                }
            }
            log.info(
                "${if (tørrKjør) "Skulle oppdatere" else "Oppdaterte"} " +
                    "${alleIkkeFullførteSamarbeidPåSak.size} samarbeid på sak med saksnummer ${iaSak.saksnummer}",
            )
        }.size.also { size ->
            log.info(
                "${if (tørrKjør) "Skulle oppdatere" else "Oppdaterte"} status til samarbeid i $size ${if (size > 1) "saker" else "sak"}",
            )
        }

    private fun IASak.nyMaskineltOppdaterSamarbeidHendelse(
        iaProsessDto: IAProsessDto,
        iASakshendelseType: IASakshendelseType,
    ) = ProsessHendelse(
        id = ULID.random(),
        opprettetTidspunkt = LocalDateTime.now(),
        saksnummer = this.saksnummer,
        orgnummer = this.orgnr,
        opprettetAv = "Fia system",
        opprettetAvRolle = Rolle.SUPERBRUKER,
        navEnhet = IASakStatusOppdaterer.NAV_ENHET_FOR_MASKINELT_OPPDATERING,
        hendelsesType = iASakshendelseType,
        resulterendeStatus = IAProsessStatus.FULLFØRT,
        prosessDto = iaProsessDto,
    )

    private fun slettSak(
        sak: IASak,
        sistEndretAvHendelseId: String?,
    ) = try {
        iaSakRepository.slettSak(sak.saksnummer, sistEndretAvHendelseId)
        Either.Right(sak)
    } catch (exception: Exception) {
        Either.Left(IASakError.`fikk ikke slettet sak`)
    }

    fun hentSakerForOrgnummer(orgnummer: String): List<IASak> = iaSakRepository.hentSaker(orgnummer)

    fun hentHendelserForOrgnummer(orgnr: String): List<IASakshendelse> = iaSakshendelseRepository.hentHendelserForOrgnummer(orgnr = orgnr)

    fun hentIASakLeveranser(saksnummer: String) =
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
                return Feil("Det finnes allerede en leveranse med denne modulen", HttpStatusCode.Conflict).left()
            }

            somEierAvSakIViBistår(saksnummer = leveranse.saksnummer, saksbehandler = saksbehandler) {
                iaSakLeveranseRepository.opprettIASakLeveranse(leveranse, saksbehandler)
                    .onRight(::varsleIASakLeveranseObservers)
            }
        } catch (e: Exception) {
            log.error("Noe gikk feil ved opprettelse av leveranse: ${e.message}", e)
            Feil("Feil ved opprettelse av leveranse", HttpStatusCode.InternalServerError).left()
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
                    .onRight { varsleIASakLeveranseObservers(iaSakLeveranse.slettet()) }
            }
        } catch (e: Exception) {
            log.error("Noe gikk feil ved letting av leveranse med id $iaSakLeveranseId: ${e.message}", e)
            Feil("Feil ved sletting av leveranse", HttpStatusCode.InternalServerError).left()
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
            Feil("Feil ved oppdatering av leveranse", HttpStatusCode.InternalServerError).left()
        }
    }

    fun hentTjenester() =
        try {
            iaSakLeveranseRepository.hentIATjenster().right()
        } catch (e: Exception) {
            log.error("Noe gikk feil ved henting av tjenester: ${e.message}", e)
            IASakError.`generell feil under uthenting`.left()
        }

    fun hentModuler() =
        try {
            iaSakLeveranseRepository.hentModuler().right()
        } catch (e: Exception) {
            log.error("Noe gikk feil ved henting av moduler: ${e.message}", e)
            IASakError.`generell feil under uthenting`.left()
        }

    fun hentIASak(saksnummer: String) = iaSakRepository.hentIASak(saksnummer = saksnummer)?.right() ?: IASakError.`ugyldig saksnummer`.left()

    private fun <T> somEierAvSak(
        saksnummer: String,
        saksbehandler: NavAnsattMedSaksbehandlerRolle,
        block: (IASak) -> Either<Feil, T>,
    ) = hentIASak(saksnummer = saksnummer)
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
    ) = somEierAvSak(saksnummer = saksnummer, saksbehandler = saksbehandler) { sak ->
        if (sak.status == IAProsessStatus.VI_BISTÅR) {
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
        val samarbeid = iaProsessService.hentIAProsesser(sak).getOrNull()
            ?: return IAProsessFeil.`feil ved henting av prosess`.left()

        samarbeid.forEach { prosess ->
            årsaker.addAll(sjekkBehovsvurderinger(prosess))
            sjekkPlan(prosess)?.let { årsaker.add(it) }
        }

        return SaksStatusDto(
            årsaker = årsaker.toList(),
        ).right()
    }

    private fun sjekkPlan(prosess: IAProsess): ÅrsakTilAtSakIkkeKanAvsluttes? {
        val plan = planRepository.hentPlan(prosessId = prosess.id) ?: return ÅrsakTilAtSakIkkeKanAvsluttes(
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

    private fun sjekkBehovsvurderinger(prosess: IAProsess): List<ÅrsakTilAtSakIkkeKanAvsluttes> {
        val årsaker = mutableListOf<ÅrsakTilAtSakIkkeKanAvsluttes>()
        val statusForBehovsvurderinger =
            iaSakRepository.hentStatusForBehovsvurderinger(prosess.id)
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
                        samarbeidsId = prosess.id,
                        samarbeidsNavn = prosess.navn,
                        id = it.first,
                        type = ÅrsaksType.BEHOVSVURDERING_IKKE_FULLFØRT,
                    ),
                )
            }
        }
        return årsaker
    }
}
