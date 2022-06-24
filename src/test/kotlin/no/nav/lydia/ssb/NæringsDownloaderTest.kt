package no.nav.lydia.ssb

import io.getunleash.FakeUnleash
import io.kotest.matchers.shouldBe
import io.ktor.http.*
import io.ktor.server.testing.*
import no.nav.lydia.helper.KtorTestHelper
import no.nav.lydia.helper.PostgrestContainerHelper
import no.nav.lydia.helper.TestData.Companion.SCENEKUNST
import no.nav.lydia.integrasjoner.ssb.NÆRINGSIMPORT_URL
import no.nav.lydia.lydiaRestApi
import kotlin.test.Test

class NæringsDownloaderTest {

    val postgres = PostgrestContainerHelper()
    val naisEnvironment = KtorTestHelper.ktorNaisEnvironment

    @Test
    fun `kan laste ned og hente ut næringer`() {
        withTestApplication({ lydiaRestApi(naisEnvironment = naisEnvironment, dataSource = postgres.getDataSource(), unleash = FakeUnleash()) }) {
            with(handleRequest(HttpMethod.Get, NÆRINGSIMPORT_URL)) {
                this.response.status() shouldBe HttpStatusCode.OK

                val rs = postgres.performQuery("select * from naring where kode = '${SCENEKUNST.kode}'")
                rs.row shouldBe 1
                rs.getString("navn") shouldBe SCENEKUNST.navn
                rs.getString("kort_navn") shouldBe "Kortnavn for ${SCENEKUNST.kode}"
            }
        }
    }
}