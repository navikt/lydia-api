package no.nav.lydia.container.personopplysninger

import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldNotContain
import io.ktor.http.HttpStatusCode
import kotlinx.serialization.json.Json
import no.nav.lydia.api.v1.PERSONOPPLYSNINGSSJEKK_PATH
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.responseString
import no.nav.lydia.helper.statuskode
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.personopplysninger.MAKS_ANTALL_TEGN_I_PERSONOPPLYSNINGSSJEKK
import no.nav.lydia.personopplysninger.PersonopplysningssjekkDto
import no.nav.lydia.personopplysninger.PersonopplysningssjekkResultatDto
import kotlin.test.Test

class PersonopplysningssjekkApiTest {
    private fun sjekk(
        tekst: String,
        token: String = authContainerHelper.saksbehandler1.token,
    ) = applikasjon.performPost(PERSONOPPLYSNINGSSJEKK_PATH)
        .authentication().bearer(token)
        .jsonBody(Json.encodeToString(PersonopplysningssjekkDto(tekst = tekst)))

    @Test
    fun `skal gi treff på tall og e-post`() {
        val respons = sjekk("Ring 12345678 eller send til ola@firma.no").tilSingelRespons<PersonopplysningssjekkResultatDto>()

        respons.statuskode() shouldBe HttpStatusCode.OK.value
        respons.third.get() shouldBe PersonopplysningssjekkResultatDto(inneholderTall = true, inneholderEpost = true)
    }

    @Test
    fun `skal ikke gi treff på tekst uten tall eller e-post`() {
        val respons = sjekk("Redusere sykefraværet i virksomheten").tilSingelRespons<PersonopplysningssjekkResultatDto>()

        respons.third.get() shouldBe PersonopplysningssjekkResultatDto(inneholderTall = false, inneholderEpost = false)
    }

    @Test
    fun `skal ikke svare med teksten som ble sjekket`() {
        val body = sjekk("Kontakt ola@firma.no på 12345678").responseString().third.get()

        body shouldNotContain "ola@firma.no"
        body shouldNotContain "12345678"
    }

    @Test
    fun `skal avvise for lang tekst`() {
        sjekk("a".repeat(MAKS_ANTALL_TEGN_I_PERSONOPPLYSNINGSSJEKK + 1)).responseString()
            .statuskode() shouldBe HttpStatusCode.BadRequest.value
    }

    @Test
    fun `skal godta tekst med maks lengde`() {
        sjekk("a".repeat(MAKS_ANTALL_TEGN_I_PERSONOPPLYSNINGSSJEKK)).responseString()
            .statuskode() shouldBe HttpStatusCode.OK.value
    }

    @Test
    fun `superbruker skal kunne sjekke tekst`() {
        sjekk("Mål", token = authContainerHelper.superbruker1.token).responseString()
            .statuskode() shouldBe HttpStatusCode.OK.value
    }

    @Test
    fun `lesebruker skal ikke kunne sjekke tekst`() {
        sjekk("Mål", token = authContainerHelper.lesebruker.token).responseString()
            .statuskode() shouldBe HttpStatusCode.Forbidden.value
    }

    @Test
    fun `bruker uten tilgangsrolle skal ikke kunne sjekke tekst`() {
        sjekk("Mål", token = authContainerHelper.brukerUtenTilgangsrolle.token).responseString()
            .statuskode() shouldBe HttpStatusCode.Forbidden.value
    }
}
