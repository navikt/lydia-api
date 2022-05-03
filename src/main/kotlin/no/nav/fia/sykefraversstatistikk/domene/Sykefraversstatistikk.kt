package no.nav.fia.sykefraversstatistikk.domene

import no.nav.fia.ia.sak.domene.IAProsessStatus
import no.nav.fia.sykefraversstatistikk.api.geografi.Kommune
import java.time.LocalDateTime

class SykefraversstatistikkVirksomhet(
    val virksomhetsnavn: String,
    val kommune: Kommune,
    val orgnr: String,
    val arstall: Int,
    val kvartal: Int,
    val antallPersoner: Double,
    val tapteDagsverk: Double,
    val muligeDagsverk: Double,
    val sykefraversprosent: Double,
    val maskert: Boolean,
    val opprettet: LocalDateTime,
    val status: IAProsessStatus?,
    val eidAv: String?
)
