package no.nav.lydia.ia.sak.domene

import no.nav.lydia.ia.sak.domene.SaksHendelsestype.*
import org.slf4j.LoggerFactory
import java.time.LocalDateTime

class IASak(
    val saksnummer: String,
    val orgnr: String,
    val type: IASakstype,
    val opprettet: LocalDateTime,
    val opprettetAv: String,
    var eidAv: String?,
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
        when (hendelse.hendelsesType) {
            VIRKSOMHET_VURDERES -> {
                tilstand.vurderes()
            }
            VIRKSOMHET_ER_IKKE_AKTUELL -> {
                tilstand.ikkeAktuell()
            }
            VIRKSOMHET_SKAL_KONTAKTES -> {
                tilstand.kontaktes()
            }
            TA_EIERSKAP_I_SAK -> {
                eidAv = hendelse.opprettetAv
            }
            OPPRETT_SAK_FOR_VIRKSOMHET -> {
                throw IllegalStateException("Ikke en gyldig hendelsestype")
            }
        }
        endretAvHendelseId = hendelse.id
        endretAv = hendelse.opprettetAv
        endret = hendelse.opprettetTidspunkt

        return this
    }

    private fun håndterFeilState(grunn : String = "Feil i systemet") {
        log.info(grunn)
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

        open fun kontaktes() {
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

        override fun kontaktes() {
            if (eidAv.isNullOrEmpty()){
                håndterFeilState("En virksomhet kan ikke kontaktes før saken har en eier")
            }
            tilstand = KontaktesTilstand()
        }
    }
    private inner class KontaktesTilstand : ProsessTilstand(
        status = IAProsessStatus.KONTAKTES
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
                IAProsessStatus.KONTAKTES -> KontaktesTilstand()
                IAProsessStatus.IKKE_AKTIV -> throw IllegalStateException()
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
                eidAv = null,
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
