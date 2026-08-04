package no.nav.lydia.container.virksomhet

import io.kotest.matchers.comparables.shouldBeEqualComparingTo
import io.kotest.matchers.comparables.shouldBeGreaterThan
import io.kotest.matchers.comparables.shouldBeLessThan
import io.kotest.matchers.shouldBe
import io.ktor.http.HttpStatusCode
import no.nav.lydia.api.VIRKSOMHET_PATH
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.vurderVirksomhet
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.TestData
import no.nav.lydia.helper.TestData.Companion.BARNEHAGER_SOM_NÆRINGSGRUPPE
import no.nav.lydia.helper.TestData.Companion.DYRKING_AV_ETTÅRIGE_VEKSTER_ELLERS
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.TestVirksomhet.Companion.nyVirksomhet
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.helper.VirksomhetHelper.Companion.genererEndretNavn
import no.nav.lydia.helper.VirksomhetHelper.Companion.hentVirksomhetsinformasjon
import no.nav.lydia.helper.VirksomhetHelper.Companion.lastInnNyVirksomhet
import no.nav.lydia.helper.VirksomhetHelper.Companion.sendEndringForVirksomhet
import no.nav.lydia.helper.VirksomhetHelper.Companion.sendFjerningForVirksomhet
import no.nav.lydia.helper.VirksomhetHelper.Companion.sendSlettingForVirksomhet
import no.nav.lydia.helper.responseString
import no.nav.lydia.helper.statuskode
import no.nav.lydia.integrasjoner.brreg.Adresse
import no.nav.lydia.prioritering.virksomhet.VirksomhetDto
import no.nav.lydia.prioritering.virksomhet.domene.VirksomhetStatus
import no.nav.lydia.samarbeidsperiode.IASakDto
import no.nav.lydia.tilstandsmaskin.VirksomhetIATilstand
import kotlin.test.Test
import kotlin.time.Duration.Companion.seconds
import kotlin.time.Instant

class VirksomhetOppdateringTest {
    @Test
    fun `vi oppdaterer næringsgrupper til en bedrift`() {
        val nyVirksomhet = nyVirksomhet(
            næringer = listOf(
                BARNEHAGER_SOM_NÆRINGSGRUPPE,
                DYRKING_AV_ETTÅRIGE_VEKSTER_ELLERS,
            ),
        )
        lastInnNyVirksomhet(nyVirksomhet)

        val oppdatertVirksomhet = nyVirksomhet.copy(
            næringsundergrupper = listOf(
                BARNEHAGER_SOM_NÆRINGSGRUPPE,
                DYRKING_AV_ETTÅRIGE_VEKSTER_ELLERS,
            ),
        )
        sendEndringForVirksomhet(oppdatertVirksomhet)

        oppdatertVirksomhet.skalHaRiktigTilstandEtterOppdatering()
    }

    @Test
    fun `vi lagrer næringsundergrupper til en bedrift`() {
        lastInnNyVirksomhet(
            nyVirksomhet(
                næringer = listOf(
                    BARNEHAGER_SOM_NÆRINGSGRUPPE,
                    DYRKING_AV_ETTÅRIGE_VEKSTER_ELLERS,
                ),
            ),
        ).skalHaRiktigTilstand()
    }

    @Test
    fun `kan oppdatere endrede virksomheter`() {
        val virksomhet = lastInnNyVirksomhet(nyVirksomhet())
        sendEndringForVirksomhet(
            virksomhet = virksomhet.copy(navn = virksomhet.genererEndretNavn()),
        )
        virksomhet.skalHaRiktigTilstandEtterOppdatering(
            status = VirksomhetStatus.AKTIV,
            navn = virksomhet.genererEndretNavn(),
        )
    }

    @Test
    fun `skal slette fjernede virksomheter uten aktivitet`() {
        val virksomhet = lastInnNyVirksomhet(nyVirksomhet())
        sendFjerningForVirksomhet(virksomhet)

        val harVirksomhet = TestContainerHelper.postgresContainerHelper.hentEnkelKolonne<Boolean>(
            """
            SELECT EXISTS(SELECT 1 FROM virksomhet
            WHERE orgnr = '${virksomhet.orgnr}')
            """.trimIndent(),
        )

        harVirksomhet shouldBe false
    }

    @Test
    fun `skal slette slettede virksomheter uten aktivitet`() {
        val virksomhet = lastInnNyVirksomhet(nyVirksomhet())
        sendSlettingForVirksomhet(virksomhet)

        val harVirksomhet = TestContainerHelper.postgresContainerHelper.hentEnkelKolonne<Boolean>(
            """
            SELECT EXISTS(SELECT 1 FROM virksomhet
            WHERE orgnr = '${virksomhet.orgnr}')
            """.trimIndent(),
        )

        harVirksomhet shouldBe false
    }

    @Test
    fun `gjør ingenting med virksomheter som ikke er relevante`() {
        val virksomhetUtenAdresse = nyVirksomhet(beliggenhet = Adresse())
        sendEndringForVirksomhet(virksomhet = virksomhetUtenAdresse)
        VirksomhetHelper.hentVirksomhetsinformasjonRespons(
            orgnummer = virksomhetUtenAdresse.orgnr,
            token = authContainerHelper.superbruker1.token,
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
        val virksomhetSomSkalFåNæringskodeOppdatert = virksomhet.copy(
            næringsundergrupper = listOf(
                TestData.DYRKING_AV_RIS,
                TestData.DYRKING_AV_KORN,
                TestData.BEDRIFTSRÅDGIVNING,
            ),
        )
        sendEndringForVirksomhet(virksomhet = virksomhetSomSkalFåNæringskodeOppdatert)
        virksomhetSomSkalFåNæringskodeOppdatert
            .skalHaRiktigTilstandEtterOppdatering(status = VirksomhetStatus.AKTIV)
    }

    @Test
    fun `behandle slettede virksomheter - ingen å fikse`() {
        val respons = tempBehandleSlettedeVirksomheterHelper()

        respons.statuskode() shouldBe HttpStatusCode.OK.value
        respons.third.get() shouldBe "Vellykket oppdatering av 0 slettede/fjernede virksomheter."
    }

    @Test
    fun `behandle slettede virksomheter - fikser virksomhet med SLETTET status og feil tilstand`() {
        val sak = vurderVirksomhet()
        postgresContainerHelper.performUpdate(
            "UPDATE virksomhet SET status = 'SLETTET' WHERE orgnr = '${sak.orgnr}'",
        )

        val respons = tempBehandleSlettedeVirksomheterHelper()

        respons.statuskode() shouldBe HttpStatusCode.OK.value
        respons.third.get() shouldBe "Vellykket oppdatering av 1 slettede/fjernede virksomheter."
        postgresContainerHelper.hentEnkelKolonne<String>(
            "SELECT tilstand FROM tilstand_virksomhet WHERE orgnr = '${sak.orgnr}'",
        ) shouldBe VirksomhetIATilstand.VirksomhetErAvregistrertIBrreg.name
    }

    @Test
    fun `behandle slettede virksomheter - fikser virksomhet med FJERNET status og feil tilstand`() {
        val sak = vurderVirksomhet()
        postgresContainerHelper.performUpdate(
            "UPDATE virksomhet SET status = 'FJERNET' WHERE orgnr = '${sak.orgnr}'",
        )

        val respons = tempBehandleSlettedeVirksomheterHelper()

        respons.statuskode() shouldBe HttpStatusCode.OK.value
        respons.third.get() shouldBe "Vellykket oppdatering av 1 slettede/fjernede virksomheter."
        postgresContainerHelper.hentEnkelKolonne<String>(
            "SELECT tilstand FROM tilstand_virksomhet WHERE orgnr = '${sak.orgnr}'",
        ) shouldBe VirksomhetIATilstand.VirksomhetErAvregistrertIBrreg.name
    }

    @Test
    fun `behandle slettede virksomheter - fikser flere virksomheter med blanding av SLETTET og FJERNET`() {
        val sak1 = vurderVirksomhet()
        val sak2 = vurderVirksomhet()
        val sak3 = vurderVirksomhet()
        postgresContainerHelper.performUpdate(
            "UPDATE virksomhet SET status = 'SLETTET' WHERE orgnr IN ('${sak1.orgnr}', '${sak2.orgnr}')",
        )
        postgresContainerHelper.performUpdate(
            "UPDATE virksomhet SET status = 'FJERNET' WHERE orgnr = '${sak3.orgnr}'",
        )

        val respons = tempBehandleSlettedeVirksomheterHelper()

        respons.statuskode() shouldBe HttpStatusCode.OK.value
        respons.third.get() shouldBe "Vellykket oppdatering av 3 slettede/fjernede virksomheter."
        listOf(sak1, sak2, sak3).forEach { sak ->
            postgresContainerHelper.hentEnkelKolonne<String>(
                "SELECT tilstand FROM tilstand_virksomhet WHERE orgnr = '${sak.orgnr}'",
            ) shouldBe VirksomhetIATilstand.VirksomhetErAvregistrertIBrreg.name
        }
    }

    private fun tempBehandleSlettedeVirksomheterHelper() =
        applikasjon.performPost("$VIRKSOMHET_PATH/temp/behandle_slettede_virksomheter")
            .authentication().bearer(authContainerHelper.superbruker1.token)
            .responseString()
}

private fun genererOppdateringsid(testVirksomhet: TestVirksomhet): Long = testVirksomhet.orgnr.toLong() + 1L

private fun TestVirksomhet.skalHaRiktigTilstandEtterOppdatering(
    status: VirksomhetStatus = VirksomhetStatus.AKTIV,
    navn: String = this.navn,
): VirksomhetDto {
    val virksomhetDto = skalHaRiktigTilstand(status, navn)
    virksomhetDto.sistEndretTidspunkt.plus(1.seconds) shouldBeGreaterThan virksomhetDto.opprettetTidspunkt
    return virksomhetDto
}

private fun TestVirksomhet.skalHaRiktigTilstand(
    status: VirksomhetStatus = VirksomhetStatus.AKTIV,
    navn: String = this.navn,
    token: String = authContainerHelper.superbruker1.token,
): VirksomhetDto {
    val virksomhetDto =
        hentVirksomhetsinformasjon(orgnummer = this.orgnr, token)

    virksomhetDto.orgnr shouldBe this.orgnr
    virksomhetDto.navn shouldBe navn
    virksomhetDto.status shouldBe status
    virksomhetDto.adresse shouldBe this.beliggenhet!!.adresse!!
    virksomhetDto.postnummer shouldBe this.beliggenhet.postnummer!!
    virksomhetDto.poststed shouldBe this.beliggenhet.poststed!!
    virksomhetDto.næringsundergruppe1 shouldBe this.næringsundergruppe1
    virksomhetDto.næringsundergruppe2 shouldBe this.næringsundergruppe2
    virksomhetDto.næringsundergruppe3 shouldBe this.næringsundergruppe3
    virksomhetDto.oppdatertAvBrregOppdateringsId shouldBe genererOppdateringsid(this)
    virksomhetDto.opprettetTidspunkt.minus(1.seconds) shouldBeLessThan nowInstant()
    return virksomhetDto
}

private fun nowInstant(): Instant = Instant.fromEpochMilliseconds(System.currentTimeMillis())

private fun TestVirksomhet.skalHaRiktigTilstandEtterNy(navn: String = this.navn) {
    val virksomhetDto = skalHaRiktigTilstand(status = VirksomhetStatus.AKTIV, navn)
    virksomhetDto.sistEndretTidspunkt shouldBeEqualComparingTo virksomhetDto.opprettetTidspunkt
}
