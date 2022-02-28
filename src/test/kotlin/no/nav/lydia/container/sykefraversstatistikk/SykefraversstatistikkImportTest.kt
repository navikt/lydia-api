package no.nav.lydia.container.sykefraversstatistikk

import com.github.kittinunf.fuel.gson.responseObject
import com.github.kittinunf.result.getOrElse
import com.google.gson.GsonBuilder
import io.kotest.matchers.ints.shouldBeExactly
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.HttpMock
import no.nav.lydia.helper.IntegrationsHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.withLydiaToken
import no.nav.lydia.helper.TestSted
import no.nav.lydia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import no.nav.lydia.sykefraversstatistikk.api.SykefraversstatistikkVirksomhetDto
import no.nav.lydia.virksomhet.VirksomhetRepository
import no.nav.lydia.virksomhet.brreg.BrregDownloader
import no.nav.lydia.virksomhet.ssb.NæringsDownloader
import no.nav.lydia.virksomhet.ssb.NæringsRepository
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.BeforeTest
import kotlin.test.Test
import kotlin.test.fail

class SykefraversstatistikkImportTest {
    val lydiaApi = TestContainerHelper.lydiaApiContainer
    val kafkaContainer = TestContainerHelper.kafkaContainerHelper
    val postgres = TestContainerHelper.postgresContainer
    val gson = GsonBuilder().create()
    val testOrgnr = "987654321"

    companion object {
        val httpMock = HttpMock()

        @BeforeClass
        @JvmStatic
        fun setupMock() {
            httpMock.start()
            IntegrationsHelper.mockKallMotBrregUnderhenter(httpMock = httpMock)
            IntegrationsHelper.mockKallMotSsbNæringer(httpMock = httpMock)
            TestContainerHelper.postgresContainer.getDataSource().use { dataSource ->
                NæringsDownloader(
                    url = IntegrationsHelper.mockKallMotSsbNæringer(httpMock = httpMock),
                    næringsRepository = NæringsRepository(dataSource = dataSource)).lastNedNæringer()

                BrregDownloader(
                    url = IntegrationsHelper.mockKallMotBrregUnderhenter(httpMock = httpMock),
                    virksomhetRepository = VirksomhetRepository(dataSource = dataSource)).lastNed()
            }
        }

        @AfterClass
        @JvmStatic
        fun afterAll() {
            httpMock.stop()
        }
    }

    @Test
    fun `importerte data skal kunne hentes ut og være like`() {
        val kafkaMelding = kafkaContainer.sykefraversstatistikkKafkaMelding()
        kafkaContainer.sendOgVentTilKonsumert(
            key = gson.toJson(kafkaMelding.key), value = gson.toJson(kafkaMelding.value)
        )

        val result = lydiaApi.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$testOrgnr")
            .withLydiaToken()
            .responseObject<List<SykefraversstatistikkVirksomhetDto>>().third

        result.fold(success = { dtos ->
            dtos.size shouldBeExactly 1
            val dto = dtos[0]
            dto.orgnr shouldBe kafkaMelding.value.virksomhetSykefravær.orgnr
            dto.arstall shouldBe kafkaMelding.value.virksomhetSykefravær.årstall
            dto.kvartal shouldBe kafkaMelding.value.virksomhetSykefravær.kvartal
            dto.sykefraversprosent shouldBe kafkaMelding.value.virksomhetSykefravær.prosent
            dto.antallPersoner shouldBe kafkaMelding.value.virksomhetSykefravær.antallPersoner
            dto.muligeDagsverk shouldBe kafkaMelding.value.virksomhetSykefravær.muligeDagsverk
            dto.tapteDagsverk shouldBe kafkaMelding.value.virksomhetSykefravær.tapteDagsverk
        }, failure = {
            fail(it.message)
        })
    }

    @Test
    fun `import av data er idempotent`() {
        kafkaContainer.sendSykefraversstatistikkKafkaMelding(TestSted.oslo)

        val førsteLagredeStatistikk = lydiaApi.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$testOrgnr")
            .withLydiaToken()
            .responseObject<List<SykefraversstatistikkVirksomhetDto>>().third
            .getOrElse { fail(it.message) }

        kafkaContainer.sendSykefraversstatistikkKafkaMelding(TestSted.oslo)

        val second = lydiaApi.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$testOrgnr")
            .withLydiaToken()
            .responseObject<List<SykefraversstatistikkVirksomhetDto>>().third

        second.fold(success = { dtos ->
            dtos.size shouldBeExactly 1
            val dto = dtos[0]
            dto.orgnr shouldBe førsteLagredeStatistikk[0].orgnr
            dto.arstall shouldBe førsteLagredeStatistikk[0].arstall
            dto.kvartal shouldBe førsteLagredeStatistikk[0].kvartal
            dto.sykefraversprosent shouldBe førsteLagredeStatistikk[0].sykefraversprosent
            dto.antallPersoner shouldBe førsteLagredeStatistikk[0].antallPersoner
            dto.muligeDagsverk shouldBe førsteLagredeStatistikk[0].muligeDagsverk
            dto.tapteDagsverk shouldBe førsteLagredeStatistikk[0].tapteDagsverk
        }, failure = {
            fail(it.message)
        })
    }

    @Test
    fun `vi lagrer metadata ved import`() {
        kafkaContainer.sendSykefraversstatistikkKafkaMelding(TestSted.oslo)

        val rs = postgres.performQuery("SELECT * FROM virksomhet_statistikk_metadata WHERE orgnr = '$testOrgnr'")

        rs.row shouldBe 1
    }
}

