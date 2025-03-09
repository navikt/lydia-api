package no.nav.lydia.ia.eksport

import no.nav.lydia.ia.sak.db.PlanRepository
import no.nav.lydia.ia.sak.domene.plan.Plan
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.util.concurrent.atomic.AtomicBoolean

class SamarbeidsplanBigqueryEksporterer(
    val samarbeidsplanBigqueryProdusent: SamarbeidsplanBigqueryProdusent,
    val planRepository: PlanRepository,
) {
    companion object {
        val KJØRER_STATISTIKK_EKSPORT = AtomicBoolean(false)
    }

    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun eksporter() {
        KJØRER_STATISTIKK_EKSPORT.set(true)

        val allePlaner: List<Plan> = planRepository.hentAllePlaner()
        log.info("Starter re-eksport av ${allePlaner.size} samarbeidsplaner")

        try {
            allePlaner.forEach { nåværendePlan -> samarbeidsplanBigqueryProdusent.reEksporter(plan = nåværendePlan) }
        } catch (e: Exception) {
            KJØRER_STATISTIKK_EKSPORT.set(false)
            log.error("Klarte ikke å kjøre eksport av samarbeidsplaner", e)
            throw e
        }
        log.info("Ferdig med re-eksport av ${allePlaner.size} samarbeidsplaner")
        KJØRER_STATISTIKK_EKSPORT.set(false)
    }
}
