package no.nav.lydia.ia.sak

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import no.nav.lydia.Observer
import no.nav.lydia.appstatus.Metrics
import no.nav.lydia.ia.grunnlag.GrunnlagService
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.IASakshendelseDto
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASak.Companion.utførHendelse
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelse.Companion.nyHendelseBasertPåSak
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_VURDERES
import no.nav.lydia.ia.årsak.ÅrsakService
import no.nav.lydia.tilgangskontroll.Rådgiver

class IASakService(
    private val iaSakRepository: IASakRepository,
    private val iaSakshendelseRepository: IASakshendelseRepository,
    private val grunnlagService: GrunnlagService,
    private val årsakService: ÅrsakService,
    private val iaSakshendelseObservers: MutableList<Observer<IASakshendelse>> = mutableListOf(),
    private val iaSakObservers: MutableList<Observer<IASak>> = mutableListOf(),
) {

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

    fun opprettSakOgMerkSomVurdert(orgnummer: String, navIdent: String): Either<Feil, IASak> {
        if (!iaSakRepository.hentSaker(orgnummer).all{ it.status.ansesSomAvsluttet() }) {
            return Either.Left(IASakError.`det finnes flere saker på dette orgnummeret som ikke anses som avsluttet`)
        }
        val sak = IASak.fraFørsteHendelse(
            IASakshendelse.nyFørsteHendelse(orgnummer = orgnummer, opprettetAv = navIdent).lagre()
        ).lagre()

        return sak.nyHendelseBasertPåSak(hendelsestype = VIRKSOMHET_VURDERES, opprettetAv = navIdent).lagre()
            .let(sak::behandleHendelse)
            .also(grunnlagService::lagreGrunnlag)
            .lagreOppdatering()
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
                rådgiver.utførHendelse(sak = sak, hendelse = sakshendelse)
                    .map { oppdatertSak ->
                        sakshendelse.lagre()
                        årsakService.lagreÅrsak(sakshendelse)
                        return oppdatertSak.lagreOppdatering()
                    }
                    .mapLeft {
                        return IASakError.`prøvde å utføre en ugyldig hendelse`.left()
                    }

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

}
