package no.nav.lydia.virksomhet

import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.integrasjoner.brreg.BrregOppdateringConsumer
import no.nav.lydia.integrasjoner.brreg.BrregOppdateringConsumer.BrregVirksomhetEndringstype.Fjernet
import no.nav.lydia.integrasjoner.brreg.BrregOppdateringConsumer.BrregVirksomhetEndringstype.Sletting
import no.nav.lydia.virksomhet.domene.Virksomhet
import org.slf4j.Logger
import org.slf4j.LoggerFactory

class VirksomhetService(
    val virksomhetRepository: VirksomhetRepository,
    val iaSakService: IASakService,
) {
    private val logger: Logger = LoggerFactory.getLogger(this::class.java)

    fun hentVirksomhet(orgnr: String): Virksomhet? = virksomhetRepository.hentVirksomhet(orgnr)

    fun finnVirksomheter(søkestreng: String): List<VirksomhetSøkeresultat> {
        if (søkestreng.isBlank() || søkestreng.length < 3) {
            return emptyList()
        }
        return virksomhetRepository.finnVirksomheter(søkestreng)
    }

    fun insertVirksomhet(virksomhetLagringDao: VirksomhetLagringDao) = virksomhetRepository.insertVirksomhet(virksomhetLagringDao)

    fun insertNæringsundergrupper(virksomhetLagringDao: VirksomhetLagringDao) = virksomhetRepository.insertNæringsundergrupper(virksomhetLagringDao)

    fun finnSlettedeVirksomheterMedAktivSak() = virksomhetRepository.finnSlettedeVirksomheterMedAktivSak()

    fun oppdaterStatusTilVirksomhetTilSlettetEllerFjernet(oppdateringVirksomhet: BrregOppdateringConsumer.OppdateringVirksomhet) {
        when (oppdateringVirksomhet.endringstype) {
            Sletting,
            Fjernet,
            -> {
                val avsluttedeStatuser = setOf(IASak.Status.FULLFØRT, IASak.Status.SLETTET, IASak.Status.IKKE_AKTUELL, IASak.Status.AVSLUTTET)

                iaSakService.hentIASakDtoerForOrgnummer(orgnummer = oppdateringVirksomhet.orgnummer)
                    .filterNot { it.status in avsluttedeStatuser }
                    .forEach {
                        logger.warn(
                            "Virksomhet med saksnummer '${it.saksnummer}' og saksstatus '${it.status}' har fått følgende endring '${oppdateringVirksomhet.endringstype}'",
                        )
                    }
                // TODO: bruk tilstandsmaskin og sett virksomhet til ny tilstand: VirksomhetIkkeTilgjengeligIBrreg (eller VirksomhetErSlettetIBrreg)
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
