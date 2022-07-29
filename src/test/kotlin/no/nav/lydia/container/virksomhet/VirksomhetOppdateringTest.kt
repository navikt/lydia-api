package no.nav.lydia.container.virksomhet

import io.kotest.matchers.collections.shouldContainAll
import io.kotest.matchers.comparables.shouldBeEqualComparingTo
import io.kotest.matchers.comparables.shouldBeGreaterThan
import io.kotest.matchers.comparables.shouldBeLessThan
import io.kotest.matchers.comparables.shouldBeLessThanOrEqualTo
import io.kotest.matchers.shouldBe
import io.ktor.http.HttpStatusCode
import kotlinx.coroutines.delay
import kotlinx.coroutines.runBlocking
import kotlinx.datetime.Clock
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestData
import no.nav.lydia.helper.TestData.Companion.BEDRIFTSRÅDGIVNING
import no.nav.lydia.helper.TestData.Companion.DYRKING_AV_KORN
import no.nav.lydia.helper.TestData.Companion.DYRKING_AV_RIS
import no.nav.lydia.helper.TestData.Companion.SCENEKUNST
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.TestVirksomhet.Companion.TESTVIRKSOMHET_FOR_OPPDATERING
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.integrasjoner.brreg.Beliggenhetsadresse
import no.nav.lydia.integrasjoner.brreg.BrregVirksomhetDto
import no.nav.lydia.integrasjoner.brreg.NæringsundergruppeBrreg
import no.nav.lydia.sykefraversstatistikk.import.BrregOppdateringConsumer
import no.nav.lydia.sykefraversstatistikk.import.BrregOppdateringConsumer.BrregVirksomhetEndringstype.Endring
import no.nav.lydia.sykefraversstatistikk.import.BrregOppdateringConsumer.BrregVirksomhetEndringstype.Fjernet
import no.nav.lydia.sykefraversstatistikk.import.BrregOppdateringConsumer.BrregVirksomhetEndringstype.Ny
import no.nav.lydia.sykefraversstatistikk.import.BrregOppdateringConsumer.BrregVirksomhetEndringstype.Sletting
import no.nav.lydia.virksomhet.api.VirksomhetDto
import no.nav.lydia.virksomhet.domene.VirksomhetStatus
import kotlin.test.Test

class VirksomhetOppdateringTest {
    private val token = TestContainerHelper.oauth2ServerContainer.superbruker1.token

    val testData = TestData()
    private val tilfeldigeVirksomheter: MutableList<TestVirksomhet> = mutableListOf()
    private val tilfeldigeFjernedeVirksomheter: MutableList<TestVirksomhet> = mutableListOf()
    private val tilfeldigeSlettedeVirksomheter: MutableList<TestVirksomhet> = mutableListOf()
    private val virksomhet2 =
        TestVirksomhet.nyVirksomhet(
            næringer = listOf(
                DYRKING_AV_RIS,
                DYRKING_AV_KORN,
                SCENEKUNST
            )
        )

    /*

    1. lage en rekke med TestVirksomhet
    2. dynamisk lage en mock-respons fra Brreg basert på disse
    3. trigge oppdateringsjobb
    4. forvent noe derfra

     */


//    init {
//        repeat(times = 5) {
//            val nyVirksomhet = TestVirksomhet.nyVirksomhet()
//            tilfeldigeVirksomheter.add(nyVirksomhet)
//            testData.lagData(
//                virksomhet = nyVirksomhet,
//                perioder = listOf(Periode.gjeldendePeriode())
//            )
//        }
//        repeat(times = 5) {
//            val nyVirksomhet = TestVirksomhet.nyVirksomhet()
//            tilfeldigeFjernedeVirksomheter.add(nyVirksomhet)
//            testData.lagData(
//                virksomhet = nyVirksomhet,
//                perioder = listOf(Periode.gjeldendePeriode())
//            )
//        }
//        repeat(times = 5) {
//            val nyVirksomhet = TestVirksomhet.nyVirksomhet()
//            tilfeldigeSlettedeVirksomheter.add(nyVirksomhet)
//            testData.lagData(
//                virksomhet = nyVirksomhet,
//                perioder = listOf(Periode.gjeldendePeriode())
//            )
//        }
//        testData.lagData(virksomhet2, perioder = listOf(Periode.gjeldendePeriode()))
//
//        runBlocking {
//            VirksomhetHelper.lastInnTestdata(testData = testData)
//        }
//    }

    @Test
    fun `kan oppdatere endrede virksomheter`() {
//        // Given
//        tilfeldigeVirksomheter.forEach { testVirksomhet ->
//            testVirksomhet.skalHaForventetTilstandFøroppdatering()
//        }
//
//        // When
//        tilfeldigeVirksomheter.forEach { testVirksomhet ->
//            testVirksomhet
//                .copy(navn = testVirksomhet.genererEndretNavn())
//                .sendOppdateringsmelding(endringstype = Endring)
//        }
//
//        // Then
//        tilfeldigeVirksomheter.forEach { testVirksomhet ->
//            testVirksomhet.skalHaRiktigTilstandEtterOppdatering(
//                status = VirksomhetStatus.AKTIV,
//                navn = testVirksomhet.genererEndretNavn()
//            )
//        }

        val testVirksomhet = TESTVIRKSOMHET_FOR_OPPDATERING
        testVirksomhet.skalHaRiktigTilstandEtterOppdatering(
            status = VirksomhetStatus.AKTIV,
            navn = testVirksomhet.navn
        )
    }

    @Test
    fun `kan oppdatere fjernede virksomheter`() {
        // Given
        tilfeldigeFjernedeVirksomheter.forEach { testVirksomhet ->
            testVirksomhet.skalHaForventetTilstandFøroppdatering()
        }

        // When
        tilfeldigeFjernedeVirksomheter.forEach { testVirksomhet ->
            testVirksomhet
                .sendOppdateringsmelding(endringstype = Fjernet)
        }

        // Then
        tilfeldigeFjernedeVirksomheter.forEach { testVirksomhet ->
            testVirksomhet.skalHaRiktigTilstandEtterOppdatering(status = VirksomhetStatus.FJERNET)
        }
    }

    @Test
    fun `kan oppdatere slettede virksomheter`() {
        // Given
        tilfeldigeSlettedeVirksomheter.forEach { testVirksomhet ->
            testVirksomhet.skalHaForventetTilstandFøroppdatering()
        }

        // When
        tilfeldigeSlettedeVirksomheter.forEach { testVirksomhet ->
            testVirksomhet
                .sendOppdateringsmelding(endringstype = Sletting)
        }

        // Then
        tilfeldigeSlettedeVirksomheter.forEach { testVirksomhet ->
            testVirksomhet.skalHaRiktigTilstandEtterOppdatering(status = VirksomhetStatus.SLETTET)
        }
    }


    @Test
    fun `gjør ingenting med virksomheter som ikke er relevante`() {
        val testVirksomhet =
            VirksomhetHelper.lastInnNyVirksomhet(nyVirksomhet = TestVirksomhet.nyVirksomhet(beliggenhet = Beliggenhetsadresse()))
        VirksomhetHelper.hentVirksomhetsinformasjonRespons(
            orgnummer = testVirksomhet.orgnr,
            token = token
        ).second.statusCode shouldBe HttpStatusCode.NotFound.value
        BrregOppdateringConsumer.BrregVirksomhetEndringstype.values().forEach { endringsType ->
            testVirksomhet
                .sendOppdateringsmelding(endringstype = endringsType)
            VirksomhetHelper.hentVirksomhetsinformasjonRespons(
                orgnummer = testVirksomhet.orgnr,
                token = token
            ).second.statusCode shouldBe HttpStatusCode.NotFound.value
        }
    }

    @Test
    fun `Skal inserte en virksomhet med endringstype ny`() {
        val virksomhet = TestVirksomhet.nyVirksomhet()
        virksomhet
            .sendOppdateringsmelding(endringstype = Ny)
        virksomhet.skalHaRiktigTilstandEtterNy()
    }

    @Test
    fun `sjekk på næringskoder`() {
        val virksomhet = virksomhet2
            .copy(næringsundergrupper = listOf(DYRKING_AV_RIS, DYRKING_AV_KORN, BEDRIFTSRÅDGIVNING))
        runBlocking {
            virksomhet
                .sendOppdateringsmelding(endringstype = Endring).also { delay(1000) }
                .skalHaRiktigTilstandEtterOppdatering(status = VirksomhetStatus.AKTIV)
        }
    }
}

private fun TestVirksomhet.skalHaForventetTilstandFøroppdatering() {
    val virksomhetDto =
        VirksomhetHelper.hentVirksomhetsinformasjon(
            orgnummer = this.orgnr,
            token = TestContainerHelper.oauth2ServerContainer.superbruker1.token
        )

    virksomhetDto.orgnr shouldBe this.orgnr
    virksomhetDto.navn shouldBe this.navn
    virksomhetDto.status shouldBe VirksomhetStatus.AKTIV
    // virksomhetDto.oppstartsdato shouldBe this.oppstartsdato TODO
    virksomhetDto.adresse shouldBe this.beliggenhet!!.adresse!!
    virksomhetDto.postnummer shouldBe this.beliggenhet.postnummer!!
    virksomhetDto.poststed shouldBe this.beliggenhet.poststed!!
    virksomhetDto.neringsgrupper shouldContainAll this.næringsundergrupper
    virksomhetDto.oppdatertAvBrregOppdateringsId shouldBe null
    virksomhetDto.opprettetTidspunkt shouldBeLessThanOrEqualTo Clock.System.now()
    virksomhetDto.sistEndretTidspunkt shouldBeLessThanOrEqualTo Clock.System.now()
}

private fun TestVirksomhet.sendOppdateringsmelding(endringstype: BrregOppdateringConsumer.BrregVirksomhetEndringstype): TestVirksomhet {
    val oppdateringVirksomhet = BrregOppdateringConsumer.OppdateringVirksomhet(
        orgnummer = this.orgnr,
        oppdateringsid = genererOppdateringsid(this),
        endringstype = endringstype,
        metadata = BrregVirksomhetDto(
            organisasjonsnummer = this.orgnr,
            navn = this.navn,
            beliggenhetsadresse = this.beliggenhet,
            naeringskode1 = NæringsundergruppeBrreg(
                beskrivelse = this.næringsundergruppe1.navn,
                kode = this.næringsundergruppe1.kode
            ),
            naeringskode2 = this.næringsundergruppe2?.let { næringsundergruppe2 ->
                NæringsundergruppeBrreg(
                    beskrivelse = næringsundergruppe2.navn,
                    kode = næringsundergruppe2.kode
                )
            },
            naeringskode3 = this.næringsundergruppe3?.let { næringsundergruppe3 ->
                NæringsundergruppeBrreg(
                    beskrivelse = næringsundergruppe3.navn,
                    kode = næringsundergruppe3.kode
                )
            },
        ),
        endringstidspunkt = Clock.System.now()
    )
    oppdateringVirksomhet.send()
    return this
}

private fun TestVirksomhet.genererEndretNavn() = this.navn.reversed()

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
    virksomhetDto.neringsgrupper shouldContainAll this.næringsundergrupper
    virksomhetDto.oppdatertAvBrregOppdateringsId shouldBe genererOppdateringsid(this)
    virksomhetDto.opprettetTidspunkt shouldBeLessThan Clock.System.now()
    return virksomhetDto
}

private fun TestVirksomhet.skalHaRiktigTilstandEtterNy(navn: String = this.navn) {
    val virksomhetDto = skalHaRiktigTilstand(status = VirksomhetStatus.AKTIV, navn)
    virksomhetDto.sistEndretTidspunkt shouldBeEqualComparingTo virksomhetDto.opprettetTidspunkt
}

private fun BrregOppdateringConsumer.OppdateringVirksomhet.send() {
    TestContainerHelper.kafkaContainerHelper.brregOppdatering.sendBrregOppdateringKafkaMelding(oppdateringVirksomhet = this)
}
