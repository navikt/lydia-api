package no.nav.lydia.container.virksomhet

import io.kotest.matchers.collections.shouldContainAll
import io.kotest.matchers.collections.shouldContainInOrder
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.TestVirksomhet.Companion.OSLO_FLERE_ADRESSER
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import kotlin.test.Test

class VirksomhetApiTest {
    private val mockOAuthContainer = TestContainerHelper.oauth2ServerContainer

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

    @Test
    fun `skal kunne vise næringer med bindestrek`() {
        val orgnummer = VirksomhetHelper.lastInnNyVirksomhet(
            nyVirksomhet = TestVirksomhet.nyVirksomhet(
                næringer = listOf(
                    Næringsgruppe(
                        navn = "Testgruppe en",
                        kode = "99.001"
                    ),
                    Næringsgruppe(
                        navn = "Test - gruppe to",
                        kode = "99.002"
                    ),
                    Næringsgruppe(
                        navn = "Test-gruppe tre",
                        kode = "99.003"
                    )
                )
            )
        ).orgnr

        val virksomhet = VirksomhetHelper.hentVirksomhetsinformasjon(
            orgnummer = orgnummer,
            token = mockOAuthContainer.saksbehandler1.token
        )

        virksomhet.orgnr shouldBe orgnummer
        virksomhet.neringsgrupper.map { it.navn } shouldContainAll listOf(
            "Testgruppe en",
            "Test - gruppe to",
            "Test-gruppe tre"
        )
    }
}
