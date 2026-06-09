package no.nav.lydia.container.arbeidsgiver

import com.github.kittinunf.fuel.core.extensions.authentication
import io.kotest.inspectors.forAll
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.ints.shouldBeExactly
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.UUIDVersion
import io.kotest.matchers.string.shouldBeUUID
import io.ktor.http.HttpStatusCode
import no.nav.lydia.abc.kartlegging.Spørreundersøkelse
import no.nav.lydia.arbeidsgiver.ARBEIDSGIVER_SAMARBEID_PATH
import no.nav.lydia.arbeidsgiver.SamarbeidMedDokumenterDto
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.aktivSamarbeidsperiode
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.fullførSamarbeidsperiode
import no.nav.lydia.helper.DokumentPubliseringHelper
import no.nav.lydia.helper.DokumentPubliseringHelper.Companion.publiserDokument
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.opprettSvarOgAvsluttSpørreundersøkelse
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.helper.statuskode
import no.nav.lydia.helper.tilListeRespons
import no.nav.lydia.ia.sak.api.IASakDto
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
    fun `skal ikke få samarbeid som ikke har dokumenter knyttet til seg i listen`() {
        val virksomhet = VirksomhetHelper.lastInnNyVirksomhet()
        aktivSamarbeidsperiode(virksomhet = virksomhet, samarbeidsnavn = "Test")

        val samarbeidSomHarDokumenter = hentSamarbeidMedDokumenter(virksomhet.orgnr)
        samarbeidSomHarDokumenter shouldHaveSize 0
    }

    @Test
    fun `skal få ut en liste over samarbeid for et orgnr`() {
        val virksomhet = VirksomhetHelper.lastInnNyVirksomhet()
        val sak = aktivSamarbeidsperiode(virksomhet = virksomhet, samarbeidsnavn = "Test")
        val samarbeid = sak.hentAlleSamarbeid().first()
        publiserDokument(sak = sak, samarbeid = samarbeid)

        val samarbeidSomHarDokumenter = hentSamarbeidMedDokumenter(virksomhet.orgnr)
        samarbeidSomHarDokumenter shouldHaveSize 1
        samarbeidSomHarDokumenter.first().navn shouldBe samarbeid.navn
        samarbeidSomHarDokumenter.first().offentligId.shouldBeUUID(version = UUIDVersion.ANY)
    }

    @Test
    fun `skal få alle samarbeid for alle saker (også gamle) for et orgnr`() {
        val virksomhet = VirksomhetHelper.lastInnNyVirksomhet()

        val gammelSak = aktivSamarbeidsperiode(virksomhet = virksomhet)
        publiserDokument(sak = gammelSak)
        gammelSak.fullførSamarbeidsperiode()

        val aktivSak = aktivSamarbeidsperiode(virksomhet = virksomhet)
        publiserDokument(sak = aktivSak)

        val samarbeidSomHarDokumenter = hentSamarbeidMedDokumenter(virksomhet.orgnr)
        samarbeidSomHarDokumenter shouldHaveSize 2
    }

    @Test
    fun `skal få kun ett samarbeid selvom det er publisert mange dokumenter`() {
        val virksomhet = VirksomhetHelper.lastInnNyVirksomhet()
        val sak = aktivSamarbeidsperiode(virksomhet = virksomhet)
        publiserDokument(sak = sak, type = Spørreundersøkelse.Type.Behovsvurdering)
        publiserDokument(sak = sak, type = Spørreundersøkelse.Type.Behovsvurdering)
        publiserDokument(sak = sak, type = Spørreundersøkelse.Type.Behovsvurdering)

        val samarbeid = hentSamarbeidMedDokumenter(virksomhet.orgnr)
        samarbeid shouldHaveSize 1
        samarbeid.forExactlyOne {
            it.dokumenter shouldHaveSize 3
            it.dokumenter.forAll { dokument ->
                dokument.type shouldBe Spørreundersøkelse.Type.Behovsvurdering.name.uppercase()
            }
        }
    }
}

internal fun hentSamarbeidMedDokumenter(orgnr: String) =
    TestContainerHelper.applikasjon.performGet("$ARBEIDSGIVER_SAMARBEID_PATH/$orgnr")
        .authentication().bearer(TestContainerHelper.tokenXAccessToken().serialize())
        .tilListeRespons<SamarbeidMedDokumenterDto>().third
        .fold(
            success = { it },
            failure = { fail("Feil ved uthenting av samarbeid: ${it.message}") },
        )

internal fun publiserDokument(
    sak: IASakDto,
    type: Spørreundersøkelse.Type = Spørreundersøkelse.Type.Behovsvurdering,
    samarbeid: IASamarbeidDto = sak.hentAlleSamarbeid().first(),
) {
    // publiser et dokument
    val fullførtBehovsvurdering = sak.opprettSvarOgAvsluttSpørreundersøkelse(
        type = type,
        samarbeidId = samarbeid.id,
    )
    val dokumentRefId = fullførtBehovsvurdering.id

    val publiseringsRespons = publiserDokument(
        dokumentReferanseId = dokumentRefId,
        token = authContainerHelper.saksbehandler1.token,
    )

    publiseringsRespons.statuskode() shouldBe HttpStatusCode.Created.value

    val dokument = publiseringsRespons.third.fold(
        success = { it },
        failure = { fail(it.message) },
    )

    DokumentPubliseringHelper.sendKvittering(dokument = dokument, samarbeidId = samarbeid.id)
}
