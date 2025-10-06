package no.nav.lydia.container.dokument

import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.ktor.http.HttpStatusCode
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.decodeFromJsonElement
import no.nav.lydia.Topic
import no.nav.lydia.helper.DokumentPubliseringHelper.Companion.hentDokumentPubliseringRespons
import no.nav.lydia.helper.DokumentPubliseringHelper.Companion.publiserDokument
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.opprettBehovsvurdering
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.opprettSvarOgAvsluttSpørreundersøkelse
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.start
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.svarPåSpørsmål
import no.nav.lydia.helper.PlanHelper.Companion.opprettEnPlan
import no.nav.lydia.helper.SakHelper.Companion.leggTilFolger
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartleggesMedEtSamarbeid
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.helper.statuskode
import no.nav.lydia.ia.sak.DEFAULT_SAMARBEID_NAVN
import no.nav.lydia.ia.sak.api.dokument.DokumentPublisering
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringDto
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringMedInnhold
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringProdusent.Companion.getKafkaMeldingKey
import no.nav.lydia.ia.sak.api.dokument.SpørreundersøkelseInnholdIDokumentDto
import no.nav.lydia.ia.sak.api.plan.PlanDto
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
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
    fun `følgere av sak som er saksbehandlere skal kunne publisere et dokument`() {
        val saksbehandlerToken = authContainerHelper.saksbehandler1.token
        val følgerToken = authContainerHelper.saksbehandler2.token

        val sak = nySakIKartleggesMedEtSamarbeid(token = saksbehandlerToken)
        sak.leggTilFolger(token = følgerToken)

        val fullførtBehovsvurdering = sak.opprettSvarOgAvsluttSpørreundersøkelse(Spørreundersøkelse.Type.Behovsvurdering)
        val dokumentRefId = fullførtBehovsvurdering.id

        val response = publiserDokument(
            dokumentReferanseId = dokumentRefId,
            token = følgerToken,
        )

        response.statuskode() shouldBe HttpStatusCode.Created.value
    }

    @Test
    fun `følgere av sak som er lesebrukere skal IKKE kunne publisere et dokument`() {
        val saksbehandlerToken = authContainerHelper.saksbehandler1.token
        val lesebrukerToken = authContainerHelper.lesebruker.token

        val sak = nySakIKartleggesMedEtSamarbeid(token = saksbehandlerToken)
        sak.leggTilFolger(token = lesebrukerToken)

        val fullførtBehovsvurdering = sak.opprettSvarOgAvsluttSpørreundersøkelse(Spørreundersøkelse.Type.Behovsvurdering)
        val dokumentRefId = fullførtBehovsvurdering.id

        val response = publiserDokument(
            dokumentReferanseId = dokumentRefId,
            token = lesebrukerToken,
        )

        response.statuskode() shouldBe HttpStatusCode.Forbidden.value
    }

    @Test
    fun `uthenting av et dokument til publisering returnerer 404 Not Found hvis ikke funnet`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val dokumentType = DokumentPublisering.Type.BEHOVSVURDERING
        val fullførtBehovsvurdering = sak.opprettSvarOgAvsluttSpørreundersøkelse(Spørreundersøkelse.Type.Behovsvurdering)

        val response = hentDokumentPubliseringRespons(dokumentReferanseId = fullførtBehovsvurdering.id, token = authContainerHelper.lesebruker.token)

        response.statuskode() shouldBe HttpStatusCode.NotFound.value
        response.second.body()
            .asString(contentType = "application/json") shouldBe
            "Ingen dokument funnet for referanseId: ${fullførtBehovsvurdering.id} og type: ${dokumentType.name}"
    }

    @Test
    fun `opprettelese av et dokument til publisering returnerer 400 Bad Request dersom referanse ikke er funnet`() {
        // TODO: Feil for uthenting av spørreundersøkelser returnerer 400 Bad Request, men burde kanskje endre det til 404 Not Found?
        nySakIKartleggesMedEtSamarbeid()
        val dokumentRefId = UUID.randomUUID().toString()

        val response = publiserDokument(
            dokumentReferanseId = dokumentRefId,
            token = authContainerHelper.saksbehandler1.token,
        )
        response.statuskode() shouldBe HttpStatusCode.BadRequest.value
        response.second.body()
            .asString(contentType = "text/plain; charset=utf-8") shouldBe
            "Ugyldig spørreundersøkelse"
    }

    @Test
    fun `opprettelese av et dokument av type Behovsvurdering returnerer 403 Forbidden dersom status ikke er FULLFØRT`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val startetBehovsvurdering = sak.opprettBehovsvurdering()
            .start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
            .also { it.svarPåSpørsmål(antallSvarPåSpørsmål = 3) }
        val dokumentRefId = startetBehovsvurdering.id

        val response = publiserDokument(
            dokumentReferanseId = dokumentRefId,
            token = authContainerHelper.saksbehandler1.token,
        )
        response.statuskode() shouldBe HttpStatusCode.Forbidden.value
        response.second.body()
            .asString(contentType = "text/plain; charset=utf-8") shouldBe
            "Spørreundersøkelse er ikke i forventet status: 'AVSLUTTET'"
    }

    @Test
    fun `opprettelese av dokument til publisering returnerer 409 Conflict dersom dokument allerede er opprettet`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val fullførtBehovsvurdering = sak.opprettSvarOgAvsluttSpørreundersøkelse(Spørreundersøkelse.Type.Behovsvurdering)
        val dokumentRefId = fullførtBehovsvurdering.id

        // 1- verifiser at et dokument har blitt opprettet
        val response = publiserDokument(
            dokumentReferanseId = dokumentRefId,
            token = authContainerHelper.saksbehandler1.token,
        )
        response.statuskode() shouldBe HttpStatusCode.Created.value

        // 2- verifiser at samme POST request returneres en 409 Conflict
        val responseDuplisertRequest = publiserDokument(
            dokumentReferanseId = dokumentRefId,
            token = authContainerHelper.saksbehandler1.token,
        )

        responseDuplisertRequest.statuskode() shouldBe HttpStatusCode.Conflict.value
        responseDuplisertRequest.second.body()
            .asString(contentType = "text/plain") shouldBe "Dokument med referanseId: $dokumentRefId og type: BEHOVSVURDERING finnes allerede"
    }

    @Test
    fun `opprettelese av behovsvurdering dokument til publisering returnerer 201 Created og sender dokumentet med innhold til Kafka`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val fullførtBehovsvurdering = sak.opprettSvarOgAvsluttSpørreundersøkelse(Spørreundersøkelse.Type.Behovsvurdering)
        val samarbeidId = fullførtBehovsvurdering.samarbeidId
        val dokumentRefId = fullførtBehovsvurdering.id
        val navIdent = authContainerHelper.saksbehandler1.navIdent

        // 1- verifiser at et dokument har blitt opprettet
        val response = publiserDokument(
            dokumentReferanseId = dokumentRefId,
            dokumentType = DokumentPublisering.Type.BEHOVSVURDERING,
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
                key = getKafkaMeldingKey(samarbeidId = samarbeidId, referanseId = dokumentRefId, type = DokumentPublisering.Type.BEHOVSVURDERING),
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveAtLeastSize 1
                Json.decodeFromString<DokumentPubliseringMedInnhold>(meldinger.first())
                    .also { dokumentPubliseringMedInnhold ->
                        dokumentPubliseringMedInnhold.referanseId shouldBe dokumentRefId
                        dokumentPubliseringMedInnhold.virksomhet.orgnummer shouldBe sak.orgnr
                        dokumentPubliseringMedInnhold.sak.saksnummer shouldBe sak.saksnummer
                        dokumentPubliseringMedInnhold.samarbeid.id shouldBe samarbeidId
                        dokumentPubliseringMedInnhold.samarbeid.navn shouldBe DEFAULT_SAMARBEID_NAVN
                        dokumentPubliseringMedInnhold.dokumentOpprettetAv shouldBe navIdent
                        val innhold = Json.decodeFromJsonElement<SpørreundersøkelseInnholdIDokumentDto>(dokumentPubliseringMedInnhold.innhold)
                        innhold.id shouldBe dokumentRefId
                        innhold.fullførtTidspunkt shouldNotBe null
                        dokumentPubliseringMedInnhold.type shouldBe DokumentPublisering.Type.BEHOVSVURDERING
                        innhold.spørsmålMedSvarPerTema.forEach { it.navn shouldNotBe null }
                        innhold.spørsmålMedSvarPerTema.forEach {
                            it.spørsmålMedSvar.forEach {
                                it.svarListe.forEach {
                                    it.antallSvar shouldNotBe null
                                }
                            }
                        }
                    }
            }
        }
    }

    @Test
    fun `opprettelese av samarbeidsplan dokument til publisering returnerer 201 Created og sender dokumentet med innhold til Kafka`() {
        val sak = nySakIViBistår()
        val samarbeid = sak.hentAlleSamarbeid().first()
        val samarbeidId = samarbeid.id
        val plan = sak.opprettEnPlan()
        val dokumentRefId = plan.id
        val navIdent = authContainerHelper.saksbehandler1.navIdent

        // 1- verifiser at et dokument har blitt opprettet
        val response = publiserDokument(
            dokumentReferanseId = dokumentRefId,
            dokumentType = DokumentPublisering.Type.SAMARBEIDSPLAN,
            token = authContainerHelper.saksbehandler1.token,
        )

        response.statuskode() shouldBe HttpStatusCode.Created.value
        val dokumentPubliseringDto: DokumentPubliseringDto = response.third.get()
        dokumentPubliseringDto.referanseId shouldBe dokumentRefId
        dokumentPubliseringDto.dokumentType shouldBe DokumentPublisering.Type.SAMARBEIDSPLAN
        dokumentPubliseringDto.opprettetAv shouldBe navIdent
        dokumentPubliseringDto.status shouldBe DokumentPublisering.Status.OPPRETTET
        dokumentPubliseringDto.dokumentId shouldBe null
        dokumentPubliseringDto.opprettetTidspunkt shouldNotBe null
        dokumentPubliseringDto.publisertTidspunkt shouldBe null

        // 2- verifiser at dokumentet + innhold er sent til Kafka
        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                // key: '1-f44fee5f-cc38-41e5-bb59-ab4a7c83051d-BEHOVSVURDERING'
                key = getKafkaMeldingKey(samarbeidId = samarbeidId, referanseId = dokumentRefId, type = DokumentPublisering.Type.SAMARBEIDSPLAN),
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveAtLeastSize 1
                Json.decodeFromString<DokumentPubliseringMedInnhold>(meldinger.first())
                    .also { dokumentPubliseringMedInnhold ->
                        dokumentPubliseringMedInnhold.referanseId shouldBe dokumentRefId
                        dokumentPubliseringMedInnhold.virksomhet.orgnummer shouldBe sak.orgnr
                        dokumentPubliseringMedInnhold.sak.saksnummer shouldBe sak.saksnummer
                        dokumentPubliseringMedInnhold.samarbeid.id shouldBe samarbeidId
                        dokumentPubliseringMedInnhold.samarbeid.navn shouldBe DEFAULT_SAMARBEID_NAVN
                        dokumentPubliseringMedInnhold.dokumentOpprettetAv shouldBe navIdent
                        val innhold = Json.decodeFromJsonElement<PlanDto>(dokumentPubliseringMedInnhold.innhold)
                        innhold.id shouldBe dokumentRefId
                        innhold.status shouldBe IASamarbeid.Status.AKTIV
                        dokumentPubliseringMedInnhold.type shouldBe DokumentPublisering.Type.SAMARBEIDSPLAN
                        innhold.temaer.forEach { it.navn shouldNotBe null }
                        innhold.temaer.forEach {
                            it.undertemaer.forEach {
                                it.navn.forEach {
                                    it shouldNotBe ""
                                }
                            }
                        }
                    }
            }
        }
    }

    @Test
    fun `uthenting av dokument til publisering returnerer 200 OK og selve dokumentet`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val fullførtBehovsvurdering = sak.opprettSvarOgAvsluttSpørreundersøkelse(Spørreundersøkelse.Type.Behovsvurdering)

        val postResponse = publiserDokument(
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
}
