package no.nav.lydia.virksomhet.domene

import ia.felles.definisjoner.bransjer.Bransje
import io.kotest.matchers.shouldBe
import no.nav.lydia.virksomhet.domene.Næringsgruppe.Companion.UOPPGITT
import kotlin.test.Test

class NæringsgruppeTest {
    @Test
    fun `utledder bransje ut i fra næringsundergruppe`() {
        Næringsgruppe(navn = "Kanskje Barnehager", kode = "85100").tilBransje() shouldBe Bransje.BARNEHAGER
        Næringsgruppe(navn = "Kanskje Sykehus", kode = "86105").tilBransje() shouldBe Bransje.SYKEHUS
        Næringsgruppe(navn = "Ukjent", kode = "99999").tilBransje() shouldBe null
        UOPPGITT.tilBransje() shouldBe null
    }

    @Test
    fun `utledder bransje ut i fra næringskode`() {
        Næringsgruppe(navn = "Kanskje Bygg", kode = "41").tilBransje() shouldBe Bransje.BYGG
        Næringsgruppe(
            navn = "Kanskje Næringsmiddelindustri",
            kode = "10",
        ).tilBransje() shouldBe Bransje.NÆRINGSMIDDELINDUSTRI
        Næringsgruppe(navn = "Ukjent", kode = "00").tilBransje() shouldBe null
    }

    @Test
    fun `takler koder med eller uten punktum`() {
        Næringsgruppe(navn = "Kanskje Barnehager", kode = "85.100").tilBransje() shouldBe Bransje.BARNEHAGER
        Næringsgruppe(navn = "Kanskje Sykehus", kode = "86.105").tilBransje() shouldBe Bransje.SYKEHUS
        Næringsgruppe(navn = "Ukjent", kode = "99.999").tilBransje() shouldBe null
    }
}
