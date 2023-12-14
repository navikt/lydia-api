package no.nav.lydia.vedlikehold

import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.util.concurrent.atomic.AtomicBoolean

class IASakStatusOppdaterer() {
    companion object {
        val KJØRER_RYDDE_I_STILLELIGENDE_SAKER = AtomicBoolean(false)
    }

    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun ryddeIStilleligendeSaker() {
        val alleSaker = emptyList<String>()
        KJØRER_RYDDE_I_STILLELIGENDE_SAKER.set(true)
        log.info("Ferdig med å rydde opp i stilleligende saker. Ryddet opp i ${alleSaker.size} saker")
        KJØRER_RYDDE_I_STILLELIGENDE_SAKER.set(false)
    }
}
