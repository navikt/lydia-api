package no.nav.lydia.container.ny.flyt.migrering

import io.kotest.matchers.shouldBe
import kotlinx.datetime.toKotlinLocalDate
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.migreringSakIKartlegges
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.migreringSakIVurderes
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.sendMigreringsmeldingOgVerifiserSak
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.tømmKafkaTopics
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.utilsSetUp
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.utilsTearDown
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.verifiserHistorikk
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.verifiserKafkaMeldinger
import no.nav.lydia.helper.SakHelper.Companion.avbrytSamarbeid
import no.nav.lydia.helper.SakHelper.Companion.hentSak
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.slettSamarbeid
import no.nav.lydia.helper.opprettNyttSamarbeid
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetIATilstand
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetTilstandAutomatiskOppdateringDto
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.GjørVirksomhetKlarTilNyVurdering
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test

class NyFlytMigreringSakVurderesTest {
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

    @Test
    fun `Rad #3_1 sak med status VURDERES uten eier migreres til VURDERES - samme status med hendeles - og tilstand VirksomhetVurderes`() {
        val iaSakDtoUnderArbeid = migreringSakIVurderes(medEier = false)
        iaSakDtoUnderArbeid.status shouldBe IASak.Status.VURDERES
        val iaSakDto = hentSak(iaSakDtoUnderArbeid.orgnr, iaSakDtoUnderArbeid.saksnummer)

        tømmKafkaTopics(iaSakDto)
        sendMigreringsmeldingOgVerifiserSak(
            iaSakDto = iaSakDto,
            sistEndretAvBruker = iaSakDto.endretTidspunkt,
            forventetStatus = IASak.Status.VURDERES,
            forventetTilstand = VirksomhetIATilstand.VirksomhetVurderes,
            forventetAutomatiskOppdatering = null,
        )

        verifiserHistorikk(
            orgnummer = iaSakDto.orgnr,
            forventedeStatuser = listOf(
                IASak.Status.NY,
                IASak.Status.VURDERES,
                IASak.Status.VURDERES,
            ),
            forventedeHendelsestyper = listOf(
                IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
                IASakshendelseType.VIRKSOMHET_VURDERES,
                IASakshendelseType.MIGRERING_TIL_NY_FLYT,
            ),
        )

        verifiserKafkaMeldinger(iaSakDto, forventetStatus = IASak.Status.VURDERES)
    }

    @Test
    fun `Rad #3_2 sak med status VURDERES med eier uten samarbeid migreres til VURDERES - samme status med hendeles - og tilstand VirksomhetVurderes`() {
        val iaSakDtoUnderArbeid = migreringSakIVurderes(medEier = true)
        iaSakDtoUnderArbeid.status shouldBe IASak.Status.VURDERES
        val iaSakDto = hentSak(iaSakDtoUnderArbeid.orgnr, iaSakDtoUnderArbeid.saksnummer)

        tømmKafkaTopics(iaSakDto)
        sendMigreringsmeldingOgVerifiserSak(
            iaSakDto = iaSakDto,
            sistEndretAvBruker = iaSakDto.endretTidspunkt,
            forventetStatus = IASak.Status.VURDERES,
            forventetTilstand = VirksomhetIATilstand.VirksomhetVurderes,
            forventetAutomatiskOppdatering = null,
        )

        verifiserHistorikk(
            orgnummer = iaSakDto.orgnr,
            forventedeStatuser = listOf(
                IASak.Status.NY,
                IASak.Status.VURDERES,
                IASak.Status.VURDERES, // ta eierskap i sak
                IASak.Status.VURDERES,
            ),
            forventedeHendelsestyper = listOf(
                IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
                IASakshendelseType.VIRKSOMHET_VURDERES,
                IASakshendelseType.TA_EIERSKAP_I_SAK,
                IASakshendelseType.MIGRERING_TIL_NY_FLYT,
            ),
        )

        verifiserKafkaMeldinger(iaSakDto, forventetStatus = IASak.Status.VURDERES)
    }

    @Test
    fun `Rad #3_3 sak med status VURDERES og et aktivt samarbeid migreres til AKTIV status og tilstand VirksomhetHarAktiveSamarbeid`() {
        val iaSakDtoUnderArbeid = migreringSakIKartlegges()
        iaSakDtoUnderArbeid.status shouldBe IASak.Status.KARTLEGGES

        val sistEndretAvBruker = iaSakDtoUnderArbeid.opprettNyttSamarbeid()
            .nyHendelse(IASakshendelseType.TILBAKE)
            .nyHendelse(IASakshendelseType.TILBAKE)
            .endretTidspunkt

        val iaSakDto = hentSak(iaSakDtoUnderArbeid.orgnr, iaSakDtoUnderArbeid.saksnummer)
        iaSakDto.status shouldBe IASak.Status.VURDERES

        tømmKafkaTopics(iaSakDto)
        sendMigreringsmeldingOgVerifiserSak(
            iaSakDto = iaSakDto,
            sistEndretAvBruker = sistEndretAvBruker,
            forventetStatus = IASak.Status.AKTIV,
            forventetTilstand = VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid,
            forventetAutomatiskOppdatering = null,
        )

        verifiserHistorikk(
            orgnummer = iaSakDto.orgnr,
            forventedeStatuser = listOf(
                IASak.Status.NY,
                IASak.Status.VURDERES,
                IASak.Status.VURDERES, // ta eierskap i sak
                IASak.Status.KONTAKTES,
                IASak.Status.KARTLEGGES,
                IASak.Status.KARTLEGGES, // Opprett samarbeid
                IASak.Status.KONTAKTES, // Tilbake #1
                IASak.Status.VURDERES, // Tilbake #2
                IASak.Status.AKTIV, // Migrer
            ),
            forventedeHendelsestyper = listOf(
                IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
                IASakshendelseType.VIRKSOMHET_VURDERES,
                IASakshendelseType.TA_EIERSKAP_I_SAK,
                IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
                IASakshendelseType.VIRKSOMHET_KARTLEGGES,
                IASakshendelseType.NY_PROSESS,
                IASakshendelseType.TILBAKE,
                IASakshendelseType.TILBAKE,
                IASakshendelseType.MIGRERING_TIL_NY_FLYT,
            ),
        )

        verifiserKafkaMeldinger(iaSakDto, forventetStatus = IASak.Status.AKTIV)
    }

    @Test
    fun `Rad #3_4 sak med status VURDERES hvor alle samarbeid er slettet migreres til VURDERES status og tilstand VirksomhetVurderes`() {
        val iaSakDtoUnderArbeid = migreringSakIKartlegges()
        iaSakDtoUnderArbeid.status shouldBe IASak.Status.KARTLEGGES

        val sistEndretAvBruker = iaSakDtoUnderArbeid.opprettNyttSamarbeid()
            .slettSamarbeid()
            .nyHendelse(IASakshendelseType.TILBAKE)
            .nyHendelse(IASakshendelseType.TILBAKE)
            .endretTidspunkt

        val iaSakDto = hentSak(iaSakDtoUnderArbeid.orgnr, iaSakDtoUnderArbeid.saksnummer)
        iaSakDto.status shouldBe IASak.Status.VURDERES

        tømmKafkaTopics(iaSakDto)
        sendMigreringsmeldingOgVerifiserSak(
            iaSakDto = iaSakDto,
            sistEndretAvBruker = sistEndretAvBruker,
            forventetStatus = IASak.Status.VURDERES,
            forventetTilstand = VirksomhetIATilstand.VirksomhetVurderes,
            forventetAutomatiskOppdatering = null,
        )

        verifiserHistorikk(
            orgnummer = iaSakDto.orgnr,
            forventedeStatuser = listOf(
                IASak.Status.NY,
                IASak.Status.VURDERES,
                IASak.Status.VURDERES, // ta eierskap i sak
                IASak.Status.KONTAKTES,
                IASak.Status.KARTLEGGES,
                IASak.Status.KARTLEGGES, // Opprett samarbeid
                IASak.Status.KARTLEGGES, // slett samarbeid
                IASak.Status.KONTAKTES, // Tilbake #1
                IASak.Status.VURDERES, // Tilbake #2
                IASak.Status.VURDERES, // Migrer
            ),
            forventedeHendelsestyper = listOf(
                IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
                IASakshendelseType.VIRKSOMHET_VURDERES,
                IASakshendelseType.TA_EIERSKAP_I_SAK,
                IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
                IASakshendelseType.VIRKSOMHET_KARTLEGGES,
                IASakshendelseType.NY_PROSESS,
                IASakshendelseType.SLETT_PROSESS,
                IASakshendelseType.TILBAKE,
                IASakshendelseType.TILBAKE,
                IASakshendelseType.MIGRERING_TIL_NY_FLYT,
            ),
        )

        verifiserKafkaMeldinger(iaSakDto, forventetStatus = IASak.Status.VURDERES)
    }

    @Test
    fun `Rad #3_5 sak med status VURDERES uten aktive smrbd MEN minst 1 avbryt smrbd migreres til AVSLUTTET og AlleSamarbeidIVirksomhetErAvsluttet`() {
        val iaSakDtoUnderArbeid = migreringSakIKartlegges()
        iaSakDtoUnderArbeid.status shouldBe IASak.Status.KARTLEGGES

        val sistEndretAvBruker = iaSakDtoUnderArbeid.opprettNyttSamarbeid()
            .avbrytSamarbeid()
            .nyHendelse(IASakshendelseType.TILBAKE)
            .nyHendelse(IASakshendelseType.TILBAKE)
            .endretTidspunkt

        val iaSakDto = hentSak(iaSakDtoUnderArbeid.orgnr, iaSakDtoUnderArbeid.saksnummer)
        iaSakDto.status shouldBe IASak.Status.VURDERES

        tømmKafkaTopics(iaSakDto)
        sendMigreringsmeldingOgVerifiserSak(
            iaSakDto = iaSakDto,
            sistEndretAvBruker = sistEndretAvBruker,
            forventetStatus = IASak.Status.AVSLUTTET,
            forventetTilstand = VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet,
            forventetAutomatiskOppdatering = VirksomhetTilstandAutomatiskOppdateringDto(
                startTilstand = VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet,
                planlagtHendelse = GjørVirksomhetKlarTilNyVurdering::class.simpleName!!,
                nyTilstand = VirksomhetIATilstand.VirksomhetKlarTilVurdering,
                planlagtDato = java.time.LocalDateTime.now().plusDays(90).toLocalDate().atStartOfDay().toLocalDate().toKotlinLocalDate(),
            ),
        )

        verifiserHistorikk(
            orgnummer = iaSakDto.orgnr,
            forventedeStatuser = listOf(
                IASak.Status.NY,
                IASak.Status.VURDERES,
                IASak.Status.VURDERES, // ta eierskap i sak
                IASak.Status.KONTAKTES,
                IASak.Status.KARTLEGGES,
                IASak.Status.KARTLEGGES, // Opprett samarbeid
                IASak.Status.KARTLEGGES, // avbryt samarbeid
                IASak.Status.KONTAKTES, // Tilbake #1
                IASak.Status.VURDERES, // Tilbake #2
                IASak.Status.AVSLUTTET, // Migrer
            ),
            forventedeHendelsestyper = listOf(
                IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
                IASakshendelseType.VIRKSOMHET_VURDERES,
                IASakshendelseType.TA_EIERSKAP_I_SAK,
                IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
                IASakshendelseType.VIRKSOMHET_KARTLEGGES,
                IASakshendelseType.NY_PROSESS,
                IASakshendelseType.AVBRYT_PROSESS,
                IASakshendelseType.TILBAKE,
                IASakshendelseType.TILBAKE,
                IASakshendelseType.MIGRERING_TIL_NY_FLYT,
            ),
        )

        verifiserKafkaMeldinger(iaSakDto, forventetStatus = IASak.Status.AVSLUTTET)
    }
}
