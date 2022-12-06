package no.nav.lydia.sykefraversstatistikk.domene

import io.kotest.assertions.throwables.shouldThrow
import io.kotest.matchers.shouldBe
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.sykefraversstatistikk.api.geografi.Kommune
import no.nav.lydia.sykefraversstatistikk.getSisteTilgjengeligKvartal
import java.time.LocalDateTime.now
import kotlin.test.Test

class SykefraversstatistikkVirksomhetTest {

    companion object {
        val opprettet = now()
        val sykefravær_2021_1 = SykefraversstatistikkVirksomhet(
            virksomhetsnavn = "en virksomhet",
            kommune = Kommune("Oslo", "1234"),
            orgnr = "987654321",
            arstall = 2021,
            kvartal = 1,
            antallPersoner = 12.0,
            tapteDagsverk = 10.0,
            muligeDagsverk = 100.0,
            sykefraversprosent = 10.0,
            maskert = false,
            opprettet = opprettet,
            status = IAProsessStatus.FULLFØRT,
            eidAv = "Meg",
            sistEndret = null
        )
        val sykefravær_2021_2 = sykefravær_2021_1.copy(arstall = 2021, kvartal = 2)
        val sykefravær_2020_1 = sykefravær_2021_1.copy(arstall = 2020, kvartal = 1)
        val sykefravær_2022_2 = sykefravær_2021_1.copy(arstall = 2022, kvartal = 2)
        val sykefravær_2021_4 = sykefravær_2021_1.copy(arstall = 2021, kvartal = 4)
    }

    @Test
    fun `skal hente siste tilgjengelige kvartal fra en usortert liste av sykefraværsstatistikk`() {
        listOf(
            sykefravær_2021_1,
            sykefravær_2020_1,
            sykefravær_2021_4,
            sykefravær_2022_2,
            sykefravær_2021_2
        ).getSisteTilgjengeligKvartal() shouldBe sykefravær_2022_2
        listOf(sykefravær_2021_1).getSisteTilgjengeligKvartal() shouldBe sykefravær_2021_1
    }

    @Test
    fun `skal hente siste tilgjengelige kvartal fra en liste med bare én sykefraværsstatistikk`() {
        listOf(sykefravær_2021_1).getSisteTilgjengeligKvartal() shouldBe sykefravær_2021_1
    }

    @Test
    fun `kaster exception dersom liste av sykefraværsstatistikk er tom`() {
        shouldThrow<IndexOutOfBoundsException> { listOf<SykefraversstatistikkVirksomhet>().getSisteTilgjengeligKvartal() }
    }

}
