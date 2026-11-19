package no.nav.lydia.samarbeid

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.integrasjoner.azure.NavEnhet

// TODO: Denne kan slettes når vi tilrettelegger for å manuelt sette Nav-enhet
@Serializable
data class IASamarbeidRequestDto(
    val id: Int,
    val saksnummer: String,
    val navn: String,
    val status: IASamarbeid.Status? = null,
    val opprettet: LocalDateTime? = null,
    val sistEndret: LocalDateTime? = null,
) {
    fun tilDto(navEnhet: NavEnhet) =
        IASamarbeidDto(
            id = id,
            saksnummer = saksnummer,
            navn = navn,
            navEnhet = navEnhet,
            status = status,
            opprettet = opprettet,
            sistEndret = sistEndret,
        )
}

@Serializable
data class IASamarbeidDto(
    val id: Int,
    val saksnummer: String,
    val navn: String,
    val navEnhet: NavEnhet,
    val status: IASamarbeid.Status? = null,
    val opprettet: LocalDateTime? = null,
    val sistEndret: LocalDateTime? = null,
)

fun List<IASamarbeid>.tilDto() = map { it.tilDto() }

fun IASamarbeid.tilDto() =
    IASamarbeidDto(
        id = id,
        saksnummer = saksnummer,
        navn = navn,
        navEnhet = navEnhet,
        status = status,
        opprettet = opprettet,
        sistEndret = sistEndret,
    )
