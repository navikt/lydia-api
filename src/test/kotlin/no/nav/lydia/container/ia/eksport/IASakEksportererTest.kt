package no.nav.lydia.container.ia.eksport

import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.TestContainerHelper.Companion.lydiaApiContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.statuskode
import no.nav.lydia.ia.eksport.IA_SAK_EKSPORT_PATH
import kotlin.test.Test

class IASakEksportererTest {

    @Test
    fun `skal trigge kafka-eksport av IASaker`() {
        lydiaApiContainer
            .performGet(IA_SAK_EKSPORT_PATH)
            .response()
            .statuskode() shouldBe 200
    }

}
