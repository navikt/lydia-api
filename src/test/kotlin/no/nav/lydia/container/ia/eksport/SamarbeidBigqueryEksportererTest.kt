package no.nav.lydia.container.ia.eksport

import ia.felles.integrasjoner.jobbsender.Jobb
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartleggesMedEtSamarbeid
import no.nav.lydia.helper.SakHelper.Companion.slettSamarbeid
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.lydiaApiContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.helper.nyttNavnPåSamarbeid
import no.nav.lydia.ia.eksport.SamarbeidBigqueryProdusent
import org.junit.After
import org.junit.Before
import kotlin.test.Test

class SamarbeidBigqueryEksportererTest {
    private val konsument = kafkaContainerHelper.nyKonsument(consumerGroupId = this::class.java.name)

    @Before
    fun setUp() {
        konsument.subscribe(mutableListOf(Topic.SAMARBEID_BIGQUERY_TOPIC.navn))
    }

    @After
    fun tearDown() {
        konsument.unsubscribe()
        konsument.close()
    }

    @Test
    fun `oppretting av samarbeid skal trigge kafka-eksport av samarbeid`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val førsteSamarbeid = sak.hentAlleSamarbeid().first()

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = sak.saksnummer,
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveSize 1
                val samarbeidValues = meldinger.map {
                    Json.decodeFromString<SamarbeidBigqueryProdusent.SamarbeidValue>(it)
                }
                samarbeidValues shouldHaveSize 1
                val sisteSamarbeid = samarbeidValues.last()
                sisteSamarbeid.id shouldBe førsteSamarbeid.id
                sisteSamarbeid.saksnummer shouldBe førsteSamarbeid.saksnummer
                sisteSamarbeid.status shouldBe "AKTIV"
                sisteSamarbeid.navn shouldBe "Samarbeid uten navn"
            }
        }
    }

    @Test
    fun `jobb starter re-eksport av alle samarbeid til bigquery`() {
        val sakMedAktivtSamarbeid = nySakIKartleggesMedEtSamarbeid(navnPåSamarbeid = "ATIVT SAMARBEID")
        val aktivtSamarbeid = sakMedAktivtSamarbeid.hentAlleSamarbeid().first()

        val sakMedSamarbeidSomSkalSlettes = nySakIKartleggesMedEtSamarbeid(navnPåSamarbeid = "SLETTET SAMARBEID")
        val samarbeidSomSkalSlettes = sakMedSamarbeidSomSkalSlettes.hentAlleSamarbeid().first()

        sakMedSamarbeidSomSkalSlettes.slettSamarbeid(samarbeidSomSkalSlettes)

        val sakMedNavngittSamarbeid = nySakIKartleggesMedEtSamarbeid(navnPåSamarbeid = "SAMARBEID UTEN NAVN")
        val samarbeidUtenNavn = sakMedNavngittSamarbeid.hentAlleSamarbeid().first()

        sakMedNavngittSamarbeid.nyttNavnPåSamarbeid(samarbeidUtenNavn, "NAVNGITT SAMARBEID")
        val samarbeidMedNyttNavn = sakMedNavngittSamarbeid.hentAlleSamarbeid().first()

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                keys = listOf(
                    sakMedAktivtSamarbeid.saksnummer,
                    sakMedSamarbeidSomSkalSlettes.saksnummer,
                    sakMedNavngittSamarbeid.saksnummer,
                ),
                konsument = konsument,
            ) { meldinger ->
                val sendteSamarbeid = meldinger.map {
                    Json.decodeFromString<SamarbeidBigqueryProdusent.SamarbeidValue>(it)
                }

                sendteSamarbeid.forExactlyOne {
                    it.id shouldBe aktivtSamarbeid.id
                    it.saksnummer shouldBe aktivtSamarbeid.saksnummer
                    it.navn shouldBe aktivtSamarbeid.navn
                    it.status shouldBe "AKTIV"
                }

                sendteSamarbeid.forExactlyOne {
                    it.id shouldBe samarbeidSomSkalSlettes.id
                    it.saksnummer shouldBe samarbeidSomSkalSlettes.saksnummer
                    it.navn shouldBe samarbeidSomSkalSlettes.navn
                    it.status shouldBe "SLETTET"
                }

                sendteSamarbeid.forExactlyOne {
                    it.id shouldBe samarbeidMedNyttNavn.id
                    it.saksnummer shouldBe samarbeidMedNyttNavn.saksnummer
                    it.navn shouldBe samarbeidMedNyttNavn.navn
                    it.status shouldBe "AKTIV"
                }
            }

            kafkaContainerHelper.sendJobbMelding(Jobb.iaSakSamarbeidEksport)

            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                keys = listOf(
                    sakMedAktivtSamarbeid.saksnummer,
                    sakMedSamarbeidSomSkalSlettes.saksnummer,
                    sakMedNavngittSamarbeid.saksnummer,
                ),
                konsument = konsument,
            ) { meldinger ->
                val sendteSamarbeid = meldinger.map {
                    Json.decodeFromString<SamarbeidBigqueryProdusent.SamarbeidValue>(it)
                }

                sendteSamarbeid.forExactlyOne {
                    it.id shouldBe aktivtSamarbeid.id
                    it.saksnummer shouldBe aktivtSamarbeid.saksnummer
                    it.navn shouldBe aktivtSamarbeid.navn
                    it.status shouldBe "AKTIV"
                }

                sendteSamarbeid.forExactlyOne {
                    it.id shouldBe samarbeidSomSkalSlettes.id
                    it.saksnummer shouldBe samarbeidSomSkalSlettes.saksnummer
                    it.navn shouldBe samarbeidSomSkalSlettes.navn
                    it.status shouldBe "SLETTET"
                }

                sendteSamarbeid.forExactlyOne {
                    it.id shouldBe samarbeidMedNyttNavn.id
                    it.saksnummer shouldBe samarbeidMedNyttNavn.saksnummer
                    it.navn shouldBe samarbeidMedNyttNavn.navn
                    it.status shouldBe "AKTIV"
                }
            }
        }
        lydiaApiContainer.shouldContainLog("Jobb 'iaSakSamarbeidEksport' ferdig".toRegex())
    }
}
