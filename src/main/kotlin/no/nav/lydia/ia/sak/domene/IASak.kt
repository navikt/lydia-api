package no.nav.lydia.ia.sak.domene

import no.nav.lydia.ia.sak.domene.SaksHendelsestype.VIRKSOMHET_VURDERES
import no.nav.lydia.ia.sak.domene.SaksHendelsestype.VIRKSOMHET_ER_IKKE_AKTUELL
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

    fun behandleHendelse(hendelse: IASakshendelse): IASak {
        when (hendelse.type) {
            VIRKSOMHET_VURDERES -> {
                tilstand.vurderes()
            }
            VIRKSOMHET_ER_IKKE_AKTUELL -> {
                tilstand.ikkeAktuell()
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

    private fun håndterFeilState() {
        log.info("Feil i systemet")
        log.info(this.status.name)
        throw IllegalStateException()
    }

    private abstract inner class ProsessTilstand(val status: IAProsessStatus) {
        open fun vurderes() {
            håndterFeilState()
        }

        open fun ikkeAktuell() {
            håndterFeilState()
        }
    }

    private inner class StartTilstand : ProsessTilstand(
        status = IAProsessStatus.NY
    ) {
        override fun vurderes() {
            tilstand = VurderesTilstand()
        }
    }

    private inner class VurderesTilstand : ProsessTilstand(
        status = IAProsessStatus.VURDERES
    ) {
        override fun ikkeAktuell() {
            tilstand = IkkeAktuellTilstand()
        }
    }

    private inner class IkkeAktuellTilstand : ProsessTilstand(
        status = IAProsessStatus.IKKE_AKTUELL
    )

    companion object {
        private fun IASak.iStatus(status: IAProsessStatus): ProsessTilstand {
            return when (status) {
                IAProsessStatus.NY -> StartTilstand()
                IAProsessStatus.VURDERES -> VurderesTilstand()
                IAProsessStatus.IKKE_AKTUELL -> IkkeAktuellTilstand()
                else -> throw IllegalStateException()
            }
        }

        fun fraHendelser(hendelser: List<IASakshendelse>): IASak {
            val førsteHendelse = hendelser.first()
            val resterendeHendelser = hendelser.minus(førsteHendelse)
            val sak = IASak(
                saksnummer = førsteHendelse.saksnummer,
                orgnr = førsteHendelse.orgnummer,
                type = IASakstype.NAV_STOTTER, // TODO: skal ligge på hendelsen
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
    IKKE_AKTIV,
    VURDERES,
    KONTAKTES,
    IKKE_AKTUELL;

    companion object {
        fun filtrerbareStatuser() = listOf(
            IKKE_AKTIV,
            VURDERES,
            KONTAKTES,
            IKKE_AKTUELL
        )
    }
}

enum class IASakstype {
    NAV_STOTTER,
    SELVBETJENT
}
