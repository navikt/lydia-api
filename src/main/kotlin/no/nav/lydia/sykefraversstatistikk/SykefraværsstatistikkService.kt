package no.nav.lydia.sykefraversstatistikk

import arrow.core.rightIfNotNull
import io.ktor.http.*
import kotlinx.datetime.LocalDate
import kotlinx.datetime.toKotlinLocalDate
import no.nav.lydia.UnleashKlient
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.domene.ANTALL_DAGER_FØR_SAK_LÅSES
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere
import no.nav.lydia.sykefraversstatistikk.domene.SykefraversstatistikkVirksomhet
import no.nav.lydia.sykefraversstatistikk.import.BehandletImportStatistikk
import no.nav.lydia.sykefraversstatistikk.import.Kategori.VIRKSOMHET
import no.nav.lydia.sykefraversstatistikk.import.SykefraversstatistikkPerKategoriImportDto
import org.slf4j.LoggerFactory
import java.time.LocalDate.now

class SykefraværsstatistikkService(
    val sykefraversstatistikkRepository: SykefraversstatistikkRepository,
    val sykefraværsstatistikkSiste4KvartalRepository: SykefraværsstatistikkSiste4KvartalRepository,
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

    fun hentSykefravær(
        søkeparametere: Søkeparametere,
    ): List<SykefraversstatistikkVirksomhet> {
        val start = System.currentTimeMillis()
        val sykefravær = if (UnleashKlient.skalHenteSiste4Kvartal()) {
            sykefraværsstatistikkSiste4KvartalRepository.hentSykefravær(søkeparametere = søkeparametere)
        } else {
            sykefraversstatistikkRepository.hentSykefravær(søkeparametere = søkeparametere)
        }

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

    fun hentTotaltAntallTreff(søkeparametere: Søkeparametere) =
        if (UnleashKlient.skalHenteSiste4Kvartal()) {
            sykefraværsstatistikkSiste4KvartalRepository.hentTotaltAntall(søkeparametere)
                .rightIfNotNull { SykefraværsstatistikkError.`feil under uthenting av sykefraværsstatistikk` }
        } else {
            sykefraversstatistikkRepository.hentTotaltAntall(søkeparametere)
                .rightIfNotNull { SykefraværsstatistikkError.`feil under uthenting av sykefraværsstatistikk` }
        }

    fun hentSykefraværForVirksomhet(orgnr: String): List<SykefraversstatistikkVirksomhet> {
        val start = System.currentTimeMillis()
        val sykefraværForVirksomhet = if (UnleashKlient.skalHenteSiste4Kvartal()) {
            sykefraværsstatistikkSiste4KvartalRepository.hentSykefraværForVirksomhet(orgnr = orgnr)
        } else {
            sykefraversstatistikkRepository.hentSykefraværForVirksomhet(orgnr = orgnr)
        }
        log.info("Brukte ${System.currentTimeMillis() - start} ms på å hente statistikk for en virksomhet")

        return sykefraværForVirksomhet
    }

    fun hentSykefraværForVirksomhetSisteTilgjengeligKvartal(orgnr: String): SykefraversstatistikkVirksomhet {
        val start = System.currentTimeMillis()
        val sykefraværForVirksomhet = sykefraversstatistikkRepository.hentSykefraværForVirksomhet(orgnr = orgnr)
        log.info("Brukte ${System.currentTimeMillis() - start} ms på å hente statistikk for en virksomhet")

        return sykefraværForVirksomhet.get(0)
    }
}

object SykefraværsstatistikkError {
    val `feil under uthenting av sykefraværsstatistikk` =
        Feil("Det skjedde noe feil under uthenting av sykefraværsstatistikk", HttpStatusCode.InternalServerError)
}
