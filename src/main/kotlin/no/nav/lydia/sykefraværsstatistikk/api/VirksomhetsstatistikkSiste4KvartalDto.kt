package no.nav.lydia.sykefraværsstatistikk.api

import kotlinx.serialization.Serializable
import no.nav.lydia.sykefraværsstatistikk.api.KvartalDto.Companion.toDto
import no.nav.lydia.sykefraværsstatistikk.domene.VirksomhetsstatistikkSiste4Kvartal
import no.nav.lydia.sykefraværsstatistikk.import.Kvartal

@Serializable
data class VirksomhetsstatistikkSiste4KvartalDto(
    val orgnr: String,
    val sykefraværsprosent: Double,
    val graderingsprosent: Double?,
    val muligeDagsverk: Double,
    val tapteDagsverk: Double,
    val tapteDagsverkGradert: Double?,
    val antallKvartaler: Int?,
    val kvartaler: List<KvartalDto>,
) {
    companion object {
        fun VirksomhetsstatistikkSiste4Kvartal.toDto(): VirksomhetsstatistikkSiste4KvartalDto =
            VirksomhetsstatistikkSiste4KvartalDto(
                orgnr = this.orgnr,
                sykefraværsprosent = this.sykefraværsprosent,
                graderingsprosent = this.graderingsprosent,
                muligeDagsverk = this.muligeDagsverk,
                tapteDagsverk = this.tapteDagsverk,
                tapteDagsverkGradert = this.tapteDagsverkGradert,
                antallKvartaler = this.antallKvartaler,
                kvartaler = this.kvartaler.toDto(),
            )
    }
}

@Serializable
data class KvartalDto(
    val kvartal: Int,
    val årstall: Int,
) {
    companion object {
        fun List<Kvartal>.toDto(): List<KvartalDto> = this.map { it.toDto() }

        fun Kvartal.toDto(): KvartalDto =
            KvartalDto(
                kvartal = this.kvartal,
                årstall = this.årstall,
            )
    }
}

@Serializable
class KvartalerFraTilDto(
    val fra: KvartalDto,
    val til: KvartalDto,
)
