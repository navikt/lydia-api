package no.nav.lydia.container.ia.sak.kartlegging

import io.kotest.inspectors.forAll
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.kotest.matchers.string.shouldMatch
import io.ktor.http.HttpStatusCode
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import kotlin.test.Test
import no.nav.lydia.helper.IASakKartleggingHelper
import no.nav.lydia.helper.KafkaContainerHelper
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartlegges
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.sak.api.kartlegging.IASakKartleggingDto
import org.junit.After
import org.junit.Before

class IASakSpørsmålOgSvaralternativerTest {
    val kartleggingKonsument = kafkaContainerHelper.nyKonsument(this::class.java.name)
    @Before
    fun setUp() {
        kartleggingKonsument.subscribe(mutableListOf(KafkaContainerHelper.iaSakKartleggingTopic))
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

        resp.third.get().id.length shouldBe 36

        postgresContainer
            .hentEnkelKolonne<String>(
                "select kartlegging_id from ia_sak_kartlegging where kartlegging_id = '${resp.third.get().id}'"
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
        resp.second.body().asString("text/plain") shouldMatch "Sak m.. v..re i kartleggingsstatus for .. starte kartlegging"
    }

    @Test
    fun `skal sende kartlegging på kafka`() {
        val sak = nySakIKartlegges()

        val resp = IASakKartleggingHelper.opprettIASakKartlegging(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
            .tilSingelRespons<IASakKartleggingDto>()

        val id = resp.third.get().id

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = id,
                konsument = kartleggingKonsument
            ) { liste ->
                liste.map { melding ->
                    val kartlegging = Json.decodeFromString<IASakKartleggingDto>(melding)
                    kartlegging.id shouldBe id
                    kartlegging.status shouldBe "OPPRETTET"
                    kartlegging.spørsmålOgSvaralternativer shouldHaveSize 3
                    kartlegging.spørsmålOgSvaralternativer.forAll {
                        it.svaralternativer shouldHaveSize 5
                    }
                }
            }
        }
    }
}
