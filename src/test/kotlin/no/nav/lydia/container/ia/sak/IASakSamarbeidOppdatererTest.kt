package no.nav.lydia.container.ia.sak

import ia.felles.integrasjoner.jobbsender.Jobb.engangsJobb
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.SakHelper.Companion.fullførSak
import no.nav.lydia.helper.SakHelper.Companion.hentSak
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.ia.sak.domene.IAProsessStatus.FULLFØRT
import no.nav.lydia.ia.sak.domene.prosess.IAProsessStatus
import kotlin.test.Test

class IASakSamarbeidOppdatererTest {
    @Test
    fun `skal trigge fullføre samarbeid på fullførte IA-saker (med ikke fullførte samarbeid)`() {
        val sak = nySakIViBistår()
        val alleSamarbeid = sak.hentAlleSamarbeid()
        alleSamarbeid.size shouldBe 1
        sak.fullførSak()

        hentSak(orgnummer = sak.orgnr, saksnummer = sak.saksnummer).status shouldBe FULLFØRT

        postgresContainerHelper.performUpdate(
            """
            UPDATE ia_prosess
                 SET status = 'AKTIV'
                 WHERE id = ${alleSamarbeid.first().id}
                 AND saksnummer = '${sak.saksnummer}'            
            """.trimIndent(),
        )
        sak.hentAlleSamarbeid().first().status shouldBe IAProsessStatus.AKTIV

        // Start jobben som skal sende oppdatere samarbeid på fullført sak
        kafkaContainerHelper.sendJobbMelding(engangsJobb, parameter = "ikke-tørrkjør")
        applikasjon shouldContainLog "Ferdig med å fullføre samarbeid i fullførte IA saker".toRegex()
        sak.hentAlleSamarbeid().first().status shouldBe IAProsessStatus.FULLFØRT
    }
}
