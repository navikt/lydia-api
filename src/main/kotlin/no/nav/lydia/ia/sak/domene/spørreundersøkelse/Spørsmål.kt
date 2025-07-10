package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import java.util.UUID

data class Spørsmål(
    val id: UUID,
    val tekst: String,
    val rekkefølge: Int,
    val antallSvar: Int,
    val svaralternativer: List<Svaralternativ>,
    val flervalg: Boolean,
) {
    fun svaralternativerHørerTilSpørsmål(svarIder: List<UUID>): Boolean = svaralternativer.map { it.id }.toList().containsAll(svarIder)
}
