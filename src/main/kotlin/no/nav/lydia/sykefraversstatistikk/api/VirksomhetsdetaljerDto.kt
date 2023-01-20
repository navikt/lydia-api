package no.nav.lydia.sykefraversstatistikk.api

import kotlinx.datetime.LocalDate
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.sykefraversstatistikk.api.KvartalDto.Companion.toDto
import no.nav.lydia.sykefraversstatistikk.api.geografi.Kommune
import no.nav.lydia.sykefraversstatistikk.domene.Virksomhetsdetaljer
import no.nav.lydia.sykefraversstatistikk.import.Kvartal

@Serializable
data class VirksomhetsdetaljerDto(
    val orgnr: String,
    val virksomhetsnavn: String,
    val kommune: Kommune,
    val sektor: String,
    val neringsgruppe: String,
    val arstall: Int,
    val kvartal: Int,
    val sykefraversprosent: Double,
    val antallPersoner: Int,
    val muligeDagsverk: Double,
    val tapteDagsverk: Double,
    val status: IAProsessStatus,
    val eidAv: String?,
    val sistEndret: LocalDate?,
    val antallKvartaler: Int?,
    val kvartaler: List<KvartalDto>,
) {

    companion object {
        fun List<Virksomhetsdetaljer>.toDto(): List<VirksomhetsdetaljerDto> =
            this.map { it.toDto() }

        fun Virksomhetsdetaljer.toDto() : VirksomhetsdetaljerDto =
            VirksomhetsdetaljerDto(
                orgnr = this.orgnr,
                virksomhetsnavn = this.virksomhetsnavn,
                kommune = this.kommune,
                sektor = "",
                neringsgruppe = "",
                arstall = this.arstall,
                kvartal = this.kvartal,
                sykefraversprosent = this.sykefraversprosent,
                antallPersoner = this.antallPersoner.toInt(),
                muligeDagsverk = this.muligeDagsverk,
                tapteDagsverk = this.tapteDagsverk,
                status = this.status ?: IAProsessStatus.IKKE_AKTIV,
                eidAv = this.eidAv,
                sistEndret = this.sistEndret,
                antallKvartaler = this.antallKvartaler,
                kvartaler = this.kvartaler.toDto(),
            )
    }
}

@Serializable
data class KvartalDto(val kvartal: Int, val årstall: Int) {
    companion object {
        fun List<Kvartal>.toDto(): List<KvartalDto> =
            this.map { it.toDto() }

        fun Kvartal.toDto(): KvartalDto =
            KvartalDto(
                kvartal = this.kvartal,
                årstall = this.årstall,
            )
    }
}

@Serializable
class KvartalerFraTilDto(val fra: KvartalDto, val til: KvartalDto)
