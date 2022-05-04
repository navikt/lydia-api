package no.nav.lydia.ia.sak.domene

import no.nav.lydia.ia.grunnlag.GrunnlagService
import no.nav.lydia.ia.sak.domene.SaksHendelsestype.OPPRETT_SAK_FOR_VIRKSOMHET
import no.nav.lydia.ia.sak.domene.SaksHendelsestype.TA_EIERSKAP_I_SAK
import no.nav.lydia.ia.sak.domene.SaksHendelsestype.VIRKSOMHET_ER_IKKE_AKTUELL
import no.nav.lydia.ia.sak.domene.SaksHendelsestype.VIRKSOMHET_SKAL_KONTAKTES
import no.nav.lydia.ia.sak.domene.SaksHendelsestype.VIRKSOMHET_VURDERES
import no.nav.lydia.tilgangskontroll.Rådgiver
import no.nav.lydia.tilgangskontroll.Rådgiver.Rolle.LESE
import no.nav.lydia.tilgangskontroll.Rådgiver.Rolle.SAKSBEHANDLER
import no.nav.lydia.tilgangskontroll.Rådgiver.Rolle.SUPERBRUKER
import org.slf4j.LoggerFactory
import java.time.LocalDateTime

class IASak(
    val saksnummer: String,
    val orgnr: String,
    val type: IASakstype,
    val opprettetTidspunkt: LocalDateTime,
    val opprettetAv: String,
    var eidAv: String?,
    var endretTidspunkt: LocalDateTime?,
    var endretAv: String?,
    var endretAvHendelseId: String,
    status: IAProsessStatus,
) {
    private var tilstand: ProsessTilstand
    private val log = LoggerFactory.getLogger(this.javaClass)

    init {
        tilstand = this.iStatus(status)
    }

    val status: IAProsessStatus
        get() = tilstand.status

    fun lagreGrunnlag(grunnlagService: GrunnlagService) = tilstand.lagreGrunnlag(grunnlagService)

    fun gyldigeNesteHendelser(rådgiver: Rådgiver) = tilstand.gyldigeNesteHendelser(rådgiver)

    fun kanUtføreHendelse(saksHendelsestype: SaksHendelsestype, rådgiver: Rådgiver) = gyldigeNesteHendelser(rådgiver).contains(saksHendelsestype)

    private fun erEierAvSak(rådgiver: Rådgiver) = eidAv == rådgiver.navIdent

    fun behandleHendelse(hendelse: AvslagsHendelse): IASak {
        tilstand.behandleHendelse(hendelse = hendelse)

        return this
    }

    fun behandleHendelse(hendelse: IASakshendelse): IASak {
        when (hendelse.hendelsesType) {
            VIRKSOMHET_VURDERES -> {
                tilstand.vurderes()
            }
            VIRKSOMHET_ER_IKKE_AKTUELL -> {
                throw IllegalStateException("Burde ikke behnadle en IKKE_AKTUELL hendelse her")
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
        endretTidspunkt = hendelse.opprettetTidspunkt

        return this
    }

    private fun håndterFeilState(grunn: String = "Feil i systemet") {
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

        open fun behandleHendelse(hendelse: AvslagsHendelse) {
            ikkeAktuell()
            oppdaterStandardFelter(hendelse = hendelse)
        }

        private fun oppdaterStandardFelter(hendelse: IASakshendelse) {
            endretAvHendelseId = hendelse.id
            endretAv = hendelse.opprettetAv
            endretTidspunkt = hendelse.opprettetTidspunkt
        }

        open fun lagreGrunnlag(grunnlagService: GrunnlagService) {

        }

        abstract fun gyldigeNesteHendelser(rådgiver: Rådgiver): List<SaksHendelsestype>
    }

    private inner class StartTilstand : ProsessTilstand(
        status = IAProsessStatus.NY
    ) {
        override fun vurderes() {
            tilstand = VurderesTilstand()
        }

        override fun gyldigeNesteHendelser(rådgiver: Rådgiver): List<SaksHendelsestype> = listOf()
    }

    private inner class VurderesTilstand : ProsessTilstand(
        status = IAProsessStatus.VURDERES
    ) {
        override fun ikkeAktuell() {
            tilstand = IkkeAktuellTilstand()
        }

        override fun kontaktes() {
            if (eidAv.isNullOrEmpty()) {
                håndterFeilState("En virksomhet kan ikke kontaktes før saken har en eier")
            }
            tilstand = KontaktesTilstand()
        }

        override fun lagreGrunnlag(grunnlagService: GrunnlagService) = grunnlagService.lagreGrunnlag(orgnr, saksnummer, endretAvHendelseId)

        override fun gyldigeNesteHendelser(rådgiver: Rådgiver): List<SaksHendelsestype> {
            return when (rådgiver.rolle) {
                LESE -> emptyList()
                SAKSBEHANDLER, SUPERBRUKER -> {
                    if (erEierAvSak(rådgiver)) return listOf(VIRKSOMHET_SKAL_KONTAKTES, VIRKSOMHET_ER_IKKE_AKTUELL)
                    else return listOf(TA_EIERSKAP_I_SAK)
                }}
        }

    }

    private inner class KontaktesTilstand : ProsessTilstand(
        status = IAProsessStatus.KONTAKTES
    ) {
        override fun ikkeAktuell() {
            tilstand = IkkeAktuellTilstand()
        }

        override fun gyldigeNesteHendelser(rådgiver: Rådgiver): List<SaksHendelsestype> {
            return when (rådgiver.rolle) {
                LESE -> emptyList()
                SAKSBEHANDLER, SUPERBRUKER -> {
                    if (erEierAvSak(rådgiver)) return listOf(VIRKSOMHET_ER_IKKE_AKTUELL)
                    else return listOf(TA_EIERSKAP_I_SAK)
                }}
        }
    }

    private inner class IkkeAktuellTilstand : ProsessTilstand(
        status = IAProsessStatus.IKKE_AKTUELL
    ) {
        override fun gyldigeNesteHendelser(rådgiver: Rådgiver): List<SaksHendelsestype> = listOf()
    }

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
                opprettetTidspunkt = førsteHendelse.opprettetTidspunkt,
                opprettetAv = førsteHendelse.opprettetAv,
                eidAv = null,
                endretTidspunkt = null,
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
