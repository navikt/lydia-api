package no.nav.lydia.container.virksomhet

import io.kotest.matchers.comparables.shouldBeEqualComparingTo
import io.kotest.matchers.comparables.shouldBeGreaterThan
import io.kotest.matchers.comparables.shouldBeLessThan
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.ktor.http.*
import kotlinx.datetime.Clock
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestData
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.TestVirksomhet.Companion.nyVirksomhet
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.helper.VirksomhetHelper.Companion.lastInnNyVirksomhet
import no.nav.lydia.helper.VirksomhetHelper.Companion.genererEndretNavn
import no.nav.lydia.helper.VirksomhetHelper.Companion.sendEndringForVirksomhet
import no.nav.lydia.helper.VirksomhetHelper.Companion.sendFjerningForVirksomhet
import no.nav.lydia.integrasjoner.brreg.Beliggenhetsadresse
import no.nav.lydia.virksomhet.api.VirksomhetDto
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import no.nav.lydia.virksomhet.domene.VirksomhetStatus
import java.sql.Timestamp
import kotlin.test.Test

class VirksomhetOppdateringTest {
    private val token = TestContainerHelper.oauth2ServerContainer.superbruker1.token

    @Test
    fun `vi oppdaterer næringsgrupper til en bedrift når vi importerer ALLE bedrifter`() {
        val nyVirksomhet = nyVirksomhet(
            beliggenhet = Beliggenhetsadresse(
                    land = "NORGE",
                    landkode = "NO",
                    postnummer = "0100",
                    poststed = "OSLO",
                    adresse = listOf("Tertitten 1"),
                    kommune = "OSLO",
                    kommunenummer = "0300",
            ), næringer = listOf(
                Næringsgruppe(
                        "Barnehager", "88.911"
                ),
                Næringsgruppe(
                        "Dyrking av ettårige vekster ellers", "01.190"
                )
            )
        )
        lastInnNyVirksomhet(nyVirksomhet)

        val virksomhetId = TestContainerHelper.postgresContainer.hentEnkelKolonne<Int>(
                """select id from virksomhet
                    where orgnr='${nyVirksomhet.orgnr}'
                    """.trimIndent()
        )

        val næringskode1 = TestContainerHelper.postgresContainer.hentEnkelKolonne<String>(
                """select naringsundergruppe1 from virksomhet_naringsundergrupper
                    where virksomhet= $virksomhetId
                    """.trimIndent()
        )

        næringskode1 shouldBe "88.911"
    }

    @Test
    fun `vi oppdaterer næringsgrupper til en bedrift`() {
        val nyVirksomhet = nyVirksomhet(
                beliggenhet = Beliggenhetsadresse(
                        land = "NORGE",
                        landkode = "NO",
                        postnummer = "0100",
                        poststed = "OSLO",
                        adresse = listOf("Tertitten 1"),
                        kommune = "OSLO",
                        kommunenummer = "0300",
                ), næringer = listOf(
                        Næringsgruppe(
                                "Barnehager", "88.911"
                        ),
                        Næringsgruppe(
                                "Dyrking av ettårige vekster ellers", "01.190"
                        )
                )
        )
        lastInnNyVirksomhet(nyVirksomhet)

        val oppdatertVirksomhet = nyVirksomhet.copy(næringsundergrupper = listOf(
            Næringsgruppe(
                navn = "Dyrking av ettårige vekster ellers",
                kode = "01.190"
            ), Næringsgruppe(
                navn = "Barnehager",
                kode = "88.911"
            )
        ))
        sendEndringForVirksomhet(oppdatertVirksomhet)

        val virksomhetId = TestContainerHelper.postgresContainer.hentEnkelKolonne<Int>(
                """select id from virksomhet
                    where orgnr='${nyVirksomhet.orgnr}'
                    """.trimIndent()
        )

        val næringskode1 = TestContainerHelper.postgresContainer.hentEnkelKolonne<String>(
                """select naringsundergruppe1 from virksomhet_naringsundergrupper
                    where virksomhet= $virksomhetId
                    """.trimIndent()
        )

        næringskode1 shouldBe "01.190"
    }

    @Test
    fun `vi lagrer næringsundergrupper til en bedrift`() {
        val nyVirksomhet = nyVirksomhet(
            beliggenhet = Beliggenhetsadresse(
                land = "NORGE",
                landkode = "NO",
                postnummer = "0100",
                poststed = "OSLO",
                adresse = listOf("Tertitten 1"),
                kommune = "OSLO",
                kommunenummer = "0300",
            ),
            næringer = listOf(
                Næringsgruppe(
                    navn = "Barnehager",
                    kode = "88.911"
                ),
                Næringsgruppe(
                    navn = "Dyrking av ettårige vekster ellers",
                    kode = "01.190"
                )
            )
        )
        lastInnNyVirksomhet(nyVirksomhet)

        val virksomhetId = TestContainerHelper.postgresContainer.hentEnkelKolonne<Int>(
            """select id from virksomhet
                    where orgnr='${nyVirksomhet.orgnr}'
                    """.trimIndent()
        )

        val næringskode1 = TestContainerHelper.postgresContainer.hentEnkelKolonne<String>(
                """select naringsundergruppe1 from virksomhet_naringsundergrupper
                    where virksomhet= $virksomhetId
                    """.trimIndent()
        )

        næringskode1 shouldBe "88.911"

        val næringskode2 = TestContainerHelper.postgresContainer.hentEnkelKolonne<String>(
                """select naringsundergruppe2 from virksomhet_naringsundergrupper
                    where virksomhet= $virksomhetId
                    """.trimIndent()
        )

        næringskode2 shouldBe "01.190"

        val oppdateringsdato = TestContainerHelper.postgresContainer.hentEnkelKolonne<Timestamp>(
                """select oppdateringsdato from virksomhet_naringsundergrupper
                    where virksomhet = $virksomhetId
                """.trimIndent()
        )
        oppdateringsdato shouldNotBe null
    }

    @Test
    fun `kan oppdatere endrede virksomheter`() {
        val virksomhet = lastInnNyVirksomhet(nyVirksomhet())
        sendEndringForVirksomhet(
            virksomhet = virksomhet.copy(navn = virksomhet.genererEndretNavn())
        )
        virksomhet.skalHaRiktigTilstandEtterOppdatering(
            status = VirksomhetStatus.AKTIV,
            navn = virksomhet.genererEndretNavn()
        )
    }

    @Test
    fun `kan oppdatere fjernede virksomheter`() {
        val virksomhet = lastInnNyVirksomhet(nyVirksomhet())
        sendFjerningForVirksomhet(virksomhet)
        virksomhet.skalHaRiktigTilstandEtterOppdatering(status = VirksomhetStatus.FJERNET)
    }

    @Test
    fun `kan oppdatere slettede virksomheter`() {
        val virksomhet = lastInnNyVirksomhet(nyVirksomhet())
        sendFjerningForVirksomhet(virksomhet)
        virksomhet.skalHaRiktigTilstandEtterOppdatering(status = VirksomhetStatus.FJERNET)
    }

    @Test
    fun `gjør ingenting med virksomheter som ikke er relevante`() {
        val virksomhetUtenAdresse = nyVirksomhet(beliggenhet = Beliggenhetsadresse())
        sendEndringForVirksomhet(virksomhet = virksomhetUtenAdresse)
        VirksomhetHelper.hentVirksomhetsinformasjonRespons(
            orgnummer = virksomhetUtenAdresse.orgnr,
            token = token
        ).second.statusCode shouldBe HttpStatusCode.NotFound.value
    }

    @Test
    fun `Skal inserte en virksomhet med endringstype ny`() {
        val virksomhet = lastInnNyVirksomhet(nyVirksomhet())
        virksomhet.skalHaRiktigTilstandEtterNy()
    }

    @Test
    fun `sjekk på næringskoder`() {
        val virksomhet = lastInnNyVirksomhet(nyVirksomhet(næringer = listOf(TestData.BEDRIFTSRÅDGIVNING)))
        val virksomhetSomSkalFåNæringskodeOppdatert = virksomhet.copy(næringsundergrupper = listOf(
            TestData.DYRKING_AV_RIS,
            TestData.DYRKING_AV_KORN,
            TestData.BEDRIFTSRÅDGIVNING
        ))
        sendEndringForVirksomhet(virksomhet = virksomhetSomSkalFåNæringskodeOppdatert)
        virksomhetSomSkalFåNæringskodeOppdatert
            .skalHaRiktigTilstandEtterOppdatering(status = VirksomhetStatus.AKTIV)
    }
}

private fun genererOppdateringsid(testVirksomhet: TestVirksomhet) =
    testVirksomhet.orgnr.toLong() + 1L

private fun TestVirksomhet.skalHaRiktigTilstandEtterOppdatering(
    status: VirksomhetStatus,
    navn: String = this.navn
): VirksomhetDto {
    val virksomhetDto = skalHaRiktigTilstand(status, navn)
    virksomhetDto.sistEndretTidspunkt shouldBeGreaterThan virksomhetDto.opprettetTidspunkt
    return virksomhetDto
}

private fun TestVirksomhet.skalHaRiktigTilstand(
    status: VirksomhetStatus,
    navn: String = this.navn,
    token: String = TestContainerHelper.oauth2ServerContainer.superbruker1.token
): VirksomhetDto {
    val virksomhetDto =
        VirksomhetHelper.hentVirksomhetsinformasjon(orgnummer = this.orgnr, token)

    virksomhetDto.orgnr shouldBe this.orgnr
    virksomhetDto.navn shouldBe navn
    virksomhetDto.status shouldBe status
    // virksomhetDto.oppstartsdato shouldBe this.oppstartsdato TODO
    virksomhetDto.adresse shouldBe this.beliggenhet!!.adresse!!
    virksomhetDto.postnummer shouldBe this.beliggenhet.postnummer!!
    virksomhetDto.poststed shouldBe this.beliggenhet.poststed!!
    virksomhetDto.næringsundergruppe1 shouldBe this.næringsundergruppe1
    virksomhetDto.næringsundergruppe2 shouldBe this.næringsundergruppe2
    virksomhetDto.næringsundergruppe3 shouldBe this.næringsundergruppe3
    virksomhetDto.oppdatertAvBrregOppdateringsId shouldBe genererOppdateringsid(this)
    virksomhetDto.opprettetTidspunkt shouldBeLessThan Clock.System.now()
    return virksomhetDto
}

private fun TestVirksomhet.skalHaRiktigTilstandEtterNy(navn: String = this.navn) {
    val virksomhetDto = skalHaRiktigTilstand(status = VirksomhetStatus.AKTIV, navn)
    virksomhetDto.sistEndretTidspunkt shouldBeEqualComparingTo virksomhetDto.opprettetTidspunkt
}
