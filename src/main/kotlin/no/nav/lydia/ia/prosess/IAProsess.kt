package no.nav.lydia.ia.prosess

import java.time.LocalDateTime

class IAProsess(
    val id: String,
    val orgnr: String,
    val type: IAProsessType,
    val status: IAProsessStatus,
    val opprettet: LocalDateTime,
    val opprettet_av: String
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

enum class IAProsessType {
    NAV_STOTTER,
    SELVBETJENT
}
