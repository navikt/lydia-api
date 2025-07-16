package no.nav.lydia.container.virksomhet

import io.kotest.inspectors.forAll
import io.kotest.matchers.comparables.shouldBeEqualComparingTo
import io.kotest.matchers.comparables.shouldBeGreaterThan
import io.kotest.matchers.comparables.shouldBeLessThan
import io.kotest.matchers.shouldBe
import io.ktor.http.HttpStatusCode
import kotlinx.datetime.Clock
import kotlinx.serialization.json.Json
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.avslutt
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettBehovsvurdering
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettEvaluering
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.start
import no.nav.lydia.helper.PlanHelper.Companion.hentPlanMal
import no.nav.lydia.helper.PlanHelper.Companion.inkluderAlt
import no.nav.lydia.helper.PlanHelper.Companion.opprettEnPlan
import no.nav.lydia.helper.PlanHelper.Companion.planleggOgFullførAlleUndertemaer
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.TestData
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.TestVirksomhet.Companion.nyVirksomhet
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.helper.VirksomhetHelper.Companion.genererEndretNavn
import no.nav.lydia.helper.VirksomhetHelper.Companion.hentVirksomhetsinformasjon
import no.nav.lydia.helper.VirksomhetHelper.Companion.lastInnNyVirksomhet
import no.nav.lydia.helper.VirksomhetHelper.Companion.sendEndringForVirksomhet
import no.nav.lydia.helper.VirksomhetHelper.Companion.sendFjerningForVirksomhet
import no.nav.lydia.helper.VirksomhetHelper.Companion.sendSlettingForVirksomhet
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.ia.sak.api.samarbeid.IASamarbeidDto
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.integrasjoner.brreg.Beliggenhetsadresse
import no.nav.lydia.virksomhet.api.VirksomhetDto
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import no.nav.lydia.virksomhet.domene.VirksomhetStatus
import kotlin.test.Test
import kotlin.time.Duration.Companion.seconds

class VirksomhetOppdateringTest {
    @Test
    fun `vi oppdaterer næringsgrupper til en bedrift`() {
        val nyVirksomhet = nyVirksomhet(
            næringer = listOf(
                Næringsgruppe(
                    "Barnehager",
                    "88.911",
                ),
                Næringsgruppe(
                    "Dyrking av ettårige vekster ellers",
                    "01.190",
                ),
            ),
        )
        lastInnNyVirksomhet(nyVirksomhet)

        val oppdatertVirksomhet = nyVirksomhet.copy(
            næringsundergrupper = listOf(
                Næringsgruppe(
                    navn = "Dyrking av ettårige vekster ellers",
                    kode = "01.190",
                ),
                Næringsgruppe(
                    navn = "Barnehager",
                    kode = "88.911",
                ),
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
                    Næringsgruppe(
                        navn = "Barnehager",
                        kode = "88.911",
                    ),
                    Næringsgruppe(
                        navn = "Dyrking av ettårige vekster ellers",
                        kode = "01.190",
                    ),
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
    fun `skal avslutte aktiv sak for virksomheter som blir slettet`() {
        val virksomhet = lastInnNyVirksomhet()

        val sak = SakHelper.nySakIViBistår(orgnummer = virksomhet.orgnr)
        val samarbeid = sak.hentAlleSamarbeid().first()
        val behovsvurdering = sak.opprettBehovsvurdering()
        val plan = sak.opprettEnPlan(plan = hentPlanMal().inkluderAlt())
        val evaluering = sak.opprettEvaluering()

        sendSlettingForVirksomhet(virksomhet)

        postgresContainerHelper.hentEnkelKolonne<String>(
            "select status from ia_sak_kartlegging where kartlegging_id = '${behovsvurdering.id}'",
        ) shouldBe Spørreundersøkelse.Status.SLETTET.name
        postgresContainerHelper.hentEnkelKolonne<String>(
            "select status from ia_sak_kartlegging where kartlegging_id = '${evaluering.id}'",
        ) shouldBe Spørreundersøkelse.Status.SLETTET.name
        postgresContainerHelper.hentEnkelKolonne<String>(
            "select status from ia_sak_plan where plan_id = '${plan.id}'",
        )
        postgresContainerHelper.hentAlleRaderTilEnkelKolonne<String>(
            "select status from ia_sak_plan_undertema where plan_id = '${plan.id}'",
        ).forAll { it shouldBe PlanUndertema.Status.AVBRUTT.name }
        postgresContainerHelper.hentEnkelKolonne<String>(
            "select status from ia_prosess where id = ${samarbeid.id}",
        ) shouldBe IASamarbeid.Status.AVBRUTT.name
        postgresContainerHelper.hentEnkelKolonne<String>(
            "select status from ia_sak where saksnummer = '${sak.saksnummer}'",
        ) shouldBe IASak.Status.IKKE_AKTUELL.name
    }

    @Test
    fun `skal ikke røre ikke aktive saker når virksomhet blir slettet`() {
        val virksomhet = lastInnNyVirksomhet()

        val sak = SakHelper.nySakIViBistår(orgnummer = virksomhet.orgnr)
        val samarbeid = sak.hentAlleSamarbeid().first()
        val behovsvurdering = sak.opprettBehovsvurdering()
        behovsvurdering.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        behovsvurdering.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        val plan = sak.opprettEnPlan(plan = hentPlanMal().inkluderAlt())
        plan.planleggOgFullførAlleUndertemaer(orgnummer = sak.orgnr, saksnummer = sak.saksnummer, prosessId = samarbeid.id)
        val evaluering = sak.opprettEvaluering()
        evaluering.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        evaluering.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        val sakEtterFullføring = sak.nyHendelse(
            hendelsestype = IASakshendelseType.FULLFØR_PROSESS,
            payload = Json.encodeToString(
                IASamarbeidDto(
                    id = samarbeid.id,
                    saksnummer = sak.saksnummer,
                    navn = samarbeid.navn,
                ),
            ),
        )
            .nyHendelse(hendelsestype = IASakshendelseType.FULLFØR_BISTAND)

        sendSlettingForVirksomhet(virksomhet)

        postgresContainerHelper.hentEnkelKolonne<String>(
            "select status from ia_sak where saksnummer = '${sak.saksnummer}'",
        ) shouldBe IASak.Status.FULLFØRT.name
        postgresContainerHelper.hentEnkelKolonne<String>(
            "select endret_av_hendelse from ia_sak where saksnummer = '${sak.saksnummer}'",
        ) shouldBe sakEtterFullføring.endretAvHendelseId
    }
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
    virksomhetDto.opprettetTidspunkt.minus(1.seconds) shouldBeLessThan Clock.System.now()
    return virksomhetDto
}

private fun TestVirksomhet.skalHaRiktigTilstandEtterNy(navn: String = this.navn) {
    val virksomhetDto = skalHaRiktigTilstand(status = VirksomhetStatus.AKTIV, navn)
    virksomhetDto.sistEndretTidspunkt shouldBeEqualComparingTo virksomhetDto.opprettetTidspunkt
}
