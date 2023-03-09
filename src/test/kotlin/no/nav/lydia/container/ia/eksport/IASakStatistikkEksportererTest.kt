package no.nav.lydia.container.ia.eksport

import ia.felles.definisjoner.bransjer.Bransjer
import io.kotest.inspectors.forAtLeastOne
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldContain
import kotlinx.coroutines.isActive
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.time.withTimeout
import no.nav.lydia.helper.KafkaContainerHelper
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.lydiaApiContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.oauth2ServerContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.helper.statuskode
import no.nav.lydia.ia.eksport.IA_SAK_EKSPORT_PATH
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import org.apache.kafka.clients.consumer.KafkaConsumer
import org.junit.After
import org.junit.Before
import java.time.Duration
import kotlin.test.Test

class IASakStatistikkEksportererTest {
    private val konsument = kafkaContainerHelper.nyKonsument(consumerGroupId = this::class.java.name)

    @Before
    fun setUp() {
        konsument.subscribe(mutableListOf(KafkaContainerHelper.iaSakStatistikkTopic))
    }

    @After
    fun tearDown() {
        konsument.unsubscribe()
        konsument.close()
    }

    @Test
    fun `skal trigge kafka-eksport av IASakStatistikk`() {
        val næringskode = "${Bransjer.BYGG.næringskoder.first()}.123"
        val virksomhet = TestVirksomhet.nyVirksomhet(næringer = listOf(Næringsgruppe(kode = næringskode, navn = "Bygg og ting")))
        VirksomhetHelper.lastInnNyVirksomhet(virksomhet)

        val sak = SakHelper.opprettSakForVirksomhet(orgnummer = virksomhet.orgnr)
            .nyHendelse(hendelsestype = IASakshendelseType.TA_EIERSKAP_I_SAK, token = oauth2ServerContainer.saksbehandler1.token)

        runBlocking {
            lydiaApiContainer
                .performGet(IA_SAK_EKSPORT_PATH)
                .response()
                .statuskode() shouldBe 200

            ventOgKonsumerKafkaMeldinger(konsument = konsument) { meldinger ->
                meldinger shouldHaveAtLeastSize 1
                meldinger.forAtLeastOne {
                    it shouldContain sak.saksnummer
                    it shouldContain oauth2ServerContainer.saksbehandler1.navIdent
                    it shouldContain IAProsessStatus.VURDERES.name
                    it shouldContain "sykefraværsstatistikkSiste4Kvartal"
                    it shouldContain Bransjer.BYGG.name
                }
            }
        }
    }

    private suspend fun ventOgKonsumerKafkaMeldinger(
        konsument: KafkaConsumer<String, String>,
        block: (meldinger: List<String>) -> Unit
    ) {
        withTimeout(Duration.ofSeconds(10)) {
            launch {
                while (this.isActive) {
                    val records = konsument.poll(Duration.ofMillis(100))
                    val meldinger = records
                        .map { it.value() }
                    if (meldinger.isNotEmpty()) {
                        block(meldinger)
                        break
                    }
                }
            }
        }
    }

}
