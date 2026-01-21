package no.nav.fia.dokument.publisering.pdfgen

enum class PdfType(
    val pathIPiaPdfgen: String,
) {
    BEHOVSVURDERING(pathIPiaPdfgen = "behovsvurdering"),
    SAMARBEIDSPLAN(pathIPiaPdfgen = "samarbeidsplan"),
    EVALUERING(pathIPiaPdfgen = "evaluering"),
}
