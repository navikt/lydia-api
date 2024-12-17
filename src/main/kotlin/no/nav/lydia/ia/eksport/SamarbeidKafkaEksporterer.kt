package no.nav.lydia.ia.eksport

import no.nav.lydia.ia.sak.db.ProsessRepository
import org.slf4j.Logger
import org.slf4j.LoggerFactory

class SamarbeidKafkaEksporterer(
    val prosessRepository: ProsessRepository,
    val samarbeidProdusent: SamarbeidProdusent,
) {
    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun eksporterEnkeltSamarbeid(samarbeidIdAsString: String) {
        log.info("Starter eksport av enkelt samarbeid, med ID: '$samarbeidIdAsString'")

        samarbeidIdAsString.toIntOrNull()?.let { samarbeidId ->
            hentOgSendSamarbeidTilKafka(samarbeidId)
        } ?: log.warn("Eksport av enkelt samarbeid, med ID: '$samarbeidIdAsString' feilet. SamarbeidId er ikke gyldig")

        log.info("Ferdig med eksport av samarbeid med Id '$samarbeidIdAsString'")
    }

    fun hentOgSendSamarbeidTilKafka(samarbeidId: Int) {
        prosessRepository.hentSamarbeidIVirksomhetDto(samarbeidId)?.let { samarbeidIVirksomhetDto ->
            samarbeidProdusent.sendPåKafka(samarbeidIVirksomhetDto)
            log.info("Eksport av enkelt samarbeid, med ID: '$samarbeidId' for virksomhet '${samarbeidIVirksomhetDto.orgnr}' er sendt på Kafka")
        } ?: log.warn("Eksport av enkelt samarbeid, med ID: '$samarbeidId' feilet. Samarbeid ikke funnet")
    }
}
