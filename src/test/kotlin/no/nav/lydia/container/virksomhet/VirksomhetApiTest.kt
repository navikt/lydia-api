package no.nav.lydia.container.virksomhet

import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.gson.responseObject
import io.kotest.matchers.collections.shouldContainInOrder
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.HttpMock
import no.nav.lydia.helper.IntegrationsHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.withLydiaToken
import no.nav.lydia.helper.TestData
import no.nav.lydia.helper.TestVirksomhet.Companion.OSLO_FLERE_ADRESSER
import no.nav.lydia.integrasjoner.brreg.BrregDownloader
import no.nav.lydia.integrasjoner.ssb.NæringsDownloader
import no.nav.lydia.integrasjoner.ssb.NæringsRepository
import no.nav.lydia.virksomhet.VirksomhetRepository
import no.nav.lydia.virksomhet.api.VIRKSOMHET_PATH
import no.nav.lydia.virksomhet.api.VirksomhetDto
import kotlin.test.Test
import kotlin.test.fail

class VirksomhetApiTest {
    private val fiaContainer = TestContainerHelper.lydiaApiContainer

    companion object {
        init {
            val testData = TestData(inkluderStandardVirksomheter = true)
            HttpMock().also { httpMock ->
                httpMock.start()
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

            testData.sykefraværsStatistikkMeldinger().forEach { melding ->
                TestContainerHelper.kafkaContainerHelper.sendSykefraversstatistikkKafkaMelding(melding)
            }
        }
    }

    @Test
    fun `skal kunne hente ut opplysninger om en virksomhet`() {
        fiaContainer.performGet("$VIRKSOMHET_PATH/${OSLO_FLERE_ADRESSER.orgnr}")
            .authentication().withLydiaToken().responseObject<VirksomhetDto>().third.fold(
                success = { dto ->
                    dto.orgnr shouldBe OSLO_FLERE_ADRESSER.orgnr
                    dto.navn shouldBe OSLO_FLERE_ADRESSER.navn
                    dto.adresse shouldContainInOrder OSLO_FLERE_ADRESSER.beliggenhet?.adresse!!
                    dto.postnummer shouldBe OSLO_FLERE_ADRESSER.beliggenhet.postnummer
                    dto.poststed shouldBe OSLO_FLERE_ADRESSER.beliggenhet.poststed
                    dto.neringsgrupper shouldHaveSize 2
                },
                failure = { fail(it.message) }
            )
    }
}