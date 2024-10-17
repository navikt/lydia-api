package no.nav.lydia.ia.eksport

import java.util.concurrent.atomic.AtomicBoolean
import java.util.concurrent.atomic.AtomicInteger
import no.nav.lydia.ia.sak.db.PlanRepository
import org.slf4j.Logger
import org.slf4j.LoggerFactory

class SamarbeidsplanKafkaEksporterer(
    val samarbeidsplanProdusent: SamarbeidsplanProdusent,
    val planRepository: PlanRepository,
) {
    companion object {
        val KJØRER_SAMARBEIDSPLAN_KAFKA_EKSPORT = AtomicBoolean(false)
        val ANTALL_SAMARBEIDSPLAN_KAFKA_EKSPORT = AtomicInteger(0)
    }

    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun eksporter() {
        KJØRER_SAMARBEIDSPLAN_KAFKA_EKSPORT.set(true)

        val alleSamarbeidsplan: List<SamarbeidsplanKafkaMelding> = planRepository.hentAlleSamarbeidsplanKafkaMelding()
        log.info("Starter re-eksport av ${alleSamarbeidsplan.size} samarbeidsplan til Kafka")

        try {
            alleSamarbeidsplan.forEach { samarbeidsplan ->
                samarbeidsplanProdusent.sendPåKafka(samarbeidsplan)
                ANTALL_SAMARBEIDSPLAN_KAFKA_EKSPORT.incrementAndGet()
            }
        } catch (e: Exception) {
            KJØRER_SAMARBEIDSPLAN_KAFKA_EKSPORT.set(false)
            log.error(
                "Klarte ikke å kjøre eksport av samarbeid, feil på samarbeidsplan nr. ${ANTALL_SAMARBEIDSPLAN_KAFKA_EKSPORT.get()}",
                e
            )
        }
        log.info("Ferdig med re-eksport av ${ANTALL_SAMARBEIDSPLAN_KAFKA_EKSPORT.get()}/${alleSamarbeidsplan.size} samarbeidsplan")
        KJØRER_SAMARBEIDSPLAN_KAFKA_EKSPORT.set(false)
    }
}
