package no.nav.lydia.virksomhet

import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.integrasjoner.brreg.BrregOppdateringConsumer
import no.nav.lydia.integrasjoner.brreg.BrregOppdateringConsumer.BrregVirksomhetEndringstype.Fjernet
import no.nav.lydia.integrasjoner.brreg.BrregOppdateringConsumer.BrregVirksomhetEndringstype.Sletting
import no.nav.lydia.virksomhet.domene.Virksomhet

class VirksomhetService(
    val virksomhetRepository: VirksomhetRepository,
    val iaSakService: IASakService,
) {
    fun hentVirksomhet(orgnr: String): Virksomhet? = virksomhetRepository.hentVirksomhet(orgnr)

    fun finnVirksomheter(søkestreng: String): List<VirksomhetSøkeresultat> {
        if (søkestreng.isBlank() || søkestreng.length < 3) {
            return emptyList()
        }
        return virksomhetRepository.finnVirksomheter(søkestreng)
    }

    fun insertVirksomhet(virksomhetLagringDao: VirksomhetLagringDao) = virksomhetRepository.insertVirksomhet(virksomhetLagringDao)

    fun insertNæringsundergrupper(virksomhetLagringDao: VirksomhetLagringDao) = virksomhetRepository.insertNæringsundergrupper(virksomhetLagringDao)

    fun slettEllerFjernVirksomhet(oppdateringVirksomhet: BrregOppdateringConsumer.OppdateringVirksomhet) {
        when (oppdateringVirksomhet.endringstype) {
            Sletting,
            Fjernet,
            -> {
                val virksomhet = hentVirksomhet(oppdateringVirksomhet.orgnummer) ?: return
                iaSakService.hentAktivSak(orgnummer = virksomhet.orgnr)?.let {
                    if (it.status != IASak.Status.FULLFØRT && it.status != IASak.Status.IKKE_AKTUELL) {
                        iaSakService.avsluttSakForSlettetVirksomhet(it)
                    }
                }
                virksomhetRepository.oppdaterStatus(
                    orgnr = oppdateringVirksomhet.orgnummer,
                    status = oppdateringVirksomhet.endringstype.tilStatus(),
                    oppdatertAvBrregOppdateringsId = oppdateringVirksomhet.oppdateringsid,
                )
            }

            else -> {}
        }
    }
}
