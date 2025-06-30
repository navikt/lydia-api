package no.nav.lydia.container.dokument

import io.kotest.matchers.shouldBe
import no.nav.lydia.ia.sak.api.dokument.DokumentPublisering
import no.nav.lydia.ia.sak.api.dokument.DokumentPublisering.Companion.tilDokumentTilPubliseringStatus
import kotlin.test.Test

class DokumentPubliseringTest {
    @Test
    fun `skal håndtere manglende publiseringsstatus`() {
        val myString = null
        myString.tilDokumentTilPubliseringStatus() shouldBe DokumentPublisering.Status.IKKE_PUBLISERT
    }
}
