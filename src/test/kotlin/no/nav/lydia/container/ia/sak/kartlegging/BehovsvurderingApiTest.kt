package no.nav.lydia.container.ia.sak.kartlegging

import com.github.kittinunf.fuel.core.extensions.authentication
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus.AVSLUTTET
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus.OPPRETTET
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus.PÅBEGYNT
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus.SLETTET
import io.kotest.assertions.shouldFail
import io.kotest.inspectors.forAll
import io.kotest.matchers.collections.shouldContainAll
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.collections.shouldNotBeEmpty
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.kotest.matchers.string.shouldMatch
import io.kotest.matchers.string.shouldNotBeEmpty
import io.ktor.http.HttpStatusCode
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.avslutt
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.hentKartleggingMedSvar
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.hentSpørreundersøkelse
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.oppdaterBehovsvurdering
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettSpørreundersøkelse
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.sendKartleggingSvarTilKafka
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.start
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartlegges
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartleggesMedEtSamarbeid
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.lydiaApiContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.oauth2ServerContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.performDelete
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.helper.opprettNyttSamarbeid
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.eksport.SpørreundersøkelseProdusent.SerializableSpørreundersøkelse
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SPØRREUNDERSØKELSE_BASE_ROUTE
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseDto
import org.junit.After
import org.junit.Before
import java.util.UUID
import kotlin.test.Test

class BehovsvurderingApiTest {
    private val spørreundersøkelseKonsument = kafkaContainerHelper.nyKonsument(this::class.java.name)

    companion object {
        const val ID_TIL_SPØRSMÅL_MED_FLERVALG_MULIGHETER = "018f4e25-6a40-713f-b769-267afa134896"
    }

    @Before
    fun setUp() {
        spørreundersøkelseKonsument.subscribe(mutableListOf(Topic.SPORREUNDERSOKELSE_TOPIC.navn))
    }

    @After
    fun tearDown() {
        spørreundersøkelseKonsument.unsubscribe()
        spørreundersøkelseKonsument.close()
    }

    @Test
    fun `kan opprette en spørreundersøkelse av type behovsvurdering i status KARTLEGGES`() {
        val sak = nySakIKartleggesMedEtSamarbeid()

        val behovsvurdering = sak.opprettSpørreundersøkelse()
        behovsvurdering.id.length shouldBe 36

        postgresContainer
            .hentEnkelKolonne<String>(
                "select kartlegging_id from ia_sak_kartlegging where kartlegging_id = '${behovsvurdering.id}'",
            ) shouldNotBe null
    }

    @Test
    fun `kan opprette en spørreundersøkelse av type behovsvurdering i status VI_BISTÅR`() {
        val sak = nySakIViBistår()

        val behovsvurdering = sak.opprettSpørreundersøkelse()
        behovsvurdering.id.length shouldBe 36

        postgresContainer
            .hentEnkelKolonne<String>(
                "select kartlegging_id from ia_sak_kartlegging where kartlegging_id = '${behovsvurdering.id}'",
            ) shouldNotBe null
    }

    @Test
    fun `kan opprette en spørreundersøkelse av type behovsvurdering med flere temaer`() {
        val behovsvurdering = nySakIKartleggesMedEtSamarbeid().opprettSpørreundersøkelse()

        behovsvurdering.type shouldBe "Behovsvurdering"
        behovsvurdering.temaMedSpørsmålOgSvaralternativer shouldHaveSize 3
        behovsvurdering.temaMedSpørsmålOgSvaralternativer.forAll {
            it.spørsmålOgSvaralternativer.shouldNotBeEmpty()
        }

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = behovsvurdering.id,
                konsument = spørreundersøkelseKonsument,
            ) { meldinger ->
                meldinger.forExactlyOne { melding ->
                    val spørreundersøkelse =
                        Json.decodeFromString<SerializableSpørreundersøkelse>(melding)
                    spørreundersøkelse.temaer shouldHaveSize 3
                    spørreundersøkelse.temaer.forAll {
                        it.spørsmål.shouldNotBeEmpty()
                        it.navn.shouldNotBeEmpty()
                    }
                }
            }
        }
    }

    @Test
    fun `skal få feil når saksnummer er ukjent ved oppretting av behovsvurdering`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val resp = opprettSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = "ukjent",
            prosessId = sak.hentAlleSamarbeid().first().id,
            type = "Behovsvurdering",
        ).tilSingelRespons<SpørreundersøkelseDto>()

        resp.second.statusCode shouldBe HttpStatusCode.BadRequest.value
        resp.second.body().asString("text/plain") shouldMatch "Ugyldig saksnummer"
    }

    @Test
    fun `skal få feil når orgnummer er feil ved oppretting av behovsvurdering`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val resp = opprettSpørreundersøkelse(
            orgnr = "222233334",
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
            type = "Behovsvurdering",
        ).tilSingelRespons<SpørreundersøkelseDto>()

        resp.second.statusCode shouldBe HttpStatusCode.BadRequest.value
        resp.second.body().asString("text/plain") shouldMatch "Ugyldig orgnummer"
    }

    @Test
    fun `kan opprette spørreundersøkelse av typen behovsvurdering og sende den på kafka`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val behovsvurdering = sak.opprettSpørreundersøkelse()

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = behovsvurdering.id,
                konsument = spørreundersøkelseKonsument,
            ) { liste ->
                liste.map { melding ->
                    val spørreundersøkelse =
                        Json.decodeFromString<SerializableSpørreundersøkelse>(melding)
                    spørreundersøkelse.id shouldBe behovsvurdering.id
                    spørreundersøkelse.orgnummer shouldBe sak.orgnr
                    spørreundersøkelse.virksomhetsNavn shouldBe "Navn ${sak.orgnr}"
                    spørreundersøkelse.status shouldBe OPPRETTET
                    spørreundersøkelse.type shouldBe "Behovsvurdering"
                    spørreundersøkelse.temaer shouldHaveSize 3
                    spørreundersøkelse.temaer.forAll { tema ->
                        tema.spørsmål.shouldNotBeEmpty()
                        tema.spørsmål.forAll {
                            it.svaralternativer.shouldNotBeEmpty()
                        }
                    }
                }
            }
        }
    }

    @Test
    fun `kan hente liste av alle spørreundersøkelser av typen Behovsvurdering`() {
        val sak = nySakIKartleggesMedEtSamarbeid()

        val behvosvurdering = sak.opprettSpørreundersøkelse()

        val alleKartlegginger = hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
            type = "Behovsvurdering",
        )

        alleKartlegginger shouldHaveSize 1
        alleKartlegginger.first().id shouldBe behvosvurdering.id
        alleKartlegginger.first().samarbeidId shouldBe behvosvurdering.samarbeidId
        alleKartlegginger.first().opprettetAv shouldBe behvosvurdering.opprettetAv
        alleKartlegginger.first().opprettetTidspunkt shouldBe behvosvurdering.opprettetTidspunkt
        alleKartlegginger.first().status shouldBe OPPRETTET
        alleKartlegginger.first().endretTidspunkt shouldBe null
    }

    @Test
    fun `nylig opprettet kartlegging får alle spørsmål med riktige svaralternativer knyttet til seg`() {
        val sak = nySakIKartleggesMedEtSamarbeid()

        val behovsvurdering = sak.opprettSpørreundersøkelse()
        behovsvurdering.temaMedSpørsmålOgSvaralternativer.shouldNotBeEmpty()
        behovsvurdering.temaMedSpørsmålOgSvaralternativer.forEach { spørsmålOgSvarPerTema ->
            val temaId: Int =
                postgresContainer.hentEnkelKolonne(
                    "select tema_id from ia_sak_kartlegging_tema where beskrivelse = '${spørsmålOgSvarPerTema.navn}' and status = 'AKTIV'",
                )
            val spørsmålIderForEtTema: List<String> =
                postgresContainer.hentAlleRaderTilEnkelKolonne(
                    "select sporsmal_id from ia_sak_kartlegging_tema_til_spørsmål where tema_id = $temaId",
                )
            spørsmålOgSvarPerTema.spørsmålOgSvaralternativer.map { spørsmålMedSvar ->
                spørsmålMedSvar.id
            }.toList() shouldContainAll spørsmålIderForEtTema
        }

        behovsvurdering.temaMedSpørsmålOgSvaralternativer.forEach { spørsmålMedSvarPerTema ->
            spørsmålMedSvarPerTema.spørsmålOgSvaralternativer.forEach { spørsmålMedSvar ->
                val svarIderForEtSpørsmål: List<String> =
                    postgresContainer.hentAlleRaderTilEnkelKolonne(
                        "select svaralternativ_id from ia_sak_kartlegging_svaralternativer where sporsmal_id = '${spørsmålMedSvar.id}'",
                    )
                spørsmålMedSvar.svaralternativer.map { it.svarId }.toList() shouldContainAll svarIderForEtSpørsmål
            }
        }
    }

    @Test
    fun `skal ikke kunne hente resultat før kartlegging er avsluttet`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val påbegyntBehovsvurdering = sak.opprettSpørreundersøkelse().also {
            it.status shouldBe OPPRETTET
        }.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer).also {
            it.status shouldBe PÅBEGYNT
        }

        listOf(UUID.randomUUID(), UUID.randomUUID(), UUID.randomUUID()).forEach { sesjonId ->
            enDeltakerSvarerPåEtSpørsmål(kartleggingDto = påbegyntBehovsvurdering, UUID.randomUUID().toString())
        }

        val førsteSpørsmål = påbegyntBehovsvurdering.temaMedSpørsmålOgSvaralternativer.first().spørsmålOgSvaralternativer.first()
        val førsteSvaralternativ = førsteSpørsmål.svaralternativer.first()
        val sesjonId = UUID.randomUUID()
        sendKartleggingSvarTilKafka(
            kartleggingId = påbegyntBehovsvurdering.id,
            spørsmålId = førsteSpørsmål.id,
            sesjonId = sesjonId.toString(),
            svarIder = listOf(førsteSvaralternativ.svarId),
        )

        shouldFail {
            hentKartleggingMedSvar(
                orgnr = sak.orgnr,
                saksnummer = sak.saksnummer,
                kartleggingId = påbegyntBehovsvurdering.id,
            )
        }
    }

    @Test
    fun `skal ikke kunne få antall svar dersom antall deltakere er færre enn 3`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val påbegyntBehovsvurdering = sak.opprettSpørreundersøkelse().also {
            it.status shouldBe OPPRETTET
        }.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer).also {
            it.status shouldBe PÅBEGYNT
        }

        val førsteSpørsmål =
            påbegyntBehovsvurdering.temaMedSpørsmålOgSvaralternativer.first().spørsmålOgSvaralternativer.first()
        val førsteSvaralternativ = førsteSpørsmål.svaralternativer.first()

        val antallSvar = 2

        repeat(antallSvar) {
            val sesjonId = UUID.randomUUID()
            sendKartleggingSvarTilKafka(
                kartleggingId = påbegyntBehovsvurdering.id,
                spørsmålId = førsteSpørsmål.id,
                sesjonId = sesjonId.toString(),
                svarIder = listOf(førsteSvaralternativ.svarId),
            )
        }

        påbegyntBehovsvurdering.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        val spørreundersøkelseResultat = hentKartleggingMedSvar(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            kartleggingId = påbegyntBehovsvurdering.id,
        )

        spørreundersøkelseResultat.spørsmålMedSvarPerTema.forAll { tema ->
            tema.spørsmålMedSvar.forAll { spørsmål ->
                spørsmål.antallDeltakereSomHarSvart shouldBe 0
                spørsmål.svarListe.forAll { svar ->
                    svar.antallSvar shouldBe 0
                }
            }
        }
    }

    @Test
    fun `skal få svardetaljer for et spørsmål dersom antall besvarelser er 3 eller flere`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val påbegyntBehovsvurdering = sak.opprettSpørreundersøkelse().also {
            it.status shouldBe OPPRETTET
        }.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer).also {
            it.status shouldBe PÅBEGYNT
        }

        val førsteSpørsmål =
            påbegyntBehovsvurdering.temaMedSpørsmålOgSvaralternativer.first().spørsmålOgSvaralternativer.first()
        val førsteSvaralternativ = førsteSpørsmål.svaralternativer.first()

        val antallSvar = 3

        repeat(antallSvar) {
            val sesjonId = UUID.randomUUID()
            sendKartleggingSvarTilKafka(
                kartleggingId = påbegyntBehovsvurdering.id,
                spørsmålId = førsteSpørsmål.id,
                sesjonId = sesjonId.toString(),
                svarIder = listOf(førsteSvaralternativ.svarId),
            )
        }

        påbegyntBehovsvurdering.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        val spørreundersøkelseResultat = hentKartleggingMedSvar(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            kartleggingId = påbegyntBehovsvurdering.id,
        )

        spørreundersøkelseResultat.spørsmålMedSvarPerTema.forAll { tema ->
            tema.spørsmålMedSvar.forAll { spørsmål ->
                if (spørsmål.id == førsteSpørsmål.id) {
                    spørsmål.antallDeltakereSomHarSvart shouldBe antallSvar
                    spørsmål.svarListe.first().antallSvar shouldBe antallSvar
                } else {
                    spørsmål.antallDeltakereSomHarSvart shouldBe 0
                    spørsmål.svarListe.forAll { svar ->
                        svar.antallSvar shouldBe 0
                    }
                }
            }
        }
    }

    @Test
    fun `alle med tilgang til fia skal kunne hente resultater av kartlegging`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val behovsvurdering = sak.opprettSpørreundersøkelse()
        behovsvurdering.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        behovsvurdering.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        val resultater = hentKartleggingMedSvar(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            kartleggingId = behovsvurdering.id,
        )
        resultater.id shouldBe behovsvurdering.id

        val behovsvurderingResultat = hentKartleggingMedSvar(
            token = oauth2ServerContainer.saksbehandler2.token,
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            kartleggingId = behovsvurdering.id,
        )
        behovsvurderingResultat.id shouldBe behovsvurdering.id
    }

    @Test
    fun `kan starte en Spørreundersøkelse av type Behovsvurdering`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val behovsvurdering = sak.opprettSpørreundersøkelse()
        behovsvurdering.type shouldBe "Behovsvurdering"
        behovsvurdering.status shouldBe OPPRETTET

        val påbegyntBehovsvurdering = behovsvurdering.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        påbegyntBehovsvurdering.status shouldBe PÅBEGYNT

        hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
            type = "Behovsvurdering",
        ).forExactlyOne {
            it.status shouldBe PÅBEGYNT
            it.endretTidspunkt shouldNotBe null
        }

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = behovsvurdering.id,
                konsument = spørreundersøkelseKonsument,
            ) {
                it.forExactlyOne { melding ->
                    val spørreundersøkelse =
                        Json.decodeFromString<SerializableSpørreundersøkelse>(melding)
                    spørreundersøkelse.status shouldBe PÅBEGYNT
                }
            }
        }
    }

    @Test
    fun `skal kunne avslutte en påbegynt kartlegging`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val kartleggingDto = sak.opprettSpørreundersøkelse()
        val påbegyntKartlegging = kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        påbegyntKartlegging.status shouldBe PÅBEGYNT

        val avsluttetKartlegging = påbegyntKartlegging.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        avsluttetKartlegging.status shouldBe AVSLUTTET

        hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
            type = "Behovsvurdering",
        ).forExactlyOne {
            it.status shouldBe AVSLUTTET
            it.endretTidspunkt shouldNotBe null
        }

        runBlocking {
            // -- topic for fia-arbeidsgiver
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = kartleggingDto.id,
                konsument = spørreundersøkelseKonsument,
            ) {
                it.forExactlyOne { melding ->
                    val spørreundersøkelse = Json.decodeFromString<SerializableSpørreundersøkelse>(melding)
                    spørreundersøkelse.status shouldBe AVSLUTTET
                }
            }
        }
    }

    @Test
    fun `skal ikke kunne avslutte kartlegging med status OPPRETTET`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val kartleggingDto = sak.opprettSpørreundersøkelse()
        kartleggingDto.status shouldBe OPPRETTET

        val response =
            lydiaApiContainer.performPost(
                "$SPØRREUNDERSØKELSE_BASE_ROUTE/${sak.orgnr}/${sak.saksnummer}/${kartleggingDto.id}/avslutt",
            )
                .authentication().bearer(oauth2ServerContainer.saksbehandler1.token)
                .tilSingelRespons<SpørreundersøkelseDto>()

        response.second.statusCode shouldBe HttpStatusCode.Forbidden.value

        lydiaApiContainer shouldContainLog "Spørreundersøkelse er ikke i status '${PÅBEGYNT.name}', kan ikke avslutte".toRegex()
    }

    @Test
    fun `skal kunne slette en kartlegging`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val kartleggingDto = sak.opprettSpørreundersøkelse()
        kartleggingDto.status shouldBe OPPRETTET

        val pågåendeKartlegging = kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        val førsteSpørsmål = pågåendeKartlegging.temaMedSpørsmålOgSvaralternativer.first().spørsmålOgSvaralternativer.first()
        sendKartleggingSvarTilKafka(
            kartleggingId = pågåendeKartlegging.id,
            spørsmålId = førsteSpørsmål.id,
            sesjonId = UUID.randomUUID().toString(),
            svarIder = listOf(
                førsteSpørsmål.svaralternativer.first().svarId,
            ),
        )

        postgresContainer
            .hentAlleRaderTilEnkelKolonne<String>(
                "select kartlegging_id from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingDto.id}'",
            ) shouldHaveSize 1

        val response =
            lydiaApiContainer.performDelete("$SPØRREUNDERSØKELSE_BASE_ROUTE/${sak.orgnr}/${sak.saksnummer}/${kartleggingDto.id}")
                .authentication().bearer(oauth2ServerContainer.saksbehandler1.token)
                .tilSingelRespons<SpørreundersøkelseDto>()

        response.second.statusCode shouldBe HttpStatusCode.OK.value

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = kartleggingDto.id,
                konsument = spørreundersøkelseKonsument,
            ) {
                it.forExactlyOne { melding ->
                    val spørreundersøkelse =
                        Json.decodeFromString<SerializableSpørreundersøkelse>(melding)
                    spørreundersøkelse.status shouldBe SLETTET
                }
            }
        }

        postgresContainer
            .hentAlleRaderTilEnkelKolonne<String>(
                "select kartlegging_id from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingDto.id}'",
            ).shouldNotBeEmpty()

        postgresContainer
            .hentAlleRaderTilEnkelKolonne<String>(
                "select status from ia_sak_kartlegging where kartlegging_id = '${kartleggingDto.id}'",
            ).forAll { it shouldBe "SLETTET" }

        hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
            type = "Behovsvurdering",
        ) shouldHaveSize 0
    }

    @Test
    fun `skal kunne slette en kartlegging i status VI_BISTÅR`() {
        val sak = nySakIViBistår()
        val kartleggingDto = sak.opprettSpørreundersøkelse()
        kartleggingDto.status shouldBe OPPRETTET
        kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        val response =
            lydiaApiContainer.performDelete("$SPØRREUNDERSØKELSE_BASE_ROUTE/${sak.orgnr}/${sak.saksnummer}/${kartleggingDto.id}")
                .authentication().bearer(oauth2ServerContainer.saksbehandler1.token)
                .tilSingelRespons<SpørreundersøkelseDto>()

        response.second.statusCode shouldBe HttpStatusCode.OK.value

        postgresContainer
            .hentAlleRaderTilEnkelKolonne<String>(
                "select kartlegging_id from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingDto.id}'",
            ) shouldHaveSize 0
        postgresContainer
            .hentAlleRaderTilEnkelKolonne<String>(
                "select status from ia_sak_kartlegging where kartlegging_id = '${kartleggingDto.id}'",
            ).forAll { it shouldBe "SLETTET" }

        hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
            type = "Behovsvurdering",
        ) shouldHaveSize 0
    }

    @Test
    fun `skal kunne opprette behovsvurdering for to forskjellige prosesser`() {
        val sak = nySakIKartlegges()
            .opprettNyttSamarbeid()
            .opprettNyttSamarbeid()

        val alleSamarbeid = sak.hentAlleSamarbeid()
        alleSamarbeid shouldHaveSize 2
        alleSamarbeid.forEach { samarbeid ->
            sak.opprettSpørreundersøkelse(prosessId = samarbeid.id)

            hentSpørreundersøkelse(
                orgnr = sak.orgnr,
                saksnummer = sak.saksnummer,
                prosessId = samarbeid.id,
                type = "Behovsvurdering",
            ) shouldHaveSize 1
        }
    }

    @Test
    fun `skal kunne flytte en behhovsvurdering fra en prosess til en annen`() {
        val sak = nySakIKartlegges()
            .opprettNyttSamarbeid()
            .opprettNyttSamarbeid()
        val alleSamarbeid = sak.hentAlleSamarbeid()
        alleSamarbeid shouldHaveSize 2
        val førsteSamarbeid = alleSamarbeid.first()
        val sisteSamarbeid = alleSamarbeid.last()

        val behovsvurdering = sak.opprettSpørreundersøkelse(prosessId = førsteSamarbeid.id)
        hentSpørreundersøkelse(sak.orgnr, sak.saksnummer, førsteSamarbeid.id, type = "Behovsvurdering")
            .map { it.id } shouldBe listOf(behovsvurdering.id)

        oppdaterBehovsvurdering(behovsvurdering, sak, sisteSamarbeid.id)
        hentSpørreundersøkelse(sak.orgnr, sak.saksnummer, førsteSamarbeid.id, type = "Behovsvurdering")
            .map { it.id } shouldBe emptyList()
        hentSpørreundersøkelse(sak.orgnr, sak.saksnummer, sisteSamarbeid.id, type = "Behovsvurdering")
            .map { it.id } shouldBe listOf(behovsvurdering.id)
    }

    @Test
    fun `skal ikke kunne flytte kartlegging en ugyldig prosess eller som lesebruker`() {
        val sak = nySakIKartlegges()
            .opprettNyttSamarbeid()
        val alleSamarbeid = sak.hentAlleSamarbeid()
        alleSamarbeid shouldHaveSize 1
        val behovsvurdering = sak.opprettSpørreundersøkelse(alleSamarbeid.first().id)

        // -- skal ikke kunne flytte til ikke eksisterende prosess
        shouldFail {
            oppdaterBehovsvurdering(behovsvurdering, sak, 100000)
        }

        // -- Lesebruker skal ikke kunne flytte saker
        shouldFail {
            oppdaterBehovsvurdering(
                behovsvurdering,
                sak,
                sak.hentAlleSamarbeid().first().id,
                oauth2ServerContainer.lesebruker.token,
            )
        }

        // -- skal ikke kunne flytte til prosess i en annen sak
        shouldFail {
            val nysak = nySakIKartlegges()
                .opprettNyttSamarbeid()
            oppdaterBehovsvurdering(behovsvurdering, sak, nysak.hentAlleSamarbeid().first().id)
        }
    }

    @Test
    fun `skal kunne avslutte en flyttet behovsvurdering`() {
        val sak = nySakIKartlegges()
            .opprettNyttSamarbeid()
            .opprettNyttSamarbeid()

        val alleSamarbeid = sak.hentAlleSamarbeid()
        alleSamarbeid shouldHaveSize 2

        val førsteSamarbeid = alleSamarbeid.first()
        val andreSamarbeid = alleSamarbeid.last()

        val behovsvurdering = sak.opprettSpørreundersøkelse(prosessId = førsteSamarbeid.id)
        behovsvurdering.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        val flyttetBehovsvurdering = oppdaterBehovsvurdering(behovsvurdering, sak, andreSamarbeid.id)
        flyttetBehovsvurdering.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = andreSamarbeid.id,
            type = "Behovsvurdering",
        ).forExactlyOne {
            it.status shouldBe AVSLUTTET
            it.samarbeidId shouldBe andreSamarbeid.id
        }

        hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = førsteSamarbeid.id,
            type = "Behovsvurdering",
        ) shouldHaveSize 0
    }

    fun enDeltakerSvarerPåEtSpørsmål(
        kartleggingDto: SpørreundersøkelseDto,
        sesjonId: String = UUID.randomUUID().toString(),
    ) {
        val førsteTema = kartleggingDto.temaMedSpørsmålOgSvaralternativer.first()
        val førsteSpørsmålId = førsteTema.spørsmålOgSvaralternativer.first().id
        val førsteSvarId = førsteTema.spørsmålOgSvaralternativer.first().svaralternativer.first().svarId
        sendKartleggingSvarTilKafka(
            kartleggingId = kartleggingDto.id,
            spørsmålId = førsteSpørsmålId,
            sesjonId = sesjonId,
            svarIder = listOf(førsteSvarId),
        )
    }
}
