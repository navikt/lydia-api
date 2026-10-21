package no.nav.lydia.ki

import io.kotest.assertions.withClue
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldNotStartWith
import kotlin.test.Test

//TODO:Gjennomgang av tester må fremdeles skje
class PersonvernPromptTest {
    @Test
    fun `hash skal stemme med gjeldende prompt`() {
        withClue(
            "Prompten er endret uten at HASH er oppdatert. Kjør main() i PersonvernPrompt.kt, " +
                "øk VERSJONSNUMMER, oppdater tidsstempel og sett HASH til '${PersonvernPrompt.nyHash()}'.",
        ) {
            PersonvernPrompt.nyHash() shouldBe PersonvernPrompt.HASH
        }
    }

    @Test
    fun `systemmelding skal være normalisert uten innrykk`() {
        val systemMelding = PersonvernPrompt.systemMelding()

        systemMelding shouldBe systemMelding.trim()
        systemMelding.lines().forEach { it shouldNotStartWith " " }
    }
}
