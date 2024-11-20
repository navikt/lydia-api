package no.nav.lydia.container.ia.eksport

import ia.felles.integrasjoner.jobbsender.Jobb
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.avslutt
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettSpørreundersøkelse
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.sendKartleggingSvarTilKafka
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.start
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartlegges
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartleggesMedEtSamarbeid
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.lydiaApiContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldNotContainLog
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.helper.opprettNyttSamarbeid
import no.nav.lydia.ia.eksport.BehovsvurderingBigqueryProdusent
import org.junit.After
import org.junit.Before
import java.util.UUID
import kotlin.test.Test

class BehovsvurderingBigqueryEksportererTest {
    private val konsument = kafkaContainerHelper.nyKonsument(consumerGroupId = this::class.java.name)

    @Before
    fun setUp() {
        konsument.subscribe(listOf(Topic.BEHOVSVURDERING_BIGQUERY_TOPIC.navn))
    }

    @After
    fun tearDown() {
        konsument.unsubscribe()
        konsument.close()
    }

    @Test
    fun `oppretting av behovsvurdering skal trigge kafka-eksport av behovsvurdering`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val opprettetBehovsvurdering = sak.opprettSpørreundersøkelse()

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = sak.saksnummer,
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveAtLeastSize 1
                val behovsvurderingerUtenSvar = meldinger.map {
                    Json.decodeFromString<BehovsvurderingBigqueryProdusent.BehovsvurderingKafkamelding>(it)
                }
                val sisteBehovsvurdering = behovsvurderingerUtenSvar.last()
                sisteBehovsvurdering.id shouldBe opprettetBehovsvurdering.id
                sisteBehovsvurdering.status shouldBe opprettetBehovsvurdering.status.name
                sisteBehovsvurdering.opprettetAv shouldBe opprettetBehovsvurdering.opprettetAv
                sisteBehovsvurdering.opprettet shouldBe opprettetBehovsvurdering.opprettetTidspunkt
                sisteBehovsvurdering.påbegynt shouldBe null
                sisteBehovsvurdering.endret shouldNotBe null
                sisteBehovsvurdering.fullført shouldBe null
                sisteBehovsvurdering.harMinstEttSvar shouldBe false
                sisteBehovsvurdering.førsteSvarMotatt shouldBe null
                sisteBehovsvurdering.sisteSvarMottatt shouldBe null
                sisteBehovsvurdering.samarbeidId shouldBe opprettetBehovsvurdering.samarbeidId
            }
        }
    }

    @Test
    fun `starting av behovsvurdering skal trigge kafka-eksport av behovsvurdering`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val startetBehovsvurdering = sak.opprettSpørreundersøkelse()
            .start(
                orgnummer = sak.orgnr,
                saksnummer = sak.saksnummer,
            )

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = sak.saksnummer,
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveAtLeastSize 2

                val behovsvurderingerUtenSvar = meldinger.map {
                    Json.decodeFromString<BehovsvurderingBigqueryProdusent.BehovsvurderingKafkamelding>(it)
                }
                val sisteBehovsvurdering = behovsvurderingerUtenSvar.last()
                sisteBehovsvurdering.id shouldBe startetBehovsvurdering.id
                sisteBehovsvurdering.status shouldBe startetBehovsvurdering.status.name
                sisteBehovsvurdering.samarbeidId shouldBe startetBehovsvurdering.samarbeidId
                sisteBehovsvurdering.opprettetAv shouldBe startetBehovsvurdering.opprettetAv
                sisteBehovsvurdering.opprettet shouldBe startetBehovsvurdering.opprettetTidspunkt
                sisteBehovsvurdering.påbegynt shouldNotBe null
                sisteBehovsvurdering.endret shouldNotBe null
                sisteBehovsvurdering.fullført shouldBe null
                sisteBehovsvurdering.harMinstEttSvar shouldBe false
                sisteBehovsvurdering.førsteSvarMotatt shouldBe null
                sisteBehovsvurdering.sisteSvarMottatt shouldBe null
            }
        }
    }

    @Test
    fun `avslutting av behovsvurdering skal trigge kafka-eksport av behovsvurdering`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val avsluttetBehovsvurdering = sak.opprettSpørreundersøkelse()
            .start(
                orgnummer = sak.orgnr,
                saksnummer = sak.saksnummer,
            )
            .avslutt(
                orgnummer = sak.orgnr,
                saksnummer = sak.saksnummer,
            )

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = sak.saksnummer,
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveAtLeastSize 3
                val behovsvurderingerUtenSvar = meldinger.map {
                    Json.decodeFromString<BehovsvurderingBigqueryProdusent.BehovsvurderingKafkamelding>(it)
                }
                val sisteBehovsvurdering = behovsvurderingerUtenSvar.last()
                sisteBehovsvurdering.id shouldBe avsluttetBehovsvurdering.id
                sisteBehovsvurdering.status shouldBe avsluttetBehovsvurdering.status.name
                sisteBehovsvurdering.samarbeidId shouldBe avsluttetBehovsvurdering.samarbeidId
                sisteBehovsvurdering.opprettetAv shouldBe avsluttetBehovsvurdering.opprettetAv
                sisteBehovsvurdering.opprettet shouldBe avsluttetBehovsvurdering.opprettetTidspunkt
                sisteBehovsvurdering.påbegynt shouldNotBe null
                sisteBehovsvurdering.endret shouldNotBe null
                sisteBehovsvurdering.fullført shouldNotBe null
                sisteBehovsvurdering.harMinstEttSvar shouldBe false
                sisteBehovsvurdering.førsteSvarMotatt shouldBe null
                sisteBehovsvurdering.sisteSvarMottatt shouldBe null
            }
        }
    }

    @Test
    fun `Behovsvurdering med info om besvarelse skal kunne sendes før fullføring`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val påbegyntBehovsvurdering = sak.opprettSpørreundersøkelse()
            .start(
                orgnummer = sak.orgnr,
                saksnummer = sak.saksnummer,
            )

        val førsteSpørsmål = påbegyntBehovsvurdering.temaer.first().spørsmålOgSvaralternativer.first()
        val førsteSvaralternativ = førsteSpørsmål.svaralternativer.first()

        val antallSvar = 3
        repeat(antallSvar) {
            val sesjonId = UUID.randomUUID()
            sendKartleggingSvarTilKafka(
                kartleggingId = påbegyntBehovsvurdering.id,
                spørsmålId = førsteSpørsmål.id,
                sesjonId = sesjonId.toString(),
                svarIder = listOf(førsteSvaralternativ.svarId),
            )
        }

        val avsluttetBehovsvurdering = påbegyntBehovsvurdering.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = sak.saksnummer,
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveSize 3
                val behovsvurderingerUtenSvar = meldinger.map {
                    Json.decodeFromString<BehovsvurderingBigqueryProdusent.BehovsvurderingKafkamelding>(it)
                }
                behovsvurderingerUtenSvar shouldHaveSize 3
                val sisteBehovsvurdering = behovsvurderingerUtenSvar.last()

                sisteBehovsvurdering.id shouldBe avsluttetBehovsvurdering.id
                sisteBehovsvurdering.status shouldBe avsluttetBehovsvurdering.status.name
                sisteBehovsvurdering.samarbeidId shouldBe avsluttetBehovsvurdering.samarbeidId
                sisteBehovsvurdering.opprettetAv shouldBe avsluttetBehovsvurdering.opprettetAv
                sisteBehovsvurdering.opprettet shouldBe avsluttetBehovsvurdering.opprettetTidspunkt
                sisteBehovsvurdering.påbegynt shouldNotBe null
                sisteBehovsvurdering.endret shouldNotBe null
                sisteBehovsvurdering.fullført shouldNotBe null
                sisteBehovsvurdering.harMinstEttSvar shouldBe true
                sisteBehovsvurdering.førsteSvarMotatt shouldNotBe null
                sisteBehovsvurdering.sisteSvarMottatt shouldNotBe null
                sisteBehovsvurdering.fullført shouldBe sisteBehovsvurdering.endret
            }
        }
    }

    @Test
    fun `jobb starter re-eksport av alle behovsvurderinger til bigquery`() {
        val sak1 = nySakIKartlegges()
        val samarbeid1 = sak1.opprettNyttSamarbeid().hentAlleSamarbeid().first()
        sak1.opprettSpørreundersøkelse(prosessId = samarbeid1.id)
        val sak2 = nySakIKartlegges()
        val samarbeid2 = sak2.opprettNyttSamarbeid().hentAlleSamarbeid().first()
        sak2.opprettSpørreundersøkelse(prosessId = samarbeid2.id)

        runBlocking {
            kafkaContainerHelper.sendJobbMelding(Jobb.iaSakBehovsvurderingEksport)
        }

        lydiaApiContainer.shouldNotContainLog("Klarte ikke å kjøre eksport av behovsvurderinger".toRegex())
        lydiaApiContainer.shouldContainLog("Jobb 'iaSakBehovsvurderingEksport' ferdig".toRegex())
    }
}
