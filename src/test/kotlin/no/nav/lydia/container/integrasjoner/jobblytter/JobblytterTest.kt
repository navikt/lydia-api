package no.nav.lydia.container.integrasjoner.jobblytter

import ia.felles.integrasjoner.jobbsender.Jobb.alleKategorierSykefraværsstatistikkDvhImport
import ia.felles.integrasjoner.jobbsender.Jobb.engangsJobb
import ia.felles.integrasjoner.jobbsender.Jobb.iaSakEksport
import ia.felles.integrasjoner.jobbsender.Jobb.iaSakLeveranseEksport
import ia.felles.integrasjoner.jobbsender.Jobb.iaSakSamarbeidEksportEttSamarbeid
import ia.felles.integrasjoner.jobbsender.Jobb.iaSakStatistikkEksport
import ia.felles.integrasjoner.jobbsender.Jobb.iaSakStatusExport
import ia.felles.integrasjoner.jobbsender.Jobb.materializedViewOppdatering
import ia.felles.integrasjoner.jobbsender.Jobb.næringsImport
import ia.felles.integrasjoner.jobbsender.Jobb.prosesserPlanlagteHendelser
import ia.felles.integrasjoner.jobbsender.Jobb.ryddeIUrørteSaker
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.ia.eksport.SAMARBEID_ID_PREFIKS
import org.junit.Test

class JobblytterTest {
    @Test
    fun `engangsjobb logger warn dersom ingen parameter er sendt`() {
        kafkaContainerHelper.sendJobbMeldingUtenParam(engangsJobb)

        applikasjon shouldContainLog "Forsøkte å starte jobb 'engangsJobb' med null/empty parameter. Avslutter".toRegex()
    }

    @Test
    fun `skal kunne trigge engangsJobb jobb via kafka`() {
        kafkaContainerHelper.sendJobbMelding(engangsJobb, "vilkårlig parameter")
        applikasjon shouldContainLog "Jobb 'engangsJobb' ferdig".toRegex()
    }

    @Test
    fun `skal kunne trigge ryddeIUrørteSaker jobb via kafka`() {
        kafkaContainerHelper.sendJobbMelding(ryddeIUrørteSaker)
        applikasjon shouldContainLog "Ferdig med å rydde opp i urørte saker".toRegex()
        applikasjon shouldContainLog "Jobb 'ryddeIUrørteSaker' ferdig".toRegex()
    }

    @Test
    fun `skal kunne trigge iaSakEksport jobb via kafka`() {
        kafkaContainerHelper.sendJobbMelding(iaSakEksport)
        applikasjon shouldContainLog "Jobb 'iaSakEksport' ferdig".toRegex()
    }

    @Test
    fun `skal kunne trigge iaSakStatistikkEksport jobb via kafka`() {
        kafkaContainerHelper.sendJobbMelding(iaSakStatistikkEksport)

        applikasjon shouldContainLog "Jobb 'iaSakStatistikkEksport' ferdig".toRegex()
    }

    @Test
    fun `skal kunne trigge iaSakStatusExport jobb via kafka`() {
        kafkaContainerHelper.sendJobbMelding(iaSakStatusExport)
        applikasjon shouldContainLog "Jobb 'iaSakStatusExport' ferdig".toRegex()
    }

    @Test
    fun `skal kunne trigge iaSakLeveranseEksport jobb via kafka`() {
        kafkaContainerHelper.sendJobbMelding(iaSakLeveranseEksport)
        applikasjon shouldContainLog "Jobb 'iaSakLeveranseEksport' ferdig".toRegex()
    }

    @Test
    fun `skal kunne trigge næringsImport jobb via kafka`() {
        kafkaContainerHelper.sendJobbMelding(næringsImport)
        applikasjon shouldContainLog "Jobb 'næringsImport' ferdig".toRegex()
    }

    @Test
    fun `skal kunne trigge materialized view oppdatering jobb via kafka`() {
        kafkaContainerHelper.sendJobbMelding(materializedViewOppdatering)
        applikasjon shouldContainLog "Oppdaterte statistikkview på ".toRegex()
        applikasjon shouldContainLog "Jobb 'materializedViewOppdatering' ferdig".toRegex()
    }

    @Test
    fun `skal kunne trigge eksport av ett samarbeid jobb via kafka`() {
        val samarbeidId = 12345
        val parameter = "$SAMARBEID_ID_PREFIKS$samarbeidId"
        kafkaContainerHelper.sendJobbMelding(jobb = iaSakSamarbeidEksportEttSamarbeid, parameter = parameter)
        applikasjon shouldContainLog "Starter eksport av enkelt samarbeid, med id: '$samarbeidId'".toRegex()
        applikasjon shouldContainLog "Eksport av enkelt samarbeid, med ID: '$samarbeidId' feilet. Samarbeid ikke funnet".toRegex()
        applikasjon shouldContainLog "Ferdig med eksport av samarbeid med parameter: '$parameter'".toRegex()
    }

    @Test
    fun `skal ignorere irrelevante jobber`() {
        kafkaContainerHelper.sendJobbMelding(alleKategorierSykefraværsstatistikkDvhImport)
        applikasjon shouldContainLog "Jobb 'alleKategorierSykefraværsstatistikkDvhImport' ignorert".toRegex()
    }

    @Test
    fun `skal kunne trigge prosesserPlanlagteHendelser via kafka`() {
        kafkaContainerHelper.sendJobbMelding(prosesserPlanlagteHendelser, "")
        applikasjon shouldContainLog "Ferdig med å oppdatere alle tilstand virksomheter.".toRegex()
    }
}
