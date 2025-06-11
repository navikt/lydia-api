package no.nav.lydia.sykefraværsstatistikk.api

import kotlinx.datetime.LocalDate
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.sykefraværsstatistikk.domene.Virksomhetsoversikt

@Serializable
data class VirksomhetsoversiktDto(
    val orgnr: String,
    val saksnummer: String? = null,
    val virksomhetsnavn: String,
    val sektor: String,
    val neringsgruppe: String,
    val arstall: Int,
    val kvartal: Int,
    val sykefraværsprosent: Double,
    val antallPersoner: Int,
    val muligeDagsverk: Double,
    val tapteDagsverk: Double,
    val status: IASak.Status,
    val eidAv: String?,
    val sistEndret: LocalDate?,
) {
    companion object {
        fun List<Virksomhetsoversikt>.toDto(): List<VirksomhetsoversiktDto> = this.map { it.toDto() }

        fun Virksomhetsoversikt.toDto(): VirksomhetsoversiktDto =
            VirksomhetsoversiktDto(
                orgnr = this.orgnr,
                saksnummer = this.saksnummer,
                virksomhetsnavn = this.virksomhetsnavn,
                sektor = "",
                neringsgruppe = "",
                arstall = this.arstall,
                kvartal = this.kvartal,
                sykefraværsprosent = this.sykefraværsprosent,
                antallPersoner = this.antallPersoner.toInt(),
                muligeDagsverk = this.muligeDagsverk,
                tapteDagsverk = this.tapteDagsverk,
                status = this.status ?: IASak.Status.IKKE_AKTIV,
                eidAv = this.eidAv,
                sistEndret = this.sistEndret,
            )
    }
}
