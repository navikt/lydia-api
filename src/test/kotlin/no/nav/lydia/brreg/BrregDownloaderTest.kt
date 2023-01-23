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
        NæringsDownloader(
            url = naisEnvironment.integrasjoner.ssbNæringsUrl,
            næringsRepository = NæringsRepository(dataSource = postgres.dataSource)
        ).lastNedNæringer()
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
                dataSource = postgres.dataSource
            )
        }) {
            with(handleRequest(HttpMethod.Get, VIRKSOMHETSIMPORT_PATH)) {
                this.response.status() shouldBe OK

                val adresser =
                    postgres.hentEnkelKolonne<java.sql.Array>("select adresse from virksomhet where orgnr = '${OSLO_FLERE_ADRESSER.orgnr}'")
                (adresser.array as? Array<out Any?>)
                    ?.filterIsInstance<String>() shouldContainExactly OSLO_FLERE_ADRESSER.beliggenhet?.adresse!!

                val manglerAdresser =
                    postgres.hentEnkelKolonne<Int>("select count(*) from virksomhet where orgnr = '${OSLO_MANGLER_ADRESSER.orgnr}'")
                manglerAdresser shouldBe 1
            }
        }
    }

    @Test
    fun `vi kan laste ned liste med underenheter fra Brreg flere ganger uten konflikt`() {
        withTestApplication({
            lydiaRestApi(
                naisEnvironment = naisEnvironment,
                dataSource = postgres.dataSource
            )
        }) {
            with(handleRequest(HttpMethod.Get, VIRKSOMHETSIMPORT_PATH)) {
                this.response.status() shouldBe OK

                val id = postgres.hentEnkelKolonne<Int>("select id from virksomhet where orgnr = '${BERGEN.orgnr}'")

                val næringsKode =
                    postgres.hentEnkelKolonne<String>("select narings_kode from virksomhet_naring where virksomhet = '$id'")
                næringsKode shouldBe BEDRIFTSRÅDGIVNING.kode

                val antallUtenPostnummer =
                    postgres.hentEnkelKolonne<Int>("select count(*) from virksomhet where orgnr = '${UTENLANDSK.orgnr}'")
                antallUtenPostnummer shouldBe 0

                val antallUtenBeliggenhetsadresse =
                    postgres.hentEnkelKolonne<Int>("select count(*) from virksomhet where orgnr = '${MANGLER_BELIGGENHETSADRESSE.orgnr}'")
                antallUtenBeliggenhetsadresse shouldBe 0
            }

            // sjekk at næringer blir populert på nytt ved ny import av virksomheter
            postgres.performUpdate("delete from virksomhet_naring")
            with(handleRequest(HttpMethod.Get, VIRKSOMHETSIMPORT_PATH)) {
                this.response.status() shouldBe OK
                val id = postgres.hentEnkelKolonne<Int>("select id from virksomhet where orgnr = '${BERGEN.orgnr}'")
                val næringsKode =
                    postgres.hentEnkelKolonne<String>("select narings_kode from virksomhet_naring where virksomhet = '$id'")
                næringsKode shouldBe BEDRIFTSRÅDGIVNING.kode
            }
        }
    }
}
