package no.nav.lydia.container.integrasjoner.jobblytter

import no.nav.lydia.Kafka
import no.nav.lydia.helper.KafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.lydiaApiContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import org.junit.Test

class JobblytterTest {
    private val kafkaContainer = TestContainerHelper.kafkaContainerHelper

    @Test
    fun `skal kunne trigge iaSakEksport jobb via kafka`() {
        kafkaContainer.sendOgVentTilKonsumert(
            nøkkel = "iaSakEksport",
            melding = """{
                "jobb": "iaSakEksport",
                "tidspunkt": "2023-01-01T00:00:00.000Z",
                "applikasjon": "lydia-api"
            }""".trimIndent(),
            topic = KafkaContainerHelper.jobblytterTopic,
            konsumentGruppeId = Kafka.jobblytterConsumerGroupId,
        )
        lydiaApiContainer shouldContainLog "Jobb iaSakEksport ferdig".toRegex()
    }

    @Test
    fun `skal kunne trigge iaSakStatistikkEksport jobb via kafka`() {
        kafkaContainer.sendOgVentTilKonsumert(
            nøkkel = "iaSakStatistikkEksport",
            melding = """{
                "jobb": "iaSakStatistikkEksport",
                "tidspunkt": "2023-01-01T00:00:00.000Z",
                "applikasjon": "lydia-api"
            }""".trimIndent(),
            topic = KafkaContainerHelper.jobblytterTopic,
            konsumentGruppeId = Kafka.jobblytterConsumerGroupId,
        )
        lydiaApiContainer shouldContainLog "Jobb iaSakStatistikkEksport ferdig".toRegex()
    }

    @Test
    fun `skal kunne trigge iaSakStatusExport jobb via kafka`() {
        kafkaContainer.sendOgVentTilKonsumert(
            nøkkel = "iaSakStatusExport",
            melding = """{
                "jobb": "iaSakStatusExport",
                "tidspunkt": "2023-01-01T00:00:00.000Z",
                "applikasjon": "lydia-api"
            }""".trimIndent(),
            topic = KafkaContainerHelper.jobblytterTopic,
            konsumentGruppeId = Kafka.jobblytterConsumerGroupId,
        )
        lydiaApiContainer shouldContainLog "Jobb iaSakStatusExport ferdig".toRegex()
    }

    @Test
    fun `skal kunne trigge iaSakLeveranseEksport jobb via kafka`() {
        kafkaContainer.sendOgVentTilKonsumert(
            nøkkel = "iaSakLeveranseEksport",
            melding = """{
                "jobb": "iaSakLeveranseEksport",
                "tidspunkt": "2023-01-01T00:00:00.000Z",
                "applikasjon": "lydia-api"
            }""".trimIndent(),
            topic = KafkaContainerHelper.jobblytterTopic,
            konsumentGruppeId = Kafka.jobblytterConsumerGroupId,
        )
        lydiaApiContainer shouldContainLog "Jobb iaSakLeveranseEksport ferdig".toRegex()
    }

    @Test
    fun `skal kunne trigge næringsImport jobb via kafka`() {
        kafkaContainer.sendOgVentTilKonsumert(
            nøkkel = "næringsImport",
            melding = """{
                "jobb": "næringsImport",
                "tidspunkt": "2023-01-01T00:00:00.000Z",
                "applikasjon": "lydia-api"
            }""".trimIndent(),
            topic = KafkaContainerHelper.jobblytterTopic,
            konsumentGruppeId = Kafka.jobblytterConsumerGroupId,
        )
        lydiaApiContainer shouldContainLog "Jobb næringsImport ferdig".toRegex()
    }
}
