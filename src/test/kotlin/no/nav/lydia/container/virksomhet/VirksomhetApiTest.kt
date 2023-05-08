package no.nav.lydia.container.virksomhet

import io.kotest.inspectors.forAll
import io.kotest.inspectors.forAtLeastOne
import io.kotest.matchers.collections.shouldContainAll
import io.kotest.matchers.collections.shouldContainInOrder
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.ints.shouldBeLessThan
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.*
import no.nav.lydia.helper.TestVirksomhet.Companion.OSLO_FLERE_ADRESSER
import no.nav.lydia.helper.TestVirksomhet.Companion.nyVirksomhet
import no.nav.lydia.helper.VirksomhetHelper.Companion.søkEtterVirksomheter
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import no.nav.lydia.virksomhet.domene.VirksomhetStatus
import kotlin.test.Test

class VirksomhetApiTest {
    private val mockOAuthContainer = TestContainerHelper.oauth2ServerContainer
    private val postgres = TestContainerHelper.postgresContainer

    @Test
    fun `sanity sjekk, test at vi har fått lastet inn virksomheter og næringer`() {
        val id = postgres.hentEnkelKolonne<Int>("select id from virksomhet where orgnr = '${TestVirksomhet.BERGEN.orgnr}'")
        val næringsKode =
            postgres.hentEnkelKolonne<String>("select narings_kode from virksomhet_naring where virksomhet = '$id'")
        næringsKode shouldBe TestData.BEDRIFTSRÅDGIVNING.kode
        val antallUtenPostnummer =
            postgres.hentEnkelKolonne<Int>("select count(*) from virksomhet where orgnr = '${TestVirksomhet.UTENLANDSK.orgnr}'")
        antallUtenPostnummer shouldBe 0
        val antallUtenBeliggenhetsadresse =
            postgres.hentEnkelKolonne<Int>("select count(*) from virksomhet where orgnr = '${TestVirksomhet.MANGLER_BELIGGENHETSADRESSE.orgnr}'")
        antallUtenBeliggenhetsadresse shouldBe 0
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
        virksomhet.sektor shouldBe "Statlig forvaltning"
    }

    @Test
    fun `skal kunne vise næringer med bindestrek`() {
        val orgnummer = VirksomhetHelper.lastInnNyVirksomhet(
                nyVirksomhet = nyVirksomhet(
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

    @Test
    fun `skal kunne søke etter virksomheter basert på navn og orgnummer`() {
        val virksomhet = nyVirksomhet(navn = "Hei og hå")
        VirksomhetHelper.lastInnNyVirksomhet(virksomhet)

        søkEtterVirksomheter(søkestreng = "hei") { virksomheter ->
            virksomheter shouldHaveAtLeastSize 1
            virksomheter.forAtLeastOne {
                it.orgnr shouldBe virksomhet.orgnr
            }
        }

        søkEtterVirksomheter(søkestreng = virksomhet.orgnr.take(5)) { virksomheter ->
            virksomheter shouldHaveAtLeastSize 1
            virksomheter.forAtLeastOne {
                it.orgnr shouldBe virksomhet.orgnr
            }
        }
    }

    @Test
    fun `virksomheter bør komme logisk sortert når man søker etter de`() {
        VirksomhetHelper.lastInnNyeVirksomheter(
            nyVirksomhet(navn = "Donald Duck Sinnemestring avd Andeby"),
            nyVirksomhet(navn = "Andeby Elektriske"),
            nyVirksomhet(navn = "Skrue McDuck Inc"),
            nyVirksomhet(navn = "Donald Duck"),
            nyVirksomhet(navn = "Crispy Duck")
        )

        // -- eksakt match burde komme først
        søkEtterVirksomheter(søkestreng = "donald duck") { virksomheter ->
            virksomheter shouldHaveAtLeastSize 2
            virksomheter.map { it.navn }.first() shouldBe "Donald Duck"
        }

        // -- treff tidligere i navnet burde komme først
        søkEtterVirksomheter(søkestreng = "andeby") { virksomheter ->
            virksomheter shouldHaveAtLeastSize 2
            val virksomhetsNavn = virksomheter.map { it.navn }
            virksomhetsNavn.indexOf("Andeby Elektriske") shouldBeLessThan virksomhetsNavn.indexOf("Donald Duck Sinnemestring avd Andeby")
        }

        // -- sorter ellers på navn stigende
        søkEtterVirksomheter(søkestreng = "duck") { virksomheter ->
            virksomheter shouldHaveAtLeastSize 4
            virksomheter.map { it.navn }.first() shouldBe "Crispy Duck"
        }
    }

    @Test
    fun `skal kunne søke etter virksomheter med treff midt i søkeordet`() {
        val virksomhet = nyVirksomhet(navn = "Dette burde teste noe")
        VirksomhetHelper.lastInnNyVirksomhet(virksomhet)

        søkEtterVirksomheter(søkestreng = "burde") { virksomheter ->
            virksomheter shouldHaveAtLeastSize 1
            virksomheter.forAtLeastOne {
                it.orgnr shouldBe virksomhet.orgnr
            }
        }
    }

    @Test
    fun `skal kunne hente ut oppdatert virksomhetsstatus`() {
        val virksomhet = nyVirksomhet(navn = "Hei og hå")
        VirksomhetHelper.lastInnNyVirksomhet(virksomhet)

        VirksomhetHelper.hentVirksomhetsinformasjon(
                virksomhet.orgnr,
                token = mockOAuthContainer.saksbehandler1.token
        ).also { it.status shouldBe VirksomhetStatus.AKTIV }

        PiaBrregOppdateringTestData.slettedeVirksomheter.forAll { slettetVirksomhet ->
            VirksomhetHelper.hentVirksomhetsinformasjon(
                    slettetVirksomhet.orgnr,
                    token = mockOAuthContainer.saksbehandler1.token
            ).also { it.status shouldBe VirksomhetStatus.SLETTET }
        }

        PiaBrregOppdateringTestData.fjernedeVirksomheter.forAll { fjernetVirksomhet ->
            VirksomhetHelper.hentVirksomhetsinformasjon(
                    fjernetVirksomhet.orgnr,
                    token = mockOAuthContainer.saksbehandler1.token
            ).also { it.status shouldBe VirksomhetStatus.FJERNET }
        }
    }
}
