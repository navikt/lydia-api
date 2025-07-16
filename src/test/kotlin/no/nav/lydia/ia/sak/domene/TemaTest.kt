package no.nav.lydia.ia.sak.domene

import io.kotest.matchers.collections.shouldContainInOrder
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.TemaInfo
import kotlin.test.Test

class TemaTest {
    @Test
    fun `skal kunne sortere temaer på 'rekkefølge'`() {
        val tema2 = TemaInfo(
            id = 2,
            navn = "tema 2",
            rekkefølge = 2,
            undertemaer = emptyList(),
        )
        val tema3 = TemaInfo(
            id = 3,
            rekkefølge = 1,
            navn = "tema 3",
            undertemaer = emptyList(),
        )

        listOf(tema2, tema3).sortedBy { it.rekkefølge }.shouldContainInOrder(listOf(tema3, tema2))
    }
}
