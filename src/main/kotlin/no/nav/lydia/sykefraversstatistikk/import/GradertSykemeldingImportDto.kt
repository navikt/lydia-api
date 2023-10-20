package no.nav.lydia.sykefraversstatistikk.import

data class GradertSykemeldingImportDto(
        val kategori: Kategori,
        val kode: String,
        val sistePubliserteKvartal: GraderingSistePubliserteKvartal,
        val siste4Kvartal: GraderingSiste4Kvartal,
)

data class GraderingSistePubliserteKvartal(
        val årstall: Int,
        val kvartal: Int,
        val prosent: Double?,
        val tapteDagsverkGradert: Double?,
        val tapteDagsverk: Double?,
        val antallPersoner: Int?,
        val erMaskert: Boolean
)

data class GraderingSiste4Kvartal(
        val prosent: Double?,
        val tapteDagsverkGradert: Double?,
        val tapteDagsverk: Double?,
        val erMaskert: Boolean,
        val kvartaler: List<Kvartal>
)

