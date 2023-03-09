package no.nav.lydia.container.ia.eksport

import ia.felles.definisjoner.bransjer.Bransjer
import io.kotest.matchers.shouldBe
import no.nav.lydia.ia.eksport.finnBransje
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import kotlin.test.Test

class IASakStatistikkEksportererUnitTest {
    @Test
    fun `skal finne riktig bransje fra næringskoder i bygg (2 siffet kode)`() {
        val næringskode = "${Bransjer.BYGG.næringskoder.first()}.123"
        finnBransje(listOf(Næringsgruppe("Bygg og sånt", næringskode))) shouldBe Bransjer.BYGG
    }

    @Test
    fun `skal finne riktig bransje fra næringskoder i barnehage (5 siffret kode)`() {
        val næringskode = "${
            Bransjer.BARNEHAGER.næringskoder.first().take(2)
        }.${
            Bransjer.BARNEHAGER.næringskoder.first().takeLast(3)
        }"
        finnBransje(listOf(Næringsgruppe("Bygg og sånt", næringskode))) shouldBe Bransjer.BARNEHAGER
    }

    @Test
    fun `skal ikke finne ukjent bransje fra næringskoder`() {
        finnBransje(listOf(Næringsgruppe("Bygg og sånt", "99999"))) shouldBe null
    }
}
