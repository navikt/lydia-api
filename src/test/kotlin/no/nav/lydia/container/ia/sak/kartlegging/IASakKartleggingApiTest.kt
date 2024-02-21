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
import java.util.*
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.IASakKartleggingHelper
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.avslutt
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.hentIASakKartlegginger
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.hentResultaterForKartlegging
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettKartlegging
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.start
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartlegges
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.oauth2ServerContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.sak.api.kartlegging.IASakKartleggingDto
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.KartleggingStatus
import no.nav.lydia.ia.sak.domene.SpørreundersøkelseDto
import org.junit.After
import org.junit.Before
import kotlin.test.Test
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.sendKartleggingSvarTilKafka
import no.nav.lydia.helper.TestContainerHelper.Companion.lydiaApiContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.ia.sak.api.kartlegging.KARTLEGGING_BASE_ROUTE

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
                    spørreundersøkelse.spørsmålOgSvaralternativer shouldHaveSize 3
                    spørreundersøkelse.spørsmålOgSvaralternativer.forAll {
                        it.svaralternativer shouldHaveSize 5
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
    fun `nylig opprettet kartlegging får alle spørsmål med rette svar knyttet til seg`() {
        val sak = nySakIKartlegges()

        val spørsmålIder =
            postgresContainer.hentAlleRaderTilEnkelKolonne<String>("select sporsmal_id from ia_sak_kartlegging_sporsmal")

        val kartleggingId =
            IASakKartleggingHelper.opprettIASakKartlegging(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
                .tilSingelRespons<IASakKartleggingDto>().third.get().kartleggingId

        val kartleggingMedSvar = hentResultaterForKartlegging(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            kartleggingId = kartleggingId
        )
        kartleggingMedSvar.kartleggingId shouldBe kartleggingId
        kartleggingMedSvar.spørsmålMedSvar.map { it.spørsmålId } shouldContainAll spørsmålIder

        kartleggingMedSvar.spørsmålMedSvar.forAll { spørsmålMedSvar ->
            val svarIder =
                postgresContainer.hentAlleRaderTilEnkelKolonne<String>(
                    "select svaralternativ_id from ia_sak_kartlegging_svaralternativer where sporsmal_id = '${spørsmålMedSvar.spørsmålId}'"
                )
            spørsmålMedSvar.svarListe.map { it.svarId } shouldContainAll svarIder
        }

    }

    @Test
    fun `skal hente antall unike deltakere som har svart på minst ett spørsmål`() {
        val sak = nySakIKartlegges()

        val kartleggingId =
            IASakKartleggingHelper.opprettIASakKartlegging(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
                .tilSingelRespons<IASakKartleggingDto>().third.get().kartleggingId

        val kartleggingMedSvar = hentResultaterForKartlegging(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            kartleggingId = kartleggingId
        )

        sendKartleggingSvarTilKafka(
            kartleggingId = kartleggingId,
            spørsmålId = kartleggingMedSvar.spørsmålMedSvar.first().spørsmålId,
            sesjonId = UUID.randomUUID().toString(),
            svarId = kartleggingMedSvar.spørsmålMedSvar.first().svarListe.first().svarId
        )

        sendKartleggingSvarTilKafka(
            kartleggingId = kartleggingId,
            spørsmålId = kartleggingMedSvar.spørsmålMedSvar.first().spørsmålId,
            sesjonId = UUID.randomUUID().toString(),
            svarId = kartleggingMedSvar.spørsmålMedSvar.first().svarListe.first().svarId
        )

        val oppdatertKartleggingMedSvar = hentResultaterForKartlegging(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            kartleggingId = kartleggingId
        )
        oppdatertKartleggingMedSvar.antallUnikeDeltakereMedMinstEttSvar shouldBe 2
    }

    @Test
    fun `skal ikke kune hente resultat før kartlegging er avsluttet`() {
        val sak = nySakIKartlegges()
        val kartlegging =
            IASakKartleggingHelper.opprettIASakKartlegging(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
                .tilSingelRespons<IASakKartleggingDto>().third.get()
        kartlegging.status shouldBe KartleggingStatus.OPPRETTET

        val pågåendeKartlegging = kartlegging.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        sendKartleggingSvarTilKafka(
            kartleggingId = pågåendeKartlegging.kartleggingId,
            spørsmålId = pågåendeKartlegging.spørsmålOgSvaralternativer.first().id,
            sesjonId = UUID.randomUUID().toString(),
            svarId = pågåendeKartlegging.spørsmålOgSvaralternativer.first().svaralternativer.first().svarId
        )

        val oppdatertKartleggingMedSvar = hentResultaterForKartlegging(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            kartleggingId = pågåendeKartlegging.kartleggingId
        )
        oppdatertKartleggingMedSvar.antallUnikeDeltakereMedMinstEttSvar shouldBe 1
        oppdatertKartleggingMedSvar.spørsmålMedSvar.forAll { it.svarListe.forAll { it.antallSvar shouldBe 0 } }

        val avsluttetKartlegging = kartlegging.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        val avsluttetKartleggingMedSvar = hentResultaterForKartlegging(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            kartleggingId = avsluttetKartlegging.kartleggingId
        )
        avsluttetKartleggingMedSvar.antallUnikeDeltakereMedMinstEttSvar shouldBe 1
        avsluttetKartleggingMedSvar.spørsmålMedSvar.first().svarListe.first().antallSvar shouldBe 1
    }

    @Test
    fun `kun eier av sak skal kunne hente resultater av kartlegging`() {
        val sak = nySakIKartlegges()
        val kartlegging = sak.opprettKartlegging()
        val resultater = hentResultaterForKartlegging(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            kartleggingId = kartlegging.kartleggingId
        )
        resultater.kartleggingId shouldBe kartlegging.kartleggingId

        sak.nyHendelse(IASakshendelseType.TA_EIERSKAP_I_SAK, token = oauth2ServerContainer.saksbehandler2.token)
        shouldFail {
            hentResultaterForKartlegging(
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

        val response = lydiaApiContainer.performPost("$KARTLEGGING_BASE_ROUTE/${sak.orgnr}/${sak.saksnummer}/${kartleggingDto.kartleggingId}/avslutt")
            .authentication().bearer(oauth2ServerContainer.saksbehandler1.token)
            .tilSingelRespons<IASakKartleggingDto>()

        response.second.statusCode shouldBe HttpStatusCode.Forbidden.value

        lydiaApiContainer shouldContainLog "Kartlegging er ikke i påbegynt".toRegex()
    }
}
