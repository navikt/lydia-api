package no.nav.lydia.integrasjoner.salesforce.aktiviteter

import no.nav.lydia.ia.sak.db.IASakRepository

class SalesforceAktivitetService(
    val salesforceAktivitetRepository: SalesforceAktivitetRepository,
    val iaSakRepository: IASakRepository,
) {
    fun lagreAktivitet(aktivitet: SalesforceAktivitet) {
//        salesforceAktivitetRepository.lagre(aktivitet.tilDbo())
    }
}
