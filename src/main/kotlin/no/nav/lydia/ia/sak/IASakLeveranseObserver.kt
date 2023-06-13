package no.nav.lydia.ia.sak

import no.nav.lydia.Observer
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.domene.IASakLeveranse

class IASakLeveranseObserver(val iaSakRepository: IASakRepository) : Observer<IASakLeveranse> {
    override fun receive(input: IASakLeveranse) {
        iaSakRepository.hentIASak(input.saksnummer)?.let { iaSak ->
            iaSakRepository.oppdaterSistEndret(iaSak)
        }
    }
}