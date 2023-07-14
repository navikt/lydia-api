package no.nav.lydia.virksomhet

import no.nav.lydia.integrasjoner.salesforce.SalesforceClient
import no.nav.lydia.virksomhet.domene.Virksomhet

class VirksomhetService(
    val virksomhetRepository: VirksomhetRepository,
    val salesforceClient: SalesforceClient,
) {

    fun hentVirksomhet(orgnr: String) = virksomhetRepository.hentVirksomhet(orgnr)

    fun hentVirksomhetMedSalesforceUrl(orgnr: String): Virksomhet? {
        val virksomhet = hentVirksomhet(orgnr) ?: return null
        val url = salesforceClient.hentUrlTilSalesforce(virksomhet)
        return virksomhet.withSalesforceUrl(url)
    }

    fun finnVirksomheter(søkestreng: String): List<VirksomhetSøkeresultat> {
        if (søkestreng.isBlank() || søkestreng.length < 3)
            return emptyList()
        return virksomhetRepository.finnVirksomheter(søkestreng)
    }
}
