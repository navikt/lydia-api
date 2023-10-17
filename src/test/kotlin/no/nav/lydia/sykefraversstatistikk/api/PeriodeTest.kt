package no.nav.lydia.sykefraversstatistikk.api

import arrow.core.getOrElse
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.TestData.Companion.lagPerioder
import kotlin.test.Test


class PeriodeTest {

    @Test
    fun `returnerer gjeldende periode når input parametre er tomme`() {
        val gjeldendePeriode = Periode(4, 2022)
        Periode.tilValidertPeriode("", "", gjeldendePeriode).getOrElse { } shouldBe gjeldendePeriode
        Periode.tilValidertPeriode(null, null, gjeldendePeriode).getOrElse { } shouldBe gjeldendePeriode
    }

    @Test
    fun `genererer en liste av perioder`() {
        val gjeldendePeriode = Periode(3, 2022)
        gjeldendePeriode.lagPerioder(1) shouldBe listOf(gjeldendePeriode)

        val perioder = gjeldendePeriode.lagPerioder(4)

        perioder.size shouldBe 4
        perioder shouldBe listOf(
                Periode(3, 2022),
                Periode(2, 2022),
                Periode(1, 2022),
                Periode(4, 2021)
        )

        gjeldendePeriode.lagPerioder(30).size shouldBe 30
    }
}

