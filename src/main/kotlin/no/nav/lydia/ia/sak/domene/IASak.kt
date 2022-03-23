package no.nav.lydia.ia.sak.domene

import no.nav.lydia.ia.sak.domene.SaksHendelsestype.VIRKSOMHET_PRIORITERES
import no.nav.lydia.ia.sak.domene.SaksHendelsestype.VIRKSOMHET_TAKKER_NEI
import org.slf4j.LoggerFactory
import java.time.LocalDateTime

class IASak(
    val saksnummer: String,
    val orgnr: String,
    val type: IASakstype,
    val opprettet: LocalDateTime,
    val opprettetAv: String,
    var endret: LocalDateTime?,
    var endretAv: String?,
    var endretAvHendelseId: String,
    status: IAProsessStatus
) {
    private var tilstand: ProsessTilstand
    private val log = LoggerFactory.getLogger(this.javaClass)

    init {
        tilstand = this.iStatus(status)
    }

    val status: IAProsessStatus
        get() = tilstand.status

    fun behandleHendelse(hendelse: IASakshendelse) : IASak {
        when (hendelse.type) {
            VIRKSOMHET_PRIORITERES -> {
                tilstand.prioritert()
            }
            VIRKSOMHET_TAKKER_NEI -> {
                tilstand.takketNei()
            }
            else -> {
                throw IllegalStateException("Ikke en gyldig hendelsestype")
            }
        }
        endretAvHendelseId = hendelse.id
        endretAv = hendelse.opprettetAv
        endret = hendelse.opprettetTidspunkt

        return this
    }

    private fun håndterFeilState(){
        log.info("Feil i systemet")
        log.info(this.status.name)
        throw IllegalStateException()
    }

    private abstract inner class ProsessTilstand(val status: IAProsessStatus) {
        open fun prioritert() {
            håndterFeilState()
        }
        open fun takketNei() {

            håndterFeilState()
        }
    }

    private inner class StartTilstand : ProsessTilstand(
        status = IAProsessStatus.NY
    ) {
        override fun prioritert() {
            tilstand = PrioritertTilstand()
        }
    }

    private inner class PrioritertTilstand : ProsessTilstand(
        status = IAProsessStatus.PRIORITERT
    ) {
        override fun takketNei() {
            tilstand = TakketNeiTilstand()
        }
    }

    private inner class TakketNeiTilstand : ProsessTilstand(
        status = IAProsessStatus.TAKKET_NEI
    )

    companion object {
        private fun IASak.iStatus(status: IAProsessStatus): ProsessTilstand {
            return when (status) {
                IAProsessStatus.NY -> StartTilstand()
                IAProsessStatus.PRIORITERT -> PrioritertTilstand()
                else -> throw IllegalStateException()
            }
        }

        fun fraHendelser(hendelser: List<IASakshendelse>): IASak {
            val førsteHendelse = hendelser.first()
            val resterendeHendelser = hendelser.minus(førsteHendelse)
            val sak = IASak(
                saksnummer = førsteHendelse.saksnummer,
                orgnr = førsteHendelse.orgnummer,
                type = IASakstype.NAV_STOTTER,
                opprettet = førsteHendelse.opprettetTidspunkt,
                opprettetAv = førsteHendelse.opprettetAv,
                endret = null,
                endretAv = null,
                endretAvHendelseId = førsteHendelse.id,
                status = IAProsessStatus.NY
            )
            resterendeHendelser.forEach(sak::behandleHendelse)
            return sak
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
