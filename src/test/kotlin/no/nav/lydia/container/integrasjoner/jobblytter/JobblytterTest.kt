package no.nav.lydia.container.integrasjoner.jobblytter

import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.lydiaApiContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.integrasjoner.jobblytter.Jobb
import org.junit.Test

class JobblytterTest {
    private val kafkaContainer = TestContainerHelper.kafkaContainerHelper

    @Test
    fun `skal kunne trigge ryddeIStilleligendeSaker jobb via kafka`() {
        kafkaContainer.sendJobbMelding(Jobb.ryddeIStilleligendeSaker)
        lydiaApiContainer shouldContainLog "Jobb ryddeIStilleligendeSaker ferdig".toRegex()
    }

    @Test
    fun `skal kunne trigge iaSakEksport jobb via kafka`() {
        kafkaContainer.sendJobbMelding(Jobb.iaSakEksport)
        lydiaApiContainer shouldContainLog "Jobb iaSakEksport ferdig".toRegex()
    }

    @Test
    fun `skal kunne trigge iaSakStatistikkEksport jobb via kafka`() {
        kafkaContainer.sendJobbMelding(Jobb.iaSakStatistikkEksport)

        lydiaApiContainer shouldContainLog "Jobb iaSakStatistikkEksport ferdig".toRegex()
    }

    @Test
    fun `skal kunne trigge iaSakStatusExport jobb via kafka`() {
        kafkaContainer.sendJobbMelding(Jobb.iaSakStatusExport)
        lydiaApiContainer shouldContainLog "Jobb iaSakStatusExport ferdig".toRegex()
    }

    @Test
    fun `skal kunne trigge iaSakLeveranseEksport jobb via kafka`() {
        kafkaContainer.sendJobbMelding(Jobb.iaSakLeveranseEksport)
        lydiaApiContainer shouldContainLog "Jobb iaSakLeveranseEksport ferdig".toRegex()
    }

    @Test
    fun `skal kunne trigge næringsImport jobb via kafka`() {
        kafkaContainer.sendJobbMelding(Jobb.næringsImport)
        lydiaApiContainer shouldContainLog "Jobb næringsImport ferdig".toRegex()
    }

    @Test
    fun `skal kunne trigge materialized view oppdatering jobb via kafka`() {
        kafkaContainer.sendJobbMelding(Jobb.materializedViewOppdatering)
        lydiaApiContainer shouldContainLog "Oppdaterte statistikkview på ".toRegex()
    }
}
