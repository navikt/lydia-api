package no.nav.lydia.container.sykefraversstatistikk

import com.github.kittinunf.fuel.gson.responseObject
import com.github.kittinunf.result.getOrElse
import com.google.gson.GsonBuilder
import io.kotest.inspectors.forAtLeastOne
import io.kotest.matchers.ints.shouldBeExactly
import io.kotest.matchers.ints.shouldBeGreaterThanOrEqual
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.Melding
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.withLydiaToken
import no.nav.lydia.helper.TestVirksomhet.Companion.TESTVIRKSOMHET_FOR_IMPORT
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.sykefraversstatistikk.api.Periode
import no.nav.lydia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import no.nav.lydia.sykefraversstatistikk.api.SykefraversstatistikkVirksomhetDto
import kotlin.test.Test
import kotlin.test.fail

class SykefraversstatistikkImportTest {
    private val lydiaApi = TestContainerHelper.lydiaApiContainer
    private val kafkaContainer = TestContainerHelper.kafkaContainerHelper
    private val postgres = TestContainerHelper.postgresContainer
    private val gson = GsonBuilder().create()

    @Test
    fun `kan importere statistikk for flere kvartal`() {
        val gjeldenePeriode = Periode.gjeldenePeriode()
        val forrigePeriode = Periode.forrigePeriode()
        kafkaContainer.sendSykefraversstatistikkKafkaMelding(melding = Melding.testVirksomhetForrigeKvartal.melding)

        lydiaApi.performGet("$SYKEFRAVERSSTATISTIKK_PATH/${TESTVIRKSOMHET_FOR_IMPORT.orgnr}")
            .withLydiaToken()
            .responseObject<List<SykefraversstatistikkVirksomhetDto>>().third
            .fold(success = { osloAndreKvart ->
                osloAndreKvart.forExactlyOne {
                    it.kvartal shouldBeExactly forrigePeriode.kvartal
                    it.arstall shouldBeExactly forrigePeriode.årstall
                    it.orgnr shouldBe TESTVIRKSOMHET_FOR_IMPORT.orgnr
                }
            }, failure = {
                fail(it.message)
            })

        kafkaContainer.sendSykefraversstatistikkKafkaMelding(melding = Melding.testVirksomhetGjeldeneKvartal.melding)

        lydiaApi.performGet("$SYKEFRAVERSSTATISTIKK_PATH/${TESTVIRKSOMHET_FOR_IMPORT.orgnr}")
            .withLydiaToken()
            .responseObject<List<SykefraversstatistikkVirksomhetDto>>().third
            .fold(success = { osloAndreOgTredjeKvart ->
                osloAndreOgTredjeKvart.forExactlyOne {
                    it.kvartal shouldBe forrigePeriode.kvartal
                    it.arstall shouldBe forrigePeriode.årstall
                    it.orgnr shouldBe TESTVIRKSOMHET_FOR_IMPORT.orgnr
                }
                osloAndreOgTredjeKvart.forExactlyOne {
                    it.kvartal shouldBe gjeldenePeriode.kvartal
                    it.arstall shouldBe gjeldenePeriode.årstall
                    it.orgnr shouldBe TESTVIRKSOMHET_FOR_IMPORT.orgnr
                }
            }, failure = {
                fail(it.message)
            })
    }

    @Test
    fun `importerte data skal kunne hentes ut og være like`() {
        val kafkaMelding = kafkaContainer.sykefraversstatistikkKafkaMelding(Melding.testVirksomhetForrigeKvartal.melding)
        kafkaContainer.sendOgVentTilKonsumert(
            key = gson.toJson(kafkaMelding.key), value = gson.toJson(kafkaMelding.value)
        )

        val result = lydiaApi.performGet("$SYKEFRAVERSSTATISTIKK_PATH/${TESTVIRKSOMHET_FOR_IMPORT.orgnr}")
            .withLydiaToken()
            .responseObject<List<SykefraversstatistikkVirksomhetDto>>().third

        result.fold(success = { dtos ->
            dtos.size shouldBeGreaterThanOrEqual 1
            dtos.forAtLeastOne { dto ->
                dto.orgnr shouldBe kafkaMelding.value.virksomhetSykefravær.orgnr
                dto.arstall shouldBe kafkaMelding.value.virksomhetSykefravær.årstall
                dto.kvartal shouldBe kafkaMelding.value.virksomhetSykefravær.kvartal
                dto.sykefraversprosent shouldBe kafkaMelding.value.virksomhetSykefravær.prosent
                dto.antallPersoner shouldBe kafkaMelding.value.virksomhetSykefravær.antallPersoner.toInt()
                dto.muligeDagsverk shouldBe kafkaMelding.value.virksomhetSykefravær.muligeDagsverk
                dto.tapteDagsverk shouldBe kafkaMelding.value.virksomhetSykefravær.tapteDagsverk
            }
        }, failure = {
            fail(it.message)
        })
    }

    @Test
    fun `import av data er idempotent`() {
        kafkaContainer.sendSykefraversstatistikkKafkaMelding(Melding.testVirksomhetForrigeKvartal.melding)

        val førsteLagredeStatistikk = lydiaApi.performGet("$SYKEFRAVERSSTATISTIKK_PATH/${TESTVIRKSOMHET_FOR_IMPORT.orgnr}")
            .withLydiaToken()
            .responseObject<List<SykefraversstatistikkVirksomhetDto>>().third
            .getOrElse { fail(it.message) }

        kafkaContainer.sendSykefraversstatistikkKafkaMelding(Melding.testVirksomhetForrigeKvartal.melding)

        val second = lydiaApi.performGet("$SYKEFRAVERSSTATISTIKK_PATH/${TESTVIRKSOMHET_FOR_IMPORT.orgnr}")
            .withLydiaToken()
            .responseObject<List<SykefraversstatistikkVirksomhetDto>>().third

        second.fold(success = { dtos ->
            dtos.forExactlyOne { dto ->
                dto.orgnr shouldBe førsteLagredeStatistikk[0].orgnr
                dto.arstall shouldBe førsteLagredeStatistikk[0].arstall
                dto.kvartal shouldBe førsteLagredeStatistikk[0].kvartal
                dto.sykefraversprosent shouldBe førsteLagredeStatistikk[0].sykefraversprosent
                dto.antallPersoner shouldBe førsteLagredeStatistikk[0].antallPersoner
                dto.muligeDagsverk shouldBe førsteLagredeStatistikk[0].muligeDagsverk
                dto.tapteDagsverk shouldBe førsteLagredeStatistikk[0].tapteDagsverk
            }
        }, failure = {
            fail(it.message)
        })
    }

    @Test
    fun `vi lagrer metadata ved import`() {
        kafkaContainer.sendSykefraversstatistikkKafkaMelding(Melding.testVirksomhetForrigeKvartal.melding)

        val rs = postgres.performQuery("SELECT * FROM virksomhet_statistikk_metadata WHERE orgnr = '${TESTVIRKSOMHET_FOR_IMPORT.orgnr}'")

        rs.row shouldBe 1
    }
}

