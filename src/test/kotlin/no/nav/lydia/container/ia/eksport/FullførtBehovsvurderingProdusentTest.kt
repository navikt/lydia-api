package no.nav.lydia.container.ia.eksport

import ia.felles.integrasjoner.kafkameldinger.SpørreundersøkelseStatus.AVSLUTTET
import ia.felles.integrasjoner.kafkameldinger.SpørreundersøkelseStatus.PÅBEGYNT
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldBeInteger
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.avslutt
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettKartlegging
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.start
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartlegges
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.ia.eksport.FullførtBehovsvurdering
import org.junit.After
import org.junit.Before
import kotlin.test.Test

class FullførtBehovsvurderingProdusentTest {
    private val fullførtBehovsvurderingKonsument = kafkaContainerHelper.nyKonsument(
        Topic.FULLFØRT_BEHOVSVURDERING_TOPIC.konsumentGruppe
    )

    @Before
    fun setUp() {
        fullførtBehovsvurderingKonsument.subscribe(listOf(Topic.FULLFØRT_BEHOVSVURDERING_TOPIC.navn))
    }

    @After
    fun tearDown() {
        fullførtBehovsvurderingKonsument.unsubscribe()
        fullførtBehovsvurderingKonsument.close()
    }

    @Test
    fun `fullført behovsvurdering skal sendes til salesforce`() {
        val sak = nySakIKartlegges()
        val kartleggingDto = sak.opprettKartlegging()
        val påbegyntKartlegging = kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        påbegyntKartlegging.status shouldBe PÅBEGYNT

        val avsluttetKartlegging = påbegyntKartlegging.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        avsluttetKartlegging.status shouldBe AVSLUTTET


        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = kartleggingDto.kartleggingId,
                konsument = fullførtBehovsvurderingKonsument
            ) {
                it.forExactlyOne { melding ->
                    val behovsvurdering = Json.decodeFromString<FullførtBehovsvurdering>(melding)
                    behovsvurdering.behovsvurderingId shouldBe avsluttetKartlegging.kartleggingId
                    behovsvurdering.prosessId.shouldBeInteger()
                }
            }
        }
    }
}