package no.nav.lydia.sykefraversstatistikk.api

import kotlinx.serialization.Serializable

@Serializable
data class SykefraversstatistikkVirksomhetDto(
    val orgnr: String,
    val virksomhetsnavn: String,
    val sektor: String,
    val neringsgruppe: String,
    val arstall: String,
    val kvartal: String,
    val sykefraversprosent: String,
    val antallPersoner: String,
    val muligeDagsverk: String,
    val tapteDagsverk: String
) {
    companion object {
        val dummySvar = SykefraversstatistikkVirksomhetDto(
            orgnr = "123456789",
            virksomhetsnavn = "Sinnasnekkern",
            sektor = "Bygg og anlegg",
            neringsgruppe = "F - Bygge- og anleggsvirksomhet",
            arstall = "2021",
            kvartal = "4",
            sykefraversprosent = "2.0",
            antallPersoner = "10",
            muligeDagsverk = "500.0",
            tapteDagsverk = "10.0",
        )
    }
}