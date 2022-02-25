package no.nav.lydia.ssb

import com.github.tomakehurst.wiremock.client.WireMock
import io.kotest.matchers.shouldBe
import io.ktor.http.*
import io.ktor.server.testing.*
import no.nav.lydia.*
import no.nav.lydia.helper.HttpMock
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.virksomhet.ssb.NÆRINGSIMPORT_URL
import org.junit.AfterClass
import org.junit.BeforeClass
import java.net.URL
import kotlin.test.Test

class NæringsDownloaderTest {
    companion object {
        val httpMock = HttpMock()

        @BeforeClass
        @JvmStatic
        fun beforeAll() {
            httpMock.start()
        }


        @AfterClass
        @JvmStatic
        fun afterAll() {
            httpMock.stop()
        }
    }

    val postgres = TestContainerHelper.postgresContainer
    val path = "/naringmock/api/klass/v1/30/json"
    val næringMockUrl = httpMock.url(path)

    val naisEnvironment = NaisEnvironment(
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
            ssbNæringsUrl = næringMockUrl,
            brregUnderEnhetUrl = "")
    )

    @Test
    fun `kan laste ned og hente ut næringer`() {
        httpMock.wireMockServer.stubFor(
            WireMock.get(WireMock.urlPathEqualTo(path))
                .willReturn(
                    WireMock.ok()
                        .withBody(næringsJson)
                )
        )

        withTestApplication({ lydiaRestApi(naisEnvironment = naisEnvironment, dataSource = postgres.getDataSource()) }) {
            with(handleRequest(HttpMethod.Get, NÆRINGSIMPORT_URL)) {
                this.response.status() shouldBe HttpStatusCode.OK

                val rs = postgres.performQuery("select * from naring where kode = '01.120'")
                rs.row shouldBe 1
                rs.getString("navn") shouldBe "Dyrking av ris"
                rs.getString("kort_navn") shouldBe "Dyrk. av ris"
            }
        }
    }


    val næringsJson = """
        {
          "name": "Næringsgruppering 2007 (SN 2007)",
          "validFrom": "2009-01-01",
          "lastModified": "2020-04-07T12:46:55.000+0000",
          "published": [],
          "introduction": "",
          "contactPerson": {},
          "owningSection": "Regnskapsstatistikk og VoF",
          "legalBase": "Rådsforordning (EF) nr. 1893/2006",
          "publications": "http://www.ssb.no/a/publikasjoner/pdf/nos_d383/nos_d383.pdf",
          "derivedFrom": "NACE Rev.2",
          "correspondenceTables": [],
          "classificationVariants": [],
          "changelogs": [],
          "levels": [],
          "classificationItems": [
            {
              "code": "01",
              "parentCode": "A",
              "level": "2",
              "name": "Jordbruk og tjenester tilknyttet jordbruk, jakt og viltstell",
              "shortName": "Jordbruk, tilhør. tjenester, jakt",
              "notes": "Inkluderer: Denne næringen omfatter to basisaktiviteter: produksjon av vegetabilske og animalske produkter, jordbruk, dyrking av genetisk modifiserte vekster og oppdrett av genetisk modifiserte dyr. Både dyrking av vekster på friland og i veksthus inngår\nInkluderer også: Omfatter også tjenester tilknyttet jordbruk, jakt og fangst\nEkskluderer: Grunnarbeid, f.eks. anlegg av jordterrasser, drenering o.l. grupperes under næringshovedområde: F Bygge- og anleggsvirksomhet. Kjøpere og andelslag engasjert i markedsføring av jordbruksprodukter grupperes under næringshovedområde: G Varehandel, reparasjon av motorvogner. Stell og vedlikehold av landskap grupperes under: 81.30 Beplantning av hager og parkanlegg"
            },
            {
              "code": "01.1",
              "parentCode": "01",
              "level": "3",
              "name": "Dyrking av ettårige vekster",
              "shortName": "Dyrking av ettårige vekster",
              "notes": "Inkluderer: Omfatter dyrking av ettårige vekster, dvs. planter som ikke varer i mer enn to vekstsesonger\nInkluderer også: Omfatter også dyrking av ettårige vekster med henblikk på produksjon av såfrø og såkorn"
            },
            {
              "code": "01.12",
              "parentCode": "01.1",
              "level": "4",
              "name": "Dyrking av ris",
              "shortName": "Dyrk. av ris",
              "notes": ""
            },
            {
              "code": "01.120",
              "parentCode": "01.12",
              "level": "5",
              "name": "Dyrking av ris",
              "shortName": "Dyrk. av ris",
              "notes": ""
            },
            {
              "code": "A",
              "parentCode": "",
              "level": "1",
              "name": "Jordbruk, skogbruk og fiske",
              "shortName": "Jordbruk, skogbruk og fiske",
              "notes": "Inkluderer: Omfatter bruken av planteressursene og de animalske ressursene, inkludert aktiviteter i forbindelse med dyrking av vekster, husdyrhold og -avl, produksjon av tømmer og høsting/utnyttelse av andre planter, dyr og animalske produkter fra en gård eller fra naturen"
            }
          ]
        }
    """.trimIndent()

}