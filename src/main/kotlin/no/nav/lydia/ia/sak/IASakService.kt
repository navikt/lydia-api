package no.nav.lydia.ia.sak

import arrow.core.Either
import no.nav.lydia.Observer
import no.nav.lydia.ia.grunnlag.GrunnlagService
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.IASakshendelseDto
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
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

    private fun lagreHendelse(hendelse: IASakshendelse): IASakshendelse {
        return iaSakshendelseRepository.lagreHendelse(hendelse).also(::varsleIASakshendelseObservers)
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
        } else if (iaSakRepository.hentSaker(orgnummer).isNotEmpty()) {
            return Either.Left(IASakError.`støtter ikke flere saker for en virksomhet ennå`)
        }
        val sak = lagreHendelse(IASakshendelse.nyFørsteHendelse(orgnummer = orgnummer, opprettetAv = navIdent))
            .let { førsteSakshendelse ->
                iaSakRepository.opprettSak(iaSak = IASak.fraFørsteHendelse(førsteSakshendelse))
            }

        return lagreHendelse(sak.nyHendelseBasertPåSak(hendelsestype = VIRKSOMHET_VURDERES, opprettetAv = navIdent))
            .let { vurderHendelse -> sak.behandleHendelse(hendelse = vurderHendelse) }
            .also { sakEtterVurdering -> sakEtterVurdering.lagreGrunnlag(grunnlagService = grunnlagService) }
            .let { sakEtterVurdering -> iaSakRepository.oppdaterSak(sakEtterVurdering) }
    }

    fun behandleHendelse(hendelseDto: IASakshendelseDto, rådgiver: Rådgiver): Either<Feil, IASak> {
        if (NavEnheter.enheterSomSkalSkjermes.contains(hendelseDto.orgnummer)) {
            return Either.Left(IASakError.`Kan ikke oppdatere sak på NAV-kontor`)
        }
        return IASakshendelse.fromDto(hendelseDto, rådgiver.navIdent)
            .map { sakshendelse ->
                val hendelser = iaSakshendelseRepository.hentHendelser(sakshendelse.saksnummer)
                if (hendelser.isEmpty()) return Either.Left(IASakError.`prøvde å legge til en hendelse på en tom sak`)
                if (hendelser.last().id != hendelseDto.endretAvHendelseId) return Either.Left(IASakError.`prøvde å legge til en hendelse på en gammel sak`)
                val sak = IASak.fraHendelser(hendelser)
                if (sak.kanUtføreHendelse(hendelse = sakshendelse, rådgiver = rådgiver))
                    sak.behandleHendelse(sakshendelse)
                else {
                    return Either.Left(IASakError.`prøvde å utføre en ugyldig hendelse`)
                }
                lagreHendelse(sakshendelse)
                årsakService.lagreÅrsak(sakshendelse)
                return iaSakRepository.oppdaterSak(sak)
            }
    }

    fun hentSaker(orgnummer: String): List<IASak> = iaSakRepository.hentSaker(orgnummer)

    fun hentHendelserForSak(saksnummer: String): List<IASakshendelse> =
        iaSakshendelseRepository.hentHendelser(saksnummer)

}
