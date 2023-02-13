package no.nav.lydia.ia.sak

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import arrow.core.right
import io.ktor.http.*
import no.nav.lydia.Observer
import no.nav.lydia.appstatus.Metrics
import no.nav.lydia.ia.sak.api.*
import no.nav.lydia.ia.sak.api.Feil.Companion.tilFeilMedHttpFeilkode
import no.nav.lydia.ia.sak.db.IASakLeveranseRepository
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
import no.nav.lydia.ia.sak.domene.*
import no.nav.lydia.ia.sak.domene.IASak.Companion.utførHendelsePåSak
import no.nav.lydia.ia.sak.domene.IASakshendelse.Companion.nyHendelseBasertPåSak
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_VURDERES
import no.nav.lydia.ia.årsak.ÅrsakService
import no.nav.lydia.tilgangskontroll.Rådgiver
import org.slf4j.Logger
import org.slf4j.LoggerFactory

class IASakService(
    private val iaSakRepository: IASakRepository,
    private val iaSakshendelseRepository: IASakshendelseRepository,
    private val iaSakLeveranseRepository: IASakLeveranseRepository,
    private val årsakService: ÅrsakService,
    private val iaSakshendelseObservers: MutableList<Observer<IASakshendelse>> = mutableListOf(),
    private val iaSakObservers: MutableList<Observer<IASak>> = mutableListOf(),
) {
    private val log: Logger = LoggerFactory.getLogger(this.javaClass)

    private fun IASakshendelse.lagre() =
        iaSakshendelseRepository.lagreHendelse(this).also(::varsleIASakshendelseObservers)

    private fun IASak.lagre() =
        iaSakRepository.opprettSak(this).also(::varsleIASakObservers)

    private fun IASak.lagreOppdatering(): Either<Feil, IASak> {
        if (this.status == IAProsessStatus.SLETTET) {
            return slettSak(this).tap(::varsleIASakObservers)
        }
            return iaSakRepository.oppdaterSak(this).tap(::varsleIASakObservers)
    }

    fun leggTilIASakshendelseObserver(observer: Observer<IASakshendelse>) {
        iaSakshendelseObservers.add(observer)
    }

    private fun varsleIASakshendelseObservers(hendelse: IASakshendelse) {
        iaSakshendelseObservers.forEach { observer -> observer.receive(hendelse) }
    }

    fun leggTilIASakObserver(observer: Observer<IASak>) {
        iaSakObservers.add(observer)
    }

    private fun varsleIASakObservers(sak: IASak) {
        iaSakObservers.forEach { observer -> observer.receive(sak) }
    }

    fun opprettSakOgMerkSomVurdert(orgnummer: String, rådgiver: Rådgiver): Either<Feil, IASak> {
        if (!iaSakRepository.hentSaker(orgnummer).all{ it.status.ansesSomAvsluttet() }) {
            return Either.Left(IASakError.`det finnes flere saker på dette orgnummeret som ikke anses som avsluttet`)
        }
        val sak = IASak.fraFørsteHendelse(
            IASakshendelse.nyFørsteHendelse(orgnummer = orgnummer, opprettetAv = rådgiver.navIdent).lagre()
        ).lagre()

        return sak.nyHendelseBasertPåSak(hendelsestype = VIRKSOMHET_VURDERES, opprettetAv = rådgiver.navIdent).lagre()
            .let { vurderesHendelse -> rådgiver.utførHendelsePåSak(sak = sak, hendelse = vurderesHendelse) }
            .mapLeft { tilstandsmaskinFeil -> tilstandsmaskinFeil.tilFeilMedHttpFeilkode() }
            .flatMap { oppdatertSak ->
                oppdatertSak.lagreOppdatering()
            }
            .tap { Metrics.virksomheterPrioritert.inc() }

    }

    fun behandleHendelse(hendelseDto: IASakshendelseDto, rådgiver: Rådgiver): Either<Feil, IASak> {
        val aktiveSaker = iaSakRepository.hentSaker(hendelseDto.orgnummer).filter { !it.status.ansesSomAvsluttet() }
        if (aktiveSaker.isNotEmpty() && hendelseDto.saksnummer != aktiveSaker.first().saksnummer)
            return Either.Left(IASakError.`det finnes flere saker på dette orgnummeret som ikke anses som avsluttet`)

        return IASakshendelse.fromDto(hendelseDto, rådgiver.navIdent)
            .flatMap { sakshendelse ->
                val hendelser = iaSakshendelseRepository.hentHendelserForSaksnummer(sakshendelse.saksnummer)
                if (hendelser.isEmpty())
                    return IASakError.`prøvde å legge til en hendelse på en tom sak`.left()
                if (hendelser.last().id != hendelseDto.endretAvHendelseId)
                    return IASakError.`prøvde å legge til en hendelse på en gammel sak`.left()
                val sak = IASak.fraHendelser(hendelser)
                rådgiver.utførHendelsePåSak(sak = sak, hendelse = sakshendelse)
                    .map { oppdatertSak ->
                        sakshendelse.lagre()
                        årsakService.lagreÅrsak(sakshendelse)
                        return oppdatertSak.lagreOppdatering()
                    }
                    .mapLeft{ it.tilFeilMedHttpFeilkode() }

            }
    }

    private fun slettSak(sak: IASak) =
        try {
            iaSakRepository.slettSak(sak.saksnummer)
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

    fun opprettIASakLeveranse(leveranse: IASakLeveranseOpprettelsesDto, rådgiver: Rådgiver): Either<Feil, IASakLeveranse> {
        val sak = iaSakRepository.hentIASak(leveranse.saksnummer) ?: return IASakError.`ugyldig saksnummer`.left()
        if (sak.eidAv != rådgiver.navIdent)
            return IASakError.`ikke eier av sak`.left()
        if (sak.status != IAProsessStatus.VI_BISTÅR)
            return Feil(feilmelding = "Kan kun opprette leveranser på saker som er i 'Vi Bistår'", httpStatusCode = HttpStatusCode.Conflict).left()

        val moduler = iaSakLeveranseRepository.hentModuler()
        moduler.firstOrNull { it.id == leveranse.modulId } ?: return IASakError.`ugyldig modul`.left()

        return try {
            iaSakLeveranseRepository.opprettIASakLeveranse(leveranse, rådgiver)
        } catch (e: Exception) {
            log.error("Noe gikk feil ved opprettelse av leveranse: ${e.message}", e)
            IASakError.`generell feil under uthenting`.left()
        }
    }

    fun slettIASakLeveranse(iaSakLeveranseId: Int, rådgiver: Rådgiver): Either<Feil, Int> {
        val iaSakLeveranse = iaSakLeveranseRepository.hentIASakLeveranse(iaSakLeveranseId = iaSakLeveranseId)
            ?: return IASakError.`ugyldig iaSakLeveranseId`.left()
        val sak = iaSakRepository.hentIASak(iaSakLeveranse.saksnummer) ?: return IASakError.`ugyldig saksnummer`.left()
        if (sak.eidAv != rådgiver.navIdent)
            return IASakError.`ikke eier av sak`.left()
        if (sak.status != IAProsessStatus.VI_BISTÅR)
            return Feil(feilmelding = "Kan kun opprette leveranser på saker som er i 'Vi Bistår'", httpStatusCode = HttpStatusCode.Conflict).left()

        return try {
            iaSakLeveranseRepository.slettIASakLeveranse(iaSakLeveranseId = iaSakLeveranseId).right()
        } catch (e: Exception) {
            log.error("Noe gikk feil ved letting av leveranse med id $iaSakLeveranseId: ${e.message}", e)
            IASakError.`generell feil under uthenting`.left()
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

    fun oppdaterIASakLeveranse(iaSakLeveranseId: Int, oppdateringsDto: IASakLeveranseOppdateringsDto, rådgiver: Rådgiver): Either<Feil, IASakLeveranse> {
        val iaSakLeveranse = iaSakLeveranseRepository.hentIASakLeveranse(iaSakLeveranseId = iaSakLeveranseId)
            ?: return IASakError.`ugyldig iaSakLeveranseId`.left()
        val sak = iaSakRepository.hentIASak(iaSakLeveranse.saksnummer) ?: return IASakError.`ugyldig saksnummer`.left()
        if (sak.eidAv != rådgiver.navIdent)
            return IASakError.`ikke eier av sak`.left()
        if (sak.status != IAProsessStatus.VI_BISTÅR)
            return Feil(feilmelding = "Kan kun opprette leveranser på saker som er i 'Vi Bistår'", httpStatusCode = HttpStatusCode.Conflict).left()

        return try {
            iaSakLeveranseRepository.oppdaterIASakLeveranse(iaSakLeveranseId = iaSakLeveranseId, oppdateringsDto = oppdateringsDto)
        }  catch (e: Exception) {
            log.error("Noe gikk feil ved henting av moduler: ${e.message}", e)
            IASakError.`generell feil under uthenting`.left()
        }
    }
}
