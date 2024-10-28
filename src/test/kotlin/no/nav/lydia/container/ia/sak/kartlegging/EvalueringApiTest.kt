package no.nav.lydia.container.ia.sak.kartlegging

import ia.felles.integrasjoner.kafkameldinger.SpørreundersøkelseStatus.OPPRETTET
import io.kotest.inspectors.forAll
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.collections.shouldNotBeEmpty
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldNotBeEmpty
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.hentEvalueringer
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettEvaluering
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartleggesMedEtSamarbeid
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.ia.eksport.SpørreundersøkelseProdusent.SerializableSpørreundersøkelse
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
        val evaluering = nySakIKartleggesMedEtSamarbeid().opprettEvaluering()

        evaluering.type shouldBe "Evaluering"
        evaluering.temaMedSpørsmålOgSvaralternativer shouldHaveSize 3
        evaluering.temaMedSpørsmålOgSvaralternativer.forAll {
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
                    spørreundersøkelse.temaMedSpørsmålOgSvaralternativer shouldHaveSize 3
                    spørreundersøkelse.temaMedSpørsmålOgSvaralternativer.forAll {
                        it.spørsmålOgSvaralternativer.shouldNotBeEmpty()
                        it.navn.shouldNotBeEmpty()
                    }
                }
            }
        }
    }

    @Test
    fun `kan hente liste av alle spørreundersøkelser av typen Evaluering`() {
        val sak = nySakIViBistår()
        val evaluering = sak.opprettEvaluering()

        val alleEvalueringer = hentEvalueringer(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
        )

        alleEvalueringer shouldHaveSize 1
        alleEvalueringer.first().id shouldBe evaluering.id
        alleEvalueringer.first().samarbeidId shouldBe evaluering.samarbeidId
        alleEvalueringer.first().opprettetAv shouldBe evaluering.opprettetAv
        alleEvalueringer.first().opprettetTidspunkt shouldBe evaluering.opprettetTidspunkt
        alleEvalueringer.first().endretTidspunkt shouldBe null
        alleEvalueringer.first().status shouldBe OPPRETTET
    }
}
