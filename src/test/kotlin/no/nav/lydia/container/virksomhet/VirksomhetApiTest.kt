package no.nav.lydia.container.virksomhet

import ia.felles.definisjoner.bransjer.Bransjer
import io.kotest.inspectors.forAtLeastOne
import io.kotest.matchers.collections.shouldContainInOrder
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.ints.shouldBeLessThan
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.kotest.matchers.string.shouldMatch
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestData
import no.nav.lydia.helper.TestData.Companion.BARNEHAGER
import no.nav.lydia.helper.TestData.Companion.DYRKING_AV_RIS
import no.nav.lydia.helper.TestData.Companion.NÆRINGSMIDLER_IKKE_NEVNT
import no.nav.lydia.helper.TestData.Companion.NÆRING_MED_BINDESTREK
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.TestVirksomhet.Companion.OSLO_FLERE_ADRESSER
import no.nav.lydia.helper.TestVirksomhet.Companion.nyVirksomhet
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.helper.VirksomhetHelper.Companion.hentSalesforceUrl
import no.nav.lydia.helper.VirksomhetHelper.Companion.hentVirksomhetsinformasjon
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
            postgres.hentEnkelKolonne<String>("select naringsundergruppe1 from virksomhet_naringsundergrupper where virksomhet = '$id'")
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
        val virksomhet = hentVirksomhetsinformasjon(
                OSLO_FLERE_ADRESSER.orgnr,
                token = mockOAuthContainer.saksbehandler1.token
        )
        virksomhet.orgnr shouldBe OSLO_FLERE_ADRESSER.orgnr
        virksomhet.navn shouldBe OSLO_FLERE_ADRESSER.navn
        virksomhet.adresse shouldContainInOrder OSLO_FLERE_ADRESSER.beliggenhet?.adresse!!
        virksomhet.postnummer shouldBe OSLO_FLERE_ADRESSER.beliggenhet.postnummer
        virksomhet.poststed shouldBe OSLO_FLERE_ADRESSER.beliggenhet.poststed
        virksomhet.næringsundergruppe2 shouldNotBe null
        virksomhet.sektor shouldBe "Statlig forvaltning"
    }

    @Test
    fun `skal kunne vise næringer med bindestrek`() {
        val orgnummer = VirksomhetHelper.lastInnNyVirksomhet(
                nyVirksomhet = nyVirksomhet(
                        næringer = listOf(
                                BARNEHAGER,
                                NÆRING_MED_BINDESTREK
                        )
                )
        ).orgnr

        val virksomhet = hentVirksomhetsinformasjon(
                orgnummer = orgnummer,
                token = mockOAuthContainer.saksbehandler1.token
        )

        virksomhet.orgnr shouldBe orgnummer
        virksomhet.næringsundergruppe1.navn shouldBe BARNEHAGER.navn
        virksomhet.næringsundergruppe2?.navn shouldBe NÆRING_MED_BINDESTREK.navn
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
    fun `skal kunne søke etter på flere av ordene selv om det er ord imellom`() {
        val virksomhet = nyVirksomhet(navn = "første noe i mellom siste")
        VirksomhetHelper.lastInnNyVirksomhet(virksomhet)

        søkEtterVirksomheter(søkestreng = "første * siste") { virksomheter ->
            virksomheter shouldHaveAtLeastSize 1
            virksomheter.forAtLeastOne {
                it.orgnr shouldBe virksomhet.orgnr
            }
        }
        søkEtterVirksomheter(søkestreng = "første*siste") { virksomheter ->
            virksomheter shouldHaveAtLeastSize 1
            virksomheter.forAtLeastOne {
                it.orgnr shouldBe virksomhet.orgnr
            }
        }
        søkEtterVirksomheter(søkestreng = "første siste") { virksomheter ->
            virksomheter shouldHaveAtLeastSize 0
        }
        søkEtterVirksomheter(søkestreng = "første*feil") { virksomheter ->
            virksomheter shouldHaveAtLeastSize 0
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

        hentVirksomhetsinformasjon(
            orgnummer = virksomhet.orgnr
        ).status shouldBe VirksomhetStatus.AKTIV

        VirksomhetHelper.sendSlettingForVirksomhet(virksomhet)
        hentVirksomhetsinformasjon(
            orgnummer = virksomhet.orgnr
        ).status shouldBe VirksomhetStatus.SLETTET

        VirksomhetHelper.sendFjerningForVirksomhet(virksomhet)
        hentVirksomhetsinformasjon(
            orgnummer = virksomhet.orgnr
        ).status shouldBe VirksomhetStatus.FJERNET
    }

    @Test
    fun `skal få bransje på virksomheter som tilhører et bransjeprogram`() {
        val virksomhetBarnehage = VirksomhetHelper.lastInnNyVirksomhet(nyVirksomhet(næringer = listOf(BARNEHAGER)))
        val virksomhetBarnehageDto = hentVirksomhetsinformasjon(orgnummer = virksomhetBarnehage.orgnr)
        virksomhetBarnehageDto.bransje shouldBe Bransjer.BARNEHAGER

        val virksomhetNæringsmiddel = VirksomhetHelper.lastInnNyVirksomhet(nyVirksomhet(næringer = listOf(NÆRINGSMIDLER_IKKE_NEVNT)))
        val virksomhetNæringsmiddelDto = hentVirksomhetsinformasjon(orgnummer = virksomhetNæringsmiddel.orgnr)
        virksomhetNæringsmiddelDto.bransje shouldBe Bransjer.NÆRINGSMIDDELINDUSTRI
    }

    @Test
    fun `skal IKKE få bransje på virksomheter som IKKE tilhører et bransjeprogram`() {
        val virksomhet = VirksomhetHelper.lastInnNyVirksomhet(nyVirksomhet(næringer = listOf(DYRKING_AV_RIS)))
        val virksomhetDto = hentVirksomhetsinformasjon(orgnummer = virksomhet.orgnr)
        virksomhetDto.bransje shouldBe null
    }

    @Test
    fun `skal få hovednæring for virksomheter`() {
        val virksomhet = VirksomhetHelper.lastInnNyVirksomhet(nyVirksomhet(næringer = listOf(DYRKING_AV_RIS)))
        val virksomhetDto = hentVirksomhetsinformasjon(orgnummer = virksomhet.orgnr)

        virksomhetDto.næring shouldBe Næringsgruppe(kode = "01", navn = "Jordbruk, tilhør. tjenester, jakt")
    }

    @Test
    fun `skal få riktig salesforce lenke`() {
        val virksomhet = VirksomhetHelper.lastInnNyVirksomhet(nyVirksomhet(næringer = listOf(DYRKING_AV_RIS)))
        val salesforceUrl = hentSalesforceUrl(orgnummer = virksomhet.orgnr)

        salesforceUrl.orgnr shouldBe virksomhet.orgnr
        salesforceUrl.url shouldMatch "http://host.testcontainers.internal:\\d+/0015t0000121xU6AAI"
    }
}
