package no.nav.lydia.ia.sak

import no.nav.lydia.Observer
import no.nav.lydia.ia.eksport.SamarbeidKafkaEksporterer
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid

class SendSamarbeidPåKafkaObserver(
    val samarbeidKafkaEksporterer: SamarbeidKafkaEksporterer,
) : Observer<IASamarbeid> {
    override fun receive(input: IASamarbeid) {
        samarbeidKafkaEksporterer.hentOgSendSamarbeidTilKafka(input.id)
    }
}
