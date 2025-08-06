package no.nav.lydia.container.arbeidsgiver

import io.kotest.matchers.ints.shouldBeExactly
import no.nav.lydia.arbeidsgiver.ARBEIDSGIVER_SAMARBEID_PATH
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import kotlin.test.Test

class SamarbeidApiTest {
    @Test
    fun `skal få feilmelding 401 dersom man ikke er innlogget`() {
        val respons = TestContainerHelper.applikasjon.performGet("$ARBEIDSGIVER_SAMARBEID_PATH/987654321").response()
        respons.second.statusCode shouldBeExactly 401
    }
}
