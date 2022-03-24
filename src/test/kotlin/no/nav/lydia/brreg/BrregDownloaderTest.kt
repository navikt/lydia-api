package no.nav.lydia.brreg

import io.kotest.matchers.collections.shouldContainExactly
import io.kotest.matchers.shouldBe
import io.ktor.http.*
import io.ktor.http.HttpStatusCode.Companion.OK
import io.ktor.server.testing.*
import no.nav.lydia.*
import no.nav.lydia.helper.HttpMock
import no.nav.lydia.helper.IntegrationsHelper
import no.nav.lydia.helper.IntegrationsHelper.Companion.adresser_oslo
import no.nav.lydia.helper.IntegrationsHelper.Companion.næringskodeBedriftsrådgivning
import no.nav.lydia.helper.IntegrationsHelper.Companion.orgnr_MANGLER_BELIGGENHETSADRESSE
import no.nav.lydia.helper.IntegrationsHelper.Companion.orgnr_MANGLER_POSTNUMMER
import no.nav.lydia.helper.IntegrationsHelper.Companion.orgnr_bergen
import no.nav.lydia.helper.IntegrationsHelper.Companion.orgnr_oslo_flere_adresser
import no.nav.lydia.helper.IntegrationsHelper.Companion.orgnr_oslo_mangler_adresser
import no.nav.lydia.helper.PostgrestContainerHelper
import no.nav.lydia.integrasjoner.brreg.VIRKSOMHETSIMPORT_PATH
import no.nav.lydia.integrasjoner.ssb.NæringsDownloader
import no.nav.lydia.integrasjoner.ssb.NæringsRepository
import org.junit.AfterClass
import java.net.URL
import kotlin.test.AfterTest
import kotlin.test.Test


class BrregDownloaderTest {
    private val naisEnvironment = NaisEnvironment(
        database = Database(
            host = "",
            port = "",
            username = "",
            password = "",
            name = "",
        ), security = Security(
            AzureConfig(
                audience = "lydia-api",
                jwksUri = URL("http://localhost:8100/default/jwks"),
                issuer = "http://localhost:8100/default"
            )
        ), kafka = Kafka(
            brokers = "",
            truststoreLocation = "",
            keystoreLocation = "",
            credstorePassword = "",
            statistikkTopic = "",
            consumerLoopDelay = 200L
        ), integrasjoner = Integrasjoner(
            ssbNæringsUrl = "/naringmock/api/klass/v1/30/json",
            brregUnderEnhetUrl = IntegrationsHelper.mockKallMotBrregUnderhenter(httpMock = httpMock)
        )
    )

    companion object {
        val httpMock = HttpMock()
        val postgres = PostgrestContainerHelper()

        init {
            httpMock.start()
            postgres.getDataSource().use { dataSource ->
                NæringsDownloader(
                    url = IntegrationsHelper.mockKallMotSsbNæringer(httpMock = httpMock),
                    næringsRepository = NæringsRepository(dataSource = dataSource)
                ).lastNedNæringer()
            }
        }

        @AfterClass
        @JvmStatic
        fun afterAll() {
            httpMock.stop()
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
                    postgres.performQuery("select * from virksomhet where orgnr = '$orgnr_oslo_flere_adresser'")
                resultSetFlereAdresser.row shouldBe 1
                (resultSetFlereAdresser.getArray("adresse").array as? Array<out Any?>)
                    ?.filterIsInstance<String>() shouldContainExactly adresser_oslo

                val resultSetManglerAdresser =
                    postgres.performQuery("select * from virksomhet where orgnr = '$orgnr_oslo_mangler_adresser'")
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

                val resultSet = postgres.performQuery("select id from virksomhet where orgnr = '$orgnr_bergen'")
                resultSet.row shouldBe 1

                val id = resultSet.getLong("id")


                val resultSetFraVirksomhetNæring =
                    postgres.performQuery("select * from virksomhet_naring where virksomhet = '$id'")
                resultSetFraVirksomhetNæring.row shouldBe 1
                resultSetFraVirksomhetNæring.getString("narings_kode") shouldBe næringskodeBedriftsrådgivning

                val resultSetUtenPostnummer =
                    postgres.performQuery("select * from virksomhet where orgnr = '$orgnr_MANGLER_POSTNUMMER'")
                resultSetUtenPostnummer.row shouldBe 0

                val resultSetUtenBeliggenhetsadresse =
                    postgres.performQuery("select * from virksomhet where orgnr = '$orgnr_MANGLER_BELIGGENHETSADRESSE'")
                resultSetUtenBeliggenhetsadresse.row shouldBe 0
            }

            // sjekk at næringer blir populert på nytt ved ny import av virksomheter
            postgres.performUpdate("delete from virksomhet_naring")
            with(handleRequest(HttpMethod.Get, VIRKSOMHETSIMPORT_PATH)) {
                this.response.status() shouldBe OK
                val resultSet = postgres.performQuery("select id from virksomhet where orgnr = '$orgnr_bergen'")
                resultSet.row shouldBe 1
                val id = resultSet.getLong("id")
                val resultSetFraVirksomhetNæring =
                    postgres.performQuery("select * from virksomhet_naring where virksomhet = '$id'")
                resultSetFraVirksomhetNæring.row shouldBe 1
                resultSetFraVirksomhetNæring.getString("narings_kode") shouldBe næringskodeBedriftsrådgivning
            }
        }
    }
}
