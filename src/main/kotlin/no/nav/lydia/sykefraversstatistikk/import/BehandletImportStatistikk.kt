package no.nav.lydia.sykefraversstatistikk.import

import no.nav.lydia.sykefraversstatistikk.import.BehandletLandSykefraværsstatistikk.Companion.tilBehandletStatistikk
import no.nav.lydia.sykefraversstatistikk.import.BehandletNæringSykefraværsstatistikk.Companion.tilBehandletStatistikk
import no.nav.lydia.sykefraversstatistikk.import.BehandletNæringsundergruppeSykefraværsstatistikk.Companion.tilBehandletStatistikk
import no.nav.lydia.sykefraversstatistikk.import.BehandletSektorSykefraværsstatistikk.Companion.tilBehandletStatistikk
import no.nav.lydia.sykefraversstatistikk.import.BehandletVirksomhetSykefraværsstatistikk.Companion.tilBehandletStatistikk

sealed class BehandletKvartalsvisSykefraværsstatistikk constructor(
    open val statistikk: KvartalsvisSykefraværsstatistikk
) {
    val kvartal
        get() = statistikk.kvartal
    val årstall
        get() = statistikk.årstall
    val antallPersoner
        get() = statistikk.antallPersoner
    val maskert
        get() = statistikk.skalMaskeres()
    val prosent
        get() = if (statistikk.skalMaskeres()) 0.0 else statistikk.prosent
    val muligeDagsverk
        get() = if (statistikk.skalMaskeres()) 0.0 else statistikk.muligeDagsverk
    val tapteDagsverk
        get() = if (statistikk.skalMaskeres()) 0.0 else statistikk.tapteDagsverk
    val kategori
        get() = statistikk.kategori

    private fun KvartalsvisSykefraværsstatistikk.skalMaskeres() =
        maskert || antallPersoner < MIN_ANTALL_PERS_FOR_AT_STATISTIKKEN_IKKE_ER_PERSONOPPLYSNINGER

    companion object {
        val MIN_ANTALL_PERS_FOR_AT_STATISTIKKEN_IKKE_ER_PERSONOPPLYSNINGER = 5
    }
}

class BehandletLandSykefraværsstatistikk constructor(
    override val statistikk: LandSykefravær
) : BehandletKvartalsvisSykefraværsstatistikk(statistikk) {
    val land
        get() = statistikk.kode

    companion object {
        fun LandSykefravær.tilBehandletStatistikk() = BehandletLandSykefraværsstatistikk(this)
    }
}

class BehandletNæringSykefraværsstatistikk constructor(
    override val statistikk: NæringSykefravær
) : BehandletKvartalsvisSykefraværsstatistikk(statistikk) {
    val næring
        get() = statistikk.kode

    companion object {
        fun NæringSykefravær.tilBehandletStatistikk() = BehandletNæringSykefraværsstatistikk(this)
    }
}

class BehandletNæringsundergruppeSykefraværsstatistikk constructor(
    override val statistikk: NæringsundergruppeSykefravær
) : BehandletKvartalsvisSykefraværsstatistikk(statistikk) {
    val næringsundergruppe
        get() = statistikk.kode

    companion object {
        fun NæringsundergruppeSykefravær.tilBehandletStatistikk() = BehandletNæringsundergruppeSykefraværsstatistikk(this)
    }
}

class BehandletSektorSykefraværsstatistikk constructor(
    override val statistikk: SektorSykefravær
) : BehandletKvartalsvisSykefraværsstatistikk(statistikk) {
    val sektor
        get() = statistikk.kode

    companion object {
        fun SektorSykefravær.tilBehandletStatistikk() = BehandletSektorSykefraværsstatistikk(this)
    }
}

class BehandletVirksomhetSykefraværsstatistikk constructor(
    override val statistikk: SykefraværsstatistikkForVirksomhet
) : BehandletKvartalsvisSykefraværsstatistikk(statistikk) {
    val orgnr
        get() = statistikk.orgnr

    companion object {
        fun SykefraværsstatistikkForVirksomhet.tilBehandletStatistikk() = BehandletVirksomhetSykefraværsstatistikk(this)
    }
}

data class BehandletImportStatistikk constructor(
    val næringSykefravær: BehandletNæringSykefraværsstatistikk,
    val næring5SifferSykefravær: List<BehandletNæringsundergruppeSykefraværsstatistikk>,
    val virksomhetSykefravær: BehandletVirksomhetSykefraværsstatistikk,
    val landSykefravær: BehandletLandSykefraværsstatistikk,
    val sektorSykefravær: BehandletSektorSykefraværsstatistikk
) {
    companion object {
        fun SykefraversstatistikkImportDto.tilBehandletStatistikk() =
            BehandletImportStatistikk(
                næringSykefravær = this.næringSykefravær.tilBehandletStatistikk(),
                næring5SifferSykefravær = this.næring5SifferSykefravær.map { it.tilBehandletStatistikk() },
                virksomhetSykefravær = this.virksomhetSykefravær.tilBehandletStatistikk(),
                landSykefravær = this.landSykefravær.tilBehandletStatistikk(),
                sektorSykefravær = this.sektorSykefravær.tilBehandletStatistikk(),
            )

        fun List<SykefraversstatistikkImportDto>.tilBehandletStatistikk() =
            this.map { it.tilBehandletStatistikk() }
    }
}
