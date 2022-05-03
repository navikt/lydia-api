package no.nav.lydia.ia.grunnlag

import no.nav.lydia.sykefraversstatistikk.domene.SykefraversstatistikkVirksomhet
import java.time.LocalDateTime

class SykefraversstatistikkGrunnlag(
    val saksnummer: String,
    val hendelseId: String,
    val orgnr: String,
    val arstall: Int,
    val kvartal: Int,
    val antallPersoner: Double,
    val tapteDagsverk: Double,
    val muligeDagsverk: Double,
    val sykefraversprosent: Double,
    val maskert: Boolean,
    val opprettet: LocalDateTime,
) {
    companion object {
        fun from(
            saksnummer: String,
            hendelseId: String,
            sykefraværsstatistikkListe: List<SykefraversstatistikkVirksomhet>
        ): List<SykefraversstatistikkGrunnlag> = sykefraværsstatistikkListe.map {
            from(saksnummer = saksnummer, hendelseId = hendelseId, sykefraværsstatistikk = it)
        }

        fun from(
            saksnummer: String,
            hendelseId: String,
            sykefraværsstatistikk: SykefraversstatistikkVirksomhet
        ): SykefraversstatistikkGrunnlag = SykefraversstatistikkGrunnlag(
            saksnummer = saksnummer,
            hendelseId = hendelseId,
            orgnr = sykefraværsstatistikk.orgnr,
            arstall = sykefraværsstatistikk.arstall,
            kvartal = sykefraværsstatistikk.kvartal,
            antallPersoner = sykefraværsstatistikk.antallPersoner,
            tapteDagsverk = sykefraværsstatistikk.tapteDagsverk,
            muligeDagsverk = sykefraværsstatistikk.muligeDagsverk,
            sykefraversprosent = sykefraværsstatistikk.sykefraversprosent,
            maskert = sykefraværsstatistikk.maskert,
            opprettet = sykefraværsstatistikk.opprettet,
        )
    }
}
