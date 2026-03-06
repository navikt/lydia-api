package no.nav.lydia.container.ny.flyt.migrering

import io.kotest.matchers.shouldBe
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.migreringSakIKontaktes
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.sendMigreringsmeldingOgVerifiserSak
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.tømmKafkaTopics
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.utilsSetUp
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.utilsTearDown
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.verifiserHistorikk
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.verifiserKafkaMeldinger
import no.nav.lydia.helper.SakHelper.Companion.hentSak
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetIATilstand
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test

class NyFlytMigreringSakKontaktesTest {
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
    fun `Rad #5 sak med status KONTAKTES migreres til VURDERES - samme status med hendeles - og tilstand VirksomhetVurderes`() {
        val iaSakDtoUnderArbeid = migreringSakIKontaktes()
        iaSakDtoUnderArbeid.status shouldBe IASak.Status.KONTAKTES
        val iaSakDto = hentSak(orgnummer = iaSakDtoUnderArbeid.orgnr, saksnummer = iaSakDtoUnderArbeid.saksnummer)

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
                IASak.Status.KONTAKTES,
                IASak.Status.VURDERES,
            ),
            forventedeHendelsestyper = listOf(
                IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
                IASakshendelseType.VIRKSOMHET_VURDERES,
                IASakshendelseType.TA_EIERSKAP_I_SAK,
                IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
                IASakshendelseType.MIGRERING_TIL_NY_FLYT,
            ),
        )

        verifiserKafkaMeldinger(iaSakDto, forventetStatus = IASak.Status.VURDERES)
    }
}
