package no.nav.lydia.ia.sak.domene

import java.time.LocalDateTime

class IASak(
    val saksnummer: String,
    val orgnr: String,
    val type: IASakstype,
    val opprettet: LocalDateTime,
    val opprettet_av: String,
    var endret: LocalDateTime?,
    var endretAv: String?,
    var tilstand: ProsessTilstand = StartTilstand()
) {
    val status: IAProsessStatus
        get() = tilstand.status

}

abstract class ProsessTilstand(val status: IAProsessStatus) {
    open fun IASak.prioritert(navIdent: String) {
        throw IllegalStateException()
    }

    companion object {
        fun iStatus(status: IAProsessStatus): ProsessTilstand {
            return when (status) {
                IAProsessStatus.NY -> StartTilstand()
                IAProsessStatus.PRIORITERT -> PrioritertTilstand()
                else -> throw IllegalStateException()
            }
        }
    }
}

class StartTilstand : ProsessTilstand(
    status = IAProsessStatus.NY
) {
    override fun IASak.prioritert(navIdent: String) {
        tilstand = PrioritertTilstand()
        endretAv = navIdent
        endret = LocalDateTime.now()
    }
}

class PrioritertTilstand : ProsessTilstand(
    status = IAProsessStatus.PRIORITERT
) {

}

enum class IAProsessStatus {
    NY,
    PRIORITERT,
    TAKKET_NEI,
    KARTLEGGING,
    GJENNOMFORING,
    EVALUERING,
    AVSLUTTET;

    companion object {
        fun avsluttedeStatuser() = listOf(TAKKET_NEI, AVSLUTTET)
    }
}

enum class IASakstype {
    NAV_STOTTER,
    SELVBETJENT
}
