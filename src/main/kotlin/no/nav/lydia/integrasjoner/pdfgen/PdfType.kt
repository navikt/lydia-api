package no.nav.fia.dokument.publisering.pdfgen

enum class PdfType(
    val pathIPiaPdfgen: String,
) {
    KARTLEGGINGRESULTAT(pathIPiaPdfgen = "kartleggingresultat"),
    BEHOVSVURDERING(pathIPiaPdfgen = "behovsvurdering"),
    SAMARBEIDSPLAN(pathIPiaPdfgen = "samarbeidsplan"),
    EVALUERING(pathIPiaPdfgen = "evaluering"),
}
