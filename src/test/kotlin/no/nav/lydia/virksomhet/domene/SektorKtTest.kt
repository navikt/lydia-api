package no.nav.lydia.virksomhet.domene

import io.kotest.inspectors.forAll
import io.kotest.matchers.shouldBe
import kotlin.test.Test

class SektorKtTest {
    @Test
    fun `tilSektor lager Sektor ut i fra 'navn' eller 'kode'`() {
        Sektor.entries.forAll {
            it.name.tilSektor() shouldBe it
            it.kode.tilSektor() shouldBe it
        }
    }
}
