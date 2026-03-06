package no.nav.lydia.container.ny.flyt.migrering

import io.kotest.matchers.shouldBe
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.migreringSakIVurderes
import no.nav.lydia.container.ny.flyt.migrering.MigreringTestUtils.Companion.sendMigreringsmeldingOgVerifiserSakIkkeBlirMigrert
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.domene.IASak
import kotlin.test.Test

class NyFlytMigreringEdgeCaseTest {
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
            sendMigreringsmeldingOgVerifiserSakIkkeBlirMigrert(iaSakDto = iaSakDtoUnderArbeid)
        } finally {
            revertSlettetSak(iaSakDto = iaSakDtoUnderArbeid)
        }
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
