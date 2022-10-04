package no.nav.lydia.container.veilder

import io.kotest.matchers.collections.shouldHaveSize
import no.nav.lydia.helper.VeilederHelper
import kotlin.test.Test

class VeilederTest {
    @Test
    fun `skal kunne hente ned en liste med veiledere`() {
        val veiledere = VeilederHelper.hentVeiledere()
        veiledere shouldHaveSize 4
    }

}