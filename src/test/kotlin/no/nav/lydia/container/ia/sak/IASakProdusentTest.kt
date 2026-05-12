package no.nav.lydia.container.ia.sak

import io.kotest.inspectors.forAll
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.string.shouldContain
import kotlinx.coroutines.runBlocking
import no.nav.lydia.Topic
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.angreVurdering
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.avsluttVurdering
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.vurderVirksomhet
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.ia.sak.domene.IASak
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test

class IASakProdusentTest {
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
    fun `sletting av feilåpnet sak produserer en slett melding på topic`() {
        runBlocking {
            val sak = vurderVirksomhet().angreVurdering()
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(key = sak.saksnummer, konsument = konsument) { meldinger ->
                meldinger.forAll { hendelse ->
                    hendelse shouldContain sak.saksnummer
                    hendelse shouldContain sak.orgnr
                }
                meldinger shouldHaveSize 3
                meldinger[0] shouldContain IASak.Status.NY.name
                meldinger[1] shouldContain IASak.Status.VURDERES.name
                meldinger[2] shouldContain IASak.Status.SLETTET.name
            }
        }
    }

    @Test
    fun `en ny hendelse på en IA-sak skal produsere en melding på kafka med oppdaterte verdier for saken`() {
        runBlocking {
            val sak = vurderVirksomhet().avsluttVurdering()

            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(key = sak.saksnummer, konsument) { meldinger ->
                meldinger.forAll { hendelse ->
                    hendelse shouldContain sak.saksnummer
                    hendelse shouldContain sak.orgnr
                }
                meldinger shouldHaveSize 3
                meldinger[0] shouldContain IASak.Status.NY.name
                meldinger[1] shouldContain IASak.Status.VURDERES.name
                meldinger[2] shouldContain IASak.Status.VURDERT.name
            }
        }
    }
}
