package no.nav.lydia.ia.sak.domene

import io.kotest.matchers.collections.shouldContainInOrder
import kotlinx.datetime.toKotlinLocalDateTime
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.TemaInfo
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.TemaStatus.AKTIV
import java.time.LocalDateTime.now
import kotlin.test.Test

class TemaTest {
    @Test
    fun `skal kunne sortere temaer på 'rekkefølge'`() {
        val tema2 = TemaInfo(
            id = 2,
            navn = "tema 2",
            status = AKTIV,
            rekkefølge = 2,
            sistEndret = now().toKotlinLocalDateTime(),
            undertemaer = emptyList(),
        )
        val tema3 = TemaInfo(
            id = 3,
            rekkefølge = 1,
            navn = "tema 3",
            status = AKTIV,
            sistEndret = now().toKotlinLocalDateTime(),
            undertemaer = emptyList(),
        )

        listOf(tema2, tema3).sortedBy { it.rekkefølge }.shouldContainInOrder(listOf(tema3, tema2))
    }
}
