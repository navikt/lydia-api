package no.nav.lydia.container.ia.sak.kartlegging

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
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.hentResultaterForKartlegging
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettKartlegging
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
        alleKartlegginger.forAll { it.spørsmålOgSvaralternativer shouldHaveSize 0 }
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
    fun `skal kunne avslutte kartlegging`() {
        val sak = nySakIKartlegges()
        val kartleggingDto = sak.opprettKartlegging()
        kartleggingDto.status shouldBe KartleggingStatus.OPPRETTET

        val avsluttetKartlegging = kartleggingDto.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        avsluttetKartlegging.status shouldBe KartleggingStatus.AVSLUTTET

        hentIASakKartlegginger(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
        ).forExactlyOne {
            it.status shouldBe KartleggingStatus.AVSLUTTET
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
}
