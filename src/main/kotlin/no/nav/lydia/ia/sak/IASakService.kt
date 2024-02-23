package no.nav.lydia.ia.sak

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import arrow.core.right
import com.github.guepardoapps.kulid.ULID
import io.ktor.http.HttpStatusCode
import no.nav.lydia.Observer
import no.nav.lydia.appstatus.Metrics
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.Feil.Companion.tilFeilMedHttpFeilkode
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.IASakLeveranseOppdateringsDto
import no.nav.lydia.ia.sak.api.IASakLeveranseOpprettelsesDto
import no.nav.lydia.ia.sak.api.IASakshendelseDto
import no.nav.lydia.ia.sak.db.IASakLeveranseRepository
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASak.Companion.tilbakeførSak
import no.nav.lydia.ia.sak.domene.IASak.Companion.utførHendelsePåSak
import no.nav.lydia.ia.sak.domene.IASakLeveranse
import no.nav.lydia.ia.sak.domene.IASakLeveranseStatus
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelse.Companion.nyHendelseBasertPåSak
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_VURDERES
import no.nav.lydia.ia.sak.domene.VirksomhetIkkeAktuellHendelse
import no.nav.lydia.ia.årsak.domene.BegrunnelseType
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.ia.årsak.domene.ÅrsakType
import no.nav.lydia.ia.årsak.ÅrsakService
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.NavAnsatt.NavAnsattMedSaksbehandlerRolle
import no.nav.lydia.tilgangskontroll.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker
import no.nav.lydia.tilgangskontroll.Rolle
import no.nav.lydia.vedlikehold.IASakStatusOppdaterer
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.time.LocalDateTime

class IASakService(
    private val iaSakRepository: IASakRepository,
    private val iaSakshendelseRepository: IASakshendelseRepository,
    private val iaSakLeveranseRepository: IASakLeveranseRepository,
    private val årsakService: ÅrsakService,
    private val iaSakObservers: MutableList<Observer<IASak>> = mutableListOf(),
    private val iaSaksLeveranseObservers: MutableList<Observer<IASakLeveranse>> = mutableListOf(),
) {
    private val log: Logger = LoggerFactory.getLogger(this.javaClass)

    private fun IASakshendelse.lagre(sistEndretAvHendelseId: String?) =
        iaSakshendelseRepository.lagreHendelse(this, sistEndretAvHendelseId)

    private fun IASak.lagre() =
        iaSakRepository.opprettSak(this).also(::varsleIASakObservers)

    private fun IASak.lagreOppdatering(sistEndretAvHendelseId: String?): Either<Feil, IASak> {
        if (this.status == IAProsessStatus.SLETTET) {
            return slettSak(this, sistEndretAvHendelseId).onRight(::varsleIASakObservers)
        }
        return iaSakRepository.oppdaterSak(this, sistEndretAvHendelseId).onRight(::varsleIASakObservers)
    }

    fun leggTilIASakObservers(vararg observers: Observer<IASak>) {
        observers.forEach { observer ->
            iaSakObservers.add(observer)
        }
    }

    private fun varsleIASakObservers(sak: IASak) {
        iaSakObservers.forEach { observer -> observer.receive(sak) }
    }

    fun leggTilIASakLeveranseObservers(vararg observers: Observer<IASakLeveranse>) {
        observers.forEach { observer ->
            iaSaksLeveranseObservers.add(observer)
        }
    }

    private fun varsleIASakLeveranseObservers(leveranse: IASakLeveranse) {
        iaSaksLeveranseObservers.forEach { observer -> observer.receive(leveranse) }
    }

    fun opprettSakOgMerkSomVurdert(
        orgnummer: String,
        superbruker: Superbruker,
        navEnhet: NavEnhet
    ): Either<Feil, IASak> {
        if (!iaSakRepository.hentSaker(orgnummer).all { it.status.regnesSomAvsluttet() }) {
            return Either.Left(IASakError.`det finnes flere saker på dette orgnummeret som ikke regnes som avsluttet`)
        }
        val sak = IASak.fraFørsteHendelse(
            IASakshendelse.nyFørsteHendelse(orgnummer = orgnummer, superbruker = superbruker, navEnhet = navEnhet)
                .lagre(null)
        ).lagre()
        val sistEndretAvHendelseId = sak.endretAvHendelseId

        return sak.nyHendelseBasertPåSak(
            hendelsestype = VIRKSOMHET_VURDERES,
            superbruker = superbruker,
            navEnhet = navEnhet
        ).lagre(null)
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
        navEnhet: NavEnhet
    ): Either<Feil, IASak> {
        val aktiveSaker = iaSakRepository.hentSaker(hendelseDto.orgnummer).filter { !it.status.regnesSomAvsluttet() }
        if (aktiveSaker.isNotEmpty() && hendelseDto.saksnummer != aktiveSaker.first().saksnummer)
            return Either.Left(IASakError.`det finnes flere saker på dette orgnummeret som ikke regnes som avsluttet`)
        val sistEndretAvHendelseId = aktiveSaker.firstOrNull()?.endretAvHendelseId

        val alleLeveranserPåEnSak = iaSakLeveranseRepository.hentIASakLeveranser(saksnummer = hendelseDto.saksnummer)
        val aktiveLeveranserPåEnSak = alleLeveranserPåEnSak.filter { it.status == IASakLeveranseStatus.UNDER_ARBEID }

        if (hendelseDto.hendelsesType == IASakshendelseType.FULLFØR_BISTAND && aktiveLeveranserPåEnSak.isNotEmpty())
            return IASakError.`kan ikke fullføre med gjenstående leveranser`.left()

        if (hendelseDto.hendelsesType == IASakshendelseType.FULLFØR_BISTAND && alleLeveranserPåEnSak.isEmpty())
            return IASakError.`kan ikke fullføre da ingen leveranser står på saken`.left()

        return IASakshendelse.fromDto(hendelseDto, saksbehandler, navEnhet)
            .flatMap { sakshendelse ->
                val hendelser = iaSakshendelseRepository.hentHendelserForSaksnummer(sakshendelse.saksnummer)
                if (hendelser.isEmpty())
                    return IASakError.`prøvde å legge til en hendelse på en tom sak`.left()
                if (hendelser.last().id != hendelseDto.endretAvHendelseId)
                    return IASakError.`prøvde å legge til en hendelse på en gammel sak`.left()
                val sak = IASak.fraHendelser(hendelser)
                saksbehandler.utførHendelsePåSak(sak = sak, hendelse = sakshendelse)
                    .map { oppdatertSak ->
                        sakshendelse.lagre(sistEndretAvHendelseId = sistEndretAvHendelseId)
                        årsakService.lagreÅrsak(sakshendelse)
                        return oppdatertSak.lagreOppdatering(sistEndretAvHendelseId = sistEndretAvHendelseId)
                    }
                    .mapLeft { it.tilFeilMedHttpFeilkode() }
            }
    }

    fun tilbakeførSaker(tørrKjør: Boolean) =
        iaSakRepository.hentUrørteSakerIVurderesUtenEier().map {
            val tilbakeføringsHendelse = it.nyTilbakeføringsHendelse()
            val sistEndretAvHendelseId = it.endretAvHendelseId
            val endretTidspunkt = it.endretTidspunkt
            if (!tørrKjør) {
                tilbakeføringsHendelse.lagre(sistEndretAvHendelseId = sistEndretAvHendelseId)
                val oppdatertSak = tilbakeførSak(it, tilbakeføringsHendelse)
                årsakService.lagreÅrsak(tilbakeføringsHendelse)
                oppdatertSak.lagreOppdatering(sistEndretAvHendelseId = sistEndretAvHendelseId)
            }
            log.info("${if (tørrKjør) "Skulle tilbakeføre" else "Tilbakeførte"} sak med saksnummer ${it.saksnummer}, sist oppdatert: $endretTidspunkt")
        }.size

    private fun IASak.nyTilbakeføringsHendelse() =
        VirksomhetIkkeAktuellHendelse(
            id = ULID.random(),
            opprettetTidspunkt = LocalDateTime.now(),
            saksnummer = this.saksnummer,
            orgnummer = this.orgnr,
            opprettetAv = "Fia system",
            opprettetAvRolle = Rolle.SUPERBRUKER,
            navEnhet = IASakStatusOppdaterer.NAV_ENHET_FOR_TILBAKEFØRING,
            valgtÅrsak = ValgtÅrsak(
                type = ÅrsakType.NAV_IGANGSETTER_IKKE_TILTAK,
                begrunnelser = listOf(BegrunnelseType.AUTOMATISK_LUKKET)
            )
        )

    private fun slettSak(sak: IASak, sistEndretAvHendelseId: String?) =
        try {
            iaSakRepository.slettSak(sak.saksnummer, sistEndretAvHendelseId)
            Either.Right(sak)
        } catch (exception: Exception) {
            Either.Left(IASakError.`fikk ikke slettet sak`)
        }

    fun hentSakerForOrgnummer(orgnummer: String): List<IASak> = iaSakRepository.hentSaker(orgnummer)

    fun hentHendelserForOrgnummer(orgnr: String): List<IASakshendelse> =
        iaSakshendelseRepository.hentHendelserForOrgnummer(orgnr = orgnr)

    fun hentIASakLeveranser(saksnummer: String) =
        try {
            iaSakLeveranseRepository.hentIASakLeveranser(saksnummer = saksnummer).right()
        } catch (e: Exception) {
            log.error("Noe gikk feil ved uthenting av leveranser: ${e.message}", e)
            IASakError.`generell feil under uthenting`.left()
        }

    fun opprettIASakLeveranse(
        leveranse: IASakLeveranseOpprettelsesDto,
        saksbehandler: NavAnsattMedSaksbehandlerRolle
    ): Either<Feil, IASakLeveranse> {
        return try {
            val moduler = iaSakLeveranseRepository.hentModuler()
            moduler.firstOrNull { it.id == leveranse.modulId } ?: return IASakError.`ugyldig modul`.left()

            val finnesFraFør = iaSakLeveranseRepository.hentIASakLeveranser(saksnummer = leveranse.saksnummer)
                .any { it.modul.id == leveranse.modulId }
            if (finnesFraFør)
                return Feil("Det finnes allerede en leveranse med denne modulen", HttpStatusCode.Conflict).left()

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
        saksbehandler: NavAnsattMedSaksbehandlerRolle
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
        saksbehandler: NavAnsattMedSaksbehandlerRolle
    ): Either<Feil, IASakLeveranse> {
        return try {
            val saksnummer =
                iaSakLeveranseRepository.hentIASakLeveranse(iaSakLeveranseId = iaSakLeveranseId)?.saksnummer
                    ?: return IASakError.`ugyldig iaSakLeveranseId`.left()
            somEierAvSakIViBistår(saksnummer = saksnummer, saksbehandler = saksbehandler) {
                iaSakLeveranseRepository.oppdaterIASakLeveranse(
                    iaSakLeveranseId = iaSakLeveranseId,
                    oppdateringsDto = oppdateringsDto,
                    saksbehandler = saksbehandler
                )
                    .onRight(::varsleIASakLeveranseObservers)
            }
        } catch (e: Exception) {
            log.error("Noe gikk feil ved oppdatering av IASakLeveranse: ${e.message}", e)
            Feil("Feil ved oppdatering av leveranse", HttpStatusCode.InternalServerError).left()
        }
    }

    fun hentTjenester() = try {
        iaSakLeveranseRepository.hentIATjenster().right()
    } catch (e: Exception) {
        log.error("Noe gikk feil ved henting av tjenester: ${e.message}", e)
        IASakError.`generell feil under uthenting`.left()
    }

    fun hentModuler() = try {
        iaSakLeveranseRepository.hentModuler().right()
    } catch (e: Exception) {
        log.error("Noe gikk feil ved henting av moduler: ${e.message}", e)
        IASakError.`generell feil under uthenting`.left()
    }

    fun hentIASak(saksnummer: String) =
        iaSakRepository.hentIASak(saksnummer = saksnummer)?.right() ?: IASakError.`ugyldig saksnummer`.left()

    fun <T> somEierAvSak(
        saksnummer: String,
        saksbehandler: NavAnsattMedSaksbehandlerRolle,
        block: (IASak) -> Either<Feil, T>
    ) =
        hentIASak(saksnummer = saksnummer)
            .flatMap { sak ->
                if (sak.eidAv == saksbehandler.navIdent) block(sak)
                else IASakError.`ikke eier av sak`.left()
            }

    private fun <T> somEierAvSakIViBistår(
        saksnummer: String,
        saksbehandler: NavAnsattMedSaksbehandlerRolle,
        block: (IASak) -> Either<Feil, T>
    ) =
        somEierAvSak(saksnummer = saksnummer, saksbehandler = saksbehandler) { sak ->
            if (sak.status == IAProsessStatus.VI_BISTÅR) block(sak)
            else IASakError.`fikk ikke oppdatert leveranse`.left()
        }
}
