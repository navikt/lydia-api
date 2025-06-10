package no.nav.lydia.integrasjoner.salesforce.aktiviteter

import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.IASamarbeidRepository
import no.nav.lydia.ia.sak.db.PlanRepository
import org.slf4j.LoggerFactory

class SalesforceAktivitetService(
    private val salesforceAktivitetRepository: SalesforceAktivitetRepository,
    private val iaSakRepository: IASakRepository,
    private val samarbeidRepository: IASamarbeidRepository,
    val planRepository: PlanRepository,
) {
    private val logger = LoggerFactory.getLogger(this.javaClass.name)

    fun håndterAktivitet(aktivitetDto: SalesforceAktivitetDto) {
        val aktivitet = aktivitetDto.tilDomene()
        when (aktivitetDto.EventType__c) {
            "Created", "Updated" -> {
                lagreAktivitet(aktivitet)
            }
            "Deleted" -> {
                oppdaterSlettetStatus(aktivitet, slettet = true)
            }
            "Undeleted" -> {
                oppdaterSlettetStatus(aktivitet, slettet = false)
            }
            else -> {
                logger.warn("Mottok uventet EventType__c: ${aktivitetDto.EventType__c} for aktivitet: ${aktivitetDto.Id__c}")
            }
        }
    }

    private fun lagreAktivitet(aktivitet: SalesforceAktivitet) {
        val skalLagres = verifisertAktivitet(aktivitet)
        if (skalLagres) {
            logger.info("Lagrer aktivitet: $aktivitet")
            salesforceAktivitetRepository.lagreAktivitet(aktivitet)
        } else {
            logger.info("Lagrer IKKE aktivitet: $aktivitet")
        }
    }

    private fun verifisertAktivitet(aktivitet: SalesforceAktivitet): Boolean {
        val iaSak = iaSakRepository.hentIASak(aktivitet.saksnummer)
        val samarbeid = aktivitet.samarbeidsId?.let { samarbeidRepository.hentProsess(aktivitet.saksnummer, it) }
        return iaSak != null && samarbeid != null
    }

    private fun oppdaterSlettetStatus(
        aktivitet: SalesforceAktivitet,
        slettet: Boolean,
    ) {
        logger.info("${if (slettet) "Sletter" else "Gjenoppretter"} aktivitet $aktivitet")
        salesforceAktivitetRepository.oppdaterSlettetStatus(aktivitet, slettet)
    }
}
