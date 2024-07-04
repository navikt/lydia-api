package no.nav.lydia.container.ia.eksport

import ia.felles.definisjoner.bransjer.Bransje
import ia.felles.definisjoner.bransjer.BransjeId
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.TestData.Companion.BOLIGBYGGELAG
import no.nav.lydia.ia.eksport.finnBransje
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import kotlin.test.Test
import no.nav.lydia.helper.TestData.Companion.BARNEHAGER
import no.nav.lydia.helper.TestData.Companion.NÆRING_BARNEHAGE

class IASakStatistikkEksportererUnitTest {
    private val næringsgruppeIkkeIBransjeprogram =
        Næringsgruppe("Denne næringen finnes ikke i et bransjeprogram", "99999")
    private val næringsgruppeBygg = BOLIGBYGGELAG

    @Test
    fun `skal finne riktig bransje fra næringskoder i bygg (2 siffet kode)`() {
        finnBransje(listOf(næringsgruppeBygg)) shouldBe Bransje.BYGG
    }

    @Test
    fun `skal finne riktig bransje fra næringskoder i barnehage (5 siffret kode)`() {
        val næringskodeBarnehage = "${
            (Bransje.BARNEHAGER.bransjeId as BransjeId.Næringskoder).næringskoder.first().take(2)
        }.${
            (Bransje.BARNEHAGER.bransjeId as BransjeId.Næringskoder).næringskoder.first().takeLast(3)
        }"
        finnBransje(listOf(Næringsgruppe("Barn og sånt", næringskodeBarnehage))) shouldBe Bransje.BARNEHAGER
    }

    @Test
    fun `skal ikke finne ukjent bransje fra næringskoder`() {
        finnBransje(listOf(næringsgruppeIkkeIBransjeprogram)) shouldBe null
    }

    @Test
    fun `skal kunne finne bransje basert på flere næringsgrupper`() {
        finnBransje(
            listOf(
                næringsgruppeIkkeIBransjeprogram,
                næringsgruppeBygg
            )
        ) shouldBe Bransje.BYGG

        finnBransje(
            listOf(
                BARNEHAGER,
                næringsgruppeBygg
            )
        ) shouldBe Bransje.BARNEHAGER

        finnBransje(
            listOf(
                NÆRING_BARNEHAGE,
                næringsgruppeBygg
            )
        ) shouldBe Bransje.BYGG

        finnBransje(
            listOf(
                næringsgruppeIkkeIBransjeprogram,
                Næringsgruppe("Denne næringen finnes ikke heller i et bransjeprogram", "99998")
            )
        ) shouldBe null

        finnBransje(emptyList()) shouldBe null
    }

    @Test
    fun `tar hensyn til rekkefølge i listen av næringsgrupper`() {
        finnBransje(
            listOf(
                BARNEHAGER,
                næringsgruppeBygg
            )
        ) shouldBe Bransje.BARNEHAGER

        finnBransje(
            listOf(
                næringsgruppeBygg,
                BARNEHAGER,
            )
        ) shouldBe Bransje.BYGG
    }
}
