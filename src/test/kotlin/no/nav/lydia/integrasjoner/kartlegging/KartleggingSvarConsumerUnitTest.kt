package no.nav.lydia.integrasjoner.kartlegging

import io.kotest.matchers.shouldBe
import java.util.UUID
import kotlin.test.Test
import no.nav.lydia.integrasjoner.kartlegging.KartleggingSvarConsumer.Companion.erKartleggingSvarMeldingenGyldig
import org.apache.kafka.clients.consumer.ConsumerRecord


class KartleggingSvarConsumerUnitTest {
    @Test
    fun `tom verdi er ikke gyldig`() {
        erKartleggingSvarMeldingenGyldig(ConsumerRecord(
            "",
            1,
            0L,
            "{}",
            "{" +
                    "}"
        )) shouldBe false
    }

    @Test
    fun `riktig verdi er gyldig`() {
        erKartleggingSvarMeldingenGyldig(ConsumerRecord(
            "",
            1,
            0L,
            "${UUID.randomUUID()}_${UUID.randomUUID()}",
            """
                {
                "kartleggingId": "${UUID.randomUUID()}", 
                "sesjonId": "${UUID.randomUUID()}", 
                "spørsmålId": "${UUID.randomUUID()}", 
                "svarId": "${UUID.randomUUID()}" 
                }
                
            """.trimIndent()
        )) shouldBe true
    }

    @Test
    fun `verdi med null Ider er IKKE gyldig`() {
        erKartleggingSvarMeldingenGyldig(ConsumerRecord(
            "",
            1,
            0L,
            "${UUID.randomUUID()}_${UUID.randomUUID()}",
            """
                {
                "kartleggingId": null, 
                "sesjonId": "${UUID.randomUUID()}", 
                "spørsmålId": "${UUID.randomUUID()}", 
                "svarId": "${UUID.randomUUID()}" 
                }
                
            """.trimIndent()
        )) shouldBe false
    }

    @Test
    fun `verdi med manglende Ider er IKKE gyldig`() {
        erKartleggingSvarMeldingenGyldig(ConsumerRecord(
            "",
            1,
            0L,
            "${UUID.randomUUID()}_${UUID.randomUUID()}",
            """
                {
                "sesjonId": "${UUID.randomUUID()}", 
                "spørsmålId": "${UUID.randomUUID()}", 
                "svarId": "${UUID.randomUUID()}" 
                }
                
            """.trimIndent()
        )) shouldBe false
    }
}