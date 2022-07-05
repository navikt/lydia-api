package no.nav.lydia.virksomhet

class VirksomhetService(val virksomhetRepository: VirksomhetRepository) {
    fun hentVirksomhet(orgnr: String) = virksomhetRepository.hentVirksomhet(orgnr)
    fun finnVirksomheter(søkestreng: String): List<Any> {
        if (søkestreng.isBlank() || søkestreng.length < 3)
            return emptyList()
        return virksomhetRepository.finnVirksomheter(søkestreng)
    }
}