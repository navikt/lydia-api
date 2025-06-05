package no.nav.lydia.vedlikehold

import no.nav.lydia.ia.sak.IASakService
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.util.concurrent.atomic.AtomicBoolean

class IASakSamarbeidOppdaterer(
    val iaSakService: IASakService,
) {
    companion object {
        val KJØRER_AVBRYTE_SAMARBEID_I_IKKE_AKTUELLE_IA_SAKER = AtomicBoolean(false)
    }

    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun avbryteSamarbeidForIkkeAktuelleIASaker(tørrKjør: Boolean = false) {
        KJØRER_AVBRYTE_SAMARBEID_I_IKKE_AKTUELLE_IA_SAKER.set(true)
        val antallSaker = iaSakService.avbrytMaskineltSamarbeidIIkkeAktuelleSaker(tørrKjør = tørrKjør)
        log.info(
            "Ferdig med å avbryte samarbeid i ikke aktuelle IA saker. Ryddet opp i $antallSaker ${if (antallSaker > 1) "saker" else "sak"}. " +
                "Tørr kjør: $tørrKjør",
        )
        KJØRER_AVBRYTE_SAMARBEID_I_IKKE_AKTUELLE_IA_SAKER.set(false)
    }
}
