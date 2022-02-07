package no.nav.lydia.virksomhet

import kotlinx.serialization.Serializable
import no.nav.lydia.virksomhet.brreg.Beliggenhetsadresse
import no.nav.lydia.virksomhet.brreg.VirksomhetDto

class VirksomhetService(private val virksomhetRepository: VirksomhetRepository) {
    fun hentVirksomheterFraFylkesnummer(fylkesnummmer: List<String>): VirksomheterDto {
        val virksomheter = virksomhetRepository.hentVirksomheterFraKommunenummer(fylkesnummmer)
        return VirksomheterDto(
            virksomheter = virksomheter
        )
    }

    val virksomheterDtoMock = VirksomheterDto(
        listOf(
            VirksomhetDto(
                "123456789",
                "123456789",
                Beliggenhetsadresse(
                    "Norge",
                    "0101",
                    "5050",
                    "Bergen",
                    "Brønnøy",
                    "1813"
                )
            )
        )
    )
}


@Serializable
data class VirksomheterDto(val virksomheter: List<VirksomhetDto>)