package no.nav.lydia.virksomhet

import no.nav.lydia.virksomhet.brreg.Beliggenhetsadresse
import no.nav.lydia.virksomhet.brreg.VirksomhetDTO

class VirksomhetService(virksomhetRepository: VirksomhetRepository) {
    fun hentVirksomheterFraFylkesnummer(fylkesnummmer: List<String>): VirksomhetDTO {
        return VirksomhetDTO(
            "123456789",
            "123456789",
            Beliggenhetsadresse(
                "Norge",
                "0101",
                5050,
                "Bergen",
                "Brønnøy",
                "1813"
            ),
        )
    }
}