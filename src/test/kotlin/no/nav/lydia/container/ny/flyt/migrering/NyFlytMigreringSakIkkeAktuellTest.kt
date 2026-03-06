package no.nav.lydia.container.ny.flyt.migrering

import io.kotest.matchers.shouldBe
import kotlinx.datetime.toKotlinLocalDate
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.migreringSakIKartlegges
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.sendMigreringsmeldingOgVerifiserSak
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.tømmKafkaTopics
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.utilsSetUp
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.utilsTearDown
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.verifiserHistorikk
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.verifiserKafkaMeldinger
import no.nav.lydia.helper.SakHelper.Companion.avbrytSamarbeid
import no.nav.lydia.helper.SakHelper.Companion.hentSak
import no.nav.lydia.helper.SakHelper.Companion.nyIkkeAktuellHendelse
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.opprettNyttSamarbeid
import no.nav.lydia.ia.sak.api.ny.flyt.Hendelse
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetIATilstand
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetTilstandAutomatiskOppdateringDto
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test

class NyFlytMigreringSakIkkeAktuellTest {
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
    fun `Rad #16 sak IKKE_AKTUELL ingen samarbeid status FULLFØRT for mindre enn 10d siden migreres til AVSLUTTET og VirksomhetErVurdert`() {
        // val iaSakDtoUnderArbeid = mirgeringSakIViBistår().avbrytSamarbeid().nyIkkeAktuellHendelse()
        val iaSakDtoUnderArbeid = migreringSakIKartlegges().nyIkkeAktuellHendelse()
        iaSakDtoUnderArbeid.status shouldBe IASak.Status.IKKE_AKTUELL

        postgresContainerHelper.performUpdate(
            "UPDATE ia_sak " +
                "SET " +
                "opprettet = opprettet - INTERVAL '9 days', " +
                "endret = endret - INTERVAL '9 days' " +
                "where saksnummer = '${iaSakDtoUnderArbeid.saksnummer}' and orgnr = '${iaSakDtoUnderArbeid.orgnr}'",
        )
        val iaSakDto = hentSak(iaSakDtoUnderArbeid.orgnr, iaSakDtoUnderArbeid.saksnummer)

        tømmKafkaTopics(iaSakDto)
        sendMigreringsmeldingOgVerifiserSak(
            iaSakDto = iaSakDto,
            sistEndretAvBruker = iaSakDto.endretTidspunkt,
            forventetStatus = IASak.Status.AVSLUTTET,
            forventetTilstand = VirksomhetIATilstand.VirksomhetErVurdert,
            forventetAutomatiskOppdatering = VirksomhetTilstandAutomatiskOppdateringDto(
                startTilstand = VirksomhetIATilstand.VirksomhetErVurdert,
                planlagtHendelse = Hendelse.GjørVirksomhetKlarTilNyVurdering::class.simpleName!!,
                nyTilstand = VirksomhetIATilstand.VirksomhetKlarTilVurdering,
                planlagtDato = java.time.LocalDateTime.now().plusDays(90).toLocalDate().atStartOfDay().toLocalDate().toKotlinLocalDate(),
            ),
        )

        verifiserHistorikk(
            orgnummer = iaSakDto.orgnr,
            forventedeStatuser = listOf(
                IASak.Status.NY,
                IASak.Status.VURDERES,
                IASak.Status.VURDERES,
                IASak.Status.KONTAKTES,
                IASak.Status.KARTLEGGES,
                IASak.Status.IKKE_AKTUELL,
                IASak.Status.AVSLUTTET,
            ),
            forventedeHendelsestyper = listOf(
                IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
                IASakshendelseType.VIRKSOMHET_VURDERES,
                IASakshendelseType.TA_EIERSKAP_I_SAK,
                IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
                IASakshendelseType.VIRKSOMHET_KARTLEGGES,
                IASakshendelseType.VIRKSOMHET_ER_IKKE_AKTUELL,
                IASakshendelseType.MIGRERING_TIL_NY_FLYT,
            ),
        )

        verifiserKafkaMeldinger(iaSakDto, forventetStatus = IASak.Status.AVSLUTTET)
    }

    @Test
    fun `Rad #17 sak IKKE_AKTUELL ingen samarbeid status FULLFØRT for mer enn 10d siden migreres til AVSLUTTET og VirksomhetKlarTilVurdering`() {
        val iaSakDtoUnderArbeid = migreringSakIKartlegges().nyIkkeAktuellHendelse()
        iaSakDtoUnderArbeid.status shouldBe IASak.Status.IKKE_AKTUELL

        postgresContainerHelper.performUpdate(
            "UPDATE ia_sak " +
                "SET " +
                "opprettet = opprettet - INTERVAL '11 days', " +
                "endret = endret - INTERVAL '11 days' " +
                "where saksnummer = '${iaSakDtoUnderArbeid.saksnummer}' and orgnr = '${iaSakDtoUnderArbeid.orgnr}'",
        )
        val iaSakDto = hentSak(iaSakDtoUnderArbeid.orgnr, iaSakDtoUnderArbeid.saksnummer)

        tømmKafkaTopics(iaSakDto)
        sendMigreringsmeldingOgVerifiserSak(
            iaSakDto = iaSakDto,
            sistEndretAvBruker = iaSakDto.endretTidspunkt,
            forventetStatus = IASak.Status.AVSLUTTET,
            forventetTilstand = VirksomhetIATilstand.VirksomhetKlarTilVurdering,
            forventetAutomatiskOppdatering = null,
        )

        verifiserHistorikk(
            orgnummer = iaSakDto.orgnr,
            forventedeStatuser = listOf(
                IASak.Status.NY,
                IASak.Status.VURDERES,
                IASak.Status.VURDERES,
                IASak.Status.KONTAKTES,
                IASak.Status.KARTLEGGES,
                IASak.Status.IKKE_AKTUELL,
                IASak.Status.AVSLUTTET,
            ),
            forventedeHendelsestyper = listOf(
                IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
                IASakshendelseType.VIRKSOMHET_VURDERES,
                IASakshendelseType.TA_EIERSKAP_I_SAK,
                IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
                IASakshendelseType.VIRKSOMHET_KARTLEGGES,
                IASakshendelseType.VIRKSOMHET_ER_IKKE_AKTUELL,
                IASakshendelseType.MIGRERING_TIL_NY_FLYT,
            ),
        )

        verifiserKafkaMeldinger(iaSakDto, forventetStatus = IASak.Status.AVSLUTTET)
    }

    @Test
    fun `Rad #18 sak IKKE_AKTUELL alle smrbd avsluttet st FULLFØRT for mindre enn 10d siden migreres til AVSLUTTET og AlleSamarbeidIVirksomhetErAvsluttet`() {
        val iaSakDtoUnderArbeid = migreringSakIKartlegges().opprettNyttSamarbeid().avbrytSamarbeid().nyIkkeAktuellHendelse()
        iaSakDtoUnderArbeid.status shouldBe IASak.Status.IKKE_AKTUELL

        postgresContainerHelper.performUpdate(
            "UPDATE ia_sak " +
                "SET " +
                "opprettet = opprettet - INTERVAL '9 days', " +
                "endret = endret - INTERVAL '9 days' " +
                "where saksnummer = '${iaSakDtoUnderArbeid.saksnummer}' and orgnr = '${iaSakDtoUnderArbeid.orgnr}'",
        )
        val iaSakDto = hentSak(iaSakDtoUnderArbeid.orgnr, iaSakDtoUnderArbeid.saksnummer)

        tømmKafkaTopics(iaSakDto)
        sendMigreringsmeldingOgVerifiserSak(
            iaSakDto = iaSakDto,
            sistEndretAvBruker = iaSakDto.endretTidspunkt,
            forventetStatus = IASak.Status.AVSLUTTET,
            forventetTilstand = VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet,
            forventetAutomatiskOppdatering = VirksomhetTilstandAutomatiskOppdateringDto(
                startTilstand = VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet,
                planlagtHendelse = Hendelse.GjørVirksomhetKlarTilNyVurdering::class.simpleName!!,
                nyTilstand = VirksomhetIATilstand.VirksomhetKlarTilVurdering,
                planlagtDato = java.time.LocalDateTime.now().plusDays(90).toLocalDate().atStartOfDay().toLocalDate().toKotlinLocalDate(),
            ),
        )

        verifiserHistorikk(
            orgnummer = iaSakDto.orgnr,
            forventedeStatuser = listOf(
                IASak.Status.NY,
                IASak.Status.VURDERES,
                IASak.Status.VURDERES,
                IASak.Status.KONTAKTES,
                IASak.Status.KARTLEGGES,
                IASak.Status.KARTLEGGES, // nytt samarbeid
                IASak.Status.KARTLEGGES, // avbryt samarbeid
                IASak.Status.IKKE_AKTUELL,
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
                IASakshendelseType.VIRKSOMHET_ER_IKKE_AKTUELL,
                IASakshendelseType.MIGRERING_TIL_NY_FLYT,
            ),
        )

        verifiserKafkaMeldinger(iaSakDto, forventetStatus = IASak.Status.AVSLUTTET)
    }
}
