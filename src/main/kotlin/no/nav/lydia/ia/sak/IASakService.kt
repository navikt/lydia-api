package no.nav.lydia.ia.sak

import no.nav.lydia.ia.sak.api.IASakshendelseDto
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakstype
import no.nav.lydia.ia.sak.domene.NyIASakshendelse

class IASakService(
    private val iaSakRepository: IASakRepository,
    private val iaSakshendelseRepository: IASakshendelseRepository
) {
    fun behandleHendelse(hendelseDto: IASakshendelseDto, navIdent: String): IASak {
        val sak = iaSakRepository.finnEllerOpprettSak(
            orgnr = hendelseDto.orgnummer,
            ident = navIdent,
            type = IASakstype.NAV_STOTTER
        )
        val sakshendelse = NyIASakshendelse.fromDto(hendelseDto, navIdent, sak.saksnummer)
        val lagretHendelse = iaSakshendelseRepository.opprettHendelse(sakshendelse)
        sak.behandleHendelse(lagretHendelse)
        iaSakRepository.oppdaterSak(sak = sak)
        return sak
    }
}