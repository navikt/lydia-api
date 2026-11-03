package no.nav.lydia.mål

import arrow.core.Either
import arrow.core.raise.either
import arrow.core.raise.ensure
import io.ktor.http.HttpStatusCode
import kotlinx.datetime.LocalDate
import kotlinx.serialization.Serializable
import no.nav.lydia.felles.Feil

const val MAKS_ANTALL_TEGN_I_SAMARBEIDSMÅL = 250
const val MAKS_PROSENT = 100.0
const val MAKS_TAPTE_DAGSVERK = 99_999_999.99
const val MAKS_ANTALL_DESIMALER = 2

enum class Sykefraværsmåltype {
    LANGTIDSFRAVÆR,
    KORTTIDSFRAVÆR,
    EGENMELDT_FRAVÆR,
    LEGEMELDT_FRAVÆR,
    GRADERT_FRAVÆR,
    TAPTE_DAGSVERK,
    ;

    fun maksverdi() = if (this == TAPTE_DAGSVERK) MAKS_TAPTE_DAGSVERK else MAKS_PROSENT
}

@Serializable
data class MålDto(
    val sykefraværsmål: List<SykefraværsmålDto>,
    val samarbeidsmål: List<SamarbeidsmålDto>,
)

@Serializable
data class SykefraværsmålDto(
    val type: Sykefraværsmåltype,
    val nåværende: Double,
    val mål: Double,
    val frist: LocalDate,
)

@Serializable
data class SamarbeidsmålDto(
    val id: Int? = null,
    val mål: String,
    val lagretMedKiAdvarsel: Boolean = false,
)

object MålFeil {
    val `ugyldig verdi i sykefraværsmål` = Feil(
        feilmelding = "Nåværende verdi og mål må være mellom 0 og 100 for prosent, og 0 eller mer for tapte dagsverk",
        httpStatusCode = HttpStatusCode.BadRequest,
    )
    val `for mange desimaler i sykefraværsmål` = Feil(
        feilmelding = "Nåværende verdi og mål kan ha høyst $MAKS_ANTALL_DESIMALER desimaler",
        httpStatusCode = HttpStatusCode.BadRequest,
    )
    val `flere sykefraværsmål med samme type` = Feil(
        feilmelding = "Det kan bare finnes ett sykefraværsmål per sykefraværsmåltype",
        httpStatusCode = HttpStatusCode.Conflict,
    )
    val `tomt samarbeidsmål` = Feil(
        feilmelding = "Samarbeidsmål kan ikke være tomt",
        httpStatusCode = HttpStatusCode.BadRequest,
    )
    val `for langt samarbeidsmål` = Feil(
        feilmelding = "Samarbeidsmål kan ikke være lengre enn $MAKS_ANTALL_TEGN_I_SAMARBEIDSMÅL tegn",
        httpStatusCode = HttpStatusCode.BadRequest,
    )
    val `ugyldig id på samarbeidsmål` = Feil(
        feilmelding = "Samarbeidsmålet finnes ikke i denne planen",
        httpStatusCode = HttpStatusCode.BadRequest,
    )
    val `samarbeidet er ikke aktivt` = Feil(
        feilmelding = "Kan bare endre mål for aktive samarbeid",
        httpStatusCode = HttpStatusCode.Conflict,
    )
    val `feil ved henting av mål` = Feil(
        feilmelding = "Klarte ikke å hente målene i samarbeidsplanen",
        httpStatusCode = HttpStatusCode.InternalServerError,
    )
    val `feil ved lagring av mål` = Feil(
        feilmelding = "Klarte ikke å lagre målene i samarbeidsplanen",
        httpStatusCode = HttpStatusCode.InternalServerError,
    )
}

fun MålDto.valider(): Either<Feil, MålDto> =
    either {
        sykefraværsmål.forEach { sykefraværsmål ->
            val maksverdi = sykefraværsmål.type.maksverdi()
            listOf(sykefraværsmål.nåværende, sykefraværsmål.mål).forEach { verdi ->
                ensure(verdi.isFinite() && verdi >= 0 && verdi <= maksverdi) {
                    MålFeil.`ugyldig verdi i sykefraværsmål`
                }
                ensure(verdi.toBigDecimal().stripTrailingZeros().scale() <= MAKS_ANTALL_DESIMALER) {
                    MålFeil.`for mange desimaler i sykefraværsmål`
                }
            }
        }
        ensure(sykefraværsmål.distinctBy { it.type }.size == sykefraværsmål.size) {
            MålFeil.`flere sykefraværsmål med samme type`
        }

        val ider = samarbeidsmål.mapNotNull { it.id }
        ensure(ider.distinct().size == ider.size) { MålFeil.`ugyldig id på samarbeidsmål` }

        copy(
            samarbeidsmål = samarbeidsmål.map { samarbeidsmål ->
                val trimmet = samarbeidsmål.mål.trim()
                ensure(trimmet.isNotEmpty()) { MålFeil.`tomt samarbeidsmål` }
                ensure(trimmet.length <= MAKS_ANTALL_TEGN_I_SAMARBEIDSMÅL) { MålFeil.`for langt samarbeidsmål` }
                samarbeidsmål.copy(mål = trimmet)
            },
        )
    }
