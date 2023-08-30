package no.nav.lydia.container.virksomhet

import io.kotest.matchers.comparables.shouldBeEqualComparingTo
import io.kotest.matchers.comparables.shouldBeGreaterThan
import io.kotest.matchers.comparables.shouldBeLessThan
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.ktor.http.*
import kotlinx.datetime.Clock
import no.nav.lydia.helper.*
import no.nav.lydia.helper.PiaBrregOppdateringTestData.Companion.endredeVirksomheter
import no.nav.lydia.helper.PiaBrregOppdateringTestData.Companion.fjernedeVirksomheter
import no.nav.lydia.helper.PiaBrregOppdateringTestData.Companion.nyeVirksomheter
import no.nav.lydia.helper.PiaBrregOppdateringTestData.Companion.slettedeVirksomheter
import no.nav.lydia.helper.PiaBrregOppdateringTestData.Companion.virksomhetSomSkalFåNæringskodeOppdatert
import no.nav.lydia.helper.PiaBrregOppdateringTestData.Companion.virksomhetUtenAdresse
import no.nav.lydia.helper.TestVirksomhet.Companion.nyVirksomhet
import no.nav.lydia.integrasjoner.brreg.Beliggenhetsadresse
import no.nav.lydia.integrasjoner.ssb.NæringsDownloader
import no.nav.lydia.virksomhet.api.VirksomhetDto
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import no.nav.lydia.virksomhet.domene.Sektor
import no.nav.lydia.virksomhet.domene.VirksomhetStatus
import java.sql.Timestamp
import kotlin.test.Test

/**
 * NOTE: Denne testen bruker testdata fra [no.nav.lydia.helper.PiaBrregOppdateringTestData]
 * NOTE: og de dataene blir behandlet av [no.nav.lydia.helper.PiaBrregOppdateringContainerHelper.brregOppdateringContainer]
 * */
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
        NæringsDownloader(
            url = IntegrationsHelper.mockKallMotSsbNæringer(
                httpMock = TestContainerHelper.httpMock,
                testData = TestData.fraVirksomhet(nyVirksomhet, sektor = Sektor.STATLIG, perioder = listOf())
            ),
            næringsRepository = TestContainerHelper.næringsRepository
        ).lastNedNæringer()

        TestContainerHelper.kafkaContainerHelper.sendBrregAlleVirksomheter(listOf(nyVirksomhet))

        val virksomhetId = TestContainerHelper.postgresContainer.hentEnkelKolonne<Int>(
                """select id from virksomhet
                    where orgnr='${nyVirksomhet.orgnr}'
                    """.trimIndent()
        )

        val næringskode1 = TestContainerHelper.postgresContainer.hentEnkelKolonne<String>(
                """select naeringskode1 from virksomhet_naringsundergrupper
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
        VirksomhetHelper.lastInnNyVirksomhet(nyVirksomhet)
        TestContainerHelper.kafkaContainerHelper.sendBrregOppdatering(nyVirksomhet)

        val oppdatertVirksomhet = nyVirksomhet.copy(næringsundergrupper = listOf(
            Næringsgruppe(
                    "Dyrking av ettårige vekster ellers",
                    "01.190"
            ), Næringsgruppe(
            "Barnehager",
            "88.911"
            )
        ))

        TestContainerHelper.kafkaContainerHelper.sendBrregOppdatering(oppdatertVirksomhet)

        val virksomhetId = TestContainerHelper.postgresContainer.hentEnkelKolonne<Int>(
                """select id from virksomhet
                    where orgnr='${nyVirksomhet.orgnr}'
                    """.trimIndent()
        )

        val næringskode1 = TestContainerHelper.postgresContainer.hentEnkelKolonne<String>(
                """select naeringskode1 from virksomhet_naringsundergrupper
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
                                "Barnehager", "88.911"
                        ),
                        Næringsgruppe(
                        "Dyrking av ettårige vekster ellers", "01.190"
                        )
                )
        )

        VirksomhetHelper.lastInnNyVirksomhet(nyVirksomhet)
        TestContainerHelper.kafkaContainerHelper.sendBrregOppdatering(nyVirksomhet)

        val virksomhetId = TestContainerHelper.postgresContainer.hentEnkelKolonne<Int>(
            """select id from virksomhet
                    where orgnr='${nyVirksomhet.orgnr}'
                    """.trimIndent()
        )

        val næringskode1 = TestContainerHelper.postgresContainer.hentEnkelKolonne<String>(
                """select naeringskode1 from virksomhet_naringsundergrupper
                    where virksomhet= $virksomhetId
                    """.trimIndent()
        )

        næringskode1 shouldBe "88.911"

        val næringskode2 = TestContainerHelper.postgresContainer.hentEnkelKolonne<String>(
                """select naeringskode2 from virksomhet_naringsundergrupper
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
        endredeVirksomheter.forEach { testVirksomhet ->
            testVirksomhet.skalHaRiktigTilstandEtterOppdatering(
                status = VirksomhetStatus.AKTIV,
                navn = testVirksomhet.genererEndretNavn()
            )
        }
    }

    @Test
    fun `kan oppdatere fjernede virksomheter`() {
        fjernedeVirksomheter.forEach { testVirksomhet ->
            testVirksomhet.skalHaRiktigTilstandEtterOppdatering(status = VirksomhetStatus.FJERNET)
        }
    }

    @Test
    fun `kan oppdatere slettede virksomheter`() {
        slettedeVirksomheter.forEach { testVirksomhet ->
            testVirksomhet.skalHaRiktigTilstandEtterOppdatering(status = VirksomhetStatus.SLETTET)
        }
    }

    @Test
    fun `gjør ingenting med virksomheter som ikke er relevante`() {
        VirksomhetHelper.hentVirksomhetsinformasjonRespons(
            orgnummer = virksomhetUtenAdresse.orgnr,
            token = token
        ).second.statusCode shouldBe HttpStatusCode.NotFound.value
    }

    @Test
    fun `Skal inserte en virksomhet med endringstype ny`() {
        nyeVirksomheter.forEach { virksomhet ->
            virksomhet.skalHaRiktigTilstandEtterNy()
        }
    }

    @Test
    fun `sjekk på næringskoder`() {
        virksomhetSomSkalFåNæringskodeOppdatert.copy(
            navn = virksomhetSomSkalFåNæringskodeOppdatert.genererEndretNavn(),
            næringsundergrupper = listOf(
                TestData.DYRKING_AV_RIS,
                TestData.DYRKING_AV_KORN,
                TestData.BEDRIFTSRÅDGIVNING
            )
        ).skalHaRiktigTilstandEtterOppdatering(status = VirksomhetStatus.AKTIV)
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
