package no.nav.lydia.sykefraversstatistikk.import

import no.nav.lydia.sykefraversstatistikk.import.BehandletKvartalsvisSykefraværsstatistikk.Companion.MIN_ANTALL_PERS_FOR_AT_STATISTIKKEN_IKKE_ER_PERSONOPPLYSNINGER

data class BehandletImportGradertSykmelding (
    val årstall: Int,
    val kvartal: Int,
    val kode: String,
    val prosent: Double?,
    val tapteDagsverkGradert: Double?,
    val tapteDagsverk: Double?,
    val antallPersoner: Int?,
    val erMaskert: Boolean
)

fun GradertSykemeldingImportDto.skalMaskeres() =
    this.sistePubliserteKvartal.erMaskert
            || this.sistePubliserteKvartal.antallPersoner == null
            || this.sistePubliserteKvartal.antallPersoner < MIN_ANTALL_PERS_FOR_AT_STATISTIKKEN_IKKE_ER_PERSONOPPLYSNINGER

fun GradertSykemeldingImportDto.tilBehandletImportGradertSykmelding() =
    BehandletImportGradertSykmelding(
        årstall = this.sistePubliserteKvartal.årstall,
        kvartal = this.sistePubliserteKvartal.kvartal,
        kode = this.kode,
        prosent = if (this.skalMaskeres()) 0.0 else this.sistePubliserteKvartal.prosent,
        tapteDagsverkGradert = if (this.skalMaskeres()) 0.0 else this.sistePubliserteKvartal.tapteDagsverkGradert,
        tapteDagsverk = if (this.skalMaskeres()) 0.0 else this.sistePubliserteKvartal.tapteDagsverk,
        antallPersoner = this.sistePubliserteKvartal.antallPersoner,
        erMaskert = this.skalMaskeres()
    )

fun List<GradertSykemeldingImportDto>.tilBehandletImportGradertSykmelding() =
    this.map {
        it.tilBehandletImportGradertSykmelding()
    }
