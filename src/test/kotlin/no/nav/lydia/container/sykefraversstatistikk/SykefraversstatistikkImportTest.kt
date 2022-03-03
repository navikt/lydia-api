package no.nav.lydia.container.sykefraversstatistikk

import com.github.kittinunf.fuel.gson.responseObject
import com.github.kittinunf.result.getOrElse
import com.google.gson.GsonBuilder
import io.kotest.inspectors.forAtLeastOne
import io.kotest.inspectors.forExactly
import io.kotest.matchers.collections.shouldContain
import io.kotest.matchers.collections.shouldContainAll
import io.kotest.matchers.ints.shouldBeExactly
import io.kotest.matchers.ints.shouldBeGreaterThan
import io.kotest.matchers.ints.shouldBeGreaterThanOrEqual
import io.kotest.matchers.should
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldHave
import no.nav.lydia.helper.HttpMock
import no.nav.lydia.helper.IntegrationsHelper
import no.nav.lydia.helper.IntegrationsHelper.Companion.orgnr_CESNAUSKAITE_oslo
import no.nav.lydia.helper.Melding
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.withLydiaToken
import no.nav.lydia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import no.nav.lydia.sykefraversstatistikk.api.SykefraversstatistikkVirksomhetDto
import no.nav.lydia.virksomhet.VirksomhetRepository
import no.nav.lydia.virksomhet.brreg.BrregDownloader
import no.nav.lydia.virksomhet.ssb.NæringsDownloader
import no.nav.lydia.virksomhet.ssb.NæringsRepository
import org.junit.AfterClass
import kotlin.test.Test
import kotlin.test.fail

class SykefraversstatistikkImportTest {
    val lydiaApi = TestContainerHelper.lydiaApiContainer
    val kafkaContainer = TestContainerHelper.kafkaContainerHelper
    val postgres = TestContainerHelper.postgresContainer
    val gson = GsonBuilder().create()

    companion object {
        val httpMock = HttpMock()

        init {
            httpMock.start()
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
        fun `kan importere statistikk for flere kvartal`() {
            kafkaContainer.sendSykefraversstatistikkKafkaMelding(melding = Melding.oslo)

            lydiaApi.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$orgnr_CESNAUSKAITE_oslo")
                .withLydiaToken()
                .responseObject<List<SykefraversstatistikkVirksomhetDto>>().third
                .fold(success = { osloAndreKvart ->
                    osloAndreKvart.size shouldBeExactly 1
                    osloAndreKvart.first().kvartal shouldBeExactly 2
                    osloAndreKvart.first().arstall shouldBeExactly 2020
                    osloAndreKvart.first().orgnr shouldBe orgnr_CESNAUSKAITE_oslo
                }, failure = {
                    fail(it.message)
                })

            kafkaContainer.sendSykefraversstatistikkKafkaMelding(melding = Melding.osloTredjeKvartal)

            lydiaApi.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$orgnr_CESNAUSKAITE_oslo")
                .withLydiaToken()
                .responseObject<List<SykefraversstatistikkVirksomhetDto>>().third
                .fold(success = { osloAndreOgTredjeKvart ->
                    osloAndreOgTredjeKvart.size shouldBeExactly 2
                    osloAndreOgTredjeKvart.map { it.kvartal } shouldContainAll listOf(2,3)
                    osloAndreOgTredjeKvart.map { it.arstall } shouldContainAll listOf(2020, 2020)
                    osloAndreOgTredjeKvart.map { it.orgnr } shouldContainAll listOf(orgnr_CESNAUSKAITE_oslo, orgnr_CESNAUSKAITE_oslo)
                }, failure = {
                    fail(it.message)
                })
        }

    @Test
    fun `importerte data skal kunne hentes ut og være like`() {
        val kafkaMelding = kafkaContainer.sykefraversstatistikkKafkaMelding()
        kafkaContainer.sendOgVentTilKonsumert(
            key = gson.toJson(kafkaMelding.key), value = gson.toJson(kafkaMelding.value)
        )

        val result = lydiaApi.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$orgnr_CESNAUSKAITE_oslo")
            .withLydiaToken()
            .responseObject<List<SykefraversstatistikkVirksomhetDto>>().third

        result.fold(success = { dtos ->
            dtos.size shouldBeGreaterThanOrEqual 1
            dtos.forExactly(1) { dto ->
                dto.orgnr shouldBe kafkaMelding.value.virksomhetSykefravær.orgnr
                dto.arstall shouldBe kafkaMelding.value.virksomhetSykefravær.årstall
                dto.kvartal shouldBe kafkaMelding.value.virksomhetSykefravær.kvartal
                dto.sykefraversprosent shouldBe kafkaMelding.value.virksomhetSykefravær.prosent
                dto.antallPersoner shouldBe kafkaMelding.value.virksomhetSykefravær.antallPersoner
                dto.muligeDagsverk shouldBe kafkaMelding.value.virksomhetSykefravær.muligeDagsverk
                dto.tapteDagsverk shouldBe kafkaMelding.value.virksomhetSykefravær.tapteDagsverk
            }
        }, failure = {
            fail(it.message)
        })
    }

    @Test
    fun `import av data er idempotent`() {
        kafkaContainer.sendSykefraversstatistikkKafkaMelding(Melding.oslo)

        val førsteLagredeStatistikk = lydiaApi.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$orgnr_CESNAUSKAITE_oslo")
            .withLydiaToken()
            .responseObject<List<SykefraversstatistikkVirksomhetDto>>().third
            .getOrElse { fail(it.message) }

        kafkaContainer.sendSykefraversstatistikkKafkaMelding(Melding.oslo)

        val second = lydiaApi.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$orgnr_CESNAUSKAITE_oslo")
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
        kafkaContainer.sendSykefraversstatistikkKafkaMelding(Melding.oslo)

        val rs = postgres.performQuery("SELECT * FROM virksomhet_statistikk_metadata WHERE orgnr = '$orgnr_CESNAUSKAITE_oslo'")

        rs.row shouldBe 1
    }
}

