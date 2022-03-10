package no.nav.lydia.ia.sak

import java.time.LocalDateTime

class IASak(
    val saksnummer: String,
    val orgnr: String,
    val type: IASakstype,
    val status: IAProsessStatus,
    val opprettet: LocalDateTime,
    val opprettet_av: String,
    val endret: LocalDateTime?,
    val endretAv: String?
) {
}

enum class IAProsessStatus {
  PRIORITERT,
  TAKKET_NEI,
  KARTLEGGING,
  GJENNOMFORING,
  EVALUERING,
  AVSLUTTET
}

enum class IASakstype {
    NAV_STOTTER,
    SELVBETJENT
}
