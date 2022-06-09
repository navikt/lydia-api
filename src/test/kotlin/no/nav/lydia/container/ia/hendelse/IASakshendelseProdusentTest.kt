package no.nav.lydia.container.ia.hendelse

import io.kotest.inspectors.forAll
import io.kotest.matchers.collections.*
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldContain
import kotlinx.coroutines.isActive
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.time.withTimeout
import no.nav.lydia.Kafka
import no.nav.lydia.helper.KafkaContainerHelper.Companion.iaSakHendelseTopic
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.SaksHendelsestype
import org.apache.kafka.clients.consumer.KafkaConsumer
import org.apache.kafka.common.serialization.StringDeserializer
import org.junit.After
import org.junit.Before
import java.time.Duration
import kotlin.test.Test

class IASakshendelseProdusentTest {
    private val konsument = TestContainerHelper.kafkaContainerHelper.nyKonsument()

    @Before
    fun setUp() {
        konsument.subscribe(mutableListOf(iaSakHendelseTopic))
    }

    @After
    fun tearDown() {
        konsument.unsubscribe()
        konsument.close()
    }

    @Test
    fun `en ny hendelse på en iasak skal produsere en melding på kafka`() {
        runBlocking {
            val orgnr = VirksomhetHelper.nyttOrgnummer()
            val sak = SakHelper.opprettSakForVirksomhet(orgnummer = orgnr)
                .nyHendelse(SaksHendelsestype.TA_EIERSKAP_I_SAK)
                .nyHendelse(SaksHendelsestype.VIRKSOMHET_SKAL_KONTAKTES)
                .also {
                    it.status shouldBe IAProsessStatus.KONTAKTES
                }

            withTimeout(Duration.ofSeconds(10)) {
                launch {
                    while (this.isActive) {
                        val records = konsument.poll(Duration.ofMillis(100))
                        val meldinger = records.map { it.value() }.filter { it.contains(sak.saksnummer) }
                        if (meldinger.isNotEmpty()) {
                            meldinger.forAll { hendelse ->
                                hendelse shouldContain sak.saksnummer
                                hendelse shouldContain sak.orgnr
                            }
                            meldinger shouldHaveSize 4
                            meldinger[0] shouldContain SaksHendelsestype.OPPRETT_SAK_FOR_VIRKSOMHET.name
                            meldinger[1] shouldContain SaksHendelsestype.VIRKSOMHET_VURDERES.name
                            meldinger[2] shouldContain SaksHendelsestype.TA_EIERSKAP_I_SAK.name
                            meldinger[3] shouldContain SaksHendelsestype.VIRKSOMHET_SKAL_KONTAKTES.name
                            break
                        }
                    }
                }
            }
        }


    }
}
