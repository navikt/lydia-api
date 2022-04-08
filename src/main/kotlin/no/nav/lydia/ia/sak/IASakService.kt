package no.nav.lydia.ia.sak

import arrow.core.Either
import com.github.guepardoapps.kulid.ULID
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.IASakshendelseDto
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
import no.nav.lydia.ia.sak.domene.*
import java.time.LocalDateTime

class IASakService(
    private val iaSakRepository: IASakRepository,
    private val iaSakshendelseRepository: IASakshendelseRepository
) {

    fun opprettSak(orgnummer: String, navIdent: String): IASak {
        val id = ULID.random()
        val nySakshendelse = IASakshendelse(
            id = id,
            opprettetTidspunkt = LocalDateTime.now(),
            saksnummer = id,
            hendelsesType = SaksHendelsestype.OPPRETT_SAK_FOR_VIRKSOMHET,
            orgnummer = orgnummer,
            opprettetAv = navIdent,
        )
        iaSakshendelseRepository.lagreHendelse(nySakshendelse)
        val sak = IASak(
            saksnummer = nySakshendelse.saksnummer,
            orgnr = nySakshendelse.orgnummer,
            type = IASakstype.NAV_STOTTER, // TODO: dette burde ligger på hendelsen
            opprettet = nySakshendelse.opprettetTidspunkt,
            opprettetAv = nySakshendelse.opprettetAv,
            endret = null,
            endretAv = null,
            endretAvHendelseId = nySakshendelse.id,
            status = IAProsessStatus.NY
        )
        return iaSakRepository.lagreSak(sak)
    }

    fun behandleHendelse(hendelseDto: IASakshendelseDto, navIdent: String): Either<IASakError, IASak> {
        val sakshendelse = IASakshendelse.fromDto(hendelseDto, navIdent)
        val hendelser = iaSakshendelseRepository.hentHendelser(sakshendelse.saksnummer)
        if (hendelser.isEmpty()) return Either.Left(IASakError.PrøvdeÅLeggeTilHendelsePåTomSak)
        val sak = IASak.fraHendelser(hendelser).behandleHendelse(sakshendelse)
        iaSakshendelseRepository.lagreHendelse(sakshendelse)
        return iaSakRepository.oppdaterSak(sak)
    }

    fun hentSaker(orgnummer: String): List<IASak> = iaSakRepository.hentSaker(orgnummer)

    fun hentHendelserForSak(saksnummer: String): List<IASakshendelse> = iaSakshendelseRepository.hentHendelser(saksnummer)

}
