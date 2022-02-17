package no.nav.lydia.sykefraversstatistikk.api

import kotlinx.serialization.Serializable
import no.nav.lydia.sykefraversstatistikk.api.geografi.Kommune
import no.nav.lydia.sykefraversstatistikk.domene.SykefraversstatistikkVirksomhet

@Serializable
data class SykefraversstatistikkVirksomhetDto(
    val orgnr: String,
    val virksomhetsnavn: String?,
    val kommune: Kommune?,
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
            kommune = Kommune("Oslo", "0301"),
            sektor = "Bygg og anlegg",
            neringsgruppe = "F - Bygge- og anleggsvirksomhet",
            arstall = "2021",
            kvartal = "4",
            sykefraversprosent = "2.0",
            antallPersoner = "10",
            muligeDagsverk = "500.0",
            tapteDagsverk = "10.0",
        )

        fun List<SykefraversstatistikkVirksomhet>.toDto(): List<SykefraversstatistikkVirksomhetDto> =
            this.map { it.toDto() }
        
        fun SykefraversstatistikkVirksomhet.toDto() : SykefraversstatistikkVirksomhetDto =
            SykefraversstatistikkVirksomhetDto(
                orgnr = this.orgnr,
                virksomhetsnavn = this.virksomhetsnavn,
                kommune = this.kommune,
                sektor = "",
                neringsgruppe = "",
                arstall = this.arstall.toString(),
                kvartal = this.kvartal.toString(),
                sykefraversprosent = this.sykefraversprosent.toString(),
                antallPersoner = this.antallPersoner.toString(),
                muligeDagsverk = this.muligeDagsverk.toString(),
                tapteDagsverk = this.tapteDagsverk.toString()
            )
    }
}