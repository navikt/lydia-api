package no.nav.lydia.container.ia.sak.kartlegging

import com.github.kittinunf.fuel.core.extensions.authentication
import io.kotest.assertions.shouldFail
import io.kotest.inspectors.forAll
import io.kotest.matchers.collections.shouldContainAll
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.equals.shouldBeEqual
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.kotest.matchers.string.shouldHaveLength
import io.kotest.matchers.string.shouldMatch
import io.ktor.http.HttpStatusCode
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.IASakKartleggingHelper
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.avslutt
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.hentIASakKartlegginger
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.hentKartleggingMedDetaljer
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettKartlegging
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.sendKartleggingSvarTilKafka
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.start
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartlegges
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.lydiaApiContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.oauth2ServerContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.performDelete
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.sak.api.kartlegging.IASakKartleggingDto
import no.nav.lydia.ia.sak.api.kartlegging.KARTLEGGING_BASE_ROUTE
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.KartleggingStatus
import no.nav.lydia.ia.sak.domene.SpørreundersøkelseDto
import no.nav.lydia.ia.sak.domene.Temanavn
import org.junit.After
import org.junit.Before
import java.util.*
import kotlin.test.Test

class IASakKartleggingApiTest {
    val kartleggingKonsument = kafkaContainerHelper.nyKonsument(this::class.java.name)

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
            .tilSingelRespons<IASakKartleggingDto>()

        resp.third.get().kartleggingId.length shouldBe 36

        postgresContainer
            .hentEnkelKolonne<String>(
                "select kartlegging_id from ia_sak_kartlegging where kartlegging_id = '${resp.third.get().kartleggingId}'"
            ) shouldNotBe null
    }

    @Test
    fun `skal få feil når saksnummer er ukjent`() {
        val resp = IASakKartleggingHelper.opprettIASakKartlegging(orgnr = "123456789", saksnummer = "ukjent")
            .tilSingelRespons<IASakKartleggingDto>()

        resp.second.statusCode shouldBe HttpStatusCode.BadRequest.value
        resp.second.body().asString("text/plain") shouldMatch "Ugyldig saksnummer"
    }

    @Test
    fun `skal få feil når orgnummer er feil`() {
        val sak = nySakIKartlegges()
        val resp = IASakKartleggingHelper.opprettIASakKartlegging(orgnr = "222233334", saksnummer = sak.saksnummer)
            .tilSingelRespons<IASakKartleggingDto>()

        resp.second.statusCode shouldBe HttpStatusCode.BadRequest.value
        resp.second.body().asString("text/plain") shouldMatch "Ugyldig orgnummer"
    }

    @Test
    fun `skal få feil når sak ikke er i kartleggingsstatus`() {
        val sak = nySakIViBistår()
        val resp = IASakKartleggingHelper.opprettIASakKartlegging(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
            .tilSingelRespons<IASakKartleggingDto>()

        resp.second.statusCode shouldBe HttpStatusCode.Forbidden.value
        resp.second.body()
            .asString("text/plain") shouldMatch "Sak m.. v..re i kartleggingsstatus for .. starte kartlegging"
    }

    @Test
    fun `skal sende kartlegging på kafka`() {
        val sak = nySakIKartlegges()

        val resp = IASakKartleggingHelper.opprettIASakKartlegging(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
            .tilSingelRespons<IASakKartleggingDto>()

        val id = resp.third.get().kartleggingId

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = id,
                konsument = kartleggingKonsument
            ) { liste ->
                liste.map { melding ->
                    val spørreundersøkelse = Json.decodeFromString<SpørreundersøkelseDto>(melding)
                    spørreundersøkelse.spørreundersøkelseId shouldBe id
                    spørreundersøkelse.vertId shouldHaveLength 36
                    spørreundersøkelse.status shouldBe KartleggingStatus.OPPRETTET
                    spørreundersøkelse.temaMedSpørsmålOgSvaralternativer shouldHaveSize 1
                    spørreundersøkelse.temaMedSpørsmålOgSvaralternativer.forAll { tema ->
                        tema.spørsmålOgSvaralternativer shouldHaveSize 3
                        tema.spørsmålOgSvaralternativer.forAll {
                            it.svaralternativer shouldHaveSize 5
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
            .tilSingelRespons<IASakKartleggingDto>()

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
    fun `skal kunne hente ut en liste med minimal informasjon over alle kartlegginger knyttet til en sak dersom bruker ikke er eier`() {
        val sak = nySakIKartlegges()

        IASakKartleggingHelper.opprettIASakKartlegging(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
            .tilSingelRespons<IASakKartleggingDto>()

        val alleKartlegginger = hentIASakKartlegginger(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            token = oauth2ServerContainer.saksbehandler2.token
        )
        alleKartlegginger shouldHaveSize 1
        alleKartlegginger.forAll { it.vertId shouldBeEqual "" }
        alleKartlegginger.forAll { it.kartleggingId shouldBeEqual "" }
        alleKartlegginger.forAll { it.opprettetAv shouldBeEqual oauth2ServerContainer.saksbehandler1.navIdent }
        alleKartlegginger.forAll { it.opprettetTidspunkt shouldNotBe null }
        alleKartlegginger.forAll { it.endretTidspunkt shouldBe null }
    }

    @Test
    fun `nylig opprettet kartlegging får alle spørsmål med riktige svaralternativer knyttet til seg`() {
        val sak = nySakIKartlegges()

        // -- har kun partssamarbeid knyttet til seg pdd
        val kartlegging =
            IASakKartleggingHelper.opprettIASakKartlegging(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
                .tilSingelRespons<IASakKartleggingDto>().third.get()

        kartlegging.temaMedSpørsmålOgSvaralternativer.forAll { spørsmålOgSvarPerTema ->
            spørsmålOgSvarPerTema.temanavn shouldBe Temanavn.UTVIKLE_PARTSSAMARBEID
        }

        // Sjekk at hvert Tema inneholder de riktige spørsmålene --> dette skal fungere med flere temaer
        kartlegging.temaMedSpørsmålOgSvaralternativer.forEach { spørsmålOgSvarPerTema ->
            val temaId: Int =
                postgresContainer.hentEnkelKolonne(
                    "select tema_id from ia_sak_kartlegging_tema where navn = '${spørsmålOgSvarPerTema.temanavn}'"
                )
            val spørsmålIderForEtTema: List<String> =
                postgresContainer.hentAlleRaderTilEnkelKolonne<String>(
                    "select sporsmal_id from ia_sak_kartlegging_tema_til_spørsmål where tema_id = ${temaId}"
                )
            spørsmålOgSvarPerTema.spørsmålOgSvaralternativer.map { spørsmålMedSvar ->
                spørsmålMedSvar.id
            }.toList() shouldContainAll  spørsmålIderForEtTema
        }

        kartlegging.temaMedSpørsmålOgSvaralternativer.forEach {  spørsmålMedSvarPerTema ->
            spørsmålMedSvarPerTema.spørsmålOgSvaralternativer.forEach { spørsmålMedSvar ->
                val svarIderForEtSpørsmål: List<String> =
                    postgresContainer.hentAlleRaderTilEnkelKolonne<String>(
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
                .tilSingelRespons<IASakKartleggingDto>().third.get()
        kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        listOf(UUID.randomUUID().toString(), UUID.randomUUID().toString()).forAll { sesjonId ->
            enDeltakerSvarerPåEtSpørsmål(kartleggingDto = kartleggingDto, sesjonId = sesjonId)
        }

        kartleggingDto.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        val oppdatertKartleggingMedSvar = hentKartleggingMedDetaljer(
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
                .tilSingelRespons<IASakKartleggingDto>().third.get()
        kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        enDeltakerSvarerPåEtSpørsmål(kartleggingDto = kartleggingDto, UUID.randomUUID().toString())
        enDeltakerSvarerPåALLESpørsmål(kartleggingDto, sesjonId)

        kartleggingDto.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        val oppdatertKartleggingMedSvar = hentKartleggingMedDetaljer(
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
                .tilSingelRespons<IASakKartleggingDto>().third.get()
        kartlegging.status shouldBe KartleggingStatus.OPPRETTET

        val pågåendeKartlegging = kartlegging.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        listOf(UUID.randomUUID(), UUID.randomUUID(), UUID.randomUUID()).forEach { sesjonId ->
            enDeltakerSvarerPåEtSpørsmål(kartleggingDto = kartlegging, UUID.randomUUID().toString())
        }

        shouldFail {
            hentKartleggingMedDetaljer(
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
                .tilSingelRespons<IASakKartleggingDto>().third.get()
        kartlegging.status shouldBe KartleggingStatus.OPPRETTET

        val pågåendeKartlegging = kartlegging.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        listOf(UUID.randomUUID(), UUID.randomUUID()).forEach { sesjonId ->
            pågåendeKartlegging.temaMedSpørsmålOgSvaralternativer.forEach { spørsmålOgSvaralternativ ->
                sendKartleggingSvarTilKafka(
                    kartleggingId = pågåendeKartlegging.kartleggingId,
                    spørsmålId = spørsmålOgSvaralternativ.spørsmålOgSvaralternativer.first().id,
                    sesjonId = sesjonId.toString(),
                    svarId = spørsmålOgSvaralternativ.spørsmålOgSvaralternativer.first().svaralternativer.first().svarId
                )
            }
        }
        kartlegging.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        val oppdatertKartleggingMedSvar = hentKartleggingMedDetaljer(
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
    fun `kun eier av sak skal kunne hente resultater av kartlegging`() {
        val sak = nySakIKartlegges()
        val kartlegging = sak.opprettKartlegging()
        kartlegging.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        kartlegging.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        val resultater = hentKartleggingMedDetaljer(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            kartleggingId = kartlegging.kartleggingId
        )
        resultater.kartleggingId shouldBe kartlegging.kartleggingId

        sak.nyHendelse(IASakshendelseType.TA_EIERSKAP_I_SAK, token = oauth2ServerContainer.saksbehandler2.token)
        shouldFail {
            hentKartleggingMedDetaljer(
                token = oauth2ServerContainer.saksbehandler1.token,
                orgnr = sak.orgnr,
                saksnummer = sak.saksnummer,
                kartleggingId = kartlegging.kartleggingId
            )
        }
    }

    @Test
    fun `skal kunne starte kartlegging`() {
        val sak = nySakIKartlegges()
        val kartleggingDto = sak.opprettKartlegging()
        kartleggingDto.status shouldBe KartleggingStatus.OPPRETTET

        val pågåendeKartlegging = kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        pågåendeKartlegging.status shouldBe KartleggingStatus.PÅBEGYNT

        hentIASakKartlegginger(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
        ).forExactlyOne {
            it.status shouldBe KartleggingStatus.PÅBEGYNT
            it.endretTidspunkt shouldNotBe null
        }

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = kartleggingDto.kartleggingId,
                konsument = kartleggingKonsument
            ) {
                it.forExactlyOne { melding ->
                    val spørreundersøkelse = Json.decodeFromString<SpørreundersøkelseDto>(melding)
                    spørreundersøkelse.status shouldBe KartleggingStatus.PÅBEGYNT
                }
            }
        }
    }

    @Test
    fun `skal kunne avslutte en påbegynt kartlegging`() {
        val sak = nySakIKartlegges()
        val kartleggingDto = sak.opprettKartlegging()
        val påbegyntKartlegging = kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        påbegyntKartlegging.status shouldBe KartleggingStatus.PÅBEGYNT

        val avsluttetKartlegging = påbegyntKartlegging.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        avsluttetKartlegging.status shouldBe KartleggingStatus.AVSLUTTET

        hentIASakKartlegginger(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
        ).forExactlyOne {
            it.status shouldBe KartleggingStatus.AVSLUTTET
            it.endretTidspunkt shouldNotBe null
        }

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = kartleggingDto.kartleggingId,
                konsument = kartleggingKonsument
            ) {
                it.forExactlyOne { melding ->
                    val spørreundersøkelse = Json.decodeFromString<SpørreundersøkelseDto>(melding)
                    spørreundersøkelse.status shouldBe KartleggingStatus.AVSLUTTET
                }
            }
        }
    }

    @Test
    fun `skal ikke kunne avslutte kartlegging med status OPPRETTET`() {
        val sak = nySakIKartlegges()
        val kartleggingDto = sak.opprettKartlegging()
        kartleggingDto.status shouldBe KartleggingStatus.OPPRETTET

        val response =
            lydiaApiContainer.performPost("$KARTLEGGING_BASE_ROUTE/${sak.orgnr}/${sak.saksnummer}/${kartleggingDto.kartleggingId}/avslutt")
                .authentication().bearer(oauth2ServerContainer.saksbehandler1.token)
                .tilSingelRespons<IASakKartleggingDto>()

        response.second.statusCode shouldBe HttpStatusCode.Forbidden.value

        lydiaApiContainer shouldContainLog "Kartlegging er ikke i påbegynt".toRegex()
    }

    @Test
    fun `skal kunne slette en kartlegging`() {
        val sak = nySakIKartlegges()
        val kartleggingDto = sak.opprettKartlegging()
        kartleggingDto.status shouldBe KartleggingStatus.OPPRETTET

        val pågåendeKartlegging = kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        sendKartleggingSvarTilKafka(
            kartleggingId = pågåendeKartlegging.kartleggingId,
            spørsmålId = pågåendeKartlegging.temaMedSpørsmålOgSvaralternativer.first().spørsmålOgSvaralternativer.first().id,
            sesjonId = UUID.randomUUID().toString(),
            svarId = pågåendeKartlegging.temaMedSpørsmålOgSvaralternativer.first().spørsmålOgSvaralternativer.first().svaralternativer.first().svarId
        )

        postgresContainer
            .hentAlleRaderTilEnkelKolonne<String>(
                "select kartlegging_id from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingDto.kartleggingId}'"
            ) shouldHaveSize 1

        val response =
            lydiaApiContainer.performDelete("$KARTLEGGING_BASE_ROUTE/${sak.orgnr}/${sak.saksnummer}/${kartleggingDto.kartleggingId}")
                .authentication().bearer(oauth2ServerContainer.saksbehandler1.token)
                .tilSingelRespons<IASakKartleggingDto>()

        response.second.statusCode shouldBe HttpStatusCode.OK.value

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = kartleggingDto.kartleggingId,
                konsument = kartleggingKonsument
            ) {
                it.forExactlyOne { melding ->
                    val spørreundersøkelse = Json.decodeFromString<SpørreundersøkelseDto>(melding)
                    spørreundersøkelse.status shouldBe KartleggingStatus.SLETTET
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


    fun enDeltakerSvarerPåALLESpørsmål(
        kartleggingDto: IASakKartleggingDto,
        sesjonId: String = UUID.randomUUID().toString()
    ) {

        kartleggingDto.temaMedSpørsmålOgSvaralternativer.forEach { temaMedSpørsmålOgSvaralternativer ->
            temaMedSpørsmålOgSvaralternativer.spørsmålOgSvaralternativer.forEach { spørsmålMedSvarAlternativer ->
                spørsmålMedSvarAlternativer.svaralternativer.forEach { svar ->
                    sendKartleggingSvarTilKafka(
                        kartleggingId = kartleggingDto.kartleggingId,
                        spørsmålId = spørsmålMedSvarAlternativer.id,
                        sesjonId = sesjonId,
                        svarId = svar.svarId
                    )
                }
            }
        }
    }

    fun enDeltakerSvarerPåEtSpørsmål(
        kartleggingDto: IASakKartleggingDto,
        sesjonId: String = UUID.randomUUID().toString()
    ) {
        val førsteSpørsmålIFørsteTema = kartleggingDto.temaMedSpørsmålOgSvaralternativer.first()
            .spørsmålOgSvaralternativer.first()
        sendKartleggingSvarTilKafka(
            kartleggingId = kartleggingDto.kartleggingId,
            spørsmålId = førsteSpørsmålIFørsteTema.id,
            sesjonId = sesjonId,
            svarId = førsteSpørsmålIFørsteTema.svaralternativer.first().svarId
        )
    }
}
