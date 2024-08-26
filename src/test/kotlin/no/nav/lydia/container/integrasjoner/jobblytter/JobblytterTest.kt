package no.nav.lydia.container.integrasjoner.jobblytter

import ia.felles.integrasjoner.jobbsender.Jobb.alleKategorierSykefraværsstatistikkDvhImport
import ia.felles.integrasjoner.jobbsender.Jobb.iaSakEksport
import ia.felles.integrasjoner.jobbsender.Jobb.iaSakLeveranseEksport
import ia.felles.integrasjoner.jobbsender.Jobb.iaSakStatistikkEksport
import ia.felles.integrasjoner.jobbsender.Jobb.iaSakStatusExport
import ia.felles.integrasjoner.jobbsender.Jobb.materializedViewOppdatering
import ia.felles.integrasjoner.jobbsender.Jobb.næringsImport
import ia.felles.integrasjoner.jobbsender.Jobb.ryddeIUrørteSaker
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.lydiaApiContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import org.junit.Test

class JobblytterTest {
    private val kafkaContainer = TestContainerHelper.kafkaContainerHelper

    @Test
    fun `skal kunne trigge ryddeIUrørteSaker jobb via kafka`() {
        kafkaContainer.sendJobbMelding(ryddeIUrørteSaker)
        lydiaApiContainer shouldContainLog "Ferdig med å rydde opp i urørte saker".toRegex()
        lydiaApiContainer shouldContainLog "Jobb 'ryddeIUrørteSaker' ferdig".toRegex()
    }

    @Test
    fun `skal kunne trigge iaSakEksport jobb via kafka`() {
        kafkaContainer.sendJobbMelding(iaSakEksport)
        lydiaApiContainer shouldContainLog "Jobb 'iaSakEksport' ferdig".toRegex()
    }

    @Test
    fun `skal kunne trigge iaSakStatistikkEksport jobb via kafka`() {
        kafkaContainer.sendJobbMelding(iaSakStatistikkEksport)

        lydiaApiContainer shouldContainLog "Jobb 'iaSakStatistikkEksport' ferdig".toRegex()
    }

    @Test
    fun `skal kunne trigge iaSakStatusExport jobb via kafka`() {
        kafkaContainer.sendJobbMelding(iaSakStatusExport)
        lydiaApiContainer shouldContainLog "Jobb 'iaSakStatusExport' ferdig".toRegex()
    }

    @Test
    fun `skal kunne trigge iaSakLeveranseEksport jobb via kafka`() {
        kafkaContainer.sendJobbMelding(iaSakLeveranseEksport)
        lydiaApiContainer shouldContainLog "Jobb 'iaSakLeveranseEksport' ferdig".toRegex()
    }

    @Test
    fun `skal kunne trigge næringsImport jobb via kafka`() {
        kafkaContainer.sendJobbMelding(næringsImport)
        lydiaApiContainer shouldContainLog "Jobb 'næringsImport' ferdig".toRegex()
    }

    @Test
    fun `skal kunne trigge materialized view oppdatering jobb via kafka`() {
        kafkaContainer.sendJobbMelding(materializedViewOppdatering)
        lydiaApiContainer shouldContainLog "Oppdaterte statistikkview på ".toRegex()
        lydiaApiContainer shouldContainLog "Jobb 'materializedViewOppdatering' ferdig".toRegex()
    }

    @Test
    fun `skal ignorere irrelevante jobber`() {
        kafkaContainer.sendJobbMelding(alleKategorierSykefraværsstatistikkDvhImport)
        lydiaApiContainer shouldContainLog "Jobb 'importSykefraværKvartalsstatistikk' ignorert".toRegex()
    }
}
