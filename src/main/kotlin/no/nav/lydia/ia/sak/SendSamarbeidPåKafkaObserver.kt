package no.nav.lydia.ia.sak

import no.nav.lydia.Observer
import no.nav.lydia.ia.eksport.SamarbeidProdusent
import no.nav.lydia.ia.sak.db.ProsessRepository
import no.nav.lydia.ia.sak.domene.prosess.IAProsess

class SendSamarbeidPåKafkaObserver(
    val prosessRepository: ProsessRepository,
    val samarbeidProdusent: SamarbeidProdusent,
) : Observer<IAProsess> {
    override fun receive(input: IAProsess) {
        prosessRepository.hentSamarbeidIVirksomhetDto(input.id)?.let { samarbeidIVirksomhetDto ->
            samarbeidProdusent.sendPåKafka(samarbeidIVirksomhetDto)
        }
    }
}
