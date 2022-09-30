package no.nav.lydia.ia.sak

import arrow.core.Either
import no.nav.lydia.Observer
import no.nav.lydia.ia.grunnlag.GrunnlagService
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.IASakshendelseDto
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelse.Companion.nyHendelseBasertPåSak
import no.nav.lydia.ia.sak.domene.SaksHendelsestype.VIRKSOMHET_VURDERES
import no.nav.lydia.ia.årsak.ÅrsakService
import no.nav.lydia.sykefraversstatistikk.api.geografi.NavEnheter
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
        if (NavEnheter.enheterSomSkalSkjermes.contains(orgnummer)) {
            return Either.Left(IASakError.`Kan ikke oppdatere sak på NAV-kontor`)
        } else if (!iaSakRepository.hentSaker(orgnummer).all(IASak::ansesSomAvsluttet)) {
            return Either.Left(IASakError.`det finnes flere saker på dette orgnummeret som ikke anses som avsluttet`)
        }
        val sak = IASak.fraFørsteHendelse(
            IASakshendelse.nyFørsteHendelse(orgnummer = orgnummer, opprettetAv = navIdent).lagre()
        ).lagre()

        return sak.nyHendelseBasertPåSak(hendelsestype = VIRKSOMHET_VURDERES, opprettetAv = navIdent).lagre()
            .let { vurderHendelse -> sak.behandleHendelse(hendelse = vurderHendelse) }
            .also { sakEtterVurdering -> sakEtterVurdering.lagreGrunnlag(grunnlagService = grunnlagService) }
            .lagreOppdatering()
    }

    fun behandleHendelse(hendelseDto: IASakshendelseDto, rådgiver: Rådgiver): Either<Feil, IASak> {
        if (NavEnheter.enheterSomSkalSkjermes.contains(hendelseDto.orgnummer)) {
            return Either.Left(IASakError.`Kan ikke oppdatere sak på NAV-kontor`)
        }

        val aktiveSaker = iaSakRepository.hentSaker(hendelseDto.orgnummer).filter { !it.ansesSomAvsluttet() }
        if (aktiveSaker.isNotEmpty() && hendelseDto.saksnummer != aktiveSaker.first().saksnummer)
            return Either.Left(IASakError.`det finnes flere saker på dette orgnummeret som ikke anses som avsluttet`)

        return IASakshendelse.fromDto(hendelseDto, rådgiver.navIdent)
            .map { sakshendelse ->
                val hendelser = iaSakshendelseRepository.hentHendelserForSaksnummer(sakshendelse.saksnummer)
                if (hendelser.isEmpty()) return Either.Left(IASakError.`prøvde å legge til en hendelse på en tom sak`)
                if (hendelser.last().id != hendelseDto.endretAvHendelseId) return Either.Left(IASakError.`prøvde å legge til en hendelse på en gammel sak`)
                val sak = IASak.fraHendelser(hendelser)
                if (sak.kanUtføreHendelse(hendelse = sakshendelse, rådgiver = rådgiver))
                    sak.behandleHendelse(sakshendelse)
                else {
                    return Either.Left(IASakError.`prøvde å utføre en ugyldig hendelse`)
                }
                sakshendelse.lagre()
                årsakService.lagreÅrsak(sakshendelse)
                return sak.lagreOppdatering()
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
