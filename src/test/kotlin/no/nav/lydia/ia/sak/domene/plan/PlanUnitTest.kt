package no.nav.lydia.ia.sak.domene.plan

import io.kotest.matchers.shouldBe
import kotlinx.datetime.LocalDate
import kotlinx.datetime.toKotlinLocalDate
import kotlinx.datetime.toKotlinLocalDateTime
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import java.util.UUID
import kotlin.test.Test

class PlanUnitTest {
    @Test
    fun `Test utregning for startDato og sluttDato`() {
        val plan = Plan(
            id = UUID.randomUUID(),
            samarbeidId = 1,
            sistEndret = java.time.LocalDateTime.now().toKotlinLocalDateTime(),
            sistPublisert = java.time.LocalDate.now().toKotlinLocalDate(),
            status = IASamarbeid.Status.AKTIV,
            temaer = listOf(
                PlanTema(
                    id = 1,
                    navn = "Tema 1",
                    inkludert = true,
                    undertemaer = listOf(
                        PlanUndertema(
                            id = 1,
                            navn = "Undertema 1",
                            målsetning = "Målsetning 1",
                            inkludert = true,
                            status = PlanUndertema.Status.PLANLAGT,
                            startDato = LocalDate.parse("2021-01-01"),
                            sluttDato = LocalDate.parse("2021-01-31"),
                            aktiviteterISalesforce = listOf(),
                        ),
                        PlanUndertema(
                            id = 2,
                            navn = "Undertema 2",
                            målsetning = "Målsetning 2",
                            inkludert = true,
                            status = PlanUndertema.Status.PLANLAGT,
                            startDato = LocalDate.parse("2021-02-01"),
                            sluttDato = LocalDate.parse("2021-02-28"),
                            aktiviteterISalesforce = listOf(),
                        ),
                    ),
                ),
                PlanTema(
                    id = 2,
                    navn = "Tema 2",
                    inkludert = true,
                    undertemaer = listOf(
                        PlanUndertema(
                            id = 3,
                            navn = "Undertema 3",
                            målsetning = "Målsetning 3",
                            inkludert = true,
                            status = PlanUndertema.Status.PLANLAGT,
                            startDato = LocalDate.parse("2021-03-01"),
                            sluttDato = LocalDate.parse("2021-03-06"),
                            aktiviteterISalesforce = listOf(),
                        ),
                    ),
                ),
            ),
        )

        plan.startDato() shouldBe LocalDate.parse("2021-01-01")
        plan.sluttDato() shouldBe LocalDate.parse("2021-03-06")
    }
}
