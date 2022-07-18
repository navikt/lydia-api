package no.nav.lydia.container.virksomhet

import io.kotest.matchers.collections.shouldContainAll
import io.kotest.matchers.collections.shouldContainExactlyInAnyOrder
import io.kotest.matchers.comparables.shouldBeEqualComparingTo
import io.kotest.matchers.comparables.shouldBeGreaterThan
import io.kotest.matchers.comparables.shouldBeLessThan
import io.kotest.matchers.comparables.shouldBeLessThanOrEqualTo
import io.kotest.matchers.shouldBe
import io.ktor.http.HttpStatusCode
import kotlinx.datetime.Clock
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestData.Companion.BEDRIFTSRÅDGIVNING
import no.nav.lydia.helper.TestData.Companion.DYRKING_AV_KORN
import no.nav.lydia.helper.TestData.Companion.DYRKING_AV_RIS
import no.nav.lydia.helper.TestData.Companion.SCENEKUNST
import no.nav.lydia.helper.TestVirksomhet
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
    private val kafkaContainer = TestContainerHelper.kafkaContainerHelper
    private val token = TestContainerHelper.oauth2ServerContainer.superbruker1.token

    @Test
    fun `kan oppdatere endrede virksomheter`() {
        // Given
        val tilfeldigeVirksomheter: MutableList<TestVirksomhet> = mutableListOf()
        repeat(times = 5) {
            val nyVirksomhet = VirksomhetHelper.lastInnNyVirksomhet()
            tilfeldigeVirksomheter.add(nyVirksomhet)
        }

        tilfeldigeVirksomheter.forEach { testVirksomhet ->
            testVirksomhet.skalHaForventetTilstandFøroppdatering()
        }

        // When
        tilfeldigeVirksomheter.forEach { testVirksomhet ->
            testVirksomhet
                .copy(navn = testVirksomhet.genererEndretNavn())
                .tilOppdateringsmelding(endringstype = Endring)
                .send()
        }

        // Then
        tilfeldigeVirksomheter.forEach { testVirksomhet ->
            testVirksomhet.skalHaRiktigTilstandEtterOppdatering(status = VirksomhetStatus.AKTIV, navn = testVirksomhet.genererEndretNavn())
        }
    }

    @Test
    fun `kan oppdatere fjernede virksomheter`() {
        // Given
        val tilfeldigeFjernedeVirksomheter: MutableList<TestVirksomhet> = mutableListOf()
        repeat(times = 5) {
            val nyVirksomhet = VirksomhetHelper.lastInnNyVirksomhet()
            tilfeldigeFjernedeVirksomheter.add(nyVirksomhet)
        }

        tilfeldigeFjernedeVirksomheter.forEach { testVirksomhet ->
            testVirksomhet.skalHaForventetTilstandFøroppdatering()
        }

        // When
        tilfeldigeFjernedeVirksomheter.forEach { testVirksomhet ->
            testVirksomhet
                .tilOppdateringsmelding(endringstype = Fjernet)
                .send()
        }

        // Then
        tilfeldigeFjernedeVirksomheter.forEach { testVirksomhet ->
            testVirksomhet.skalHaRiktigTilstandEtterOppdatering(status = VirksomhetStatus.FJERNET)
        }
    }

    @Test
    fun `kan oppdatere slettede virksomheter`() {
        // Given
        val tilfeldigeSlettedeVirksomheter: MutableList<TestVirksomhet> = mutableListOf()
        repeat(times = 5) {
            val nyVirksomhet = VirksomhetHelper.lastInnNyVirksomhet()
            tilfeldigeSlettedeVirksomheter.add(nyVirksomhet)
        }

        tilfeldigeSlettedeVirksomheter.forEach { testVirksomhet ->
            testVirksomhet.skalHaForventetTilstandFøroppdatering()
        }

        // When
        tilfeldigeSlettedeVirksomheter.forEach { testVirksomhet ->
            testVirksomhet
                .tilOppdateringsmelding(endringstype = Sletting)
                .send()
        }

        // Then
        tilfeldigeSlettedeVirksomheter.forEach { testVirksomhet ->
            testVirksomhet.skalHaRiktigTilstandEtterOppdatering(status = VirksomhetStatus.SLETTET)
        }
    }

    private fun TestVirksomhet.skalHaForventetTilstandFøroppdatering() {
        val virksomhetDto =
            VirksomhetHelper.hentVirksomhetsinformasjon(orgnummer = this.orgnr, token)

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

    private fun TestVirksomhet.tilOppdateringsmelding(endringstype: BrregOppdateringConsumer.BrregVirksomhetEndringstype): BrregOppdateringConsumer.OppdateringVirksomhet {
        return BrregOppdateringConsumer.OppdateringVirksomhet(
            orgnummer = this.orgnr,
            oppdateringsId = genererOppdateringsid(this),
            brregVirksomhetEndringstype = endringstype,
            metadata = BrregVirksomhetDto(
                organisasjonsnummer = this.orgnr,
                navn = this.navn,
                beliggenhetsadresse = this.beliggenhet,
                naeringskode1 = NæringsundergruppeBrreg(
                    beskrivelse = this.næringsundergruppe1.navn,
                    kode = this.næringsundergruppe1.kode
                )
            ),
            endringstidspunkt = Clock.System.now()
        )
    }

    private fun TestVirksomhet.genererEndretNavn() = this.navn.reversed()

    private fun genererOppdateringsid(testVirksomhet: TestVirksomhet) =
        testVirksomhet.orgnr.toLong() + 1L

    private fun BrregOppdateringConsumer.OppdateringVirksomhet.send() {
        kafkaContainer.brregOppdatering.sendBrregOppdateringKafkaMelding(oppdateringVirksomhet = this)
    }

    private fun TestVirksomhet.skalHaRiktigTilstandEtterOppdatering(status: VirksomhetStatus, navn: String = this.navn): VirksomhetDto {
        val virksomhetDto = skalHaRiktigTilstand(status, navn)
        virksomhetDto.sistEndretTidspunkt shouldBeGreaterThan virksomhetDto.opprettetTidspunkt
        return virksomhetDto
    }

    private fun TestVirksomhet.skalHaRiktigTilstand(status: VirksomhetStatus, navn: String = this.navn): VirksomhetDto {
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

    @Test
    fun `gjør ingenting med virksomheter som ikke er relevante`() {
        val testVirksomhet = VirksomhetHelper.lastInnNyVirksomhet(nyVirksomhet = TestVirksomhet.nyVirksomhet(beliggenhet = Beliggenhetsadresse()))
        VirksomhetHelper.hentVirksomhetsinformasjonRespons(orgnummer = testVirksomhet.orgnr, token = token).second.statusCode shouldBe HttpStatusCode.NotFound.value
        BrregOppdateringConsumer.BrregVirksomhetEndringstype.values().forEach { endringsType ->
            testVirksomhet
                .tilOppdateringsmelding(endringstype = endringsType)
                .send()
            VirksomhetHelper.hentVirksomhetsinformasjonRespons(orgnummer = testVirksomhet.orgnr, token = token).second.statusCode shouldBe HttpStatusCode.NotFound.value
        }
    }

    @Test
    fun `Skal inserte en virksomhet med endringstype ny`() {
        val virksomhet = TestVirksomhet.nyVirksomhet()
        virksomhet
            .tilOppdateringsmelding(endringstype = Ny)
            .send()
        virksomhet.skalHaRiktigTilstandEtterNy()
    }

    @Test
    fun `sjekk på næringskoder`() {
        val virksomhet = VirksomhetHelper.lastInnNyVirksomhet(TestVirksomhet.nyVirksomhet(næringer = listOf(DYRKING_AV_RIS, DYRKING_AV_KORN, SCENEKUNST)))
        virksomhet
            .copy(næringsundergrupper = listOf(DYRKING_AV_RIS, DYRKING_AV_KORN, BEDRIFTSRÅDGIVNING))
            .tilOppdateringsmelding(endringstype = Endring)
            .send()
        val virksomhetDto = virksomhet.skalHaRiktigTilstandEtterOppdatering(status = VirksomhetStatus.AKTIV)
        virksomhetDto.neringsgrupper shouldContainExactlyInAnyOrder listOf(DYRKING_AV_RIS, DYRKING_AV_KORN, BEDRIFTSRÅDGIVNING)
    }
}

