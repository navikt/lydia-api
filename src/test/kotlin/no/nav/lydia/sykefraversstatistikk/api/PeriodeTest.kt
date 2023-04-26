package no.nav.lydia.sykefraversstatistikk.api

import arrow.core.getOrElse
import io.kotest.matchers.shouldBe
import kotlin.test.Test


class PeriodeTest {

    @Test
    fun `returnerer gjeldende periode når input parametre er tomme`() {
        val gjeldendePeriode = Periode(4, 2022)
        Periode.tilValidertPeriode("", "", gjeldendePeriode).getOrElse { } shouldBe gjeldendePeriode
        Periode.tilValidertPeriode(null, null, gjeldendePeriode).getOrElse { } shouldBe gjeldendePeriode
    }
}

