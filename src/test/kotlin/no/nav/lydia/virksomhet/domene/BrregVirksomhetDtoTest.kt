package no.nav.lydia.virksomhet.domene

import io.kotest.matchers.shouldBe
import no.nav.lydia.integrasjoner.brreg.Adresse
import no.nav.lydia.integrasjoner.brreg.BrregVirksomhetDto
import no.nav.lydia.integrasjoner.brreg.tilVirksomhet
import kotlin.test.Test

class BrregVirksomhetDtoTest {
    private val beliggenhetsadresse = Adresse(
        land = "Norge",
        landkode = "NO",
        postnummer = "9876",
        poststed = "Beliggenhet",
        adresse = listOf("Beliggenhet"),
        kommune = "Beliggenhet",
        kommunenummer = "3222",
    )
    private val postadresse = Adresse(
        land = "Norge",
        landkode = "NO",
        postnummer = "9876",
        poststed = "Post",
        adresse = listOf("Post"),
        kommune = "Post",
        kommunenummer = "3222",
    )

    @Test
    fun `skal få beliggenhetsadresse dersom den finnes`() {
        val dto = BrregVirksomhetDto(
            organisasjonsnummer = "123456789",
            oppstartsdato = null,
            navn = "Test",
            beliggenhetsadresse = beliggenhetsadresse,
            postadresse = postadresse,
            naeringskode1 = null,
            naeringskode2 = null,
            naeringskode3 = null,
        )
        val virksomhetDto = dto.tilVirksomhet(status = VirksomhetStatus.AKTIV, oppdateringsId = null)
        virksomhetDto.kommune shouldBe "Beliggenhet"
    }

    @Test
    fun `skal få postadresse dersom beliggenhetsadresse ikke finnes`() {
        val dto = BrregVirksomhetDto(
            organisasjonsnummer = "123456789",
            oppstartsdato = null,
            navn = "Test",
            beliggenhetsadresse = null,
            postadresse = postadresse,
            naeringskode1 = null,
            naeringskode2 = null,
            naeringskode3 = null,
        )
        val virksomhetDto = dto.tilVirksomhet(status = VirksomhetStatus.AKTIV, oppdateringsId = null)
        virksomhetDto.kommune shouldBe "Post"
    }
}
