package no.nav.lydia.container.integrasjoner.jobblytter

import ia.felles.integrasjoner.jobbsender.Jobb.alleKategorierSykefraværsstatistikkDvhImport
import ia.felles.integrasjoner.jobbsender.Jobb.engangsJobb
import ia.felles.integrasjoner.jobbsender.Jobb.fullforKartleggingEtter24t
import ia.felles.integrasjoner.jobbsender.Jobb.iaSakEksport
import ia.felles.integrasjoner.jobbsender.Jobb.iaSakLeveranseEksport
import ia.felles.integrasjoner.jobbsender.Jobb.iaSakSamarbeidEksportEttSamarbeid
import ia.felles.integrasjoner.jobbsender.Jobb.iaSakStatistikkEksport
import ia.felles.integrasjoner.jobbsender.Jobb.iaSakStatusExport
import ia.felles.integrasjoner.jobbsender.Jobb.materializedViewOppdatering
import ia.felles.integrasjoner.jobbsender.Jobb.næringsImport
import ia.felles.integrasjoner.jobbsender.Jobb.prosesserPlanlagteHendelser
import io.kotest.matchers.shouldBe
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.opprettSamarbeid
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.vurderVirksomhet
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.fullfør
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.hentSpørreundersøkelse
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.opprettKartlegging
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.start
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.svarPåSpørsmål
import no.nav.lydia.helper.SakHelper.Companion.leggTilFolger
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.kartlegging.Spørreundersøkelse
import no.nav.lydia.samarbeid.SAMARBEID_ID_PREFIKS
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

    @Test
    fun `skal ignorere melding adressert til annen applikasjon uten å krasje`() {
        kafkaContainerHelper.sendJobbMeldingTilAnnenApp(alleKategorierSykefraværsstatistikkDvhImport)
        applikasjon shouldContainLog "Ignorerer melding adressert til 'pia-dvh-import'".toRegex()
    }

    @Test
    fun `skal overleve og fortsette å prosessere etter poison pill med ukjent jobb`() {
        kafkaContainerHelper.sendJobbMeldingMedUkjentJobb("navnPaaEnJobbSomIkkeFinnesIIAFelles")
        applikasjon shouldContainLog "Hopper over melding".toRegex()

        kafkaContainerHelper.sendJobbMelding(næringsImport)
        applikasjon shouldContainLog "Jobb 'næringsImport' ferdig".toRegex()
    }

    @Test
    fun `skal IKKE kunne fullføre en kartlegging som allerede er fullført`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()

        val fullførtKartleggingForOver24timerSiden = samarbeid.opprettKartlegging(orgnr = sak.orgnr, type = Spørreundersøkelse.Type.Behovsvurdering)
            .start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
            .also { it.svarPåSpørsmål(antallSvarPåSpørsmål = 4) }
            .fullfør(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        // oppdater dato
        postgresContainerHelper.performUpdate(
            """
            UPDATE ia_sak_kartlegging 
            SET 
              opprettet = opprettet - INTERVAL '25 hours', 
              pabegynt = pabegynt - INTERVAL '25 hours', 
              endret = endret - INTERVAL '25 hours', 
              gyldig_til = gyldig_til - INTERVAL '25 hours'
            WHERE kartlegging_id = '${fullførtKartleggingForOver24timerSiden.id}'
            """.trimIndent(),
        )

        kafkaContainerHelper.sendJobbMelding(jobb = fullforKartleggingEtter24t, parameter = fullførtKartleggingForOver24timerSiden.id)

        val kartlegging = hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = samarbeid.id,
            type = Spørreundersøkelse.Type.Behovsvurdering,
        ).first()

        kartlegging.status shouldBe Spørreundersøkelse.Status.AVSLUTTET
        applikasjon shouldContainLog "Kan ikke fullføre kartleggingen".toRegex()
        applikasjon shouldContainLog "Spørreundersøkelse er ikke i status 'PÅBEGYNT'".toRegex()
        applikasjon shouldContainLog "Jobb 'fullforKartleggingEtter24t' ferdig".toRegex()
    }

    @Test
    fun `skal IKKE kunne fullføre en kartlegging som ikke har gått ut enda`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()

        val ikkeFullførtkartlegging = samarbeid.opprettKartlegging(orgnr = sak.orgnr, type = Spørreundersøkelse.Type.Behovsvurdering)
            .start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
            .also { it.svarPåSpørsmål(antallSvarPåSpørsmål = 4) }

        kafkaContainerHelper.sendJobbMelding(jobb = fullforKartleggingEtter24t, parameter = ikkeFullførtkartlegging.id)

        val kartlegging = hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = samarbeid.id,
            type = Spørreundersøkelse.Type.Behovsvurdering,
        ).first()
        kartlegging.status shouldBe Spørreundersøkelse.Status.PÅBEGYNT
        applikasjon shouldContainLog "har ikke passert fristen og skal kunne fullføres av brukeren".toRegex()
        applikasjon shouldContainLog "Jobb 'fullforKartleggingEtter24t' ferdig".toRegex()
    }

    @Test
    fun `skal kunne fullføre en kartlegging etter 24 timer`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()

        val ikkeFullførtkartleggingOver24timer = samarbeid.opprettKartlegging(orgnr = sak.orgnr, type = Spørreundersøkelse.Type.Behovsvurdering)
            .start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
            .also { it.svarPåSpørsmål(antallSvarPåSpørsmål = 4) }

        // oppdater dato så kartleggingen er over 24 timer gammel
        postgresContainerHelper.performUpdate(
            """
            UPDATE ia_sak_kartlegging 
            SET 
              opprettet = opprettet - INTERVAL '25 hours', 
              pabegynt = pabegynt - INTERVAL '25 hours', 
              endret = endret - INTERVAL '25 hours', 
              gyldig_til = gyldig_til - INTERVAL '25 hours'
            WHERE kartlegging_id = '${ikkeFullførtkartleggingOver24timer.id}'
            """.trimIndent(),
        )

        kafkaContainerHelper.sendJobbMelding(jobb = fullforKartleggingEtter24t, parameter = ikkeFullførtkartleggingOver24timer.id)

        val maskineltFullførtBehovsvurdering = hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = samarbeid.id,
            type = Spørreundersøkelse.Type.Behovsvurdering,
        ).first()
        maskineltFullførtBehovsvurdering.status shouldBe Spørreundersøkelse.Status.AVSLUTTET
        applikasjon shouldContainLog "Fullførte kartleggingen".toRegex()
        applikasjon shouldContainLog "Jobb 'fullforKartleggingEtter24t' ferdig".toRegex()
    }
}
