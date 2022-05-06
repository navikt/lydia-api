package no.nav.lydia.ia.sak

import arrow.core.Either
import com.github.guepardoapps.kulid.ULID
import no.nav.lydia.ia.grunnlag.GrunnlagService
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.IASakshendelseDto
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakstype
import no.nav.lydia.ia.sak.domene.SaksHendelsestype
import no.nav.lydia.ia.årsak.ÅrsakService
import no.nav.lydia.sykefraversstatistikk.api.geografi.NavEnheter
import no.nav.lydia.tilgangskontroll.Rådgiver
import java.time.LocalDateTime

class IASakService(
    private val iaSakRepository: IASakRepository,
    private val iaSakshendelseRepository: IASakshendelseRepository,
    private val grunnlagService: GrunnlagService,
    private val årsakService : ÅrsakService
) {

    fun opprettSakOgMerkSomVurdert(orgnummer: String, navIdent: String): Either<Feil, IASak> {
        if (NavEnheter.enheterSomSkalSkjermes.contains(orgnummer)) {
            return Either.Left(IASakError.`Kan ikke oppdatere sak på NAV-kontor`)
        }
        val saksnummer = ULID.random()
        val nySakshendelse = iaSakshendelseRepository.lagreHendelse(IASakshendelse(
            id = saksnummer,
            opprettetTidspunkt = LocalDateTime.now(),
            saksnummer = saksnummer,
            hendelsesType = SaksHendelsestype.OPPRETT_SAK_FOR_VIRKSOMHET,
            orgnummer = orgnummer,
            opprettetAv = navIdent,
        ))

        val sak = IASak(
            saksnummer = nySakshendelse.saksnummer,
            orgnr = nySakshendelse.orgnummer,
            type = IASakstype.NAV_STOTTER, // TODO: dette burde ligger på hendelsen
            opprettetTidspunkt = nySakshendelse.opprettetTidspunkt,
            opprettetAv = nySakshendelse.opprettetAv,
            eidAv = null,
            endretTidspunkt = null,
            endretAv = null,
            endretAvHendelseId = nySakshendelse.id,
            status = IAProsessStatus.NY
        )
        val lagretSak = iaSakRepository.opprettSak(sak)

        val vurderHendelse = IASakshendelse(
            id = ULID.random(),
            opprettetTidspunkt = LocalDateTime.now(),
            saksnummer = saksnummer,
            hendelsesType = SaksHendelsestype.VIRKSOMHET_VURDERES,
            orgnummer = orgnummer,
            opprettetAv = navIdent
        )
        val sakEtterVurdering = lagretSak.behandleHendelse(
            iaSakshendelseRepository.lagreHendelse(vurderHendelse)
        )
        sakEtterVurdering.lagreGrunnlag(grunnlagService)
        return iaSakRepository.oppdaterSak(sakEtterVurdering)
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
                iaSakshendelseRepository.lagreHendelse(sakshendelse)
                årsakService.lagreÅrsak(sakshendelse)
                return iaSakRepository.oppdaterSak(sak)
            }
    }

    fun hentSaker(orgnummer: String): List<IASak> = iaSakRepository.hentSaker(orgnummer)

    fun hentHendelserForSak(saksnummer: String): List<IASakshendelse> = iaSakshendelseRepository.hentHendelser(saksnummer)

}
