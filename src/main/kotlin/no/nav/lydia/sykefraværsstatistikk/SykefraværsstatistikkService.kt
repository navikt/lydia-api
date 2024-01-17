package no.nav.lydia.sykefraværsstatistikk

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.*
import kotlinx.datetime.LocalDate
import kotlinx.datetime.toKotlinLocalDate
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.domene.ANTALL_DAGER_FØR_SAK_LÅSES
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.sykefraværsstatistikk.api.KvartalDto.Companion.toDto
import no.nav.lydia.sykefraværsstatistikk.api.KvartalerFraTilDto
import no.nav.lydia.sykefraværsstatistikk.api.Periode
import no.nav.lydia.sykefraværsstatistikk.api.Søkeparametere
import no.nav.lydia.sykefraværsstatistikk.domene.BransjeSykefraværsstatistikk
import no.nav.lydia.sykefraværsstatistikk.domene.HistoriskStatistikk
import no.nav.lydia.sykefraværsstatistikk.domene.KategoriStatistikk
import no.nav.lydia.sykefraværsstatistikk.domene.NæringSykefraværsstatistikk
import no.nav.lydia.sykefraværsstatistikk.domene.Virksomhetsoversikt
import no.nav.lydia.sykefraværsstatistikk.domene.VirksomhetsstatistikkSiste4Kvartal
import no.nav.lydia.sykefraværsstatistikk.domene.VirksomhetsstatistikkSisteKvartal
import no.nav.lydia.sykefraværsstatistikk.import.*
import no.nav.lydia.sykefraværsstatistikk.import.Kategori.*
import no.nav.lydia.sykefraværsstatistikk.import.SykefraværsstatistikkPerKategoriImportDto.Companion.filterPåKategoriSektorOgGyldigSektor
import no.nav.lydia.sykefraværsstatistikk.import.SykefraværsstatistikkPerKategoriImportDto.Companion.mapSektorNavnTilSektorKode
import no.nav.lydia.virksomhet.VirksomhetRepository
import org.slf4j.LoggerFactory
import java.time.LocalDate.now
import kotlin.system.measureTimeMillis

const val LANDKODE_NO = "NO"

class SykefraværsstatistikkService(
    val sykefraværsstatistikkRepository: SykefraværsstatistikkRepository,
    val virksomhetsinformasjonRepository: VirksomhetsinformasjonRepository,
    val sistePubliseringService: SistePubliseringService,
    val virksomhetRepository: VirksomhetRepository,
) {
    val log = LoggerFactory.getLogger(this.javaClass)

    fun lagreStatistikkMetadataVirksomhet(behandletImportMetadataVirksomhetListe: List<BehandletImportMetadataVirksomhet>) {
        if (behandletImportMetadataVirksomhetListe.isNotEmpty()) {
            log.info("Lagrer ${behandletImportMetadataVirksomhetListe.size} rad(er) med metadata virksomhet")
        }
        val start = System.currentTimeMillis()
        sykefraværsstatistikkRepository.insertMetadataForVirksomhet(
            behandletImportMetadataVirksomhetListe
        )
        log.info("Brukte ${System.currentTimeMillis() - start} ms på å lagre ${behandletImportMetadataVirksomhetListe.size} virksomhet metadata")
    }

    fun lagreSykefraværsstatistikkPerKategori(
        sykefraværsstatistikkKategoriImportDtoListe: List<SykefraværsstatistikkPerKategoriImportDto>,
    ) {
        val start = System.currentTimeMillis()
        lagreSykefraværsstatistikkSiste4Kvartal(sykefraværsstatistikkKategoriImportDtoListe)
        lagreSykefraværsstatistikkGjeldendeKvartal(sykefraværsstatistikkKategoriImportDtoListe)
        log.info("Brukte ${System.currentTimeMillis() - start} ms på å lagre ${sykefraværsstatistikkKategoriImportDtoListe.size} statistikkmeldinger per kategori")
    }

    private fun lagreSykefraværsstatistikkGjeldendeKvartal(sykefraværsstatistikkKategoriImportDtoListe: List<SykefraværsstatistikkPerKategoriImportDto>) {
        sykefraværsstatistikkRepository.insertSykefraværsstatistikkForSisteGjelendeKvartalForLand(
            sykefraværsstatistikk = filterPåKategoriOgLogInfo(sykefraværsstatistikkKategoriImportDtoListe, LAND)
        )
        sykefraværsstatistikkRepository.insertSykefraværsstatistikkForSisteGjelendeKvartalForSektor(
            sykefraværsstatistikk = filterPåKategoriOgLogInfo(sykefraværsstatistikkKategoriImportDtoListe, SEKTOR)
        )
        sykefraværsstatistikkRepository.insertSykefraværsstatistikkForSisteGjelendeKvartalForBransje(
            sykefraværsstatistikk = filterPåKategoriOgLogInfo(sykefraværsstatistikkKategoriImportDtoListe, BRANSJE)
        )
        sykefraværsstatistikkRepository.insertSykefraværsstatistikkForSisteGjelendeKvartalForNæring(
            sykefraværsstatistikk = filterPåKategoriOgLogInfo(sykefraværsstatistikkKategoriImportDtoListe, NÆRING)
        )
        sykefraværsstatistikkRepository.insertSykefraværsstatistikkForSisteGjelendeKvartalForNæringskode(
            sykefraværsstatistikk = filterPåKategoriOgLogInfo(sykefraværsstatistikkKategoriImportDtoListe, NÆRINGSKODE)
        )
        sykefraværsstatistikkRepository.insertSykefraværsstatistikkForSisteGjelendeKvartalForVirksomhet(
            sykefraværsstatistikk = filterPåKategoriOgLogInfo(sykefraværsstatistikkKategoriImportDtoListe, VIRKSOMHET)
        )
    }

    fun lagreStatistikkVirksomhetGradering(gradertSykemeldingImportDtoListe: List<GradertSykemeldingImportDto>) {
        sykefraværsstatistikkRepository.insertStatistikkVirksomhetGraderingGjeldendeKvartal(
            gradertSykemeldingImportDtoList = gradertSykemeldingImportDtoListe
        )
        sykefraværsstatistikkRepository.insertStatistikkVirksomhetGraderingSiste4Kvartal(
            gradertSykemeldingImportDtoList = gradertSykemeldingImportDtoListe
        )
    }

    private fun lagreSykefraværsstatistikkSiste4Kvartal(sykefraværsstatistikkKategoriImportDtoListe: List<SykefraværsstatistikkPerKategoriImportDto>) {
        val sykefraværsstatistikkForVirksomheter = sykefraværsstatistikkKategoriImportDtoListe
            .filter { it.kategori == VIRKSOMHET }

        sykefraværsstatistikkRepository.insertSykefraværsstatistikkForSiste4KvartalerForVirksomhet(
            sykefraværsstatistikk = sykefraværsstatistikkForVirksomheter
        )

        val sykefraværsstatistikkForSektor = sykefraværsstatistikkKategoriImportDtoListe
            .filterPåKategoriSektorOgGyldigSektor()
            .mapSektorNavnTilSektorKode()

        if (sykefraværsstatistikkForSektor.isNotEmpty()) {
            log.info("Lagrer ${sykefraværsstatistikkForSektor.size} rad(er) med statistikk for SEKTOR i siste 4 kvartal")
        }
        sykefraværsstatistikkRepository.insertSykefraværsstatistikkForSiste4KvartalerForAndreKategorier(
            sykefraværsstatistikk = sykefraværsstatistikkForSektor
        )

        val sykefraværsstatistikkForAndreKategorier = sykefraværsstatistikkKategoriImportDtoListe
            .filter { it.kategori != VIRKSOMHET && it.kategori != SEKTOR }

        if (sykefraværsstatistikkForAndreKategorier.isNotEmpty()) {
            log.info("Lagrer ${sykefraværsstatistikkForAndreKategorier.size} rad(er) med statistikk for andre kategorier i siste 4 kvartal")
        }
        sykefraværsstatistikkRepository.insertSykefraværsstatistikkForSiste4KvartalerForAndreKategorier(
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
        sykefraværsstatistikkKategoriImportDtoListe: List<SykefraværsstatistikkPerKategoriImportDto>, kategori: Kategori
    ): List<SykefraværsstatistikkPerKategoriImportDto> {
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
            ?.right() ?: SykefraværsstatistikkError.`feil under uthenting av sykefraværsstatistikk`.left()

    fun hentSykefraværForVirksomhetSiste4Kvartal(orgnr: String): Either<Feil, VirksomhetsstatistikkSiste4Kvartal> {
        val start = System.currentTimeMillis()
        val gjeldendePeriode = sistePubliseringService.hentGjelendePeriode()
        val sykefraværForVirksomhetSiste4Kvartal =
            virksomhetsinformasjonRepository.hentVirksomhetsstatistikkSiste4Kvartal(
                orgnr = orgnr,
                periode = gjeldendePeriode
            )
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
            virksomhetsinformasjonRepository.hentVirksomhetsstatistikkSisteKvartal(orgnr = orgnr, periode = periode, gjeldenPeriode = sistePubliseringService.hentGjelendePeriode())
        log.info("Brukte ${System.currentTimeMillis() - start} ms på å hente statistikk for en virksomhet")

        return sykefraværForVirksomhetSisteKvartal?.right()
            ?: SykefraværsstatistikkError.`ingen sykefraværsstatistikk`.left()
    }

    fun hentHistoriskStatistikk(orgnummer: String) : Either<Feil, HistoriskStatistikk> {
        var virksomhetsstatistikk : HistoriskStatistikk
        val tidsbruk = measureTimeMillis {
            val virksomhet = virksomhetRepository.hentVirksomhet(orgnr = orgnummer) ?: return SykefraværsstatistikkError.`feil under uthenting av sykefraværsstatistikk`.left()
            val næring = virksomhet.næring
            val bransje = virksomhet.bransje
            val sektor = virksomhet.sektor

            virksomhetsstatistikk = HistoriskStatistikk (
                    virksomhetsstatistikk =
                        KategoriStatistikk(
                            kategori = VIRKSOMHET,
                            kode = orgnummer,
                            beskrivelse = virksomhet.navn,
                            statistikk = virksomhetsinformasjonRepository.hentVirksomhetsstatistikkPerKvartal(orgnr = orgnummer)
                        ),
                    næringsstatistikk = KategoriStatistikk(
                        kategori = NÆRING,
                        kode = næring.kode,
                        beskrivelse = næring.navn,
                        statistikk = virksomhetsinformasjonRepository.hentNæringstatistikkPerKvartal(næring = næring.kode)
                    ),
                    bransjestatistikk = KategoriStatistikk(
                        kategori = BRANSJE,
                        kode = bransje?.navn ?: "",
                        beskrivelse = bransje?.navn ?: "",
                        statistikk = bransje?.let { virksomhetsinformasjonRepository.hentBransjestatistikkPerKvartal(bransje = it) } ?: emptyList()
                    ),
                    sektorstatistikk = KategoriStatistikk(
                        kategori = SEKTOR,
                        kode = sektor?.kode ?: "",
                        beskrivelse = sektor?.beskrivelse ?: "",
                        statistikk = sektor?.let { virksomhetsinformasjonRepository.hentSektorstatistikkPerKvartal(sektor = it) } ?: emptyList()
                    ),
                    landsstatistikk = KategoriStatistikk(
                        kategori = LAND,
                        kode = LANDKODE_NO,
                        beskrivelse = "Norge",
                        statistikk = virksomhetsinformasjonRepository.hentLandsstatistikkPerKvartal()
                    )
            )
        }
        log.info("Brukte $tidsbruk ms på å hente statistikk for en virksomhet")
        return virksomhetsstatistikk.right()
    }

    fun hentNæringsstatistikk(næringskode: String): Either<Feil, NæringSykefraværsstatistikk> {
        val gjeldendePeriode = sistePubliseringService.hentGjelendePeriode()
        val hentNæringSykefraværsstatistikk = sykefraværsstatistikkRepository.hentNæringSykefraværsstatistikk(næringskode, gjeldendePeriode)
        return hentNæringSykefraværsstatistikk?.right()
                ?: SykefraværsstatistikkError.`ingen sykefraværsstatistikk`.left()
    }

    fun hentBransjestatistikk(bransje: String): Either<Feil, BransjeSykefraværsstatistikk> {
        val gjeldendePeriode = sistePubliseringService.hentGjelendePeriode()
        val hentBransjeSykefraværsstatistikk = sykefraværsstatistikkRepository.hentBransjeSykefraværsstatistikk(bransje, gjeldendePeriode)
        return hentBransjeSykefraværsstatistikk?.right()
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
