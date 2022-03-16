package no.nav.lydia.ia.sak.domene

import no.nav.lydia.ia.sak.domene.SaksHendelsestype.VIRKSOMHET_PRIORITERES
import java.time.LocalDateTime

class IASak(
    val saksnummer: String,
    val orgnr: String,
    val type: IASakstype,
    val opprettet: LocalDateTime,
    val opprettet_av: String,
    var endret: LocalDateTime?,
    var endretAv: String?,
    status: IAProsessStatus
) {
    private var tilstand: ProsessTilstand

    init {
        tilstand = this.iStatus(status)
    }

    val status: IAProsessStatus
        get() = tilstand.status

    fun behandleHendelse(hendelse: IASakshendelse) {
        when (hendelse.type) {
            VIRKSOMHET_PRIORITERES -> {
                tilstand.prioritert(hendelse.navIdent)
            }
            else -> {
                throw IllegalStateException("Ikke en gyldig hendelsestype")
            }
        }
    }


    private abstract inner class ProsessTilstand(val status: IAProsessStatus) {
        open fun prioritert(navIdent: String) {
            throw IllegalStateException()
        }
    }

    private inner class StartTilstand : ProsessTilstand(
        status = IAProsessStatus.NY
    ) {
        override fun prioritert(navIdent: String) {
            tilstand = PrioritertTilstand()
            endretAv = navIdent
            endret = LocalDateTime.now()
        }
    }

    private inner class PrioritertTilstand : ProsessTilstand(
        status = IAProsessStatus.PRIORITERT
    ) {

    }

    companion object {
        private fun IASak.iStatus(status: IAProsessStatus): ProsessTilstand {
            return when (status) {
                IAProsessStatus.NY -> StartTilstand()
                IAProsessStatus.PRIORITERT -> PrioritertTilstand()
                else -> throw IllegalStateException()
            }
        }
    }
}



enum class IAProsessStatus {
    NY,
    PRIORITERT,
    TAKKET_NEI,
    KARTLEGGING,
    GJENNOMFORING,
    EVALUERING,
    AVSLUTTET,
    IKKE_AKTIV;

    companion object {
        fun avsluttedeStatuser() = listOf(TAKKET_NEI, AVSLUTTET)
    }
}

enum class IASakstype {
    NAV_STOTTER,
    SELVBETJENT
}
