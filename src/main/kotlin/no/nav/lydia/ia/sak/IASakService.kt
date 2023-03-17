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
    private val iaSaksLeveranseObservers: MutableList<Observer<IASakLeveranse>> = mutableListOf(),
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

    fun leggTilIASakLeveranseObserver(observer: Observer<IASakLeveranse>) {
        iaSaksLeveranseObservers.add(observer)
    }
    private fun varsleIASakLeveranseObservers(leveranse: IASakLeveranse) {
        iaSaksLeveranseObservers.forEach { observer -> observer.receive(leveranse) }
    }

    fun opprettSakOgMerkSomVurdert(orgnummer: String, rådgiver: Rådgiver): Either<Feil, IASak> {
        if (!iaSakRepository.hentSaker(orgnummer).all{ it.status.ansesSomAvsluttet() }) {
            return Either.Left(IASakError.`det finnes flere saker på dette orgnummeret som ikke anses som avsluttet`)
        }
        val sak = IASak.fraFørsteHendelse(
            IASakshendelse.nyFørsteHendelse(orgnummer = orgnummer, rådgiver = rådgiver).lagre()
        ).lagre()

        return sak.nyHendelseBasertPåSak(hendelsestype = VIRKSOMHET_VURDERES, rådgiver = rådgiver).lagre()
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

        return IASakshendelse.fromDto(hendelseDto, rådgiver)
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
        return try {
            val moduler = iaSakLeveranseRepository.hentModuler()
            moduler.firstOrNull { it.id == leveranse.modulId } ?: return IASakError.`ugyldig modul`.left()

            val finnesFraFør = iaSakLeveranseRepository.hentIASakLeveranser(saksnummer = leveranse.saksnummer)
                .any { it.modul.id == leveranse.modulId }
            if (finnesFraFør)
                return Feil("Det finnes allerede en leveranse med denne modulen", HttpStatusCode.Conflict).left()

            somEierAvSakIViBistår(saksnummer = leveranse.saksnummer, rådgiver = rådgiver) {
                iaSakLeveranseRepository.opprettIASakLeveranse(leveranse, rådgiver)
                    .tap( ::varsleIASakLeveranseObservers)
            }
        } catch (e: Exception) {
            log.error("Noe gikk feil ved opprettelse av leveranse: ${e.message}", e)
            Feil("Feil ved opprettelse av leveranse", HttpStatusCode.InternalServerError).left()
        }
    }

    fun slettIASakLeveranse(iaSakLeveranseId: Int, rådgiver: Rådgiver): Either<Feil, Int> {
        return try {
            val iaSakLeveranse = iaSakLeveranseRepository.hentIASakLeveranse(iaSakLeveranseId = iaSakLeveranseId)
            val saksnummer = iaSakLeveranse?.saksnummer ?: return IASakError.`ugyldig iaSakLeveranseId`.left()
            somEierAvSakIViBistår(saksnummer = saksnummer, rådgiver = rådgiver) {
                iaSakLeveranseRepository.slettIASakLeveranse(iaSakLeveranseId = iaSakLeveranseId).right()
                    .tap{ varsleIASakLeveranseObservers(iaSakLeveranse.slettet()) }
            }
        } catch (e: Exception) {
            log.error("Noe gikk feil ved letting av leveranse med id $iaSakLeveranseId: ${e.message}", e)
            Feil("Feil ved sletting av leveranse", HttpStatusCode.InternalServerError).left()
        }
    }

    fun oppdaterIASakLeveranse(iaSakLeveranseId: Int, oppdateringsDto: IASakLeveranseOppdateringsDto, rådgiver: Rådgiver): Either<Feil, IASakLeveranse> {
        return try {
            val saksnummer = iaSakLeveranseRepository.hentIASakLeveranse(iaSakLeveranseId = iaSakLeveranseId)?.saksnummer
                ?: return IASakError.`ugyldig iaSakLeveranseId`.left()
            somEierAvSakIViBistår(saksnummer = saksnummer, rådgiver = rådgiver) {
                iaSakLeveranseRepository.oppdaterIASakLeveranse(iaSakLeveranseId = iaSakLeveranseId, oppdateringsDto = oppdateringsDto, rådgiver = rådgiver)
                    .tap(::varsleIASakLeveranseObservers)
            }
        }  catch (e: Exception) {
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

    private fun hentIASak(saksnummer: String) =
        iaSakRepository.hentIASak(saksnummer = saksnummer)?.right() ?: IASakError.`ugyldig saksnummer`.left()

    private fun <T> somEierAvSak(saksnummer: String, rådgiver: Rådgiver, block: (IASak) -> Either<Feil, T>) =
       hentIASak(saksnummer = saksnummer)
           .flatMap { sak ->
               if (sak.eidAv == rådgiver.navIdent) block(sak)
               else IASakError.`ikke eier av sak`.left()
           }

    private fun <T> somEierAvSakIViBistår(saksnummer: String, rådgiver: Rådgiver, block: (IASak) -> Either<Feil, T>) =
        somEierAvSak(saksnummer = saksnummer, rådgiver = rådgiver) { sak ->
            if (sak.status == IAProsessStatus.VI_BISTÅR) block(sak)
            else IASakError.`fikk ikke oppdatert sak`.left()
        }
}
