package no.nav.lydia.container.arbeidsgiver

import com.github.kittinunf.fuel.core.extensions.authentication
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.ints.shouldBeExactly
import io.kotest.matchers.shouldBe
import no.nav.lydia.arbeidsgiver.ARBEIDSGIVER_SAMARBEID_PATH
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.SakHelper.Companion.fullførSak
import no.nav.lydia.helper.SakHelper.Companion.slettSamarbeid
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.helper.opprettNyttSamarbeid
import no.nav.lydia.helper.tilListeRespons
import no.nav.lydia.ia.sak.api.samarbeid.IASamarbeidDto
import kotlin.test.Test
import kotlin.test.fail

class SamarbeidApiTest {
    @Test
    fun `skal få feilmelding 401 dersom man ikke er innlogget`() {
        val respons = TestContainerHelper.applikasjon.performGet("$ARBEIDSGIVER_SAMARBEID_PATH/987654321").response()
        respons.second.statusCode shouldBeExactly 401
    }

    @Test
    fun `skal få ut en liste over samarbeid for et orgnr`() {
        val orgnr = VirksomhetHelper.nyttOrgnummer()
        SakHelper.nySakIKartleggesMedEtSamarbeid(orgnummer = orgnr, navnPåSamarbeid = "Test")
        val respons = TestContainerHelper.applikasjon.performGet("$ARBEIDSGIVER_SAMARBEID_PATH/$orgnr")
            .authentication().bearer(TestContainerHelper.tokenXAccessToken().serialize())
            .tilListeRespons<IASamarbeidDto>().third
            .fold(
                success = { it },
                failure = { fail(it.message) },
            )
        respons shouldHaveSize 1
        respons.first().navn shouldBe "Test"
    }

    @Test
    fun `skal få alle samarbeid for alle saker (også gamle) for et orgnr`() {
        val orgnr = VirksomhetHelper.nyttOrgnummer()

        SakHelper.nySakIViBistår(orgnummer = orgnr).fullførSak()
        SakHelper.nySakIViBistår(orgnummer = orgnr)

        val respons = TestContainerHelper.applikasjon.performGet("$ARBEIDSGIVER_SAMARBEID_PATH/$orgnr")
            .authentication().bearer(TestContainerHelper.tokenXAccessToken().serialize())
            .tilListeRespons<IASamarbeidDto>().third
            .fold(
                success = { it },
                failure = { fail(it.message) },
            )
        respons shouldHaveSize 2
    }

    @Test
    fun `skal ikke få slettede samarbeid i listen over samarbeid`() {
        val orgnr = VirksomhetHelper.nyttOrgnummer()
        val sak = SakHelper.nySakIKartleggesMedEtSamarbeid(orgnummer = orgnr, navnPåSamarbeid = "Ikke slett")
        sak.opprettNyttSamarbeid("Slettes")
            .slettSamarbeid(
                samarbeidDto = sak.hentAlleSamarbeid().first { it.navn == "Slettes" },
            )

        val respons = TestContainerHelper.applikasjon.performGet("$ARBEIDSGIVER_SAMARBEID_PATH/$orgnr")
            .authentication().bearer(TestContainerHelper.tokenXAccessToken().serialize())
            .tilListeRespons<IASamarbeidDto>().third
            .fold(
                success = { it },
                failure = { fail(it.message) },
            )
        respons shouldHaveSize 1
        respons.first().navn shouldBe "Ikke slett"
    }
}
