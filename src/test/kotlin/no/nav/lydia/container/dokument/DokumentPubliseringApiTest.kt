package no.nav.lydia.container.dokument

import com.github.kittinunf.fuel.core.extensions.authentication
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.ktor.http.HttpStatusCode
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.DokumentPubliseringHelper.Companion.opprettDokumentPubliseringRespons
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.avslutt
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettSpørreundersøkelse
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.start
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartleggesMedEtSamarbeid
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.statuskode
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.sak.api.dokument.DOKUMENT_PUBLISERING_BASE_ROUTE
import no.nav.lydia.ia.sak.api.dokument.DokumentPublisering
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringDto
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringMedInnhold
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringProdusent.Companion.getKafkaMeldingKey
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseDto
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseDomene
import org.junit.AfterClass
import org.junit.BeforeClass
import java.util.UUID
import kotlin.test.Test

class DokumentPubliseringApiTest {
    companion object {
        private val topic = Topic.DOKUMENT_PUBLISERING_TOPIC
        private val konsument = kafkaContainerHelper.nyKonsument(topic = topic)

        @BeforeClass
        @JvmStatic
        fun setUp() = konsument.subscribe(mutableListOf(topic.navn))

        @AfterClass
        @JvmStatic
        fun tearDown() {
            konsument.unsubscribe()
            konsument.close()
        }
    }

    @Test
    fun `uthenting av et dokument til publisering returnerer 404 Not Found hvis ikke funnet`() {
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
    fun `opprettelese av et dokument til publisering returnerer 404 Not Found dersom referanse ikke er funnet`() {
        nySakIKartleggesMedEtSamarbeid()
        val dokumentRefId = UUID.randomUUID().toString()

        val response = opprettDokumentPubliseringRespons(
            dokumentReferanseId = dokumentRefId,
            token = authContainerHelper.saksbehandler1.token,
        )
        response.statuskode() shouldBe HttpStatusCode.NotFound.value
        response.second.body()
            .asString(contentType = "text/plain") shouldBe
            "Innhold dokumentet refererer til, med referanseId: '$dokumentRefId' og type: 'BEHOVSVURDERING', ble ikke funnet"
    }

    @Test
    fun `opprettelese av et dokument av type Behovsvurdering returnerer 400 Bad Request dersom status ikke er FULLFØRT`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val startetBehovsvurdering = sak.opprettSpørreundersøkelse(type = "Behovsvurdering")
            .start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        val dokumentRefId = startetBehovsvurdering.id

        val response = opprettDokumentPubliseringRespons(
            dokumentReferanseId = dokumentRefId,
            token = authContainerHelper.saksbehandler1.token,
        )
        response.statuskode() shouldBe HttpStatusCode.BadRequest.value
        response.second.body()
            .asString(contentType = "text/plain; charset=utf-8") shouldBe
            "Spørreundersøkelse med id: '$dokumentRefId' har ikke status AVSLUTTET, og dermed ikke kan lagres som dokument. Status var: 'PÅBEGYNT'"
    }

    @Test
    fun `opprettelese av dokument til publisering returnerer 409 Conflict dersom dokument allerede er opprettet`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val type = "Behovsvurdering"
        val fullførtBehovsvurdering = sak.opprettSpørreundersøkelse(type = type)
            .start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
            .avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        val dokumentRefId = fullførtBehovsvurdering.id

        // 1- verifiser at et dokument har blitt opprettet
        val response = opprettDokumentPubliseringRespons(
            dokumentReferanseId = dokumentRefId,
            token = authContainerHelper.saksbehandler1.token,
        )
        response.statuskode() shouldBe HttpStatusCode.Created.value

        // 2- verifiser at samme POST request returneres en 409 Conflict
        val responseDuplisertRequest = opprettDokumentPubliseringRespons(
            dokumentReferanseId = dokumentRefId,
            token = authContainerHelper.saksbehandler1.token,
        )

        responseDuplisertRequest.statuskode() shouldBe HttpStatusCode.Conflict.value
        responseDuplisertRequest.second.body()
            .asString(contentType = "text/plain") shouldBe "Dokument med referanseId: $dokumentRefId og type: BEHOVSVURDERING finnes allerede"
    }

    @Test
    fun `opprettelese av dokument til publisering returnerer 201 Created og sender dokumentet med innhold til Kafka`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val type = "Behovsvurdering"
        val fullførtBehovsvurdering = sak.opprettSpørreundersøkelse(type = type)
            .start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
            .avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        val samarbeidId = fullførtBehovsvurdering.samarbeidId
        val dokumentRefId = fullførtBehovsvurdering.id
        val navIdent = authContainerHelper.saksbehandler1.navIdent

        // 1- verifiser at et dokument har blitt opprettet
        val response = opprettDokumentPubliseringRespons(
            dokumentReferanseId = dokumentRefId,
            token = authContainerHelper.saksbehandler1.token,
        )

        response.statuskode() shouldBe HttpStatusCode.Created.value
        val dokumentPubliseringDto: DokumentPubliseringDto = response.third.get()
        dokumentPubliseringDto.referanseId shouldBe dokumentRefId
        dokumentPubliseringDto.dokumentType shouldBe DokumentPublisering.Type.BEHOVSVURDERING
        dokumentPubliseringDto.opprettetAv shouldBe navIdent
        dokumentPubliseringDto.status shouldBe DokumentPublisering.Status.OPPRETTET
        dokumentPubliseringDto.dokumentId shouldBe null
        dokumentPubliseringDto.opprettetTidspunkt shouldNotBe null
        dokumentPubliseringDto.publisertTidspunkt shouldBe null

        // 2- verifiser at dokumentet + innhold er sent til Kafka
        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                // key: '1-f44fee5f-cc38-41e5-bb59-ab4a7c83051d-BEHOVSVURDERING'
                key = getKafkaMeldingKey(samarbeidId = samarbeidId, referanseId = dokumentRefId, type = DokumentPublisering.Type.BEHOVSVURDERING.name),
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveAtLeastSize 1
                Json.decodeFromString<DokumentPubliseringMedInnhold>(meldinger.first())
                    .also { dokumentPubliseringMedInnhold ->
                        dokumentPubliseringMedInnhold.referanseId shouldBe dokumentRefId
                        dokumentPubliseringMedInnhold.orgnr shouldBe sak.orgnr
                        dokumentPubliseringMedInnhold.saksnummer shouldBe sak.saksnummer
                        dokumentPubliseringMedInnhold.samarbeidId shouldBe samarbeidId
                        dokumentPubliseringMedInnhold.opprettetAv shouldBe navIdent
                        Json.decodeFromString<SpørreundersøkelseDto>(dokumentPubliseringMedInnhold.innhold).also { spørreundersøkelseDto ->
                            spørreundersøkelseDto.id shouldBe dokumentRefId
                            spørreundersøkelseDto.samarbeidId shouldBe fullførtBehovsvurdering.samarbeidId
                            spørreundersøkelseDto.status shouldBe SpørreundersøkelseDomene.Status.AVSLUTTET
                            spørreundersøkelseDto.type shouldBe SpørreundersøkelseDomene.Type.Behovsvurdering
                        }
                    }
            }
        }
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
        getResponse.statuskode() shouldBe HttpStatusCode.OK.value
        val dokumentPubliseringDto: DokumentPubliseringDto = getResponse.third.get()
        dokumentPubliseringDto.referanseId shouldBe fullførtBehovsvurdering.id
        dokumentPubliseringDto.dokumentType shouldBe DokumentPublisering.Type.BEHOVSVURDERING
        dokumentPubliseringDto.opprettetAv shouldBe authContainerHelper.saksbehandler1.navIdent
        dokumentPubliseringDto.status shouldBe DokumentPublisering.Status.OPPRETTET
        dokumentPubliseringDto.dokumentId shouldBe null
        dokumentPubliseringDto.opprettetTidspunkt shouldNotBe null
        dokumentPubliseringDto.publisertTidspunkt shouldBe null
    }

    private fun hentDokumentPubliseringRespons(
        dokumentReferanseId: String,
        token: String = authContainerHelper.lesebruker.token,
    ) = applikasjon.performGet(url = "$DOKUMENT_PUBLISERING_BASE_ROUTE/type/Behovsvurdering/ref/$dokumentReferanseId")
        .authentication().bearer(token = token)
        .tilSingelRespons<DokumentPubliseringDto>()
}
