package no.nav.lydia.ia.sak.domene

import kotliquery.Row
import no.nav.lydia.ia.grunnlag.GrunnlagService
import no.nav.lydia.ia.sak.domene.SaksHendelsestype.*
import no.nav.lydia.ia.årsak.domene.GyldigBegrunnelse.Companion.somBegrunnelseType
import no.nav.lydia.tilgangskontroll.Rådgiver
import no.nav.lydia.tilgangskontroll.Rådgiver.Rolle.*
import org.slf4j.LoggerFactory
import java.time.LocalDateTime

class IASak private constructor(
    val saksnummer: String,
    val orgnr: String,
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

    private val sakshendelser = mutableListOf<IASakshendelse>()
    val hendelser get() = sakshendelser.toList()

    init {
        tilstand = tilstandFraStatus(status)
    }

    val status: IAProsessStatus
        get() = tilstand.status

    private fun tilstandFraStatus(status: IAProsessStatus): ProsessTilstand {
        return when (status) {
            IAProsessStatus.NY -> StartTilstand()
            IAProsessStatus.VURDERES -> VurderesTilstand()
            IAProsessStatus.IKKE_AKTUELL -> IkkeAktuellTilstand()
            IAProsessStatus.KONTAKTES -> KontaktesTilstand()
            IAProsessStatus.IKKE_AKTIV -> throw IllegalStateException()
        }
    }

    fun lagreGrunnlag(grunnlagService: GrunnlagService) = tilstand.lagreGrunnlag(grunnlagService)

    fun gyldigeNesteHendelser(rådgiver: Rådgiver) = tilstand.gyldigeNesteHendelser(rådgiver)

    fun kanUtføreHendelse(hendelse: IASakshendelse, rådgiver: Rådgiver) = when (hendelse) {
        is VirksomhetIkkeAktuellHendelse -> gyldigeNesteHendelser(rådgiver)
            .first { gyldigHendelse -> gyldigHendelse.saksHendelsestype == hendelse.hendelsesType }.gyldigeÅrsaker
            .filter { it.type == hendelse.valgtÅrsak.type }
            .any {
                hendelse.valgtÅrsak.begrunnelser.isNotEmpty()
                    .and(it.begrunnelser.somBegrunnelseType().containsAll(hendelse.valgtÅrsak.begrunnelser))
            }
        else ->
            gyldigeNesteHendelser(rådgiver)
                .map { gyldigHendelse -> gyldigHendelse.saksHendelsestype }
                .contains(hendelse.hendelsesType)
    }

    private fun erEierAvSak(rådgiver: Rådgiver) = eidAv == rådgiver.navIdent

    fun behandleHendelse(hendelse: IASakshendelse): IASak {
        when (hendelse.hendelsesType) {
            VIRKSOMHET_VURDERES -> {
                tilstand.vurderes()
            }
            VIRKSOMHET_ER_IKKE_AKTUELL -> {
                when (hendelse) {
                    is VirksomhetIkkeAktuellHendelse -> tilstand.behandleHendelse(hendelse = hendelse)
                    else -> tilstand.ikkeAktuell() // TODO...
                }
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
            TILBAKE -> {
                tilstand.tilbake()
            }
        }
        endretAvHendelseId = hendelse.id
        endretAv = hendelse.opprettetAv
        endretTidspunkt = hendelse.opprettetTidspunkt
        sakshendelser.add(hendelse)
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

        open fun behandleHendelse(hendelse: VirksomhetIkkeAktuellHendelse) {
            håndterFeilState()
        }

        open fun tilbake() {
           håndterFeilState()
        }

        protected fun finnForrigeTilstand(): ProsessTilstand {
            val hendelserUtenTilbake = hendelser.filter { it.hendelsesType != TILBAKE }
            val sak = fraHendelser(hendelser.minus(hendelserUtenTilbake.last()))
            return tilstandFraStatus(sak.status)
        }

        open fun lagreGrunnlag(grunnlagService: GrunnlagService) {}

        abstract fun gyldigeNesteHendelser(rådgiver: Rådgiver): List<GyldigHendelse>

        protected fun oppdaterStandardFelter(hendelse: IASakshendelse) {
            endretAvHendelseId = hendelse.id
            endretAv = hendelse.opprettetAv
            endretTidspunkt = hendelse.opprettetTidspunkt
        }

    }

    private inner class StartTilstand : ProsessTilstand(
        status = IAProsessStatus.NY
    ) {
        override fun vurderes() {
            tilstand = VurderesTilstand()
        }

        override fun gyldigeNesteHendelser(rådgiver: Rådgiver): List<GyldigHendelse> = listOf()
    }

    private inner class VurderesTilstand : ProsessTilstand(
        status = IAProsessStatus.VURDERES
    ) {
        override fun ikkeAktuell() {
            tilstand = IkkeAktuellTilstand()
        }

        override fun behandleHendelse(hendelse: VirksomhetIkkeAktuellHendelse) {
            ikkeAktuell()
            super.oppdaterStandardFelter(hendelse = hendelse)
        }

        override fun kontaktes() {
            if (eidAv.isNullOrEmpty()) {
                håndterFeilState("En virksomhet kan ikke kontaktes før saken har en eier")
            }
            tilstand = KontaktesTilstand()
        }

        override fun lagreGrunnlag(grunnlagService: GrunnlagService) =
            grunnlagService.lagreGrunnlag(orgnr, saksnummer, endretAvHendelseId)

        override fun gyldigeNesteHendelser(rådgiver: Rådgiver): List<GyldigHendelse> {
            return when (rådgiver.rolle) {
                LESE -> emptyList()
                SAKSBEHANDLER, SUPERBRUKER -> {
                    if (erEierAvSak(rådgiver)) return listOf(
                        GyldigHendelse(saksHendelsestype = VIRKSOMHET_SKAL_KONTAKTES),
                        GyldigHendelse(saksHendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL)
                    )
                    else return listOf(GyldigHendelse(saksHendelsestype = TA_EIERSKAP_I_SAK))
                }
            }
        }
    }

    private inner class KontaktesTilstand : ProsessTilstand(
        status = IAProsessStatus.KONTAKTES
    ) {

        override fun ikkeAktuell() {
            tilstand = IkkeAktuellTilstand()
        }

        override fun behandleHendelse(hendelse: VirksomhetIkkeAktuellHendelse) {
            ikkeAktuell()
            super.oppdaterStandardFelter(hendelse = hendelse)
        }

        override fun gyldigeNesteHendelser(rådgiver: Rådgiver): List<GyldigHendelse> {
            return when (rådgiver.rolle) {
                LESE -> emptyList()
                SAKSBEHANDLER, SUPERBRUKER -> {
                    if (erEierAvSak(rådgiver)) return listOf(
                        GyldigHendelse(saksHendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL),
                        GyldigHendelse(saksHendelsestype = TILBAKE)
                    )
                    else return listOf(GyldigHendelse(saksHendelsestype = TA_EIERSKAP_I_SAK))
                }
            }
        }

        override fun tilbake() {
            tilstand = finnForrigeTilstand()
        }
    }

    private inner class IkkeAktuellTilstand : ProsessTilstand(
        status = IAProsessStatus.IKKE_AKTUELL
    ) {
        override fun gyldigeNesteHendelser(rådgiver: Rådgiver): List<GyldigHendelse> =
            when (rådgiver.rolle) {
                LESE -> emptyList()
                SAKSBEHANDLER, SUPERBRUKER -> {
                    if (erEierAvSak(rådgiver= rådgiver)) listOf(GyldigHendelse(saksHendelsestype = TILBAKE))
                    else listOf(GyldigHendelse(saksHendelsestype = TA_EIERSKAP_I_SAK))
                }
            }

        override fun tilbake() {
            tilstand = finnForrigeTilstand()
        }
    }

    companion object {
        fun fraFørsteHendelse(hendelse: IASakshendelse): IASak =
            IASak(
                saksnummer = hendelse.saksnummer,
                orgnr = hendelse.orgnummer,
                opprettetTidspunkt = hendelse.opprettetTidspunkt,
                opprettetAv = hendelse.opprettetAv,
                eidAv = null,
                endretTidspunkt = null,
                endretAv = null,
                endretAvHendelseId = hendelse.id,
                status = IAProsessStatus.NY
            )
                .also { sak -> sak.sakshendelser.add(hendelse) }

        fun fraHendelser(hendelser: List<IASakshendelse>): IASak {
            val førsteHendelse = hendelser.first()
            val sak = fraFørsteHendelse(førsteHendelse)
            val resterendeHendelser = hendelser.minus(førsteHendelse)
            resterendeHendelser.forEach(sak::behandleHendelse)
            return sak
        }

        fun Row.tilIASak(): IASak =
            IASak(
                saksnummer = this.string("saksnummer"),
                orgnr = this.string("orgnr"),
                opprettetTidspunkt = this.localDateTime("opprettet"),
                opprettetAv = this.string("opprettet_av"),
                endretTidspunkt = this.localDateTimeOrNull("endret"),
                endretAv = this.stringOrNull("endret_av"),
                status = IAProsessStatus.valueOf(this.string("status")),
                endretAvHendelseId = this.string("endret_av_hendelse"),
                eidAv = this.stringOrNull("eid_av")
            )
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
