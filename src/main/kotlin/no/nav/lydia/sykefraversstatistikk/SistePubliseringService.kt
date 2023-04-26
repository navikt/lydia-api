package no.nav.lydia.sykefraversstatistikk

import kotlinx.datetime.toKotlinLocalDate
import kotlinx.serialization.Serializable
import kotliquery.Row
import no.nav.lydia.sykefraversstatistikk.api.Periode

class SistePubliseringService(
    private val sistePubliseringRepository: SistePubliseringRepository
) {

    //private val deserializer = Json { ignoreUnknownKeys = true }

    /*
    fun hentPubliseringsinfo(): Either<Feil, PeriodeDto> {
        return "https://arbeidsgiver.nav.no/sykefravarsstatistikk/api/publiseringsdato".httpGet().useHttpCache(true)
            .header(HttpHeaders.Accept to "application/json", HttpHeaders.ContentType to "application/json")
            .response()
            .third
            .fold(success = {
                it.toString(Charsets.UTF_8).right()
                deserializer.decodeFromString<Publiseringsinfo>(it.toString(Charsets.UTF_8)).gjeldendePeriode.right()
            }, failure = {
                throw IOException(
                    "Feilet under henting av publiseringsdato: ${it.message} ${
                        it.errorData.toString(
                            Charsets.UTF_8
                        )
                    }"
                )
            })
    }*/

    fun hentGjelendePeriode(): Periode {
        val publiseringsinfo = sistePubliseringRepository.hentPubliseringsinfo()
        return publiseringsinfo.gjeldendePeriode.tilPeriode()
    }
}

@Serializable
data class Publiseringsinfo(
    val sistePubliseringsdato: kotlinx.datetime.LocalDate,
    val nestePubliseringsdato: kotlinx.datetime.LocalDate,
    val gjeldendePeriode: PeriodeDto,
) {
    companion object {
        fun Row.tilPubliseringsinfo(): Publiseringsinfo =
            Publiseringsinfo(
                gjeldendePeriode = PeriodeDto(årstall = this.int("gjeldende_arstall"), kvartal = this.int("gjeldende_kvartal")),
                sistePubliseringsdato = this.localDate("siste_publiseringsdato").toKotlinLocalDate(),
                nestePubliseringsdato = this.localDate("neste_publiseringsdato").toKotlinLocalDate()
            )
    }
}

@Serializable
data class PeriodeDto(
    val årstall: Int,
    val kvartal: Int,
) {
    fun tilPeriode() : Periode {
        return Periode(årstall = årstall, kvartal = kvartal)
    }
}


