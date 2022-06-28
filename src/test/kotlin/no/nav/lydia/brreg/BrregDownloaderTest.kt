package no.nav.lydia.brreg

import io.kotest.matchers.collections.shouldContainExactly
import io.kotest.matchers.shouldBe
import io.ktor.http.HttpMethod
import io.ktor.http.HttpStatusCode.Companion.OK
import io.ktor.server.testing.handleRequest
import io.ktor.server.testing.withTestApplication
import no.nav.lydia.helper.KtorTestHelper
import no.nav.lydia.helper.PostgrestContainerHelper
import no.nav.lydia.helper.TestData.Companion.BEDRIFTSRÅDGIVNING
import no.nav.lydia.helper.TestVirksomhet.Companion.BERGEN
import no.nav.lydia.helper.TestVirksomhet.Companion.MANGLER_BELIGGENHETSADRESSE
import no.nav.lydia.helper.TestVirksomhet.Companion.OSLO_FLERE_ADRESSER
import no.nav.lydia.helper.TestVirksomhet.Companion.OSLO_MANGLER_ADRESSER
import no.nav.lydia.helper.TestVirksomhet.Companion.UTENLANDSK
import no.nav.lydia.integrasjoner.brreg.VIRKSOMHETSIMPORT_PATH
import no.nav.lydia.integrasjoner.ssb.NæringsDownloader
import no.nav.lydia.integrasjoner.ssb.NæringsRepository
import no.nav.lydia.lydiaRestApi
import kotlin.test.AfterTest
import kotlin.test.Test


class BrregDownloaderTest {
    private val naisEnvironment = KtorTestHelper.ktorNaisEnvironment
    val postgres = PostgrestContainerHelper()

    init {
        postgres.getDataSource().use { dataSource ->
            NæringsDownloader(
                url = naisEnvironment.integrasjoner.ssbNæringsUrl,
                næringsRepository = NæringsRepository(dataSource = dataSource)
            ).lastNedNæringer()
        }
    }

    @AfterTest
    fun cleanup() {
        postgres.performUpdate("delete from virksomhet_naring")
        postgres.performUpdate("delete from virksomhet")
    }

    @Test
    fun `vi kan laste ned virksomheter med og uten adresser`() {
        withTestApplication({
            lydiaRestApi(
                naisEnvironment = naisEnvironment,
                dataSource = postgres.getDataSource()
            )
        }) {
            with(handleRequest(HttpMethod.Get, VIRKSOMHETSIMPORT_PATH)) {
                this.response.status() shouldBe OK

                val resultSetFlereAdresser =
                    postgres.performQuery("select * from virksomhet where orgnr = '${OSLO_FLERE_ADRESSER.orgnr}'")
                resultSetFlereAdresser.row shouldBe 1
                (resultSetFlereAdresser.getArray("adresse").array as? Array<out Any?>)
                    ?.filterIsInstance<String>() shouldContainExactly OSLO_FLERE_ADRESSER.beliggenhet?.adresse!!

                val resultSetManglerAdresser =
                    postgres.performQuery("select * from virksomhet where orgnr = '${OSLO_MANGLER_ADRESSER.orgnr}'")
                resultSetManglerAdresser.row shouldBe 1
            }
        }
    }

    @Test
    fun `vi kan laste ned liste med underenheter fra Brreg flere ganger uten konflikt`() {
        withTestApplication({
            lydiaRestApi(
                naisEnvironment = naisEnvironment,
                dataSource = postgres.getDataSource()
            )
        }) {
            with(handleRequest(HttpMethod.Get, VIRKSOMHETSIMPORT_PATH)) {
                this.response.status() shouldBe OK

                val resultSet = postgres.performQuery("select id from virksomhet where orgnr = '${BERGEN.orgnr}'")
                resultSet.row shouldBe 1

                val id = resultSet.getLong("id")


                val resultSetFraVirksomhetNæring =
                    postgres.performQuery("select * from virksomhet_naring where virksomhet = '$id'")
                resultSetFraVirksomhetNæring.row shouldBe 1
                resultSetFraVirksomhetNæring.getString("narings_kode") shouldBe BEDRIFTSRÅDGIVNING.kode

                val resultSetUtenPostnummer =
                    postgres.performQuery("select * from virksomhet where orgnr = '${UTENLANDSK.orgnr}'")
                resultSetUtenPostnummer.row shouldBe 0

                val resultSetUtenBeliggenhetsadresse =
                    postgres.performQuery("select * from virksomhet where orgnr = '${MANGLER_BELIGGENHETSADRESSE.orgnr}'")
                resultSetUtenBeliggenhetsadresse.row shouldBe 0
            }

            // sjekk at næringer blir populert på nytt ved ny import av virksomheter
            postgres.performUpdate("delete from virksomhet_naring")
            with(handleRequest(HttpMethod.Get, VIRKSOMHETSIMPORT_PATH)) {
                this.response.status() shouldBe OK
                val resultSet = postgres.performQuery("select id from virksomhet where orgnr = '${BERGEN.orgnr}'")
                resultSet.row shouldBe 1
                val id = resultSet.getLong("id")
                val resultSetFraVirksomhetNæring =
                    postgres.performQuery("select * from virksomhet_naring where virksomhet = '$id'")
                resultSetFraVirksomhetNæring.row shouldBe 1
                resultSetFraVirksomhetNæring.getString("narings_kode") shouldBe BEDRIFTSRÅDGIVNING.kode
            }
        }
    }
}
