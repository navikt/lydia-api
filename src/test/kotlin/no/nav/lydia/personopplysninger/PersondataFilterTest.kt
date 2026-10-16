package no.nav.lydia.personopplysninger

import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldBeBlank
import io.kotest.matchers.string.shouldBeEmpty
import kotlin.test.Test

class PersondataFilterTest {
    @Test
    fun `skal erstatte e-postadresse`() {
        PersondataFilter.filtrerUtPersonsensitiveData("Send en e-post til test@eksempel.no.") shouldBe "Send en e-post til ."
    }

    @Test
    fun `skal fjerne tall med 5 eller flere sifre uten separator`() {
        PersondataFilter.filtrerUtPersonsensitiveData("Fødselsnummer: 12345678901.") shouldBe "Fødselsnummer: ."
    }

    @Test
    fun `skal fjerne tall med bindestrek`() {
        PersondataFilter.filtrerUtPersonsensitiveData("Kontakt oss på 123-45-678.") shouldBe "Kontakt oss på ."
    }

    @Test
    fun `skal fjerne tall med mellomrom`() {
        PersondataFilter.filtrerUtPersonsensitiveData("Kontakt oss på: 123 45 678.") shouldBe "Kontakt oss på: ."
    }

    @Test
    fun `skal ikke fjerne tall med færre enn 5 sifre`() {
        val input = "Prosjekt 55 er viktig."
        PersondataFilter.filtrerUtPersonsensitiveData(input) shouldBe input
    }

    @Test
    fun `skal fjerne både e-post og tall i samme streng`() {
        PersondataFilter.filtrerUtPersonsensitiveData("Kontakt meg på test@nav.no eller ring 98765432.") shouldBe
            "Kontakt meg på  eller ring ."
    }

    @Test
    fun `skal håndtere tekst uten sensitiv data`() {
        val input = "Dette er en helt vanlig tekst."
        PersondataFilter.filtrerUtPersonsensitiveData(input) shouldBe input
    }

    @Test
    fun `skal håndtere tom streng`() {
        PersondataFilter.filtrerUtPersonsensitiveData("").shouldBeEmpty()
    }

    @Test
    fun `skal fjerne tall selv om det er bokstaver rett etterpå`() {
        PersondataFilter.filtrerUtPersonsensitiveData("ID: 1234567A") shouldBe "ID: A"
    }

    @Test
    fun `skal fjerne tall på slutten av en streng`() {
        PersondataFilter.filtrerUtPersonsensitiveData("Ring meg på 12345678") shouldBe "Ring meg på "
    }

    @Test
    fun `skal fjerne tall med blanding av separatorer`() {
        PersondataFilter.filtrerUtPersonsensitiveData("Nummeret er 123 45-678.") shouldBe "Nummeret er ."
    }

    @Test
    fun `skal fjerne både tall og epost`() {
        PersondataFilter.filtrerUtPersonsensitiveData("test@nav.no 12356789").shouldBeBlank()
    }

    @Test
    fun `inneholderTall gir riktig svar`() {
        PersondataFilter.inneholderTall("12345") shouldBe true

        PersondataFilter.inneholderTall("") shouldBe false
        PersondataFilter.inneholderTall("  ") shouldBe false
        PersondataFilter.inneholderTall("12") shouldBe false
        PersondataFilter.inneholderTall("123") shouldBe false
        PersondataFilter.inneholderTall("1234") shouldBe false
        PersondataFilter.inneholderTall("test@nav.no") shouldBe false
    }

    @Test
    fun `inneholderEpost gir riktig svar`() {
        PersondataFilter.inneholderEpost("test@nav.no") shouldBe true

        PersondataFilter.inneholderEpost("123") shouldBe false
        PersondataFilter.inneholderEpost("") shouldBe false
    }
}
