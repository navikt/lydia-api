package no.nav.lydia.container.ia.hendelse

import io.kotest.inspectors.forAll
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.string.shouldContain
import kotlinx.coroutines.isActive
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.time.withTimeout
import no.nav.lydia.Kafka
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.toJson
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.ia.sak.domene.SaksHendelsestype
import no.nav.lydia.ia.årsak.domene.BegrunnelseType
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.ia.årsak.domene.ÅrsakType
import org.apache.kafka.clients.consumer.KafkaConsumer
import org.apache.kafka.common.serialization.StringDeserializer
import org.junit.After
import org.junit.Before
import java.time.Duration
import kotlin.test.Test

class IASakshendelseProdusentTest {
    private val iaSakshendelseTopic = TestContainerHelper.kafkaContainerHelper.iaSakHendelseTopic
    private val kafkaConsumerConfig = Kafka(
        brokers = TestContainerHelper.kafkaContainerHelper.getConnectionString(),
        iaSakHendelseTopic = iaSakshendelseTopic,
        statistikkTopic = TestContainerHelper.kafkaContainerHelper.statistikkTopic,
        consumerLoopDelay = 1,
        credstorePassword = "",
        keystoreLocation = "",
        truststoreLocation = ""
    ).consumerProperties()
    private val konsument = KafkaConsumer(kafkaConsumerConfig, StringDeserializer(), StringDeserializer())

    @Before
    fun setUp() {
        konsument.subscribe(mutableListOf(iaSakshendelseTopic))
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
                .nyHendelse(
                    hendelsestype = SaksHendelsestype.VIRKSOMHET_ER_IKKE_AKTUELL,
                    payload = ValgtÅrsak(
                        type = ÅrsakType.VIRKSOMHETEN_TAKKET_NEI,
                        begrunnelser = listOf(BegrunnelseType.GJENNOMFØRER_TILTAK_MED_BHT, BegrunnelseType.HAR_IKKE_KAPASITET)
                    ).toJson()
                )

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
                            meldinger shouldHaveSize 5
                            meldinger[0] shouldContain SaksHendelsestype.OPPRETT_SAK_FOR_VIRKSOMHET.name
                            meldinger[1] shouldContain SaksHendelsestype.VIRKSOMHET_VURDERES.name
                            meldinger[2] shouldContain SaksHendelsestype.TA_EIERSKAP_I_SAK.name
                            meldinger[3] shouldContain SaksHendelsestype.VIRKSOMHET_SKAL_KONTAKTES.name
                            meldinger[4] shouldContain SaksHendelsestype.VIRKSOMHET_ER_IKKE_AKTUELL.name
                            meldinger[4] shouldContain BegrunnelseType.GJENNOMFØRER_TILTAK_MED_BHT.navn
                            meldinger[4] shouldContain BegrunnelseType.HAR_IKKE_KAPASITET.navn
                            break
                        }
                    }
                }
            }
        }


    }
}
