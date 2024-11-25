package no.nav.lydia.container.ia.sak.kartlegging

import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus.OPPRETTET
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus.PÅBEGYNT
import io.kotest.assertions.shouldFail
import io.kotest.inspectors.forAll
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.collections.shouldNotBeEmpty
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.kotest.matchers.string.shouldNotBeEmpty
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.hentSpørreundersøkelse
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettEvaluering
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.start
import no.nav.lydia.helper.PlanHelper.Companion.inkluderAlt
import no.nav.lydia.helper.PlanHelper.Companion.inkluderEttTemaOgEttInnhold
import no.nav.lydia.helper.PlanHelper.Companion.opprettEnPlan
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartleggesMedEtSamarbeid
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.ia.eksport.SpørreundersøkelseProdusent.SerializableSpørreundersøkelse
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import org.junit.After
import org.junit.Before
import kotlin.test.Test

class EvalueringApiTest {
    private val spørreundersøkelseKonsument = kafkaContainerHelper.nyKonsument(this::class.java.name)

    @Before
    fun setUp() {
        spørreundersøkelseKonsument.subscribe(mutableListOf(Topic.SPORREUNDERSOKELSE_TOPIC.navn))
    }

    @After
    fun tearDown() {
        spørreundersøkelseKonsument.unsubscribe()
        spørreundersøkelseKonsument.close()
    }

    @Test
    fun `kan opprette en spørreundersøkelse av type evaluering i status VI_BISTÅR`() {
        val sak = nySakIViBistår()
        sak.opprettEnPlan(plan = PlanMalDto().inkluderAlt())
        val evaluering = sak.opprettEvaluering()

        evaluering.type shouldBe "Evaluering"
        evaluering.temaer shouldHaveSize 3
        evaluering.temaer.forAll {
            it.spørsmålOgSvaralternativer.shouldNotBeEmpty()
            it.navn.shouldNotBeEmpty()
        }

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = evaluering.id,
                konsument = spørreundersøkelseKonsument,
            ) { meldinger ->
                meldinger.forExactlyOne { melding ->
                    val spørreundersøkelse =
                        Json.decodeFromString<SerializableSpørreundersøkelse>(melding)
                    spørreundersøkelse.temaer shouldHaveSize 3
                    spørreundersøkelse.temaer.forAll {
                        it.spørsmål.shouldNotBeEmpty()
                        it.navn.shouldNotBeEmpty()
                    }
                }
            }
        }
    }

    @Test
    fun `kan ikke opprette en spørreundersøkelse av type evaluering i en annen status enn VI_BISTÅR`() {
        val sakIKartleggesMedSamarbeid = nySakIKartleggesMedEtSamarbeid()
        shouldFail { sakIKartleggesMedSamarbeid.opprettEvaluering() }
    }

    @Test
    fun `kan ikke opprette en spørreundersøkelse av typen evaluering om det ikke eksisterer en plan`() {
        val sak = nySakIViBistår()
        shouldFail { sak.opprettEvaluering() }
    }

    @Test
    fun `kan hente liste av alle spørreundersøkelser av typen Evaluering`() {
        val sak = nySakIViBistår()
        sak.opprettEnPlan(plan = PlanMalDto().inkluderAlt())
        val evaluering = sak.opprettEvaluering()

        val alleEvalueringer = hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
            type = "Evaluering",
        )

        alleEvalueringer shouldHaveSize 1
        alleEvalueringer.first().id shouldBe evaluering.id
        alleEvalueringer.first().samarbeidId shouldBe evaluering.samarbeidId
        alleEvalueringer.first().opprettetAv shouldBe evaluering.opprettetAv
        alleEvalueringer.first().opprettetTidspunkt shouldBe evaluering.opprettetTidspunkt
        alleEvalueringer.first().endretTidspunkt shouldBe null
        alleEvalueringer.first().status shouldBe OPPRETTET
    }

    @Test
    fun `kan starte en Spørreundersøkelse av typen Evaluering`() {
        val sak = nySakIViBistår()
        val opprettetPlan = sak.opprettEnPlan(plan = PlanMalDto().inkluderAlt())
        val type = "Evaluering"
        val evaluering = sak.opprettEvaluering()

        evaluering.type shouldBe type
        evaluering.status shouldBe OPPRETTET

        val påbegyntEvaluering = evaluering.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        påbegyntEvaluering.status shouldBe PÅBEGYNT

        hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
            type = type,
        ).forExactlyOne {
            it.status shouldBe PÅBEGYNT
            it.id shouldBe evaluering.id
            it.endretTidspunkt shouldNotBe null
        }

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = evaluering.id,
                konsument = spørreundersøkelseKonsument,
            ) {
                it.forExactlyOne { melding ->
                    val spørreundersøkelse =
                        Json.decodeFromString<SerializableSpørreundersøkelse>(melding)
                    spørreundersøkelse.type shouldBe type
                    spørreundersøkelse.status shouldBe PÅBEGYNT
                    spørreundersøkelse.plan?.id shouldBe opprettetPlan.id
                }
            }
        }
    }

    @Test
    fun `skal kun evaluere temaer som er inkludert i plan`() {
        val sak = nySakIViBistår()
        sak.opprettEnPlan(
            plan = PlanMalDto().inkluderEttTemaOgEttInnhold(
                temanummer = 3, // "Arbeidsmiljø"
                innholdnummer = 1,
            ),
        )

        val evaluering = sak.opprettEvaluering()

        evaluering.temaer.size shouldBe 1

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = evaluering.id,
                konsument = spørreundersøkelseKonsument,
            ) { meldinger ->
                meldinger.forExactlyOne { melding ->
                    val spørreundersøkelse =
                        Json.decodeFromString<SerializableSpørreundersøkelse>(melding)
                    spørreundersøkelse.id shouldBe evaluering.id
                    spørreundersøkelse.temaer shouldHaveSize 1
                    spørreundersøkelse.temaer.forExactlyOne { tema ->
                        tema.navn shouldBe "Arbeidsmiljø"
                    }
                    spørreundersøkelse.temaer.first().spørsmål.forAll { spørsmål ->
                        spørsmål.kategori shouldBe "Utvikle arbeidsmiljøet"
                    }
                }
            }
        }
    }

    @Test
    fun `skal ikke kunne opprette en tom evaluering pga tom plan`() {
        val sak = nySakIViBistår()
        sak.opprettEnPlan()
        shouldFail { sak.opprettEvaluering() }.message shouldBe "HTTP Exception 400 Bad Request"
    }
}
