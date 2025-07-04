package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import kotlinx.datetime.LocalDateTime
import java.util.UUID

class SpørreundersøkelseDomene(
    val virksomhetsNavn: String,
    val orgnummer: String,
    val saksnummer: String,
    val samarbeidId: Int,
    val id: UUID,
    val type: Type,
    val status: Status, // Bruke denne til å programmatisk skjule avsluttet?
    val opprettetAv: String,
    val opprettetTidspunkt: LocalDateTime,
    val gyldigTilTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?,
    val påbegyntTidspunkt: LocalDateTime?,
    val fullførtTidspunkt: LocalDateTime?,
    val temaer: List<TemaDomene>,
) {
    companion object {
        const val ANTALL_TIMER_EN_SPØRREUNDERSØKELSE_ER_TILGJENGELIG = 24L
        const val MINIMUM_ANTALL_SVAR = 3
    }

    enum class Status {
        OPPRETTET,
        PÅBEGYNT,
        AVSLUTTET,
        SLETTET,
    }

    enum class Type {
        Evaluering,
        Behovsvurdering,
    }
}

class TemaDomene(
    val id: Int,
    val navn: String,
    val status: Status,
    val rekkefølge: Int,
    val stengtForSvar: Boolean,
    val sistEndret: LocalDateTime, // Når innholdet i et tema sist ble endret (spørsmål, undertemaer, osv.)
    val undertemaer: List<UndertemaDomene>,
) {
    // Om det er et gammelt tema som ikke lenger vil brukes
    enum class Status {
        AKTIV,
        INAKTIV,
    }
}

class UndertemaDomene(
    val id: Int,
    val navn: String,
    val status: Status,
    val rekkefølge: Int,
    val spørsmål: List<SpørsmålDomene>,
) {
    // Om det er et gammelt undertema som ikke lenger vil brukes
    enum class Status {
        AKTIV,
        INAKTIV,
    }
}

class SpørsmålDomene(
    val id: UUID,
    val tekst: String,
    val rekkefølge: Int,
    val flervalg: Boolean,
    val antallSvar: Int,
    // kan være 2 selv om det i antallSvar er 0. Kan brukes for å se hvor mange som har svart så langt?
    val svaralternativer: List<SvaralternativDomene>,
)

class SvaralternativDomene(
    val id: UUID,
    val tekst: String,
    val antallSvar: Int,
    // Kommer kun om minst 3 har svart på et spørsmål, ellers settes den til 0 av SQL query
)
