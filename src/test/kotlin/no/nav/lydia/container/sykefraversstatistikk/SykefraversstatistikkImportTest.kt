package no.nav.lydia.container.sykefraversstatistikk

import com.github.kittinunf.fuel.gson.responseObject
import com.github.kittinunf.result.getOrElse
import com.google.gson.GsonBuilder
import io.kotest.matchers.ints.shouldBeExactly
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.withLydiaToken
import no.nav.lydia.helper.TestSted
import no.nav.lydia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import no.nav.lydia.sykefraversstatistikk.api.SykefraversstatistikkVirksomhetDto
import kotlin.test.Test
import kotlin.test.fail

class SykefraversstatistikkImportTest {
    val lydiaApi = TestContainerHelper.lydiaApiContainer
    val kafkaContainer = TestContainerHelper.kafkaContainerHelper
    val gson = GsonBuilder().create()
    val testOrgnr = "987654321"

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
}

