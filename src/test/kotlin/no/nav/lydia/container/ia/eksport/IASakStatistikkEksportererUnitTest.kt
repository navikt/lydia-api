package no.nav.lydia.container.ia.eksport

import ia.felles.definisjoner.bransjer.Bransjer
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.TestData.Companion.BOLIGBYGGELAG
import no.nav.lydia.ia.eksport.finnBransje
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import kotlin.test.Test

class IASakStatistikkEksportererUnitTest {
    private val næringsgruppeIkkeIBransjeprogram = Næringsgruppe("Denne næringen finnes ikke i et bransjeprogram", "99999")
    private val næringsgruppeBygg = BOLIGBYGGELAG
    @Test
    fun `skal finne riktig bransje fra næringskoder i bygg (2 siffet kode)`() {
        finnBransje(listOf(næringsgruppeBygg)) shouldBe Bransjer.BYGG
    }

    @Test
    fun `skal finne riktig bransje fra næringskoder i barnehage (5 siffret kode)`() {
        val næringskodeBarnehage = "${
            Bransjer.BARNEHAGER.næringskoder.first().take(2)
        }.${
            Bransjer.BARNEHAGER.næringskoder.first().takeLast(3)
        }"
        finnBransje(listOf(Næringsgruppe("Barn og sånt", næringskodeBarnehage))) shouldBe Bransjer.BARNEHAGER
    }

    @Test
    fun `skal ikke finne ukjent bransje fra næringskoder`() {
        finnBransje(listOf(næringsgruppeIkkeIBransjeprogram)) shouldBe null
    }

    @Test
    fun `skal kunne finne bransje basert på flere næringsgrupper`() {
        finnBransje(listOf(
            næringsgruppeIkkeIBransjeprogram,
            næringsgruppeBygg
        )) shouldBe Bransjer.BYGG
    }
}
