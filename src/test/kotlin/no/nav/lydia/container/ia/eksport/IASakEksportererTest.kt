package no.nav.lydia.container.ia.eksport

import ia.felles.integrasjoner.jobbsender.Jobb.iaSakEksport
import io.kotest.inspectors.forAtLeastOne
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.string.shouldContain
import kotlinx.coroutines.runBlocking
import no.nav.lydia.Topic
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.vurderVirksomhet
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.samarbeidsperiode.IASak
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test

class IASakEksportererTest {
    companion object {
        private val topic = Topic.IA_SAK_TOPIC
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
    fun `skal trigge kafka-eksport av IASaker`() {
        val sak = vurderVirksomhet(token = authContainerHelper.superbruker1.token)

        runBlocking {
            kafkaContainerHelper.sendJobbMelding(iaSakEksport)

            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = sak.saksnummer,
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveAtLeastSize 1
                meldinger.forAtLeastOne {
                    it shouldContain sak.saksnummer
                    it shouldContain IASak.Status.VURDERES.name
                }
            }
        }
    }
}
