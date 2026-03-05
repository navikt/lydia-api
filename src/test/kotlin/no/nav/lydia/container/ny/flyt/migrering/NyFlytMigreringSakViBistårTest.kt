package no.nav.lydia.container.ny.flyt.migrering

import io.kotest.matchers.comparables.shouldBeGreaterThan
import io.kotest.matchers.comparables.shouldBeLessThanOrEqualTo
import io.kotest.matchers.shouldBe
import kotlinx.datetime.toJavaLocalDateTime
import kotlinx.datetime.toKotlinLocalDate
import kotlinx.datetime.toKotlinLocalDateTime
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.mirgeringSakIViBistår
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.sendMigreringsmeldingOgVerifiserSak
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.tømmKafkaTopics
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.utilsSetUp
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.utilsTearDown
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.verifiserHistorikk
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.verifiserKafkaMeldinger
import no.nav.lydia.helper.SakHelper.Companion.avbrytSamarbeid
import no.nav.lydia.helper.SakHelper.Companion.slettSamarbeid
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.ia.sak.api.ny.flyt.Hendelse
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetIATilstand
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetTilstandAutomatiskOppdateringDto
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test

class NyFlytMigreringSakViBistårTest {
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
    fun `Rad #10 sak med status VI_BISTÅR med minst et aktivt samarbeid migreres til AKTIV status og VirksomhetHarAktiveSamarbeid tilstand`() {
        val iaSakDto = mirgeringSakIViBistår()

        tømmKafkaTopics(iaSakDto)
        sendMigreringsmeldingOgVerifiserSak(
            iaSakDto = iaSakDto,
            sistEndretAvBruker = iaSakDto.endretTidspunkt,
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
                IASak.Status.KARTLEGGES,
                IASak.Status.VI_BISTÅR,
                IASak.Status.AKTIV,
            ),
            forventedeHendelsestyper = listOf(
                IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
                IASakshendelseType.VIRKSOMHET_VURDERES,
                IASakshendelseType.TA_EIERSKAP_I_SAK,
                IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
                IASakshendelseType.VIRKSOMHET_KARTLEGGES,
                IASakshendelseType.NY_PROSESS,
                IASakshendelseType.VIRKSOMHET_SKAL_BISTÅS,
                IASakshendelseType.MIGRERING_TIL_NY_FLYT,
            ),
        )

        verifiserKafkaMeldinger(iaSakDto, forventetStatus = IASak.Status.AKTIV)
    }

    @Test
    fun `Rad #11 sak med status VI_BISTÅR hvor alle samarbeid er slettet migreres til AKTIV status og VirksomhetHarAktiveSamarbeid tilstand`() {
        val iaSakDto = mirgeringSakIViBistår().slettSamarbeid()

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
                IASak.Status.KARTLEGGES,
                IASak.Status.VI_BISTÅR,
                IASak.Status.VI_BISTÅR, // Den med sletting av samarbeid
                IASak.Status.VURDERES,
            ),
            forventedeHendelsestyper = listOf(
                IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
                IASakshendelseType.VIRKSOMHET_VURDERES,
                IASakshendelseType.TA_EIERSKAP_I_SAK,
                IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
                IASakshendelseType.VIRKSOMHET_KARTLEGGES,
                IASakshendelseType.NY_PROSESS,
                IASakshendelseType.VIRKSOMHET_SKAL_BISTÅS,
                IASakshendelseType.SLETT_PROSESS,
                IASakshendelseType.MIGRERING_TIL_NY_FLYT,
            ),
        )

        verifiserKafkaMeldinger(iaSakDto, forventetStatus = IASak.Status.VURDERES)
    }

    @Test
    fun `Rad #12 status VI_BISTÅR uten aktive samarbeid og minst et avsluttet samarbeid over 10 dager migreres til AVSLUTTET og VirksomhetKlarTilVurdering`() {
        val iaSakDto = mirgeringSakIViBistår().avbrytSamarbeid()
        val iASamarbeidDto = iaSakDto.hentAlleSamarbeid().first()
        postgresContainerHelper.performUpdate(
            "UPDATE ia_prosess " +
                "SET " +
                "opprettet = opprettet - INTERVAL '11 days', " +
                "endret_tidspunkt = endret_tidspunkt - INTERVAL '11 days', " +
                "avbrutt_tidspunkt = avbrutt_tidspunkt - INTERVAL '11 days' " +
                "where id = ${
                    iASamarbeidDto.id
                }",
        )
        val manuellOppdataertIaSamarbeidDto = iaSakDto.hentAlleSamarbeid().first()
        manuellOppdataertIaSamarbeidDto.status shouldBe IASamarbeid.Status.AVBRUTT
        manuellOppdataertIaSamarbeidDto.sistEndret?.shouldBeLessThanOrEqualTo(
            (iASamarbeidDto.sistEndret!!.toJavaLocalDateTime().minusDays(10)).toKotlinLocalDateTime(),
        )

        tømmKafkaTopics(iaSakDto)
        sendMigreringsmeldingOgVerifiserSak(
            iaSakDto = iaSakDto,
            sistEndretAvBruker = iaSakDto.endretTidspunkt,
            forventetStatus = IASak.Status.AVSLUTTET,
            forventetTilstand = VirksomhetIATilstand.VirksomhetKlarTilVurdering,
        )

        verifiserHistorikk(
            orgnummer = iaSakDto.orgnr,
            forventedeStatuser = listOf(
                IASak.Status.NY,
                IASak.Status.VURDERES,
                IASak.Status.VURDERES,
                IASak.Status.KONTAKTES,
                IASak.Status.KARTLEGGES,
                IASak.Status.KARTLEGGES,
                IASak.Status.VI_BISTÅR,
                IASak.Status.VI_BISTÅR, // Den med sletting av samarbeid
                IASak.Status.AVSLUTTET,
            ),
            forventedeHendelsestyper = listOf(
                IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
                IASakshendelseType.VIRKSOMHET_VURDERES,
                IASakshendelseType.TA_EIERSKAP_I_SAK,
                IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
                IASakshendelseType.VIRKSOMHET_KARTLEGGES,
                IASakshendelseType.NY_PROSESS,
                IASakshendelseType.VIRKSOMHET_SKAL_BISTÅS,
                IASakshendelseType.AVBRYT_PROSESS,
                IASakshendelseType.MIGRERING_TIL_NY_FLYT,
            ),
        )

        verifiserKafkaMeldinger(iaSakDto, forventetStatus = IASak.Status.AVSLUTTET)
    }

    @Test
    fun `Rad #13 VI_BISTÅR uten aktive samarb, minst ett avsluttet samarbeid under 10 dager migreres til AVSLUTTET og AlleSamarbeidIVirksomhetErAvsluttet`() {
        val iaSakDto = mirgeringSakIViBistår().avbrytSamarbeid()
        val iASamarbeidDto = iaSakDto.hentAlleSamarbeid().first()
        postgresContainerHelper.performUpdate(
            "UPDATE ia_prosess " +
                "SET " +
                "opprettet = opprettet - INTERVAL '9 days', " +
                "endret_tidspunkt = endret_tidspunkt - INTERVAL '9 days', " +
                "avbrutt_tidspunkt = avbrutt_tidspunkt - INTERVAL '9 days' " +
                "where id = ${
                    iASamarbeidDto.id
                }",
        )
        val manuellOppdataertIaSamarbeidDto = iaSakDto.hentAlleSamarbeid().first()
        manuellOppdataertIaSamarbeidDto.status shouldBe IASamarbeid.Status.AVBRUTT
        manuellOppdataertIaSamarbeidDto.sistEndret?.shouldBeGreaterThan(
            (iASamarbeidDto.sistEndret!!.toJavaLocalDateTime().minusDays(10)).toKotlinLocalDateTime(),
        )

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
                IASak.Status.KARTLEGGES,
                IASak.Status.VI_BISTÅR,
                IASak.Status.VI_BISTÅR, // Den med sletting av samarbeid
                IASak.Status.AVSLUTTET,
            ),
            forventedeHendelsestyper = listOf(
                IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
                IASakshendelseType.VIRKSOMHET_VURDERES,
                IASakshendelseType.TA_EIERSKAP_I_SAK,
                IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
                IASakshendelseType.VIRKSOMHET_KARTLEGGES,
                IASakshendelseType.NY_PROSESS,
                IASakshendelseType.VIRKSOMHET_SKAL_BISTÅS,
                IASakshendelseType.AVBRYT_PROSESS,
                IASakshendelseType.MIGRERING_TIL_NY_FLYT,
            ),
        )

        verifiserKafkaMeldinger(iaSakDto, forventetStatus = IASak.Status.AVSLUTTET)
    }
}
