package no.nav.lydia.sykefraversstatistikk

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import arrow.core.rightIfNotNull
import io.ktor.http.*
import kotlinx.datetime.LocalDate
import kotlinx.datetime.toKotlinLocalDate
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.domene.ANTALL_DAGER_FØR_SAK_LÅSES
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.sykefraversstatistikk.api.KvartalDto.Companion.toDto
import no.nav.lydia.sykefraversstatistikk.api.KvartalerFraTilDto
import no.nav.lydia.sykefraversstatistikk.api.Periode
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere
import no.nav.lydia.sykefraversstatistikk.domene.Virksomhetsdetaljer
import no.nav.lydia.sykefraversstatistikk.domene.Virksomhetsoversikt
import no.nav.lydia.sykefraversstatistikk.domene.VirksomhetsstatistikkSisteKvartal
import no.nav.lydia.sykefraversstatistikk.import.BehandletImportStatistikk
import no.nav.lydia.sykefraversstatistikk.import.Kategori.VIRKSOMHET
import no.nav.lydia.sykefraversstatistikk.import.Kvartal
import no.nav.lydia.sykefraversstatistikk.import.SykefraversstatistikkPerKategoriImportDto
import org.slf4j.LoggerFactory
import java.time.LocalDate.now

class SykefraværsstatistikkService(
    val sykefraversstatistikkRepository: SykefraversstatistikkRepository,
    val virksomhetsinformasjonRepository: VirksomhetsinformasjonRepository,
) {
    val log = LoggerFactory.getLogger(this.javaClass)

    fun lagre(sykefraværsstatistikkListe: List<BehandletImportStatistikk>) {
        val start = System.currentTimeMillis()
        sykefraversstatistikkRepository.insert(behandletImportStatistikkListe = sykefraværsstatistikkListe)
        log.info("Brukte ${System.currentTimeMillis() - start} ms på å lagre statistikk for ${sykefraværsstatistikkListe.size} virksomheter")
    }

    fun lagreSykefraværsstatistikkPerKategori(
        sykefraværsstatistikkKategoriImportDtoListe: List<SykefraversstatistikkPerKategoriImportDto>,
    ) {
        val start = System.currentTimeMillis()
        sykefraversstatistikkRepository.insertSykefraværsstatistikkForSiste4KvartalerForVirksomhet(
            sykefraværsstatistikk = sykefraværsstatistikkKategoriImportDtoListe
                .filter { it.kategori == VIRKSOMHET }
        )
        sykefraversstatistikkRepository.insertSykefraværsstatistikkForSiste4KvartalerForAndreKategorier(
            sykefraværsstatistikk = sykefraværsstatistikkKategoriImportDtoListe
                .filter { it.kategori != VIRKSOMHET }
        )
        log.info("Brukte ${System.currentTimeMillis() - start} ms på å lagre ${sykefraværsstatistikkKategoriImportDtoListe.size} statistikkmeldinger per kategori")
    }

    fun søkEtterVirksomheter(
        søkeparametere: Søkeparametere,
    ): List<Virksomhetsoversikt> {
        val start = System.currentTimeMillis()
        val sykefravær = virksomhetsinformasjonRepository.søkEtterVirksomheter(søkeparametere = søkeparametere)

        log.info("Brukte ${System.currentTimeMillis() - start} ms på å hente statistikk for virksomheter.")
        return sykefravær.map {
            if (it.status.erAvsluttet() && it.sistEndret.erForeldet()) {
                it.copy(
                    status = IAProsessStatus.IKKE_AKTIV
                )
            } else {
                it
            }
        }
    }

    private fun LocalDate?.erForeldet() = when (this) {
        null -> false
        else -> {
            this < now().minusDays(ANTALL_DAGER_FØR_SAK_LÅSES).toKotlinLocalDate()
        }
    }

    private fun IAProsessStatus?.erAvsluttet() = when (this) {
        null -> true
        else -> ansesSomAvsluttet()
    }

    fun hentTotaltAntallVirksomheter(søkeparametere: Søkeparametere) =
        virksomhetsinformasjonRepository.hentTotaltAntallVirksomheter(søkeparametere)
            .rightIfNotNull { SykefraværsstatistikkError.`feil under uthenting av sykefraværsstatistikk` }

    fun hentSykefraværForVirksomhet(orgnr: String): List<Virksomhetsdetaljer> {
        val start = System.currentTimeMillis()
        val sykefraværForVirksomhet =
            virksomhetsinformasjonRepository.hentSykefraværForVirksomhet(orgnr = orgnr)
        log.info("Brukte ${System.currentTimeMillis() - start} ms på å hente statistikk for en virksomhet")

        return sykefraværForVirksomhet
    }

    fun hentVirksomhetsstatistikkSisteKvartal(orgnr: String): Either<Feil, VirksomhetsstatistikkSisteKvartal> {
        val start = System.currentTimeMillis()
        val sykefraværForVirksomhetSisteKvartal = virksomhetsinformasjonRepository.hentVirksomhetsstatistikkSisteKvartal(orgnr = orgnr)
        log.info("Brukte ${System.currentTimeMillis() - start} ms på å hente statistikk for en virksomhet")

        return sykefraværForVirksomhetSisteKvartal?.right() ?: SykefraværsstatistikkError.`ingen sykefraværsstatistikk`.left()
    }

    fun hentGjeldendePeriodeSiste4Kvartal(): Either<Feil, KvartalerFraTil> {
        return KvartalerFraTil(
            fra = Periode.forrigePeriode().forrigePeriode().forrigePeriode().tilKvartal(),
            til = Periode.gjeldendePeriode().tilKvartal()
        ).right()
    }
}

object SykefraværsstatistikkError {
    val `feil under uthenting av sykefraværsstatistikk` =
        Feil("Det skjedde noe feil under uthenting av sykefraværsstatistikk", HttpStatusCode.InternalServerError)
    val `ingen sykefraværsstatistikk` =
        Feil("Ingen sykefraværsstatistikk funnet for virksomhet", HttpStatusCode.NotFound)
}

class KvartalerFraTil(val fra: Kvartal, val til: Kvartal) {
    fun toDto(): KvartalerFraTilDto {
        return KvartalerFraTilDto(fra = fra.toDto(), til = til.toDto())
    }
}
