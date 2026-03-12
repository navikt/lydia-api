package no.nav.lydia.container.ny.flyt.migrering

import io.kotest.matchers.shouldBe
import kotlinx.datetime.toKotlinLocalDate
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.migreringSakIViBistår
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.migreringSakIVurderes
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.sendMigreringsmeldingOgVerifiserLogg
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.sendMigreringsmeldingOgVerifiserSak
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.tømmKafkaTopics
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.utilsSetUp
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.utilsTearDown
import no.nav.lydia.helper.SakHelper.Companion.avbrytSamarbeid
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.ny.flyt.Hendelse
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetIATilstand
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetTilstandAutomatiskOppdateringDto
import no.nav.lydia.ia.sak.domene.IASak
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test

class NyFlytMigreringEdgeCaseTest {
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
    fun `Rad #1 og #2 sak med status som ikke kan håndteres`() {
        val iaSakDtoUnderArbeid = migreringSakIVurderes()
        iaSakDtoUnderArbeid.status shouldBe IASak.Status.VURDERES

        postgresContainerHelper.performUpdate(
            "UPDATE ia_sak " +
                "SET " +
                "status = 'SLETTET'" +
                "where saksnummer = '${iaSakDtoUnderArbeid.saksnummer}' and orgnr = '${iaSakDtoUnderArbeid.orgnr}'",
        )

        try {
            sendMigreringsmeldingOgVerifiserLogg(
                iaSakDto = iaSakDtoUnderArbeid,
                loggmelding = (
                    "Sak '${iaSakDtoUnderArbeid.saksnummer}' med status 'SLETTET' på virksomhet med orgnr '${iaSakDtoUnderArbeid.orgnr}' " +
                        "er ikke håndtert som en use-case til migrering"
                ).toRegex(),
            )
        } finally {
            revertSlettetSak(iaSakDto = iaSakDtoUnderArbeid)
        }
    }

    @Test
    fun `en virksomhet som allerede er migrert skal ikke migreres på nytt`() {
        val iaSakDto = migreringSakIVurderes()
        iaSakDto.status shouldBe IASak.Status.VURDERES

        tømmKafkaTopics(iaSakDto)
        sendMigreringsmeldingOgVerifiserSak(
            iaSakDto = iaSakDto,
            sistEndretAvBruker = iaSakDto.endretTidspunkt,
            forventetStatus = IASak.Status.VURDERES,
            forventetTilstand = VirksomhetIATilstand.VirksomhetVurderes,
            forventetAutomatiskOppdatering = null,
        )

        tømmKafkaTopics(iaSakDto)
        sendMigreringsmeldingOgVerifiserLogg(
            iaSakDto = iaSakDto,
            (
                "Sak '${iaSakDto.saksnummer}' med status '${iaSakDto.status}' på virksomhet med orgnr '${iaSakDto.orgnr}' " +
                    "er allerede migrert"
            ).toRegex(),
        )
    }

    @Test
    fun `en virksomhet som allerede er migrert med planlagt automatisk endring av tilstand skal ikke migreres heller`() {
        val iaSakDto = migreringSakIViBistår().avbrytSamarbeid()

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

        sendMigreringsmeldingOgVerifiserLogg(
            iaSakDto = iaSakDto,
            (
                "Sak '${iaSakDto.saksnummer}' med status '${IASak.Status.AVSLUTTET.name}' på virksomhet med orgnr '${iaSakDto.orgnr}' " +
                    "er allerede migrert. Virksomhet har tilstand 'AlleSamarbeidIVirksomhetErAvsluttet', og eventuelt ny tilstand til senere oppdatering: " +
                    "'neste tilstand 'VirksomhetKlarTilVurdering' med planlagt hendelse 'GjørVirksomhetKlarTilNyVurdering'"
            ).toRegex(),
        )
    }

    private fun revertSlettetSak(iaSakDto: IASakDto) {
        postgresContainerHelper.performUpdate(
            "UPDATE ia_sak " +
                "SET " +
                "status = 'VURDERES'" +
                "where saksnummer = '${iaSakDto.saksnummer}' and orgnr = '${iaSakDto.orgnr}'",
        )
    }
}
