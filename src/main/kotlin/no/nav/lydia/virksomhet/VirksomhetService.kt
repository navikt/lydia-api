package no.nav.lydia.virksomhet

import kotlinx.serialization.Serializable
import no.nav.lydia.virksomhet.brreg.VirksomhetDto

class VirksomhetService(private val virksomhetRepository: VirksomhetRepository) {
    fun hentVirksomheterFraKommunenummer(kommunenummer: Collection<String>): VirksomheterDto {
        val virksomheter = virksomhetRepository.hentVirksomheterFraKommunenummer(kommunenummer)
        return VirksomheterDto(
            virksomheter = virksomheter
        )
    }
    fun hentAlleVirksomheter(): VirksomheterDto {
        val alleVirksomheter = virksomhetRepository.hentAlleVirksomheter()
        return VirksomheterDto(virksomheter = alleVirksomheter)
    }
}


@Serializable
data class VirksomheterDto(val virksomheter: List<VirksomhetDto>)