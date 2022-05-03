package no.nav.fia.container.sykefraversstatistikk

import com.github.kittinunf.fuel.gson.responseObject
import com.github.kittinunf.result.getOrElse
import com.google.gson.GsonBuilder
import io.kotest.inspectors.forAtLeastOne
import io.kotest.matchers.ints.shouldBeExactly
import io.kotest.matchers.ints.shouldBeGreaterThanOrEqual
import io.kotest.matchers.shouldBe
import no.nav.fia.helper.*
import no.nav.fia.helper.TestContainerHelper.Companion.performGet
import no.nav.fia.helper.TestContainerHelper.Companion.withLydiaToken
import no.nav.fia.helper.TestVirksomhet.Companion.BERGEN
import no.nav.fia.helper.TestVirksomhet.Companion.OSLO
import no.nav.fia.integrasjoner.brreg.BrregDownloader
import no.nav.fia.integrasjoner.ssb.NæringsDownloader
import no.nav.fia.integrasjoner.ssb.NæringsRepository
import no.nav.fia.sykefraversstatistikk.api.Periode
import no.nav.fia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import no.nav.fia.sykefraversstatistikk.api.SykefraversstatistikkVirksomhetDto
import no.nav.fia.virksomhet.VirksomhetRepository
import kotlin.test.Test
import kotlin.test.fail

class SykefraversstatistikkImportTest {
    private val lydiaApi = TestContainerHelper.lydiaApiContainer
    private val kafkaContainer = TestContainerHelper.kafkaContainerHelper
    private val postgres = TestContainerHelper.postgresContainer
    private val gson = GsonBuilder().create()

    companion object {
        init {
            val testData = TestData(inkluderStandardVirksomheter = false)
            HttpMock().also { httpMock ->
                httpMock.start()
                testData.lagData(virksomhet = OSLO, perioder = listOf())
                testData.lagData(virksomhet = BERGEN, perioder = listOf())

                TestContainerHelper.postgresContainer.getDataSource().use { dataSource ->
                    NæringsDownloader(
                        url = IntegrationsHelper.mockKallMotSsbNæringer(httpMock = httpMock, testData = testData),
                        næringsRepository = NæringsRepository(dataSource = dataSource)
                    ).lastNedNæringer()

                    BrregDownloader(
                        url = IntegrationsHelper.mockKallMotBrregUnderhenter(httpMock = httpMock, testData = testData),
                        virksomhetRepository = VirksomhetRepository(dataSource = dataSource)
                    ).lastNed()

                }
                httpMock.stop()
            }
        }
    }

    @Test
    fun `kan importere statistikk for flere kvartal`() {
        val gjeldenePeriode = Periode.gjeldenePeriode()
        val forrigePeriode = Periode.forrigePeriode()
        kafkaContainer.sendSykefraversstatistikkKafkaMelding(melding = Melding.osloForrigeKvartal.melding)

        lydiaApi.performGet("$SYKEFRAVERSSTATISTIKK_PATH/${OSLO.orgnr}")
            .withLydiaToken()
            .responseObject<List<SykefraversstatistikkVirksomhetDto>>().third
            .fold(success = { osloAndreKvart ->
                osloAndreKvart.forExactlyOne {
                    it.kvartal shouldBeExactly forrigePeriode.kvartal
                    it.arstall shouldBeExactly forrigePeriode.årstall
                    it.orgnr shouldBe OSLO.orgnr
                }
            }, failure = {
                fail(it.message)
            })

        kafkaContainer.sendSykefraversstatistikkKafkaMelding(melding = Melding.osloGjeldeneKvartal.melding)

        lydiaApi.performGet("$SYKEFRAVERSSTATISTIKK_PATH/${OSLO.orgnr}")
            .withLydiaToken()
            .responseObject<List<SykefraversstatistikkVirksomhetDto>>().third
            .fold(success = { osloAndreOgTredjeKvart ->
                osloAndreOgTredjeKvart.forExactlyOne {
                    it.kvartal shouldBe forrigePeriode.kvartal
                    it.arstall shouldBe forrigePeriode.årstall
                    it.orgnr shouldBe OSLO.orgnr
                }
                osloAndreOgTredjeKvart.forExactlyOne {
                    it.kvartal shouldBe gjeldenePeriode.kvartal
                    it.arstall shouldBe gjeldenePeriode.årstall
                    it.orgnr shouldBe OSLO.orgnr
                }
            }, failure = {
                fail(it.message)
            })
    }

    @Test
    fun `importerte data skal kunne hentes ut og være like`() {
        val kafkaMelding = kafkaContainer.sykefraversstatistikkKafkaMelding(Melding.osloForrigeKvartal.melding)
        kafkaContainer.sendOgVentTilKonsumert(
            key = gson.toJson(kafkaMelding.key), value = gson.toJson(kafkaMelding.value)
        )

        val result = lydiaApi.performGet("$SYKEFRAVERSSTATISTIKK_PATH/${OSLO.orgnr}")
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
        kafkaContainer.sendSykefraversstatistikkKafkaMelding(Melding.osloForrigeKvartal.melding)

        val førsteLagredeStatistikk = lydiaApi.performGet("$SYKEFRAVERSSTATISTIKK_PATH/${OSLO.orgnr}")
            .withLydiaToken()
            .responseObject<List<SykefraversstatistikkVirksomhetDto>>().third
            .getOrElse { fail(it.message) }

        kafkaContainer.sendSykefraversstatistikkKafkaMelding(Melding.osloForrigeKvartal.melding)

        val second = lydiaApi.performGet("$SYKEFRAVERSSTATISTIKK_PATH/${OSLO.orgnr}")
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
        kafkaContainer.sendSykefraversstatistikkKafkaMelding(Melding.osloForrigeKvartal.melding)

        val rs = postgres.performQuery("SELECT * FROM virksomhet_statistikk_metadata WHERE orgnr = '${OSLO.orgnr}'")

        rs.row shouldBe 1
    }
}

