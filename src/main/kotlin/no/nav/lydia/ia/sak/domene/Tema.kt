package no.nav.lydia.ia.sak.domene

import kotlinx.datetime.LocalDateTime


data class Tema(
	val id: Int,
	val navn: Temanavn,
	val beskrivelse: String,
	val introtekst: String,
	val status: TemaStatus,
	val sistEndret: LocalDateTime
)

enum class Temanavn {
	UTVIKLE_PARTSSAMARBEID, REDUSERE_SYKEFRAVÆR
}

enum class TemaStatus {
	AKTIV, INAKTIV
}
