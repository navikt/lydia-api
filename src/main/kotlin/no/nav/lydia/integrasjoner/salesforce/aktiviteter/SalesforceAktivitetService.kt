package no.nav.lydia.integrasjoner.salesforce.aktiviteter

import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.PlanRepository
import no.nav.lydia.ia.sak.db.ProsessRepository
import org.slf4j.LoggerFactory

class SalesforceAktivitetService(
    val salesforceAktivitetRepository: SalesforceAktivitetRepository,
    val iaSakRepository: IASakRepository,
    val prosessRepository: ProsessRepository,
    val planRepository: PlanRepository,
) {
    private val logger = LoggerFactory.getLogger(this.javaClass.name)

    fun håndterAktivitet(aktivitetDto: SalesforceAktivitetDto) {
        val aktivitet = aktivitetDto.tilDomene()
        when (aktivitetDto.EventType__c) {
            "Created" -> {
                lagreAktivitet(aktivitet)
            }
            "Updated" -> {
                oppdaterAktivitet(aktivitet)
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

    private fun oppdaterAktivitet(aktivitet: SalesforceAktivitet) {
        val skalOppdateres = verifisertAktivitet(aktivitet)
        if (skalOppdateres) {
            logger.info("Oppdaterer aktivitet: $aktivitet")
            salesforceAktivitetRepository.oppdaterAktivitet(aktivitet)
        } else {
            logger.info("Oppdaterer IKKE aktivitet: $aktivitet")
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
        val samarbeid = aktivitet.samarbeidsId?.let { prosessRepository.hentProsess(aktivitet.saksnummer, it) }
        val plan = samarbeid?.let {
            planRepository.hentPlan(it.id)
        }
        if (plan?.id?.toString() != aktivitet.planId) {
            logger.warn("Plan '${aktivitet.planId}' for aktivitet '${aktivitet.id}' stemmer ikke med plan i samarbeid: ${aktivitet.samarbeidsId}")
            return false
        }

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
