package no.nav.lydia.ia.sak

import io.ktor.features.*
import no.nav.lydia.ia.sak.api.IASakshendelseDto
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakstype

class IASakService(
    private val iaSakRepository: IASakRepository,
) {

    fun behandleHendelse(hendelseDto: IASakshendelseDto, navIdent: String): IASak {
        val sak = hentIASakPåSaksnummer(hendelseDto.saksnummer) ?: throw NotFoundException("FIX ME") // TODO
        val sakshendelse = IASakshendelse.fromDto(hendelseDto, navIdent)
        try {
            sak.behandleHendelse(sakshendelse) // TODO: ikke modifiser in-place, men returner et nytt IASak-objekt
            iaSakRepository.opprettHendelseOgOppdaterSak(sakshendelse, hendelseDto.forrigeHendelsesId, sak)
        } catch (e : Exception) {
            // TODO: hva skjer hvis feil?
        }
        // TODO: hva returnerer vi hvis feil?
        return sak
    }

    fun opprettIASak(orgnummer: String, navIdent: String): IASak =
        iaSakRepository.opprettSak(
            orgnr = orgnummer,
            ident = navIdent,
            type = IASakstype.NAV_STOTTER
        )

    fun hentIASakPåOrgnummer(orgnummer: String) =
        iaSakRepository.hentIASakPåOrgnummer(orgnummer = orgnummer)
    private fun hentIASakPåSaksnummer(saksnummer: String) =
        iaSakRepository.hentIASakPåSaksnummer(saksnummer)

}