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
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettEvaluering
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettSpørreundersøkelse
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.sendKartleggingSvarTilKafka
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.start
import no.nav.lydia.helper.PlanHelper.Companion.inkluderAlt
import no.nav.lydia.helper.PlanHelper.Companion.opprettEnPlan
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartlegges
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartleggesMedEtSamarbeid
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.lydiaApiContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldNotContainLog
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.helper.opprettNyttSamarbeid
import no.nav.lydia.ia.eksport.SpørreundersøkelseBigqueryProdusent.SpørreundersøkelseEksport
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import org.junit.AfterClass
import org.junit.BeforeClass
import java.util.UUID
import kotlin.test.Test

class SpørreundersøkelseBigqueryEksportererTest {
    companion object {
        private val konsument = kafkaContainerHelper.nyKonsument(consumerGroupId = this::class.java.name)

        @BeforeClass
        @JvmStatic
        fun setUp() {
            konsument.subscribe(listOf(Topic.SPØRREUNDERSØKELSE_BIGQUERY_TOPIC.navn))
        }

        @AfterClass
        @JvmStatic
        fun tearDown() {
            konsument.unsubscribe()
            konsument.close()
        }
    }

    @Test
    fun `Oppretting av en spørreundersøkelse med typen 'Behovsvurdering' skal trigge kafka-eksport`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val opprettetBehovsvurdering = sak.opprettSpørreundersøkelse()

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = sak.saksnummer,
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveAtLeastSize 1
                val behovsvurderingerUtenSvar = meldinger.map {
                    Json.decodeFromString<SpørreundersøkelseEksport>(it)
                }
                val sisteBehovsvurdering = behovsvurderingerUtenSvar.last()
                sisteBehovsvurdering.id shouldBe opprettetBehovsvurdering.id
                sisteBehovsvurdering.type shouldBe "Behovsvurdering"
                sisteBehovsvurdering.status shouldBe opprettetBehovsvurdering.status
                sisteBehovsvurdering.opprettetAv shouldBe opprettetBehovsvurdering.opprettetAv
                sisteBehovsvurdering.opprettet shouldBe opprettetBehovsvurdering.opprettetTidspunkt
                sisteBehovsvurdering.påbegynt shouldBe null
                sisteBehovsvurdering.endret shouldBe null
                sisteBehovsvurdering.fullført shouldBe null
                sisteBehovsvurdering.harMinstEttSvar shouldBe false
                sisteBehovsvurdering.førsteSvarMotatt shouldBe null
                sisteBehovsvurdering.sisteSvarMottatt shouldBe null
                sisteBehovsvurdering.samarbeidId shouldBe opprettetBehovsvurdering.samarbeidId
            }
        }
    }

    @Test
    fun `Oppretting av en spørreundersøkelse med typen 'Evaluering' skal trigge kafka-eksport`() {
        val sak = nySakIViBistår()
        sak.opprettEnPlan(plan = PlanMalDto().inkluderAlt())
        val opprettetEvaluering = sak.opprettEvaluering()

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = sak.saksnummer,
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveAtLeastSize 1
                val behovsvurderingerUtenSvar = meldinger.map {
                    Json.decodeFromString<SpørreundersøkelseEksport>(it)
                }
                val sisteBehovsvurdering = behovsvurderingerUtenSvar.last()
                sisteBehovsvurdering.id shouldBe opprettetEvaluering.id
                sisteBehovsvurdering.type shouldBe "Evaluering"
                sisteBehovsvurdering.status shouldBe opprettetEvaluering.status
                sisteBehovsvurdering.opprettetAv shouldBe opprettetEvaluering.opprettetAv
                sisteBehovsvurdering.opprettet shouldBe opprettetEvaluering.opprettetTidspunkt
                sisteBehovsvurdering.påbegynt shouldBe null
                sisteBehovsvurdering.endret shouldBe null
                sisteBehovsvurdering.fullført shouldBe null
                sisteBehovsvurdering.harMinstEttSvar shouldBe false
                sisteBehovsvurdering.førsteSvarMotatt shouldBe null
                sisteBehovsvurdering.sisteSvarMottatt shouldBe null
                sisteBehovsvurdering.samarbeidId shouldBe opprettetEvaluering.samarbeidId
            }
        }
    }

    @Test
    fun `Start av en spørreundersøkelse med typen 'Behovsvurdering' skal trigge kafka-eksport`() {
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
                    Json.decodeFromString<SpørreundersøkelseEksport>(it)
                }
                val sisteBehovsvurdering = behovsvurderingerUtenSvar.last()
                sisteBehovsvurdering.id shouldBe startetBehovsvurdering.id
                sisteBehovsvurdering.type shouldBe "Behovsvurdering"
                sisteBehovsvurdering.status shouldBe startetBehovsvurdering.status
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
    fun `Start av en spørreundersøkelse med typen 'Evaluering' skal trigge kafka-eksport`() {
        val sak = nySakIViBistår()
        sak.opprettEnPlan(plan = PlanMalDto().inkluderAlt())
        val startetEvaluering = sak.opprettEvaluering().start(
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
                    Json.decodeFromString<SpørreundersøkelseEksport>(it)
                }
                val sisteSpørreundersøkelse = behovsvurderingerUtenSvar.last()
                sisteSpørreundersøkelse.id shouldBe startetEvaluering.id
                sisteSpørreundersøkelse.type shouldBe "Evaluering"
                sisteSpørreundersøkelse.status shouldBe startetEvaluering.status
                sisteSpørreundersøkelse.samarbeidId shouldBe startetEvaluering.samarbeidId
                sisteSpørreundersøkelse.opprettetAv shouldBe startetEvaluering.opprettetAv
                sisteSpørreundersøkelse.opprettet shouldBe startetEvaluering.opprettetTidspunkt
                sisteSpørreundersøkelse.påbegynt shouldNotBe null
                sisteSpørreundersøkelse.endret shouldNotBe null
                sisteSpørreundersøkelse.fullført shouldBe null
                sisteSpørreundersøkelse.harMinstEttSvar shouldBe false
                sisteSpørreundersøkelse.førsteSvarMotatt shouldBe null
                sisteSpørreundersøkelse.sisteSvarMottatt shouldBe null
            }
        }
    }

    @Test
    fun `Avslutting av en spørreundersøkelse med typen 'Behovsvurdering' skal trigge kafka-eksport`() {
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
                    Json.decodeFromString<SpørreundersøkelseEksport>(it)
                }
                val sisteBehovsvurdering = behovsvurderingerUtenSvar.last()
                sisteBehovsvurdering.id shouldBe avsluttetBehovsvurdering.id
                sisteBehovsvurdering.status shouldBe avsluttetBehovsvurdering.status
                sisteBehovsvurdering.type shouldBe "Behovsvurdering"
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
    fun `Avslutting av en spørreundersøkelse med typen 'Evaluering' skal trigge kafka-eksport`() {
        val sak = nySakIViBistår()
        sak.opprettEnPlan(plan = PlanMalDto().inkluderAlt())
        val avsluttetEvaluering = sak.opprettEvaluering().start(
            orgnummer = sak.orgnr,
            saksnummer = sak.saksnummer,
        ).avslutt(
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
                    Json.decodeFromString<SpørreundersøkelseEksport>(it)
                }
                val sisteSpørreundersøkelse = behovsvurderingerUtenSvar.last()
                sisteSpørreundersøkelse.id shouldBe avsluttetEvaluering.id
                sisteSpørreundersøkelse.status shouldBe avsluttetEvaluering.status
                sisteSpørreundersøkelse.type shouldBe "Evaluering"
                sisteSpørreundersøkelse.samarbeidId shouldBe avsluttetEvaluering.samarbeidId
                sisteSpørreundersøkelse.opprettetAv shouldBe avsluttetEvaluering.opprettetAv
                sisteSpørreundersøkelse.opprettet shouldBe avsluttetEvaluering.opprettetTidspunkt
                sisteSpørreundersøkelse.påbegynt shouldNotBe null
                sisteSpørreundersøkelse.endret shouldNotBe null
                sisteSpørreundersøkelse.fullført shouldNotBe null
                sisteSpørreundersøkelse.harMinstEttSvar shouldBe false
                sisteSpørreundersøkelse.førsteSvarMotatt shouldBe null
                sisteSpørreundersøkelse.sisteSvarMottatt shouldBe null
            }
        }
    }

    @Test
    fun `Behovsvurdering med info om besvarelse skal kunne sendes før fullføring`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val påbegyntSpørreundersøkelse = sak.opprettSpørreundersøkelse()
            .start(
                orgnummer = sak.orgnr,
                saksnummer = sak.saksnummer,
            )

        val førsteSpørsmål = påbegyntSpørreundersøkelse.temaer.first().spørsmålOgSvaralternativer.first()
        val førsteSvaralternativ = førsteSpørsmål.svaralternativer.first()

        val antallSvar = 3
        repeat(antallSvar) {
            val sesjonId = UUID.randomUUID()
            sendKartleggingSvarTilKafka(
                kartleggingId = påbegyntSpørreundersøkelse.id,
                spørsmålId = førsteSpørsmål.id,
                sesjonId = sesjonId.toString(),
                svarIder = listOf(førsteSvaralternativ.svarId),
            )
        }

        val avsluttetSpørreundersøkelse = påbegyntSpørreundersøkelse.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = sak.saksnummer,
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveSize 3
                val spørreundersøkelser = meldinger.map {
                    Json.decodeFromString<SpørreundersøkelseEksport>(it)
                }
                spørreundersøkelser shouldHaveSize 3
                val sisteSpørreundersøkelse = spørreundersøkelser.last()

                sisteSpørreundersøkelse.id shouldBe avsluttetSpørreundersøkelse.id
                sisteSpørreundersøkelse.status shouldBe avsluttetSpørreundersøkelse.status
                sisteSpørreundersøkelse.type shouldBe "Behovsvurdering"
                sisteSpørreundersøkelse.samarbeidId shouldBe avsluttetSpørreundersøkelse.samarbeidId
                sisteSpørreundersøkelse.opprettetAv shouldBe avsluttetSpørreundersøkelse.opprettetAv
                sisteSpørreundersøkelse.opprettet shouldBe avsluttetSpørreundersøkelse.opprettetTidspunkt
                sisteSpørreundersøkelse.påbegynt shouldNotBe null
                sisteSpørreundersøkelse.endret shouldNotBe null
                sisteSpørreundersøkelse.fullført shouldNotBe null
                sisteSpørreundersøkelse.harMinstEttSvar shouldBe true
                sisteSpørreundersøkelse.førsteSvarMotatt shouldNotBe null
                sisteSpørreundersøkelse.sisteSvarMottatt shouldNotBe null
                sisteSpørreundersøkelse.fullført shouldBe sisteSpørreundersøkelse.endret
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
