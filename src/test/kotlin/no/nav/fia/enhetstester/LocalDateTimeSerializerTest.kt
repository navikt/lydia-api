package no.nav.fia.enhetstester

import io.kotest.matchers.shouldBe
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.Json.Default.decodeFromString
import no.nav.fia.ia.sak.api.LocalDateTimeSerializer
import java.time.LocalDateTime
import java.time.Month.JANUARY
import kotlin.test.Test

class LocalDateTimeSerializerTest {


    @Test
    fun `skal kunne serialisere og deserialisere en LocalDateTime`() {
        val time = LocalDateTime.of(2022, JANUARY, 1, 23, 59)
        val encodedTime = Json.encodeToString(LocalDateTimeSerializer, time)
        val decodedTime = decodeFromString(LocalDateTimeSerializer, encodedTime)
        decodedTime.year shouldBe 2022
        decodedTime.month shouldBe JANUARY
        decodedTime.dayOfMonth shouldBe 1
        decodedTime.hour shouldBe 23
        decodedTime.minute shouldBe 59
        time.toLocalTime() shouldBe decodedTime.toLocalTime()
        time shouldBe decodedTime
    }

}
