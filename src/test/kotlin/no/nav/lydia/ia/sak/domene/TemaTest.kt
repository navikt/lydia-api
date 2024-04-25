package no.nav.lydia.ia.sak.domene

import io.kotest.matchers.collections.shouldContainInOrder
import java.time.LocalDateTime.now
import kotlin.test.Test
import kotlinx.datetime.toKotlinLocalDateTime
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.TemaInfo
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.TemaStatus
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Temanavn


class TemaTest {

    @Test
    fun `skal kunne sortere temaer på 'rekkefølge'`() {
        val tema2 = TemaInfo(
            2,
            2,
            Temanavn.UTVIKLE_PARTSSAMARBEID,
            "",
            "",
            TemaStatus.AKTIV,
            sistEndret = now().toKotlinLocalDateTime()
        )
        val tema3 = TemaInfo(
            3,
            1,
            Temanavn.REDUSERE_SYKEFRAVÆR,
            "",
            "",
            TemaStatus.AKTIV,
            sistEndret = now().toKotlinLocalDateTime()
        )

        listOf(tema2, tema3).sortedBy { it.rekkefølge }.shouldContainInOrder(listOf(tema3, tema2))
    }
}