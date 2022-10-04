package no.nav.lydia.container.veilder

import io.kotest.assertions.shouldFail
import io.kotest.matchers.collections.shouldHaveSize
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.VeilederHelper
import kotlin.test.Test

class VeilederTest {
    @Test
    fun `skal kunne hente ned en liste med veiledere dersom man er superbruker`() {
        val veiledere = VeilederHelper.hentVeiledere()
        veiledere shouldHaveSize 4
        shouldFail {
            VeilederHelper.hentVeiledere(TestContainerHelper.oauth2ServerContainer.saksbehandler1.token)
        }
        shouldFail {
            VeilederHelper.hentVeiledere(TestContainerHelper.oauth2ServerContainer.lesebruker.token)
        }

    }
}