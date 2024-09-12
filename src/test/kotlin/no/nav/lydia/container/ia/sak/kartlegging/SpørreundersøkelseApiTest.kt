package no.nav.lydia.container.ia.sak.kartlegging

import com.github.kittinunf.fuel.core.extensions.authentication
import ia.felles.integrasjoner.kafkameldinger.SpørreundersøkelseStatus.*
import io.kotest.assertions.shouldFail
import io.kotest.inspectors.forAll
import io.kotest.matchers.collections.shouldContainAll
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.collections.shouldNotBeEmpty
import io.kotest.matchers.equals.shouldBeEqual
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.kotest.matchers.string.shouldHaveLength
import io.kotest.matchers.string.shouldMatch
import io.kotest.matchers.string.shouldNotBeEmpty
import io.ktor.http.HttpStatusCode
import java.util.*
import kotlin.test.Test
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.IASakKartleggingHelper
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.avslutt
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.hentIASakKartlegginger
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.hentKartleggingMedSvar
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.oppdaterBehovsvurdering
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettKartlegging
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.sendKartleggingSvarTilKafka
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.start
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartlegges
import no.nav.lydia.helper.SakHelper.Companion.nySakIKontaktes
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.lydiaApiContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.oauth2ServerContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.performDelete
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.hentIAProsesser
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.eksport.SpørreundersøkelseProdusent.SerializableSpørreundersøkelse
import no.nav.lydia.ia.sak.api.spørreundersøkelse.BEHOVSVURDERING_BASE_ROUTE
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseDto
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import org.junit.After
import org.junit.Before

class SpørreundersøkelseApiTest {
    private val kartleggingKonsument = kafkaContainerHelper.nyKonsument(this::class.java.name)

    companion object {
        const val ID_TIL_SPØRSMÅL_MED_FLERVALG_MULIGHETER = "018f4e25-6a40-713f-b769-267afa134896"
    }

    @Before
    fun setUp() {
        kartleggingKonsument.subscribe(mutableListOf(Topic.SPORREUNDERSOKELSE_TOPIC.navn))
    }

    @After
    fun tearDown() {
        kartleggingKonsument.unsubscribe()
        kartleggingKonsument.close()
    }

    @Test
    fun `oppretter en ny kartlegging`() {
        val sak = nySakIKartlegges()

        val resp = IASakKartleggingHelper.opprettIASakKartlegging(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
            .tilSingelRespons<SpørreundersøkelseDto>()

        resp.third.get().kartleggingId.length shouldBe 36

        postgresContainer
            .hentEnkelKolonne<String>(
                "select kartlegging_id from ia_sak_kartlegging where kartlegging_id = '${resp.third.get().kartleggingId}'"
            ) shouldNotBe null
    }

    @Test
    fun `skal også kunne opprette en behovsvurdering i status VI_BISTÅR`() {
        val sak = nySakIViBistår()

        val resp = IASakKartleggingHelper.opprettIASakKartlegging(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
            .tilSingelRespons<SpørreundersøkelseDto>()

        resp.third.get().kartleggingId.length shouldBe 36

        postgresContainer
            .hentEnkelKolonne<String>(
                "select kartlegging_id from ia_sak_kartlegging where kartlegging_id = '${resp.third.get().kartleggingId}'"
            ) shouldNotBe null
    }

    @Test
    fun `skal kunne opprette en kartlegging med flere temaer`() {
        val sak = nySakIKartlegges()
        val kartleggingDto = sak.opprettKartlegging()

        kartleggingDto.temaMedSpørsmålOgSvaralternativer shouldHaveSize 3
        kartleggingDto.temaMedSpørsmålOgSvaralternativer.forAll {
            it.spørsmålOgSvaralternativer.shouldNotBeEmpty()
        }

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = kartleggingDto.kartleggingId,
                konsument = kartleggingKonsument,
            ) { meldinger ->
                meldinger.forExactlyOne { melding ->
                    val spørreundersøkelse =
                        Json.decodeFromString<SerializableSpørreundersøkelse>(melding)
                    spørreundersøkelse.temaMedSpørsmålOgSvaralternativer shouldHaveSize 3
                    spørreundersøkelse.temaMedSpørsmålOgSvaralternativer.forAll {
                        it.spørsmålOgSvaralternativer.shouldNotBeEmpty()
                        it.navn.shouldNotBeEmpty()
                    }
                }
            }
        }
    }

    @Test
    fun `skal få feil når saksnummer er ukjent`() {
        val resp = IASakKartleggingHelper.opprettIASakKartlegging(orgnr = "123456789", saksnummer = "ukjent")
            .tilSingelRespons<SpørreundersøkelseDto>()

        resp.second.statusCode shouldBe HttpStatusCode.BadRequest.value
        resp.second.body().asString("text/plain") shouldMatch "Ugyldig saksnummer"
    }

    @Test
    fun `skal få feil når orgnummer er feil`() {
        val sak = nySakIKartlegges()
        val resp = IASakKartleggingHelper.opprettIASakKartlegging(orgnr = "222233334", saksnummer = sak.saksnummer)
            .tilSingelRespons<SpørreundersøkelseDto>()

        resp.second.statusCode shouldBe HttpStatusCode.BadRequest.value
        resp.second.body().asString("text/plain") shouldMatch "Ugyldig orgnummer"
    }

    @Test
    fun `skal få feil når sak ikke er i riktig status (kartlegges eller vi bistår)`() {
        val sak = nySakIKontaktes()
        val resp = IASakKartleggingHelper.opprettIASakKartlegging(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
            .tilSingelRespons<SpørreundersøkelseDto>()

        resp.second.statusCode shouldBe HttpStatusCode.Forbidden.value
        resp.second.body()
            .asString("text/plain") shouldMatch "Sak m.. v..re i kartleggingsstatus for .. starte kartlegging"
    }

    @Test
    fun `skal sende kartlegging på kafka`() {
        val sak = nySakIKartlegges()

        val resp = IASakKartleggingHelper.opprettIASakKartlegging(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
        ).tilSingelRespons<SpørreundersøkelseDto>()

        val id = resp.third.get().kartleggingId

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = id,
                konsument = kartleggingKonsument
            ) { liste ->
                liste.map { melding ->
                    val spørreundersøkelse =
                        Json.decodeFromString<SerializableSpørreundersøkelse>(melding)
                    spørreundersøkelse.spørreundersøkelseId shouldBe id
                    spørreundersøkelse.orgnummer shouldBe sak.orgnr
                    spørreundersøkelse.virksomhetsNavn shouldBe "Navn ${sak.orgnr}"
                    spørreundersøkelse.status shouldBe OPPRETTET
                    spørreundersøkelse.temaMedSpørsmålOgSvaralternativer shouldHaveSize 3
                    spørreundersøkelse.temaMedSpørsmålOgSvaralternativer.forAll { tema ->
                        tema.spørsmålOgSvaralternativer.shouldNotBeEmpty()
                        tema.spørsmålOgSvaralternativer.forAll {
                            it.svaralternativer.shouldNotBeEmpty()
                        }
                    }
                }
            }
        }
    }

    @Test
    fun `skal kunne hente ut liste over alle kartlegginger knyttet til en sak`() {
        val sak = nySakIKartlegges()

        IASakKartleggingHelper.opprettIASakKartlegging(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
            .tilSingelRespons<SpørreundersøkelseDto>()

        val alleKartlegginger = hentIASakKartlegginger(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
        )
        alleKartlegginger shouldHaveSize 1
        alleKartlegginger.first().vertId shouldHaveLength 36
        alleKartlegginger.first().opprettetAv shouldBeEqual oauth2ServerContainer.saksbehandler1.navIdent
        alleKartlegginger.first().opprettetTidspunkt shouldNotBe null
        alleKartlegginger.first().endretTidspunkt shouldBe null
    }

    @Test
    fun `nylig opprettet kartlegging får alle spørsmål med riktige svaralternativer knyttet til seg`() {
        val sak = nySakIKartlegges()

        val behovsvurdering =
            IASakKartleggingHelper.opprettIASakKartlegging(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
                .tilSingelRespons<SpørreundersøkelseDto>().third.get()

        behovsvurdering.temaMedSpørsmålOgSvaralternativer.shouldNotBeEmpty()
        behovsvurdering.temaMedSpørsmålOgSvaralternativer.forEach { spørsmålOgSvarPerTema ->
            val temaId: Int =
                postgresContainer.hentEnkelKolonne(
                    "select tema_id from ia_sak_kartlegging_tema where beskrivelse = '${spørsmålOgSvarPerTema.navn}' and status = 'AKTIV'"
                )
            val spørsmålIderForEtTema: List<String> =
                postgresContainer.hentAlleRaderTilEnkelKolonne(
                    "select sporsmal_id from ia_sak_kartlegging_tema_til_spørsmål where tema_id = $temaId"
                )
            spørsmålOgSvarPerTema.spørsmålOgSvaralternativer.map { spørsmålMedSvar ->
                spørsmålMedSvar.id
            }.toList() shouldContainAll spørsmålIderForEtTema
        }

        behovsvurdering.temaMedSpørsmålOgSvaralternativer.forEach { spørsmålMedSvarPerTema ->
            spørsmålMedSvarPerTema.spørsmålOgSvaralternativer.forEach { spørsmålMedSvar ->
                val svarIderForEtSpørsmål: List<String> =
                    postgresContainer.hentAlleRaderTilEnkelKolonne(
                        "select svaralternativ_id from ia_sak_kartlegging_svaralternativer where sporsmal_id = '${spørsmålMedSvar.id}'"
                    )
                spørsmålMedSvar.svaralternativer.map { it.svarId }.toList() shouldContainAll svarIderForEtSpørsmål
            }
        }

    }

    @Test
    fun `skal hente antall unike deltakere som har svart på minst ett spørsmål`() {
        val sak = nySakIKartlegges()

        val kartleggingDto =
            IASakKartleggingHelper.opprettIASakKartlegging(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
                .tilSingelRespons<SpørreundersøkelseDto>().third.get()
        kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        listOf(UUID.randomUUID().toString(), UUID.randomUUID().toString()).forAll { sesjonId ->
            enDeltakerSvarerPåEtSpørsmål(kartleggingDto = kartleggingDto, sesjonId = sesjonId)
        }

        kartleggingDto.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        val oppdatertKartleggingMedSvar = hentKartleggingMedSvar(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            kartleggingId = kartleggingDto.kartleggingId
        )
        oppdatertKartleggingMedSvar.antallUnikeDeltakereMedMinstEttSvar shouldBe 2
        oppdatertKartleggingMedSvar.antallUnikeDeltakereSomHarSvartPåAlt shouldBe 0
    }

    @Test
    fun `skal hente antall unike deltakere som har svart på alle spørsmål`() {
        val sak = nySakIKartlegges()
        val sesjonId = UUID.randomUUID().toString()

        val kartleggingDto =
            IASakKartleggingHelper.opprettIASakKartlegging(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
                .tilSingelRespons<SpørreundersøkelseDto>().third.get()
        kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        enDeltakerSvarerPåEtSpørsmål(kartleggingDto = kartleggingDto, UUID.randomUUID().toString())
        enDeltakerSvarerPåALLESpørsmål(kartleggingDto, sesjonId)

        kartleggingDto.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        val oppdatertKartleggingMedSvar = hentKartleggingMedSvar(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            kartleggingId = kartleggingDto.kartleggingId
        )
        oppdatertKartleggingMedSvar.antallUnikeDeltakereMedMinstEttSvar shouldBe 2
        oppdatertKartleggingMedSvar.antallUnikeDeltakereSomHarSvartPåAlt shouldBe 1
    }

    @Test
    fun `skal ikke kunne hente resultat før kartlegging er avsluttet`() {
        val sak = nySakIKartlegges()
        val kartlegging =
            IASakKartleggingHelper.opprettIASakKartlegging(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
                .tilSingelRespons<SpørreundersøkelseDto>().third.get()
        kartlegging.status shouldBe OPPRETTET

        val pågåendeKartlegging = kartlegging.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        listOf(UUID.randomUUID(), UUID.randomUUID(), UUID.randomUUID()).forEach { sesjonId ->
            enDeltakerSvarerPåEtSpørsmål(kartleggingDto = kartlegging, UUID.randomUUID().toString())
        }

        shouldFail {
            hentKartleggingMedSvar(
                orgnr = sak.orgnr,
                saksnummer = sak.saksnummer,
                kartleggingId = pågåendeKartlegging.kartleggingId
            )
        }

    }

    @Test
    fun `skal ikke kunne få antall svar dersom antall deltakere er færre enn 3`() {
        val sak = nySakIKartlegges()
        val kartlegging =
            IASakKartleggingHelper.opprettIASakKartlegging(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
                .tilSingelRespons<SpørreundersøkelseDto>().third.get()
        kartlegging.status shouldBe OPPRETTET

        val pågåendeKartlegging = kartlegging.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        listOf(UUID.randomUUID(), UUID.randomUUID()).forEach { sesjonId ->
            pågåendeKartlegging.temaMedSpørsmålOgSvaralternativer.forEach { spørsmålOgSvaralternativ ->
                sendKartleggingSvarTilKafka(
                    kartleggingId = pågåendeKartlegging.kartleggingId,
                    spørsmålId = spørsmålOgSvaralternativ.spørsmålOgSvaralternativer.first().id,
                    sesjonId = sesjonId.toString(),
                    svarIder = listOf(spørsmålOgSvaralternativ.spørsmålOgSvaralternativer.first().svaralternativer.first().svarId)
                )
            }
        }
        kartlegging.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        val oppdatertKartleggingMedSvar = hentKartleggingMedSvar(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            kartleggingId = pågåendeKartlegging.kartleggingId
        )
        oppdatertKartleggingMedSvar.antallUnikeDeltakereMedMinstEttSvar shouldBe 2
        oppdatertKartleggingMedSvar.spørsmålMedSvarPerTema.forAll { temaMedSpørsmålOgSvar ->
            temaMedSpørsmålOgSvar.spørsmålMedSvar.forAll { spørsmålMedSvar ->
                spørsmålMedSvar.svarListe.forAll { svar ->
                    svar.antallSvar shouldBe 0
                }
            }
        }
    }

    @Test
    fun `skal få svardetaljer for et spørsmål dersom antall besvarelser er 3 eller flere`() {
        val sak = nySakIKartlegges()
        val kartlegging =
            IASakKartleggingHelper.opprettIASakKartlegging(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
                .tilSingelRespons<SpørreundersøkelseDto>().third.get()
        kartlegging.status shouldBe OPPRETTET

        val pågåendeKartlegging = kartlegging.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        val spørsmålOgSvaralternativ =
            pågåendeKartlegging.temaMedSpørsmålOgSvaralternativer.first().spørsmålOgSvaralternativer.first()
        val svaralternativ = spørsmålOgSvaralternativ.svaralternativer.first()
        listOf(UUID.randomUUID(), UUID.randomUUID(), UUID.randomUUID()).forEach { sesjonId ->
            sendKartleggingSvarTilKafka(
                kartleggingId = pågåendeKartlegging.kartleggingId,
                spørsmålId = spørsmålOgSvaralternativ.id,
                sesjonId = sesjonId.toString(),
                svarIder = listOf(svaralternativ.svarId)
            )
        }
        kartlegging.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        val oppdatertKartleggingMedSvar = hentKartleggingMedSvar(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            kartleggingId = pågåendeKartlegging.kartleggingId
        )
        oppdatertKartleggingMedSvar.antallUnikeDeltakereMedMinstEttSvar shouldBe 3
        oppdatertKartleggingMedSvar.antallUnikeDeltakereSomHarSvartPåAlt shouldBe 0
        oppdatertKartleggingMedSvar.spørsmålMedSvarPerTema.forExactlyOne { temaMedSpørsmålOgSvar ->
            temaMedSpørsmålOgSvar.navn shouldNotBe null
            temaMedSpørsmålOgSvar.tema shouldBe null
            temaMedSpørsmålOgSvar.beskrivelse shouldBe null
            temaMedSpørsmålOgSvar.spørsmålMedSvar.forExactlyOne { spørsmålMedSvar ->
                spørsmålMedSvar.svarListe.forExactlyOne { svar ->
                    svar.antallSvar shouldBe 3
                }
            }
        }
    }

    @Test
    fun `alle med tilgang til fia skal kunne hente resultater av kartlegging`() {
        val sak = nySakIKartlegges()
        val kartlegging = sak.opprettKartlegging()
        kartlegging.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        kartlegging.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        val resultater = hentKartleggingMedSvar(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            kartleggingId = kartlegging.kartleggingId
        )
        resultater.kartleggingId shouldBe kartlegging.kartleggingId

        val kartleggingMedSvar = hentKartleggingMedSvar(
            token = oauth2ServerContainer.saksbehandler2.token,
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            kartleggingId = kartlegging.kartleggingId
        )
        kartleggingMedSvar.kartleggingId shouldBe kartlegging.kartleggingId
    }

    @Test
    fun `skal kunne starte kartlegging`() {
        val sak = nySakIKartlegges()
        val kartleggingDto = sak.opprettKartlegging()
        kartleggingDto.status shouldBe OPPRETTET

        val pågåendeKartlegging = kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        pågåendeKartlegging.status shouldBe PÅBEGYNT

        hentIASakKartlegginger(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
        ).forExactlyOne {
            it.status shouldBe PÅBEGYNT
            it.endretTidspunkt shouldNotBe null
        }

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = kartleggingDto.kartleggingId,
                konsument = kartleggingKonsument
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
        val sak = nySakIKartlegges()
        val kartleggingDto = sak.opprettKartlegging()
        val påbegyntKartlegging = kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        påbegyntKartlegging.status shouldBe PÅBEGYNT

        val avsluttetKartlegging = påbegyntKartlegging.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        avsluttetKartlegging.status shouldBe AVSLUTTET

        hentIASakKartlegginger(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
        ).forExactlyOne {
            it.status shouldBe AVSLUTTET
            it.endretTidspunkt shouldNotBe null
        }

        runBlocking {
            // -- topic for fia-arbeidsgiver
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = kartleggingDto.kartleggingId,
                konsument = kartleggingKonsument
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
        val sak = nySakIKartlegges()
        val kartleggingDto = sak.opprettKartlegging()
        kartleggingDto.status shouldBe OPPRETTET

        val response =
            lydiaApiContainer.performPost("$BEHOVSVURDERING_BASE_ROUTE/${sak.orgnr}/${sak.saksnummer}/${kartleggingDto.kartleggingId}/avslutt")
                .authentication().bearer(oauth2ServerContainer.saksbehandler1.token)
                .tilSingelRespons<SpørreundersøkelseDto>()

        response.second.statusCode shouldBe HttpStatusCode.Forbidden.value

        lydiaApiContainer shouldContainLog "Kartlegging er ikke i påbegynt".toRegex()
    }

    @Test
    fun `skal kunne slette en kartlegging`() {
        val sak = nySakIKartlegges()
        val kartleggingDto = sak.opprettKartlegging()
        kartleggingDto.status shouldBe OPPRETTET

        val pågåendeKartlegging = kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        sendKartleggingSvarTilKafka(
            kartleggingId = pågåendeKartlegging.kartleggingId,
            spørsmålId = pågåendeKartlegging.temaMedSpørsmålOgSvaralternativer.first().spørsmålOgSvaralternativer.first().id,
            sesjonId = UUID.randomUUID().toString(),
            svarIder = listOf(pågåendeKartlegging.temaMedSpørsmålOgSvaralternativer.first().spørsmålOgSvaralternativer.first().svaralternativer.first().svarId)
        )

        postgresContainer
            .hentAlleRaderTilEnkelKolonne<String>(
                "select kartlegging_id from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingDto.kartleggingId}'"
            ) shouldHaveSize 1

        val response =
            lydiaApiContainer.performDelete("$BEHOVSVURDERING_BASE_ROUTE/${sak.orgnr}/${sak.saksnummer}/${kartleggingDto.kartleggingId}")
                .authentication().bearer(oauth2ServerContainer.saksbehandler1.token)
                .tilSingelRespons<SpørreundersøkelseDto>()

        response.second.statusCode shouldBe HttpStatusCode.OK.value

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = kartleggingDto.kartleggingId,
                konsument = kartleggingKonsument
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
                "select kartlegging_id from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingDto.kartleggingId}'"
            ) shouldHaveSize 0
        postgresContainer
            .hentAlleRaderTilEnkelKolonne<String>(
                "select status from ia_sak_kartlegging where kartlegging_id = '${kartleggingDto.kartleggingId}'"
            ).forAll { it shouldBe "SLETTET" }

        hentIASakKartlegginger(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
        ) shouldHaveSize 0
    }

    @Test
    fun `skal kunne slette en kartlegging i status VI_BISTÅR`() {
        val sak = nySakIViBistår()
        val kartleggingDto = sak.opprettKartlegging()
        kartleggingDto.status shouldBe OPPRETTET
        kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        val response =
            lydiaApiContainer.performDelete("$BEHOVSVURDERING_BASE_ROUTE/${sak.orgnr}/${sak.saksnummer}/${kartleggingDto.kartleggingId}")
                .authentication().bearer(oauth2ServerContainer.saksbehandler1.token)
                .tilSingelRespons<SpørreundersøkelseDto>()

        response.second.statusCode shouldBe HttpStatusCode.OK.value

        postgresContainer
            .hentAlleRaderTilEnkelKolonne<String>(
                "select kartlegging_id from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingDto.kartleggingId}'"
            ) shouldHaveSize 0
        postgresContainer
            .hentAlleRaderTilEnkelKolonne<String>(
                "select status from ia_sak_kartlegging where kartlegging_id = '${kartleggingDto.kartleggingId}'"
            ).forAll { it shouldBe "SLETTET" }

        hentIASakKartlegginger(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
        ) shouldHaveSize 0
    }

    @Test
    fun `skal kunne opprette behovsvurdering for to forskjellige prosesser`() {
        val sak = nySakIKartlegges()
            .nyHendelse(hendelsestype = IASakshendelseType.NY_PROSESS)
            .nyHendelse(hendelsestype = IASakshendelseType.NY_PROSESS)

        val iaProsesser = sak.hentIAProsesser()
        iaProsesser shouldHaveSize 2
        iaProsesser.forEach {
            sak.opprettKartlegging(prosessId = it.id)

            hentIASakKartlegginger(
                orgnr = sak.orgnr,
                saksnummer = sak.saksnummer,
                prosessId = it.id
            ) shouldHaveSize 1
        }
    }

    @Test
    fun `skal kunne flytte en behhovsvurdering fra en prosess til en annen`() {
        val sak = nySakIKartlegges()
            .nyHendelse(hendelsestype = IASakshendelseType.NY_PROSESS)
            .nyHendelse(hendelsestype = IASakshendelseType.NY_PROSESS)
        val iaProsesser = sak.hentIAProsesser()
        iaProsesser shouldHaveSize 2
        val fraProsess = iaProsesser.first()
        val tilProsess = iaProsesser.last()

        val behovsvurdering = sak.opprettKartlegging(prosessId = fraProsess.id)
        hentIASakKartlegginger(sak.orgnr, sak.saksnummer, fraProsess.id)
            .map { it.kartleggingId } shouldBe listOf(behovsvurdering.kartleggingId)

        oppdaterBehovsvurdering(behovsvurdering, sak, tilProsess.id)
        hentIASakKartlegginger(sak.orgnr, sak.saksnummer, fraProsess.id)
            .map { it.kartleggingId } shouldBe emptyList()
        hentIASakKartlegginger(sak.orgnr, sak.saksnummer, tilProsess.id)
            .map { it.kartleggingId } shouldBe listOf(behovsvurdering.kartleggingId)
    }

    @Test
    fun `skal ikke kunne flytte kartlegging en ugyldig prosess eller som lesebruker`() {
        val sak = nySakIKartlegges()
            .nyHendelse(hendelsestype = IASakshendelseType.NY_PROSESS)
        val prosesser = sak.hentIAProsesser()
        prosesser shouldHaveSize 1
        val behovsvurdering = sak.opprettKartlegging(prosesser.first().id)

        // -- skal ikke kunne flytte til ikke eksisterende prosess
        shouldFail {
            oppdaterBehovsvurdering(behovsvurdering, sak, 100000)
        }

        // -- Lesebruker skal ikke kunne flytte saker
        shouldFail {
            oppdaterBehovsvurdering(
                behovsvurdering,
                sak,
                sak.hentIAProsesser().first().id,
                oauth2ServerContainer.lesebruker.token)
        }

        // -- skal ikke kunne flytte til prosess i en annen sak
        shouldFail {
            val nysak = nySakIKartlegges()
                .nyHendelse(IASakshendelseType.NY_PROSESS)
            oppdaterBehovsvurdering(behovsvurdering, sak, nysak.hentIAProsesser().first().id)
        }
    }

    fun enDeltakerSvarerPåALLESpørsmål(
        kartleggingDto: SpørreundersøkelseDto,
        sesjonId: String = UUID.randomUUID().toString(),
    ) {
        kartleggingDto.temaMedSpørsmålOgSvaralternativer.forEach { temaMedSpørsmålOgSvaralternativer ->
            temaMedSpørsmålOgSvaralternativer.spørsmålOgSvaralternativer.forEach { spørsmålMedSvarAlternativer ->
                spørsmålMedSvarAlternativer.svaralternativer.first().let { svar ->
                    sendKartleggingSvarTilKafka(
                        kartleggingId = kartleggingDto.kartleggingId,
                        spørsmålId = spørsmålMedSvarAlternativer.id,
                        sesjonId = sesjonId,
                        svarIder = listOf(svar.svarId)
                    )
                }
            }
        }
    }

    fun enDeltakerSvarerPåEtSpørsmål(
        kartleggingDto: SpørreundersøkelseDto,
        sesjonId: String = UUID.randomUUID().toString(),
    ) {
        val førsteTema = kartleggingDto.temaMedSpørsmålOgSvaralternativer.first()
        val førsteSpørsmålId = førsteTema.spørsmålOgSvaralternativer.first().id
        val førsteSvarId = førsteTema.spørsmålOgSvaralternativer.first().svaralternativer.first().svarId
        sendKartleggingSvarTilKafka(
            kartleggingId = kartleggingDto.kartleggingId,
            spørsmålId = førsteSpørsmålId,
            sesjonId = sesjonId,
            svarIder = listOf(førsteSvarId)
        )
    }
}
