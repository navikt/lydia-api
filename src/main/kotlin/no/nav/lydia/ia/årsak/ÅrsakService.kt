package no.nav.lydia.ia.årsak

import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.VirksomhetIkkeAktuellHendelse
import no.nav.lydia.ia.årsak.db.ÅrsakRepository

class ÅrsakService(private val årsakRepository: ÅrsakRepository) {
    fun lagreÅrsak(sakshendelse : IASakshendelse) = when(sakshendelse){
        is VirksomhetIkkeAktuellHendelse -> årsakRepository.lagreÅrsakForHendelse(sakshendelse)
        else -> Unit
    }
}
