package no.nav.lydia.ia.sak.domene

import io.kotest.matchers.shouldBe
import kotlinx.datetime.LocalDate
import no.nav.lydia.ia.sak.domene.IASakshendelse.Companion.utleddPeriodeForStatistikk
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.sykefraværsstatistikk.PeriodeDto
import no.nav.lydia.sykefraværsstatistikk.PubliseringsinfoDto
import no.nav.lydia.sykefraværsstatistikk.api.Periode
import no.nav.lydia.tilgangskontroll.fia.Rolle
import java.time.LocalDateTime
import java.time.Month
import kotlin.test.Test

class IASakshendelseUnitTest {
    @Test
    fun `skal utlede riktig periode når hendelse faller på publiseringsdato`() {
        val hendelse = lagHendelse(opprettetTidspunkt = LocalDateTime.of(2025, Month.NOVEMBER, 27, 10, 0))
        val statistikkPeriodeForHendelse = hendelse.utleddPeriodeForStatistikk(allPubliseringsinfo = lagAllPubliseringsinfo())

        statistikkPeriodeForHendelse shouldBe Periode(kvartal = 3, årstall = 2025)
    }

    @Test
    fun `skal utlede riktig periode når hendelse faller på publiseringsdato, uavhengig av rekkefølge i lista av publiseringsinfo`() {
        val hendelse = lagHendelse(opprettetTidspunkt = LocalDateTime.of(2025, Month.NOVEMBER, 27, 10, 0))
        val allPubliseringsinfoIHvilkenSomHelstRekkefølge = lagAllPubliseringsinfo().shuffled()
        val statistikkPeriodeForHendelse = hendelse.utleddPeriodeForStatistikk(allPubliseringsinfo = allPubliseringsinfoIHvilkenSomHelstRekkefølge)

        statistikkPeriodeForHendelse shouldBe Periode(kvartal = 3, årstall = 2025)
    }

    @Test
    fun `skal utlede riktig periode når hendelse faller på publiseringsdato før og etter publisering`() {
        // Vi bruker allPubliseringsinfo som har siste publiseringsdato 27. november 2025 og neste publiseringsdato 26. februar 2026 for periode 2025K3
        val hendelse = lagHendelse(opprettetTidspunkt = LocalDateTime.of(2026, Month.FEBRUARY, 26, 10, 0))
        val statistikkPeriodeForHendelseFørPublisering = hendelse.utleddPeriodeForStatistikk(allPubliseringsinfo = lagAllPubliseringsinfo())

        statistikkPeriodeForHendelseFørPublisering shouldBe Periode(kvartal = 3, årstall = 2025)

        val publiseringsinfo2025K4 = PubliseringsinfoDto(
            sistePubliseringsdato = LocalDate(2026, Month.FEBRUARY, 26),
            nestePubliseringsdato = LocalDate(2026, Month.MAY, 28),
            gjeldendePeriode = PeriodeDto(årstall = 2025, kvartal = 4),
        )
        // Legger til en ny "publiseringsinfo" på samme dato som hendelsen, så hendelsen nå faller etter ny publiseringsdato er lagret i databasen
        val statistikkPeriodeForHendelseEtterPublisering =
            hendelse.utleddPeriodeForStatistikk(allPubliseringsinfo = lagAllPubliseringsinfo().plus(publiseringsinfo2025K4))

        statistikkPeriodeForHendelseEtterPublisering shouldBe Periode(kvartal = 4, årstall = 2025)
    }

    @Test
    fun `skal utlede riktig periode når hendelse er mellom to publiseringsdatoer`() {
        val hendelse = lagHendelse(opprettetTidspunkt = LocalDateTime.of(2026, Month.FEBRUARY, 25, 10, 0))
        val statistikkPeriodeForHendelse = hendelse.utleddPeriodeForStatistikk(allPubliseringsinfo = lagAllPubliseringsinfo())

        statistikkPeriodeForHendelse shouldBe Periode(kvartal = 3, årstall = 2025)
    }

    @Test
    fun `skal falle tilbake til Periode fraDato når ingen publiseringsinfo matcher`() {
        val hendelse = lagHendelse(opprettetTidspunkt = LocalDateTime.of(2024, 2, 20, 10, 0))
        val statistikkPeriodeForHendelse = hendelse.utleddPeriodeForStatistikk(allPubliseringsinfo = lagAllPubliseringsinfo())

        // Periode.fraDato for feb 2024 => kvartal 1 2024, deretter forrigePeriode => kvartal 4 2023
        statistikkPeriodeForHendelse shouldBe Periode(kvartal = 4, årstall = 2023)
    }

    companion object {
        private fun lagHendelse(opprettetTidspunkt: LocalDateTime) =
            IASakshendelse(
                id = "test-id",
                saksnummer = "123",
                opprettetTidspunkt = opprettetTidspunkt,
                hendelsesType = IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
                orgnummer = "999999999",
                opprettetAv = "A123456",
                opprettetAvRolle = Rolle.SUPERBRUKER,
                navEnhet = NavEnhet(enhetsnummer = "0100", enhetsnavn = "Nav Test"),
                resulterendeStatus = null,
            )

        private fun lagAllPubliseringsinfo(): List<PubliseringsinfoDto> {
            val publiseringsinfo2024K4 = PubliseringsinfoDto(
                sistePubliseringsdato = LocalDate(2025, Month.FEBRUARY, 27),
                nestePubliseringsdato = LocalDate(2024, Month.NOVEMBER, 19),
                gjeldendePeriode = PeriodeDto(årstall = 2024, kvartal = 4),
            )
            val publiseringsinfo2025K1 = PubliseringsinfoDto(
                sistePubliseringsdato = LocalDate(2025, Month.MAY, 28),
                nestePubliseringsdato = LocalDate(2026, Month.SEPTEMBER, 4),
                gjeldendePeriode = PeriodeDto(årstall = 2025, kvartal = 1),
            )
            val publiseringsinfo2025K2 = PubliseringsinfoDto(
                sistePubliseringsdato = LocalDate(2025, Month.SEPTEMBER, 4),
                nestePubliseringsdato = LocalDate(2026, Month.FEBRUARY, 26),
                gjeldendePeriode = PeriodeDto(årstall = 2025, kvartal = 2),
            )
            val publiseringsinfo2025K3 = PubliseringsinfoDto(
                sistePubliseringsdato = LocalDate(2025, Month.NOVEMBER, 27),
                nestePubliseringsdato = LocalDate(2026, Month.FEBRUARY, 26),
                gjeldendePeriode = PeriodeDto(årstall = 2025, kvartal = 3),
            )
            return listOf(publiseringsinfo2025K3, publiseringsinfo2025K2, publiseringsinfo2025K1, publiseringsinfo2024K4)
        }
    }
}
