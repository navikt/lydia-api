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
import no.nav.lydia.sykefraversstatistikk.domene.VirksomhetsstatistikkSiste4Kvartal
import no.nav.lydia.sykefraversstatistikk.domene.Virksomhetsoversikt
import no.nav.lydia.sykefraversstatistikk.domene.VirksomhetsstatistikkSisteKvartal
import no.nav.lydia.sykefraversstatistikk.import.*
import no.nav.lydia.sykefraversstatistikk.import.Kategori.*
import org.slf4j.LoggerFactory
import java.time.LocalDate.now

class SykefraværsstatistikkService(
    val sistePubliseringService: SistePubliseringService,
    val sykefraversstatistikkRepository: SykefraversstatistikkRepository,
    val virksomhetsinformasjonRepository: VirksomhetsinformasjonRepository,
) {
    val log = LoggerFactory.getLogger(this.javaClass)

    fun lagre(sykefraværsstatistikkListe: List<BehandletImportStatistikk>) {
        val start = System.currentTimeMillis()
        sykefraversstatistikkRepository.insert(behandletImportStatistikkListe = sykefraværsstatistikkListe)
        log.info("Brukte ${System.currentTimeMillis() - start} ms på å lagre statistikk for ${sykefraværsstatistikkListe.size} virksomheter")
    }

    fun lagreStatistikkMetadataVirksomhet(behandletImportMetadataVirksomhetListe: List<BehandletImportMetadataVirksomhet>) {
        if (behandletImportMetadataVirksomhetListe.isNotEmpty()) {
            log.info("Lagrer ${behandletImportMetadataVirksomhetListe.size} rad(er) med metadata virksomhet")
        }
        val start = System.currentTimeMillis()
        sykefraversstatistikkRepository.insertMetadataForVirksomhet(
            behandletImportMetadataVirksomhetListe
        )
        log.info("Brukte ${System.currentTimeMillis() - start} ms på å lagre ${behandletImportMetadataVirksomhetListe.size} virksomhet metadata")
    }

    fun lagreSykefraværsstatistikkPerKategori(
        sykefraværsstatistikkKategoriImportDtoListe: List<SykefraversstatistikkPerKategoriImportDto>,
    ) {
        val start = System.currentTimeMillis()
        lagreSykefraværsstatistikkSiste4Kvartal(sykefraværsstatistikkKategoriImportDtoListe)
        lagreSykefraværsstatistikkGjeldendeKvartal(sykefraværsstatistikkKategoriImportDtoListe)
        log.info("Brukte ${System.currentTimeMillis() - start} ms på å lagre ${sykefraværsstatistikkKategoriImportDtoListe.size} statistikkmeldinger per kategori")
    }

    private fun lagreSykefraværsstatistikkGjeldendeKvartal(sykefraværsstatistikkKategoriImportDtoListe: List<SykefraversstatistikkPerKategoriImportDto>) {
        sykefraversstatistikkRepository.insertSykefraværsstatistikkForSisteGjelendeKvartalForLand(
            sykefraværsstatistikk = filterPåKategoriOgLogInfo(sykefraværsstatistikkKategoriImportDtoListe, LAND)
        )
        sykefraversstatistikkRepository.insertSykefraværsstatistikkForSisteGjelendeKvartalForSektor(
            sykefraværsstatistikk = filterPåKategoriOgLogInfo(sykefraværsstatistikkKategoriImportDtoListe, SEKTOR)
        )
        sykefraversstatistikkRepository.insertSykefraværsstatistikkForSisteGjelendeKvartalForNæring(
            sykefraværsstatistikk = filterPåKategoriOgLogInfo(sykefraværsstatistikkKategoriImportDtoListe, NÆRING)
        )
        sykefraversstatistikkRepository.insertSykefraværsstatistikkForSisteGjelendeKvartalForVirksomhet(
            sykefraværsstatistikk = filterPåKategoriOgLogInfo(sykefraværsstatistikkKategoriImportDtoListe, VIRKSOMHET)
        )
    }

    private fun lagreSykefraværsstatistikkSiste4Kvartal(sykefraværsstatistikkKategoriImportDtoListe: List<SykefraversstatistikkPerKategoriImportDto>) {
        sykefraversstatistikkRepository.insertSykefraværsstatistikkForSiste4KvartalerForVirksomhet(
            sykefraværsstatistikk = sykefraværsstatistikkKategoriImportDtoListe
                .filter { it.kategori == VIRKSOMHET }
        )

        val sykefraværsstatistikkForAndreKategorier = sykefraværsstatistikkKategoriImportDtoListe
            .filter { it.kategori != VIRKSOMHET }

        if (sykefraværsstatistikkForAndreKategorier.isNotEmpty()) {
            log.info("Lagrer ${sykefraværsstatistikkForAndreKategorier.size} rad(er) med statistikk for andre kategorier i siste 4 kvartal")
        }
        sykefraversstatistikkRepository.insertSykefraværsstatistikkForSiste4KvartalerForAndreKategorier(
            sykefraværsstatistikk = sykefraværsstatistikkForAndreKategorier
        )
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

    private fun filterPåKategoriOgLogInfo(
        sykefraværsstatistikkKategoriImportDtoListe: List<SykefraversstatistikkPerKategoriImportDto>, kategori: Kategori
    ): List<SykefraversstatistikkPerKategoriImportDto> {
        val statistikkForKategori = sykefraværsstatistikkKategoriImportDtoListe
            .filter { it.kategori == kategori }

        if (statistikkForKategori.isNotEmpty()) {
            log.info("Lagrer ${statistikkForKategori.size} rad(er) med statistikk for kategori ${kategori.name} i gjeldende kvartal")
        }
        return statistikkForKategori
    }

    private fun LocalDate?.erForeldet() = when (this) {
        null -> false
        else -> {
            this < now().minusDays(ANTALL_DAGER_FØR_SAK_LÅSES).toKotlinLocalDate()
        }
    }

    private fun IAProsessStatus?.erAvsluttet() = when (this) {
        null -> true
        else -> regnesSomAvsluttet()
    }

    fun hentTotaltAntallVirksomheter(søkeparametere: Søkeparametere) =
        virksomhetsinformasjonRepository.hentTotaltAntallVirksomheter(søkeparametere)
            .rightIfNotNull { SykefraværsstatistikkError.`feil under uthenting av sykefraværsstatistikk` }

    fun hentSykefraværForVirksomhetSiste4Kvartal(orgnr: String): Either<Feil, VirksomhetsstatistikkSiste4Kvartal> {
        val start = System.currentTimeMillis()
        val sykefraværForVirksomhetSiste4Kvartal =
            virksomhetsinformasjonRepository.hentVirksomhetsstatistikkSiste4Kvartal(orgnr = orgnr)
        log.info("Brukte ${System.currentTimeMillis() - start} ms på å hente statistikk for en virksomhet")

        return sykefraværForVirksomhetSiste4Kvartal?.right()
            ?: SykefraværsstatistikkError.`ingen sykefraværsstatistikk`.left()
    }

    fun hentVirksomhetsstatistikkSisteKvartal(
        orgnr: String,
        periode: Periode? = null
    ): Either<Feil, VirksomhetsstatistikkSisteKvartal> {
        val start = System.currentTimeMillis()
        val sykefraværForVirksomhetSisteKvartal =
            virksomhetsinformasjonRepository.hentVirksomhetsstatistikkSisteKvartal(orgnr = orgnr, periode = periode)
        log.info("Brukte ${System.currentTimeMillis() - start} ms på å hente statistikk for en virksomhet")

        return sykefraværForVirksomhetSisteKvartal?.right()
            ?: SykefraværsstatistikkError.`ingen sykefraværsstatistikk`.left()
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
