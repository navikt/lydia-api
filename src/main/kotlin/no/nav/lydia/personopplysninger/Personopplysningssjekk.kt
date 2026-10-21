package no.nav.lydia.personopplysninger

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import kotlinx.serialization.Serializable
import no.nav.lydia.felles.Feil
import no.nav.lydia.ki.AzureOpenAiKlient

const val MAKS_ANTALL_TEGN_I_PERSONOPPLYSNINGSSJEKK = 250

@Serializable
data class PersonopplysningssjekkDto(
    val tekst: String,
)

@Serializable
data class PersonopplysningssjekkResultatDto(
    val kanInneholdePersonopplysninger: Boolean,
    val inneholderTall: Boolean,
    val inneholderEpost: Boolean,
    // null betyr at KI ikke ble kalt, fordi teksten var tom etter filtrering, burde man ha null?
    val kiFlagget: Boolean?,
)

object PersonopplysningssjekkFeil {
    val `for lang tekst` =
        Feil(
            feilmelding = "Teksten kan ikke være lengre enn $MAKS_ANTALL_TEGN_I_PERSONOPPLYSNINGSSJEKK tegn",
            httpStatusCode = HttpStatusCode.BadRequest,
        )
}

class Personopplysningssjekk(
    private val azureOpenAiKlient: AzureOpenAiKlient,
) {
    suspend fun sjekk(tekst: String): Either<Feil, PersonopplysningssjekkResultatDto> {
        if (tekst.length > MAKS_ANTALL_TEGN_I_PERSONOPPLYSNINGSSJEKK) {
            return PersonopplysningssjekkFeil.`for lang tekst`.left()
        }

        val inneholderTall = PersondataFilter.inneholderTall(tekst)
        val inneholderEpost = PersondataFilter.inneholderEpost(tekst)
        val filtrertTekst = PersondataFilter.filtrerUtPersonsensitiveData(tekst)

        if (filtrertTekst.isBlank()) {
            return PersonopplysningssjekkResultatDto(
                kanInneholdePersonopplysninger = true,
                inneholderTall = inneholderTall,
                inneholderEpost = inneholderEpost,
                //TODO: burde dette være null? sender ikke til KI fordi det er ingenting i fritekstfeltet
                //TODO: burde kanskje bare settes til false, slik at vi kan ha Boolean men kan være misvisende
                kiFlagget = null,
            ).right()
        }

        return azureOpenAiKlient.vurderPersonvern(filtrertTekst).map { vurdering ->
            PersonopplysningssjekkResultatDto(
                kanInneholdePersonopplysninger = vurdering.personvernflagget || inneholderTall || inneholderEpost,
                inneholderTall = inneholderTall,
                inneholderEpost = inneholderEpost,
                kiFlagget = vurdering.personvernflagget,
            )
        }
    }
}
