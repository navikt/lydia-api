package no.nav.lydia.container.ia.eksport

import ia.felles.integrasjoner.jobbsender.Jobb.iaSakEksport
import io.kotest.inspectors.forAtLeastOne
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.string.shouldContain
import kotlinx.coroutines.runBlocking
import no.nav.lydia.Topic
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.oauth2ServerContainer
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test

class IASakEksportererTest {
    companion object {
        private val konsument = kafkaContainerHelper.nyKonsument(consumerGroupId = this::class.java.name)

        @BeforeClass
        @JvmStatic
        fun setUp() {
            konsument.subscribe(mutableListOf(Topic.IA_SAK_TOPIC.navn))
        }

        @AfterClass
        @JvmStatic
        fun tearDown() {
            konsument.unsubscribe()
            konsument.close()
        }
    }

    @Test
    fun `skal trigge kafka-eksport av IASaker`() {
        val sak = SakHelper.opprettSakForVirksomhet(orgnummer = VirksomhetHelper.nyttOrgnummer())
            .nyHendelse(
                hendelsestype = IASakshendelseType.TA_EIERSKAP_I_SAK,
                token = oauth2ServerContainer.saksbehandler1.token,
            )

        runBlocking {
            kafkaContainerHelper.sendJobbMelding(iaSakEksport)

            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = sak.saksnummer,
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveAtLeastSize 1
                meldinger.forAtLeastOne {
                    it shouldContain sak.saksnummer
                    it shouldContain oauth2ServerContainer.saksbehandler1.navIdent
                    it shouldContain IAProsessStatus.VURDERES.name
                }
            }
        }
    }
}
