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

data class BehandletImportGradertSykmeldingSiste4Kvartal(
    val publisertÅrstall: Int,
    val publisertKvartal: Int,
    val kode: String,
    val prosent: Double?,
    val tapteDagsverkGradert: Double?,
    val tapteDagsverk: Double?,
    val erMaskert: Boolean,
    val kvartaler: List<Kvartal>
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

fun GradertSykemeldingImportDto.tilBehandletImportGradertSykmeldingSiste4Kvartal() =
    BehandletImportGradertSykmeldingSiste4Kvartal(
        publisertÅrstall = this.sistePubliserteKvartal.årstall,
        publisertKvartal = this.sistePubliserteKvartal.kvartal,
        kode = this.kode,
        prosent = if (this.siste4Kvartal.erMaskert) 0.0 else this.siste4Kvartal.prosent,
        tapteDagsverkGradert = if (this.siste4Kvartal.erMaskert) 0.0 else this.siste4Kvartal.tapteDagsverkGradert,
        tapteDagsverk = if (this.siste4Kvartal.erMaskert) 0.0 else this.siste4Kvartal.tapteDagsverk,
        erMaskert = this.siste4Kvartal.erMaskert,
        kvartaler = this.siste4Kvartal.kvartaler
    )

fun List<GradertSykemeldingImportDto>.tilBehandletImportGradertSykmelding() =
    this.map {
        it.tilBehandletImportGradertSykmelding()
    }

fun List<GradertSykemeldingImportDto>.tilBehandletImportGradertSykmeldingSiste4Kvartal() =
    this.map {
        it.tilBehandletImportGradertSykmeldingSiste4Kvartal()
    }
