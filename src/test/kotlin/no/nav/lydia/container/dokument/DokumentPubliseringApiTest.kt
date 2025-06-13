package no.nav.lydia.container.dokument

import com.github.kittinunf.fuel.core.extensions.authentication
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.ktor.http.HttpStatusCode
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.avslutt
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettSpørreundersøkelse
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.start
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartleggesMedEtSamarbeid
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.statuskode
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.sak.api.dokument.DOKUMENT_PUBLISERING_BASE_ROUTE
import no.nav.lydia.ia.sak.api.dokument.DokumentPublisering
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringDto
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import java.util.UUID
import kotlin.test.Test

class DokumentPubliseringApiTest {
    @Test
    fun `uthenting av dokument returnerer 404 Not Found hvis ikke funnet`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val dokumentType = DokumentPublisering.Type.BEHOVSVURDERING
        val spørreundersøkelseType = Spørreundersøkelse.Type.Behovsvurdering.name
        val fullførtBehovsvurdering = sak.opprettSpørreundersøkelse(type = spørreundersøkelseType)
            .start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
            .avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        val response = hentDokumentPubliseringRespons(dokumentReferanseId = fullførtBehovsvurdering.id, token = authContainerHelper.lesebruker.token)

        response.statuskode() shouldBe HttpStatusCode.NotFound.value
        response.second.body()
            .asString(contentType = "application/json") shouldBe
            "Ingen dokument funnet for referanseId: ${fullførtBehovsvurdering.id} og type: ${dokumentType.name}"
    }

    @Test
    fun `opprettelese av dokument til publisering returnerer 201 Created`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val type = "Behovsvurdering"
        val fullførtBehovsvurdering = sak.opprettSpørreundersøkelse(type = type)
            .start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
            .avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        val response = opprettDokumentPubliseringRespons(
            dokumentReferanseId = fullførtBehovsvurdering.id,
            token = authContainerHelper.saksbehandler1.token,
        )

        response.statuskode() shouldBe HttpStatusCode.Created.value
        val dokumentPubliseringDto: DokumentPubliseringDto = response.third.get()
        dokumentPubliseringDto.referanseId shouldBe fullførtBehovsvurdering.id
        dokumentPubliseringDto.dokumentType shouldBe DokumentPublisering.Type.BEHOVSVURDERING
        dokumentPubliseringDto.opprettetAv shouldBe authContainerHelper.saksbehandler1.navIdent
        dokumentPubliseringDto.status shouldBe DokumentPublisering.Status.OPPRETTET
        dokumentPubliseringDto.dokumentId shouldNotBe null
        dokumentPubliseringDto.opprettetTidspunkt shouldNotBe null
        dokumentPubliseringDto.publisertTidspunkt shouldBe null
    }

    @Test
    fun `uthenting av dokument til publisering returnerer 200 OK og selve dokumentet`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val type = "Behovsvurdering"
        val fullførtBehovsvurdering = sak.opprettSpørreundersøkelse(type = type)
            .start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
            .avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        val postResponse = opprettDokumentPubliseringRespons(
            dokumentReferanseId = fullførtBehovsvurdering.id,
            token = authContainerHelper.saksbehandler1.token,
        )
        postResponse.statuskode() shouldBe HttpStatusCode.Created.value
        val getResponse = hentDokumentPubliseringRespons(dokumentReferanseId = fullførtBehovsvurdering.id)

        val dokumentPubliseringDto: DokumentPubliseringDto = getResponse.third.get()
        dokumentPubliseringDto.dokumentId.length shouldBe UUID.randomUUID().toString().length
        dokumentPubliseringDto.referanseId shouldBe fullførtBehovsvurdering.id
        dokumentPubliseringDto.dokumentType shouldBe DokumentPublisering.Type.BEHOVSVURDERING
        dokumentPubliseringDto.opprettetAv shouldBe authContainerHelper.saksbehandler1.navIdent
        dokumentPubliseringDto.status shouldBe DokumentPublisering.Status.OPPRETTET
        dokumentPubliseringDto.dokumentId shouldNotBe null
        dokumentPubliseringDto.opprettetTidspunkt shouldNotBe null
        dokumentPubliseringDto.publisertTidspunkt shouldBe null
    }

    private fun hentDokumentPubliseringRespons(
        dokumentReferanseId: String,
        token: String = authContainerHelper.lesebruker.token,
    ) = applikasjon.performGet(url = "$DOKUMENT_PUBLISERING_BASE_ROUTE/type/Behovsvurdering/ref/$dokumentReferanseId")
        .authentication().bearer(token = token)
        .tilSingelRespons<DokumentPubliseringDto>()

    private fun opprettDokumentPubliseringRespons(
        dokumentReferanseId: String,
        token: String,
    ) = applikasjon.performPost(url = "$DOKUMENT_PUBLISERING_BASE_ROUTE/type/Behovsvurdering/ref/$dokumentReferanseId")
        .authentication().bearer(token = token)
        .tilSingelRespons<DokumentPubliseringDto>()
}
