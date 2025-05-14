package no.nav.lydia.ia.eksport

import no.nav.lydia.ia.sak.db.ProsessRepository
import org.slf4j.Logger
import org.slf4j.LoggerFactory

const val SAMARBEID_ID_PREFIKS = "SAMARBEID_ID_"

class SamarbeidKafkaEksporterer(
    val prosessRepository: ProsessRepository,
    val samarbeidProdusent: SamarbeidProdusent,
) {
    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    companion object {
        fun String.parseSamarbeidId() = this.trim().removePrefix(SAMARBEID_ID_PREFIKS)
    }

    fun eksporterEnkeltSamarbeid(samarbeidIdAsString: String) {
        log.info("Starter eksport av enkelt samarbeid, med ID: '$samarbeidIdAsString'")

        samarbeidIdAsString.parseSamarbeidId().toIntOrNull()?.let { samarbeidId ->
            hentOgSendSamarbeidTilKafka(samarbeidId)
        } ?: log.warn("Eksport av enkelt samarbeid, med ID: '$samarbeidIdAsString' feilet. SamarbeidId er ikke gyldig")

        log.info("Ferdig med eksport av samarbeid med Id '$samarbeidIdAsString'")
    }

    fun eksporterAlleSamarbeid() {
        prosessRepository.hentAlleSamarbeidIVirksomhetDto().forEach { samarbeidIVirksomhetDto ->
            samarbeidProdusent.sendPåKafka(samarbeidIVirksomhetDto)
            log.info(
                "Eksport av enkelt samarbeid, med ID: '${samarbeidIVirksomhetDto.samarbeid.id}' for virksomhet '${samarbeidIVirksomhetDto.orgnr}' er sendt på Kafka",
            )
        }
        log.info("Ferdig med eksport av alle samarbeid. Totalt '${prosessRepository.hentAlleSamarbeidIVirksomhetDto().size}' samarbeid")
    }

    fun hentOgSendSamarbeidTilKafka(samarbeidId: Int) {
        prosessRepository.hentSamarbeidIVirksomhetDto(samarbeidId)?.let { samarbeidIVirksomhetDto ->
            samarbeidProdusent.sendPåKafka(samarbeidIVirksomhetDto)
            log.info("Eksport av enkelt samarbeid, med ID: '$samarbeidId' for virksomhet '${samarbeidIVirksomhetDto.orgnr}' har blitt sendt på Kafka")
        } ?: log.warn("Eksport av enkelt samarbeid, med ID: '$samarbeidId' feilet. Samarbeid ikke funnet")
    }
}
