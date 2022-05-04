package no.nav.lydia.container.virksomhet

import io.kotest.matchers.collections.shouldContainInOrder
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.*
import no.nav.lydia.helper.TestVirksomhet.Companion.OSLO_FLERE_ADRESSER
import no.nav.lydia.integrasjoner.brreg.BrregDownloader
import no.nav.lydia.integrasjoner.ssb.NæringsDownloader
import no.nav.lydia.integrasjoner.ssb.NæringsRepository
import no.nav.lydia.virksomhet.VirksomhetRepository
import kotlin.test.Test

class VirksomhetApiTest {
    private val mockOAuthContainer = TestContainerHelper.oauth2ServerContainer

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
        val virksomhet = VirksomhetHelper.hentVirksomhetsinformasjon(
            OSLO_FLERE_ADRESSER.orgnr,
            token = mockOAuthContainer.saksbehandler1.token
        )
        virksomhet.orgnr shouldBe OSLO_FLERE_ADRESSER.orgnr
        virksomhet.navn shouldBe OSLO_FLERE_ADRESSER.navn
        virksomhet.adresse shouldContainInOrder OSLO_FLERE_ADRESSER.beliggenhet?.adresse!!
        virksomhet.postnummer shouldBe OSLO_FLERE_ADRESSER.beliggenhet.postnummer
        virksomhet.poststed shouldBe OSLO_FLERE_ADRESSER.beliggenhet.poststed
        virksomhet.neringsgrupper shouldHaveSize 2
    }
}
