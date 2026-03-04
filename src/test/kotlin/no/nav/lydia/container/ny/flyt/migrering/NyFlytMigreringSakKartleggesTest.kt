package no.nav.lydia.container.ny.flyt.migrering

import io.kotest.assertions.shouldFail
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.migreringSakIKartlegges
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.sendMigreringsmeldingOgVerifiserSak
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.tømmKafkaTopics
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.utilsSetUp
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.utilsTearDown
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.verifiserHistorikk
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.verifiserKafkaMeldinger
import no.nav.lydia.helper.PlanHelper.Companion.opprettEnPlan
import no.nav.lydia.helper.SakHelper.Companion.avbrytSamarbeid
import no.nav.lydia.helper.SakHelper.Companion.fullførSamarbeid
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.slettSamarbeid
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.opprettNyttSamarbeid
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetIATilstand
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_SKAL_BISTÅS
import org.junit.AfterClass
import org.junit.BeforeClass
import org.junit.Ignore
import kotlin.test.Test

class NyFlytMigreringSakKartleggesTest {
    companion object {
        @BeforeClass
        @JvmStatic
        fun setUp() {
            utilsSetUp()
        }

        @AfterClass
        @JvmStatic
        fun tearDown() {
            utilsTearDown()
        }
    }

    @Ignore
    fun `EDGE CASE sak med status KARTLEGGES med et fullført samarbeid er ikke dekket enda av migrerings matrise`() {
        val iaSakDto = migreringSakIKartlegges().opprettNyttSamarbeid().also { it.opprettEnPlan() }.nyHendelse(hendelsestype = VIRKSOMHET_SKAL_BISTÅS)
        val iaSakDtoTilbakeIKartlegges = iaSakDto.fullførSamarbeid().nyHendelse(IASakshendelseType.TILBAKE)

        tømmKafkaTopics(iaSakDto)
        sendMigreringsmeldingOgVerifiserSak(
            iaSakDto = iaSakDtoTilbakeIKartlegges,
            sistEndretAvBruker = iaSakDtoTilbakeIKartlegges.endretTidspunkt,
            forventetStatus = IASak.Status.KARTLEGGES,
            forventetTilstand = VirksomhetIATilstand.VirksomhetKlarTilVurdering,
            migrer = false,
        )
        shouldFail {
            postgresContainerHelper.hentEnkelKolonne<String>(
                "select tilstand from tilstand_virksomhet where orgnr = '${iaSakDtoTilbakeIKartlegges.orgnr}'",
            )
        }

        applikasjon.shouldContainLog("er ikke håndtert som en use-case til migrering enda".toRegex())
    }

    @Test
    fun `Rad #6 sak med status KARTLEGGES men ingen aktive samarbeid migreres til VURDERES status`() {
        val iaSakDto = migreringSakIKartlegges()

        tømmKafkaTopics(iaSakDto)
        sendMigreringsmeldingOgVerifiserSak(
            iaSakDto = iaSakDto,
            sistEndretAvBruker = iaSakDto.endretTidspunkt,
            forventetStatus = IASak.Status.VURDERES,
            forventetTilstand = VirksomhetIATilstand.VirksomhetVurderes,
        )

        verifiserHistorikk(
            orgnummer = iaSakDto.orgnr,
            forventedeStatuser = listOf(
                IASak.Status.NY,
                IASak.Status.VURDERES,
                IASak.Status.VURDERES,
                IASak.Status.KONTAKTES,
                IASak.Status.KARTLEGGES,
                IASak.Status.VURDERES,
            ),
            forventedeHendelsestyper = listOf(
                IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
                IASakshendelseType.VIRKSOMHET_VURDERES,
                IASakshendelseType.TA_EIERSKAP_I_SAK,
                IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
                IASakshendelseType.VIRKSOMHET_KARTLEGGES,
                IASakshendelseType.MIGRERING_TIL_NY_FLYT,
            ),
        )

        verifiserKafkaMeldinger(iaSakDto, forventetStatus = IASak.Status.VURDERES)
    }

    @Test
    fun `Rad #7 sak med status KARTLEGGES og et aktivt samarbeid migreres til AKTIV status`() {
        val iaSakDto = migreringSakIKartlegges()
        val sistEndretAvBruker = iaSakDto.opprettNyttSamarbeid().endretTidspunkt

        tømmKafkaTopics(iaSakDto)
        sendMigreringsmeldingOgVerifiserSak(
            iaSakDto = iaSakDto,
            sistEndretAvBruker = sistEndretAvBruker,
            forventetStatus = IASak.Status.AKTIV,
            forventetTilstand = VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid,
        )

        verifiserHistorikk(
            orgnummer = iaSakDto.orgnr,
            forventedeStatuser = listOf(
                IASak.Status.NY,
                IASak.Status.VURDERES,
                IASak.Status.VURDERES,
                IASak.Status.KONTAKTES,
                IASak.Status.KARTLEGGES,
                IASak.Status.KARTLEGGES, // opprett samarbeid
                IASak.Status.AKTIV,
            ),
            forventedeHendelsestyper = listOf(
                IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
                IASakshendelseType.VIRKSOMHET_VURDERES,
                IASakshendelseType.TA_EIERSKAP_I_SAK,
                IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
                IASakshendelseType.VIRKSOMHET_KARTLEGGES,
                IASakshendelseType.NY_PROSESS,
                IASakshendelseType.MIGRERING_TIL_NY_FLYT,
            ),
        )

        verifiserKafkaMeldinger(iaSakDto, forventetStatus = IASak.Status.AKTIV)
    }

    @Test
    fun `Rad #8 sak med status KARTLEGGES hvor alle samarbeid er slettet migreres til VURDERES status`() {
        val iaSakDto = migreringSakIKartlegges()
        val sistEndretAvBruker = iaSakDto.opprettNyttSamarbeid().slettSamarbeid().endretTidspunkt

        tømmKafkaTopics(iaSakDto)
        sendMigreringsmeldingOgVerifiserSak(
            iaSakDto = iaSakDto,
            sistEndretAvBruker = sistEndretAvBruker,
            forventetStatus = IASak.Status.VURDERES,
            forventetTilstand = VirksomhetIATilstand.VirksomhetVurderes,
        )

        verifiserHistorikk(
            orgnummer = iaSakDto.orgnr,
            forventedeStatuser = listOf(
                IASak.Status.NY,
                IASak.Status.VURDERES,
                IASak.Status.VURDERES,
                IASak.Status.KONTAKTES,
                IASak.Status.KARTLEGGES,
                IASak.Status.KARTLEGGES, // opprett samarbeid
                IASak.Status.KARTLEGGES, // slett samarbeid
                IASak.Status.VURDERES,
            ),
            forventedeHendelsestyper = listOf(
                IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
                IASakshendelseType.VIRKSOMHET_VURDERES,
                IASakshendelseType.TA_EIERSKAP_I_SAK,
                IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
                IASakshendelseType.VIRKSOMHET_KARTLEGGES,
                IASakshendelseType.NY_PROSESS,
                IASakshendelseType.SLETT_PROSESS,
                IASakshendelseType.MIGRERING_TIL_NY_FLYT,
            ),
        )

        verifiserKafkaMeldinger(iaSakDto, forventetStatus = IASak.Status.VURDERES)
    }

    @Test
    fun `Rad #9 sak med status KARTLEGGES uten aktive samarbeid men hvor det er minst ett avbryt samarbeid migreres til VURDERES status`() {
        val iaSakDto = migreringSakIKartlegges()
        val sistEndretAvBruker = iaSakDto.opprettNyttSamarbeid().avbrytSamarbeid().endretTidspunkt

        tømmKafkaTopics(iaSakDto)
        sendMigreringsmeldingOgVerifiserSak(
            iaSakDto = iaSakDto,
            sistEndretAvBruker = sistEndretAvBruker,
            forventetStatus = IASak.Status.AVSLUTTET,
            forventetTilstand = VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet,
        )

        verifiserHistorikk(
            orgnummer = iaSakDto.orgnr,
            forventedeStatuser = listOf(
                IASak.Status.NY,
                IASak.Status.VURDERES,
                IASak.Status.VURDERES,
                IASak.Status.KONTAKTES,
                IASak.Status.KARTLEGGES,
                IASak.Status.KARTLEGGES, // opprett samarbeid
                IASak.Status.KARTLEGGES, // avbryt samarbeid
                IASak.Status.AVSLUTTET,
            ),
            forventedeHendelsestyper = listOf(
                IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
                IASakshendelseType.VIRKSOMHET_VURDERES,
                IASakshendelseType.TA_EIERSKAP_I_SAK,
                IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
                IASakshendelseType.VIRKSOMHET_KARTLEGGES,
                IASakshendelseType.NY_PROSESS,
                IASakshendelseType.AVBRYT_PROSESS,
                IASakshendelseType.MIGRERING_TIL_NY_FLYT,
            ),
        )

        verifiserKafkaMeldinger(iaSakDto, forventetStatus = IASak.Status.AVSLUTTET)
    }
}
