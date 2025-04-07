package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import kotlinx.datetime.LocalDateTime

data class TemaInfo(
    val id: Int,
    val navn: String,
    val status: TemaStatus,
    val rekkefølge: Int,
    val sistEndret: LocalDateTime,
    val undertemaer: List<UndertemaInfo>,
)

data class UndertemaInfo(
    val id: Int,
    val navn: String,
    val status: TemaStatus,
    val rekkefølge: Int,
)
