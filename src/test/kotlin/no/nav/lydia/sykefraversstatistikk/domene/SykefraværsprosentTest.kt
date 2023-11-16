package no.nav.lydia.sykefraversstatistikk.domene

import io.kotest.inspectors.forAll
import io.kotest.matchers.shouldBe
import no.nav.lydia.sykefraversstatistikk.api.Sykefraværsprosent.Companion.tilSykefraværsProsent
import kotlin.test.Test

class SykefraværsprosentTest {
    @Test
    fun  `gyldig sykefraværsprosent skal validere`() {
        listOf(
            "0", "7.5", "40.0", "100", "100.0000"
        ).forAll { it.tilSykefraværsProsent().isRight() shouldBe true }
    }

    @Test
    fun `ugylgide sykefraværs prosenter skal ikke validere`() {
        listOf(
            "-10", "100.1", "a"
        ).forAll { it.tilSykefraværsProsent().isLeft() shouldBe true }
    }

    @Test
    fun `null og tomme skal validere og være null`() {
        listOf("", null).forAll {
            it.tilSykefraværsProsent().isRight() shouldBe true
            it.tilSykefraværsProsent().map {
                it shouldBe null
            }
        }
    }
}