package no.nav.lydia.personopplysninger

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import kotlinx.serialization.Serializable
import no.nav.lydia.felles.Feil

const val MAKS_ANTALL_TEGN_I_PERSONOPPLYSNINGSSJEKK = 250

@Serializable
data class PersonopplysningssjekkDto(
    val tekst: String,
)

@Serializable
data class PersonopplysningssjekkResultatDto(
    val inneholderTall: Boolean,
    val inneholderEpost: Boolean,
)

object PersonopplysningssjekkFeil {
    val `for lang tekst` =
        Feil(
            feilmelding = "Teksten kan ikke være lengre enn $MAKS_ANTALL_TEGN_I_PERSONOPPLYSNINGSSJEKK tegn",
            httpStatusCode = HttpStatusCode.BadRequest,
        )
}

fun sjekkForPersonopplysninger(tekst: String): Either<Feil, PersonopplysningssjekkResultatDto> =
    if (tekst.length > MAKS_ANTALL_TEGN_I_PERSONOPPLYSNINGSSJEKK) {
        PersonopplysningssjekkFeil.`for lang tekst`.left()
    } else {
        PersonopplysningssjekkResultatDto(
            inneholderTall = PersondataFilter.inneholderTall(tekst),
            inneholderEpost = PersondataFilter.inneholderEpost(tekst),
        ).right()
    }
