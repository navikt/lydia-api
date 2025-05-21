package no.nav.lydia.container.ia.sak.kartlegging

import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus.AVSLUTTET
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus.OPPRETTET
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus.PÅBEGYNT
import io.kotest.assertions.shouldFail
import io.kotest.inspectors.forAll
import io.kotest.inspectors.forAtLeastOne
import io.kotest.matchers.collections.shouldBeIn
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.collections.shouldNotBeEmpty
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.kotest.matchers.string.shouldContain
import io.kotest.matchers.string.shouldNotBeEmpty
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.avslutt
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.flytt
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.hentForhåndsvisning
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
import no.nav.lydia.helper.opprettNyttSamarbeid
import no.nav.lydia.ia.eksport.SpørreundersøkelseProdusent.SerializableSpørreundersøkelse
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse.Companion.Type.Evaluering
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test

class EvalueringApiTest {
    companion object {
        private val topic = Topic.SPORREUNDERSOKELSE_TOPIC
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

    @Test
    fun `kan opprette en spørreundersøkelse av type evaluering i status VI_BISTÅR`() {
        val sak = nySakIViBistår()
        sak.opprettEnPlan(plan = PlanMalDto().inkluderAlt())
        val evaluering = sak.opprettEvaluering()

        evaluering.type shouldBe Evaluering
        evaluering.temaer shouldHaveSize 3
        evaluering.temaer.forAll {
            it.spørsmålOgSvaralternativer.shouldNotBeEmpty()
            it.navn.shouldNotBeEmpty()
        }

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = evaluering.id,
                konsument = konsument,
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
            type = Evaluering,
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
        val type = Evaluering
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
                konsument = konsument,
            ) {
                it.forExactlyOne { melding ->
                    val spørreundersøkelse =
                        Json.decodeFromString<SerializableSpørreundersøkelse>(melding)
                    spørreundersøkelse.type shouldBe type.name
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
                konsument = konsument,
            ) { meldinger ->
                meldinger.forExactlyOne { melding ->
                    val spørreundersøkelse =
                        Json.decodeFromString<SerializableSpørreundersøkelse>(melding)
                    spørreundersøkelse.id shouldBe evaluering.id
                    spørreundersøkelse.temaer shouldHaveSize 1
                    spørreundersøkelse.temaer.forExactlyOne { tema ->
                        tema.navn shouldBe "Arbeidsmiljø"
                    }
                    val temaArbeidsmiljø = spørreundersøkelse.temaer.first { it.navn == "Arbeidsmiljø" }

                    temaArbeidsmiljø.spørsmål.forAtLeastOne { spørsmål ->
                        spørsmål.kategori shouldBe "Utvikle arbeidsmiljøet"
                    }
                    temaArbeidsmiljø.spørsmål.forAtLeastOne { spørsmål ->
                        spørsmål.kategori shouldBe "Veien videre"
                    }
                    temaArbeidsmiljø.spørsmål.forAll { spørsmål ->
                        spørsmål.kategori shouldBeIn listOf("Utvikle arbeidsmiljøet", "Veien videre")
                    }
                }
            }
        }
    }

    @Test
    fun `skal kunne hente en forhåndsvisning av en spørreundersøkelse av typen evaluering`() {
        val sak = nySakIViBistår(navnPåSamarbeid = "Samarbeid 1")
        val samarbeid = sak.hentAlleSamarbeid().first()
        sak.opprettEnPlan(
            samarbeidId = samarbeid.id,
            plan = PlanMalDto().inkluderEttTemaOgEttInnhold(
                temanummer = 3, // "Arbeidsmiljø"
                innholdnummer = 1,
            ),
        )
        val evaluering = sak.opprettEvaluering(prosessId = samarbeid.id)

        evaluering.temaer shouldHaveSize 1
        evaluering.status shouldBe OPPRETTET
        evaluering.temaer.forExactlyOne { tema ->
            tema.navn shouldBe "Arbeidsmiljø"
            tema.spørsmålOgSvaralternativer.forAll { spørsmål ->
                spørsmål.undertemanavn shouldBeIn listOf("Utvikle arbeidsmiljøet", "Veien videre")
            }
        }

        val forhåndsvisning = sak.hentForhåndsvisning(
            prosessId = samarbeid.id,
            type = Evaluering,
            spørreundersøkseId = evaluering.id,
        )

        forhåndsvisning.id shouldBe evaluering.id
        forhåndsvisning.status shouldBe evaluering.status
        forhåndsvisning.temaer.size shouldBe evaluering.temaer.size
        forhåndsvisning.temaer.forExactlyOne { tema ->
            tema.navn shouldBe evaluering.temaer.first().navn
            tema.spørsmålOgSvaralternativer.forAll { spørsmål ->
                spørsmål.undertemanavn shouldBeIn listOf("Utvikle arbeidsmiljøet", "Veien videre")
            }
        }
    }

    @Test
    fun `skal ikke kunne opprette en tom evaluering pga tom plan`() {
        val sak = nySakIViBistår()
        sak.opprettEnPlan()
        shouldFail { sak.opprettEvaluering() }.message shouldBe "HTTP Exception 400 Bad Request"
    }

    @Test
    fun `skal ikke flytte evaluering mellom samarbeid`() {
        val sak = nySakIViBistår(navnPåSamarbeid = "Samarbeid 1")
        sak.opprettNyttSamarbeid(navn = "Samarbeid 2")
        val samarbeid1 = sak.hentAlleSamarbeid().first()
        val samarbeid2 = sak.hentAlleSamarbeid().last()
        sak.opprettEnPlan(samarbeidId = samarbeid1.id, plan = PlanMalDto().inkluderAlt())
        val evaluering = sak.opprettEvaluering(prosessId = samarbeid1.id)
        evaluering.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        evaluering.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = samarbeid1.id,
            type = Evaluering,
        ).forExactlyOne {
            it.status shouldBe AVSLUTTET
            it.id shouldBe evaluering.id
        }

        shouldFail {
            evaluering.flytt(
                orgnummer = sak.orgnr,
                saksnummer = sak.saksnummer,
                samarbeidId = samarbeid2.id,
            )
        }.message shouldContain "Bad Request"

        hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = samarbeid1.id,
            type = Evaluering,
        ).forExactlyOne {
            it.status shouldBe AVSLUTTET
            it.id shouldBe evaluering.id
        }
    }
}
