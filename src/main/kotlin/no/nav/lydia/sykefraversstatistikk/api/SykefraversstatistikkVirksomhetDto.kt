package no.nav.lydia.sykefraversstatistikk.api

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.sykefraversstatistikk.api.geografi.Kommune
import no.nav.lydia.sykefraversstatistikk.domene.SykefraversstatistikkVirksomhet

@Serializable
data class SykefraversstatistikkVirksomhetDto(
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
    val eidAv: String?
) {

    companion object {
        fun List<SykefraversstatistikkVirksomhet>.toDto(): List<SykefraversstatistikkVirksomhetDto> =
            this.map { it.toDto() }
        
        fun SykefraversstatistikkVirksomhet.toDto() : SykefraversstatistikkVirksomhetDto =
            SykefraversstatistikkVirksomhetDto(
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
                eidAv = this.eidAv
            )
    }
}
