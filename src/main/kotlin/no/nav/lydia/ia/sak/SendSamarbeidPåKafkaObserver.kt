package no.nav.lydia.ia.sak

import no.nav.lydia.Observer
import no.nav.lydia.ia.eksport.SamarbeidKafkaEksporterer
import no.nav.lydia.ia.sak.domene.prosess.IAProsess

class SendSamarbeidPåKafkaObserver(
    val samarbeidKafkaEksporterer: SamarbeidKafkaEksporterer,
) : Observer<IAProsess> {
    override fun receive(input: IAProsess) {
        samarbeidKafkaEksporterer.hentOgSendSamarbeidTilKafka(input.id)
    }
}
