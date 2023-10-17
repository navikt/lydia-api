package no.nav.lydia.sykefraversstatistikk

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.*
import kotlinx.datetime.toKotlinLocalDate
import kotlinx.serialization.Serializable
import kotliquery.Row
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.sykefraversstatistikk.api.KvartalerFraTilDto
import no.nav.lydia.sykefraversstatistikk.api.Periode
import org.slf4j.LoggerFactory

class SistePubliseringService(
    private val sistePubliseringRepository: SistePubliseringRepository
) {

    companion object {
        val logger = LoggerFactory.getLogger(this::class.java)
    }


    fun hentPubliseringsinfo(): Either<Feil, Publiseringsinfo> {
        val publiseringsinfo = try {
            sistePubliseringRepository.hentPubliseringsinfo()
        } catch (e: Exception) {
            logger.warn(e.message, e)
            return Feil(e.message ?: "Ukjent feil under henting av publiseringsinfo", HttpStatusCode.InternalServerError).left()
        }
        return publiseringsinfo.toPubliseringsinfo().right()
    }

    fun hentGjelendePeriode(): Periode {
        val publiseringsinfo = sistePubliseringRepository.hentPubliseringsinfo()
        return publiseringsinfo.gjeldendePeriode.tilPeriode()
    }

    fun hentAllPubliseringsinfo() = sistePubliseringRepository.hentAllPubliseringsinfo()
}

@Serializable
data class PubliseringsinfoDto(
    val sistePubliseringsdato: kotlinx.datetime.LocalDate,
    val nestePubliseringsdato: kotlinx.datetime.LocalDate,
    val gjeldendePeriode: PeriodeDto,
) {
    companion object {
        fun Row.tilPubliseringsinfo(): PubliseringsinfoDto =
            PubliseringsinfoDto(
                gjeldendePeriode = PeriodeDto(årstall = this.int("gjeldende_arstall"), kvartal = this.int("gjeldende_kvartal")),
                sistePubliseringsdato = this.localDate("siste_publiseringsdato").toKotlinLocalDate(),
                nestePubliseringsdato = this.localDate("neste_publiseringsdato").toKotlinLocalDate()
            )
    }

    fun toPubliseringsinfo(): Publiseringsinfo =
        Publiseringsinfo(
            sistePubliseringsdato = sistePubliseringsdato,
            nestePubliseringsdato = nestePubliseringsdato,
            fraTil = KvartalerFraTil(
                fra = gjeldendePeriode.tilPeriode().forrigePeriode().forrigePeriode().forrigePeriode().tilKvartal(),
                til = gjeldendePeriode.tilPeriode().tilKvartal()
            ).toDto()
        )

}
@Serializable
data class Publiseringsinfo(
    val sistePubliseringsdato: kotlinx.datetime.LocalDate,
    val nestePubliseringsdato: kotlinx.datetime.LocalDate,
    val fraTil: KvartalerFraTilDto
)

@Serializable
data class PeriodeDto(
    val årstall: Int,
    val kvartal: Int,
) {
    fun tilPeriode() : Periode {
        return Periode(årstall = årstall, kvartal = kvartal)
    }
}


