package no.nav.lydia.container.ia.sak

import ia.felles.integrasjoner.jobbsender.Jobb.engangsJobb
import io.kotest.inspectors.forAll
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.SakHelper.Companion.avbrytSamarbeid
import no.nav.lydia.helper.SakHelper.Companion.hentSak
import no.nav.lydia.helper.SakHelper.Companion.hentSamarbeidshistorikk
import no.nav.lydia.helper.SakHelper.Companion.nyIkkeAktuellHendelse
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.helper.opprettNyttSamarbeid
import no.nav.lydia.ia.eksport.SamarbeidProdusent.SamarbeidKafkaMeldingValue
import no.nav.lydia.ia.sak.domene.IAProsessStatus.IKKE_AKTUELL
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Ignore

class IASakSamarbeidOppdatererTest {
    companion object {
        private val topic = Topic.SAMARBEIDSPLAN_TOPIC
        private val konsument = kafkaContainerHelper.nyKonsument(topic = topic)

        @BeforeClass
        @JvmStatic
        fun setUp() = konsument.subscribe(mutableListOf(topic.navn))

        @AfterClass
        @JvmStatic
        fun tearDown() {
            konsument.unsubscribe()
            konsument.close()
        }
    }

    @Ignore
    fun `skal trigge avbryt samarbeid på ikke aktuelle IA-saker`() {
        val sak = nySakIViBistår()
        val alleSamarbeid = sak.hentAlleSamarbeid()
        alleSamarbeid.size shouldBe 1
        sak.avbrytSamarbeid().nyIkkeAktuellHendelse()

        hentSak(orgnummer = sak.orgnr, saksnummer = sak.saksnummer).status shouldBe IKKE_AKTUELL

        postgresContainerHelper.performUpdate(
            """
            UPDATE ia_prosess
                 SET status = 'AKTIV'
                 WHERE id = ${alleSamarbeid.first().id}
                 AND saksnummer = '${sak.saksnummer}'            
            """.trimIndent(),
        )
        sak.hentAlleSamarbeid().first().status shouldBe IASamarbeid.Status.AKTIV

        // Start jobben som skal sende oppdatere samarbeid på fullført sak
        kafkaContainerHelper.sendJobbMelding(engangsJobb, parameter = "GO!")

        // Verifikasjon:
        // 1. Vi får loggmelding om at jobben er ferdig
        applikasjon shouldContainLog "Avbrøt samarbeid med id ${alleSamarbeid.first().id} og status AKTIV på sak med saksnummer ${sak.saksnummer}".toRegex()
        applikasjon shouldContainLog "Oppdaterte 1 samarbeid på sak med saksnummer ${sak.saksnummer}".toRegex()
        applikasjon shouldContainLog "Oppdaterte status til samarbeid i 1 sak".toRegex()
        applikasjon shouldContainLog "Ferdig med å avbryte samarbeid i ikke aktuelle IA saker. Ryddet opp i 1 sak\\. Tørr kjør: false".toRegex()
        // 2. Samarbeid er oppdatert til fullført
        val samarbeid = sak.hentAlleSamarbeid().first()
        samarbeid.status shouldBe IASamarbeid.Status.AVBRUTT

        // 3. Sakshistorikk er oppdatert uten begrunnelse (pga ProsessHendelse)
        val samarbeidshistorikk = hentSamarbeidshistorikk(orgnummer = sak.orgnr)
        samarbeidshistorikk.forExactlyOne { sakshistorikk ->
            sakshistorikk.sakshendelser.forExactlyOne { snapshot ->
                snapshot.eier shouldBe "Fia system"
                snapshot.begrunnelser shouldBe emptyList()
            }
        }
        // 4. Kafkamelding om oppdatert samarbeid er produsert
        runBlocking {
            // Sjekk at denne meldingen ble sendt på Kafka
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = "${sak.saksnummer}-${samarbeid.id}",
                konsument = konsument,
            ) {
                it.map { melding -> Json.decodeFromString<SamarbeidKafkaMeldingValue>(melding) }
                    .sortedBy { kafkaMeldingValue -> kafkaMeldingValue.samarbeid.endretTidspunkt }
                    .last()
                    .let { samarbeidKafkaMelding ->
                        samarbeidKafkaMelding.orgnr shouldBe sak.orgnr
                        samarbeidKafkaMelding.saksnummer shouldBe sak.saksnummer
                        samarbeidKafkaMelding.samarbeid.id shouldBe samarbeid.id
                        samarbeidKafkaMelding.samarbeid.navn shouldBe samarbeid.navn
                        samarbeidKafkaMelding.samarbeid.status shouldBe samarbeid.status
                        samarbeidKafkaMelding.samarbeid.endretTidspunkt shouldNotBe null
                    }
            }
        }
    }

    @Ignore
    fun `skal trigge avbryte ALLE samarbeid på ikke aktuelle IA-saker`() {
        val sak = nySakIViBistår().opprettNyttSamarbeid("Samarbeid 2")
        val alleSamarbeid = sak.hentAlleSamarbeid()
        alleSamarbeid.size shouldBe 2

        val samarbeid1 = alleSamarbeid.first()
        val samarbeid2 = alleSamarbeid.last()
        sak.avbrytSamarbeid(samarbeid1).avbrytSamarbeid(samarbeid2).nyIkkeAktuellHendelse()

        hentSak(orgnummer = sak.orgnr, saksnummer = sak.saksnummer).status shouldBe IKKE_AKTUELL

        postgresContainerHelper.performUpdate(
            """
            UPDATE ia_prosess
                 SET status = 'AKTIV'
                 WHERE saksnummer = '${sak.saksnummer}'            
            """.trimIndent(),
        )
        sak.hentAlleSamarbeid().forAll { it.status shouldBe IASamarbeid.Status.AKTIV }

        // Start jobben som skal sende oppdatere samarbeid på fullført sak
        kafkaContainerHelper.sendJobbMelding(engangsJobb, parameter = "GO!")

        // Verifikasjon:
        // 1. Vi får loggmelding om at jobben er ferdig
        applikasjon shouldContainLog
            "Avbrøt samarbeid med id ${alleSamarbeid.first().id} og status AKTIV på sak med saksnummer ${sak.saksnummer}".toRegex()
        applikasjon shouldContainLog
            "Avbrøt samarbeid med id ${alleSamarbeid.last().id} og status AKTIV på sak med saksnummer ${sak.saksnummer}".toRegex()
        applikasjon shouldContainLog "Oppdaterte 2 samarbeid på sak med saksnummer ${sak.saksnummer}".toRegex()
        applikasjon shouldContainLog "Oppdaterte status til samarbeid i 1 sak".toRegex()
        applikasjon shouldContainLog "Ferdig med å avbryte samarbeid i ikke aktuelle IA saker. Ryddet opp i 1 sak\\. Tørr kjør: false".toRegex()
        // 2. Samarbeid er oppdatert til fullført
        val alleOppdaterteSamarbeid = sak.hentAlleSamarbeid()
        alleOppdaterteSamarbeid.forAll { it.status shouldBe IASamarbeid.Status.AVBRUTT }

        // 3. Sakshistorikk er oppdatert uten begrunnelse (pga ProsessHendelse)
        val samarbeidshistorikk = hentSamarbeidshistorikk(orgnummer = sak.orgnr)
        samarbeidshistorikk.first().also { sakshistorikk ->
            sakshistorikk.sakshendelser.filter { it.eier == "Fia system" }.size shouldBe 2
        }

        // 4. Kafkamelding om oppdatert samarbeid er produsert (2 meldinger). Denne er testet et annet sted
    }

    @Ignore
    fun `skal trigge tørrkjør av avbryte samarbeid på Ikke Aktuelle IA-saker`() {
        val sak = nySakIViBistår()
        val alleSamarbeid = sak.hentAlleSamarbeid()
        alleSamarbeid.size shouldBe 1
        sak.avbrytSamarbeid().nyIkkeAktuellHendelse()

        hentSak(orgnummer = sak.orgnr, saksnummer = sak.saksnummer).status shouldBe IKKE_AKTUELL

        postgresContainerHelper.performUpdate(
            """
            UPDATE ia_prosess
                 SET status = 'AKTIV'
                 WHERE id = ${alleSamarbeid.first().id}
                 AND saksnummer = '${sak.saksnummer}'            
            """.trimIndent(),
        )
        sak.hentAlleSamarbeid().first().status shouldBe IASamarbeid.Status.AKTIV

        // Start jobben som skal sende oppdatere samarbeid på fullført sak
        kafkaContainerHelper.sendJobbMelding(engangsJobb, parameter = "dummy")

        // Verifikasjon:
        // 1. Vi får loggmelding om at jobben er ferdig
        applikasjon shouldContainLog
            "Skulle avbryte samarbeid med id ${alleSamarbeid.first().id} og status AKTIV på sak med saksnummer ${sak.saksnummer}".toRegex()
        applikasjon shouldContainLog "Skulle oppdatere 1 samarbeid på sak med saksnummer ${sak.saksnummer}".toRegex()
        applikasjon shouldContainLog "Skulle oppdatere status til samarbeid i 1 sak".toRegex()
        applikasjon shouldContainLog "Ferdig med å avbryte samarbeid i ikke aktuelle IA saker. Ryddet opp i 1 sak\\. Tørr kjør: true".toRegex()
        // 2. Samarbeid er IKKE oppdatert til fullført
        val samarbeid = sak.hentAlleSamarbeid().first()
        samarbeid.status shouldBe IASamarbeid.Status.AKTIV
    }
}
