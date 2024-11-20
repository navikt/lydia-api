package no.nav.lydia.container.ia.eksport

import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartleggesMedEtSamarbeid
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.ia.eksport.SamarbeidKafkaMeldingValue
import no.nav.lydia.ia.sak.DEFAULT_SAMARBEID_NAVN
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.prosess.IAProsessDto
import org.junit.After
import org.junit.Before
import kotlin.test.Test

class SamarbeidProdusentTest {
    private val samarbeidKonsument = kafkaContainerHelper.nyKonsument(
        Topic.SAMARBEIDSPLAN_TOPIC.konsumentGruppe,
    )

    @Before
    fun setUp() {
        samarbeidKonsument.subscribe(listOf(Topic.SAMARBEIDSPLAN_TOPIC.navn))
    }

    @After
    fun tearDown() {
        samarbeidKonsument.unsubscribe()
        samarbeidKonsument.close()
    }

    @Test
    fun `Nyopprettet samarbeid skal sendes til salesforce`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val samarbeid = sak.hentAlleSamarbeid().first()

        runBlocking {
            konsummerOgSjekkKafkaMelding(
                sak1 = sak,
                samarbeid1 = samarbeid,
            )
        }
    }

    private suspend fun konsummerOgSjekkKafkaMelding(
        sak1: IASakDto,
        samarbeid1: IAProsessDto,
    ) {
        kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
            key = "${sak1.saksnummer}-${samarbeid1.id}",
            konsument = samarbeidKonsument,
        ) {
            it.forExactlyOne { melding ->
                val samarbeidSentTilSalesforce = Json.decodeFromString<SamarbeidKafkaMeldingValue>(melding)
                samarbeidIKafkaErRiktigPlan(
                    samarbeidKafkaMelding = samarbeidSentTilSalesforce,
                    sak = sak1,
                    samarbeid = samarbeid1,
                )
            }
        }
    }

    private fun samarbeidIKafkaErRiktigPlan(
        samarbeidKafkaMelding: SamarbeidKafkaMeldingValue,
        sak: IASakDto,
        samarbeid: IAProsessDto,
    ) {
        samarbeidKafkaMelding.orgnr shouldBe sak.orgnr
        samarbeidKafkaMelding.saksnummer shouldBe sak.saksnummer
        samarbeidKafkaMelding.samarbeid.id shouldBe samarbeid.id
        if (samarbeid.navn == null) {
            samarbeidKafkaMelding.samarbeid.navn shouldBe DEFAULT_SAMARBEID_NAVN
        } else {
            samarbeidKafkaMelding.samarbeid.navn shouldBe samarbeid.navn
        }
        samarbeidKafkaMelding.samarbeid.status shouldBe samarbeid.status
        samarbeidKafkaMelding.samarbeid.endretTidspunkt shouldNotBe null
    }
}
