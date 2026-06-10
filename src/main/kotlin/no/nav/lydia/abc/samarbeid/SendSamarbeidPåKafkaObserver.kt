package no.nav.lydia.abc.samarbeid

import no.nav.lydia.Observer

class SendSamarbeidPåKafkaObserver(
    val samarbeidKafkaEksporterer: SamarbeidKafkaEksporterer,
) : Observer<IASamarbeid> {
    override fun receive(input: IASamarbeid) {
        samarbeidKafkaEksporterer.hentOgSendSamarbeidTilKafka(input.id)
    }
}
