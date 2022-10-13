package no.nav.lydia.ia.sak.domene

import kotliquery.Row
import no.nav.lydia.UnleashKlient.skalSjekkeFrist
import no.nav.lydia.ia.grunnlag.GrunnlagService
import no.nav.lydia.ia.sak.domene.IAProsessStatus.*
import no.nav.lydia.ia.sak.domene.IAProsessStatus.valueOf
import no.nav.lydia.ia.sak.domene.SaksHendelsestype.FULLFØR_BISTAND
import no.nav.lydia.ia.sak.domene.SaksHendelsestype.OPPRETT_SAK_FOR_VIRKSOMHET
import no.nav.lydia.ia.sak.domene.SaksHendelsestype.SLETT_SAK
import no.nav.lydia.ia.sak.domene.SaksHendelsestype.TA_EIERSKAP_I_SAK
import no.nav.lydia.ia.sak.domene.SaksHendelsestype.TILBAKE
import no.nav.lydia.ia.sak.domene.SaksHendelsestype.VIRKSOMHET_ER_IKKE_AKTUELL
import no.nav.lydia.ia.sak.domene.SaksHendelsestype.VIRKSOMHET_KARTLEGGES
import no.nav.lydia.ia.sak.domene.SaksHendelsestype.VIRKSOMHET_SKAL_BISTÅS
import no.nav.lydia.ia.sak.domene.SaksHendelsestype.VIRKSOMHET_SKAL_KONTAKTES
import no.nav.lydia.ia.sak.domene.SaksHendelsestype.VIRKSOMHET_VURDERES
import no.nav.lydia.ia.årsak.domene.GyldigBegrunnelse.Companion.somBegrunnelseType
import no.nav.lydia.tilgangskontroll.Rådgiver
import no.nav.lydia.tilgangskontroll.Rådgiver.Rolle.LESE
import no.nav.lydia.tilgangskontroll.Rådgiver.Rolle.SAKSBEHANDLER
import no.nav.lydia.tilgangskontroll.Rådgiver.Rolle.SUPERBRUKER
import org.slf4j.LoggerFactory
import java.time.Duration
import java.time.LocalDateTime
import java.time.LocalDateTime.now

const val ANTALL_DAGER_FØR_SAK_LÅSES = 10L

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
            NY -> StartTilstand()
            VURDERES -> VurderesTilstand()
            IKKE_AKTUELL -> IkkeAktuellTilstand()
            KONTAKTES -> KontaktesTilstand()
            KARTLEGGES -> KartleggesTilstand()
            VI_BISTÅR -> ViBistårTilstand()
            FULLFØRT -> FullførtTilstand()
            IKKE_AKTIV -> throw IllegalStateException()
            SLETTET -> throw IllegalStateException()
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
            VIRKSOMHET_VURDERES,
            VIRKSOMHET_SKAL_KONTAKTES,
            VIRKSOMHET_KARTLEGGES,
            VIRKSOMHET_SKAL_BISTÅS,
            FULLFØR_BISTAND,
            -> {
                tilstand.prosesser()
            }

            VIRKSOMHET_ER_IKKE_AKTUELL -> {
                when (hendelse) {
                    is VirksomhetIkkeAktuellHendelse -> tilstand.behandleHendelse(hendelse = hendelse)
                    else -> tilstand.ikkeAktuell() // TODO...
                }
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

            SLETT_SAK -> {
                tilstand.slett()
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
        open fun ikkeAktuell() {
            håndterFeilState()
        }

        open fun prosesser() {
            håndterFeilState()
        }

        open fun behandleHendelse(hendelse: VirksomhetIkkeAktuellHendelse) {
            håndterFeilState()
        }

        open fun tilbake() {
            håndterFeilState()
        }

        open fun slett() {
            håndterFeilState()
        }

        protected fun finnForrigeTilstand(): ProsessTilstand {
            val hendelserUtenTilbakeOgTaEierskap =
                hendelser.filter { it.hendelsesType != TILBAKE && it.hendelsesType != TA_EIERSKAP_I_SAK }
            val sak = fraHendelser(hendelser.minus(hendelserUtenTilbakeOgTaEierskap.last()))
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
        status = NY
    ) {
        override fun prosesser() {
            tilstand = VurderesTilstand()
        }

        override fun gyldigeNesteHendelser(rådgiver: Rådgiver): List<GyldigHendelse> = listOf()
    }

    private inner class VurderesTilstand : ProsessTilstand(
        status = VURDERES
    ) {
        override fun ikkeAktuell() {
            tilstand = IkkeAktuellTilstand()
        }

        override fun slett() {
            if (eidAv != null) {
                håndterFeilState()
            }
            tilstand = SlettetTilstand()
        }

        override fun behandleHendelse(hendelse: VirksomhetIkkeAktuellHendelse) {
            ikkeAktuell()
            super.oppdaterStandardFelter(hendelse = hendelse)
        }

        override fun prosesser() {
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
                SAKSBEHANDLER -> {
                    if (erEierAvSak(rådgiver)) return listOf(
                        GyldigHendelse(saksHendelsestype = VIRKSOMHET_SKAL_KONTAKTES),
                        GyldigHendelse(saksHendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL)
                    )
                    else return listOf(
                        GyldigHendelse(saksHendelsestype = TA_EIERSKAP_I_SAK),
                    )
                }
                SUPERBRUKER -> {
                    if (eidAv == null) return listOf(
                        GyldigHendelse(saksHendelsestype = TA_EIERSKAP_I_SAK),
                        GyldigHendelse(saksHendelsestype = SLETT_SAK)
                    )
                    else if (erEierAvSak(rådgiver)) return listOf(
                        GyldigHendelse(saksHendelsestype = VIRKSOMHET_SKAL_KONTAKTES),
                        GyldigHendelse(saksHendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL)
                    )
                    else return listOf(
                        GyldigHendelse(saksHendelsestype = TA_EIERSKAP_I_SAK)
                    )
                }
            }
        }
    }

    private inner class KontaktesTilstand : ProsessTilstand(
        status = KONTAKTES
    ) {

        override fun ikkeAktuell() {
            tilstand = IkkeAktuellTilstand()
        }

        override fun prosesser() {
            tilstand = KartleggesTilstand()
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
                        GyldigHendelse(saksHendelsestype = VIRKSOMHET_KARTLEGGES),
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

    private inner class KartleggesTilstand : ProsessTilstand(
        status = KARTLEGGES
    ) {
        override fun prosesser() {
            tilstand = ViBistårTilstand()
        }

        override fun gyldigeNesteHendelser(rådgiver: Rådgiver): List<GyldigHendelse> {
            return when (rådgiver.rolle) {
                LESE -> emptyList()
                SAKSBEHANDLER, SUPERBRUKER -> {
                    if (erEierAvSak(rådgiver)) return listOf(
                        GyldigHendelse(saksHendelsestype = VIRKSOMHET_SKAL_BISTÅS),
                        GyldigHendelse(saksHendelsestype = TILBAKE),
                        GyldigHendelse(saksHendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL)
                    )
                    else return listOf(GyldigHendelse(saksHendelsestype = TA_EIERSKAP_I_SAK))
                }
            }
        }

        override fun tilbake() {
            tilstand = finnForrigeTilstand()
        }

        override fun behandleHendelse(hendelse: VirksomhetIkkeAktuellHendelse) {
            ikkeAktuell()
            super.oppdaterStandardFelter(hendelse = hendelse)
        }

        override fun ikkeAktuell() {
            tilstand = IkkeAktuellTilstand()
        }

    }

    private inner class ViBistårTilstand : ProsessTilstand(
        status = VI_BISTÅR
    ) {
        override fun gyldigeNesteHendelser(rådgiver: Rådgiver): List<GyldigHendelse> {
            return when (rådgiver.rolle) {
                LESE -> emptyList()
                SAKSBEHANDLER, SUPERBRUKER -> {
                    if (erEierAvSak(rådgiver)) return listOf(
                        GyldigHendelse(saksHendelsestype = TILBAKE),
                        GyldigHendelse(saksHendelsestype = FULLFØR_BISTAND),
                        GyldigHendelse(saksHendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL)
                    )
                    else return listOf(GyldigHendelse(saksHendelsestype = TA_EIERSKAP_I_SAK))
                }
            }
        }

        override fun prosesser() {
            tilstand = FullførtTilstand()
        }

        override fun tilbake() {
            tilstand = finnForrigeTilstand()
        }

        override fun behandleHendelse(hendelse: VirksomhetIkkeAktuellHendelse) {
            ikkeAktuell()
            super.oppdaterStandardFelter(hendelse = hendelse)
        }

        override fun ikkeAktuell() {
            tilstand = IkkeAktuellTilstand()
        }
    }

    private fun erFørFristen(): Boolean {
        // -- feature toggles av unleash
        if (!skalSjekkeFrist())
            return true

        return this@IASak.endretTidspunkt?.let {
            it.toLocalDate().atStartOfDay().plus(Duration.ofDays(ANTALL_DAGER_FØR_SAK_LÅSES)).isAfter(now())
        } ?: true
    }

    fun erEtterFristen() = !erFørFristen()

    private abstract inner class EndeTilstand(status: IAProsessStatus) : ProsessTilstand(status = status) {
        override fun gyldigeNesteHendelser(rådgiver: Rådgiver): List<GyldigHendelse> = when (rådgiver.rolle) {
            SUPERBRUKER -> {
                if (erEtterFristen()) {
                    listOf(GyldigHendelse(saksHendelsestype = OPPRETT_SAK_FOR_VIRKSOMHET))
                } else if (erEierAvSak(rådgiver = rådgiver)) {
                    listOf(
                        GyldigHendelse(saksHendelsestype = TILBAKE),
                        GyldigHendelse(saksHendelsestype = OPPRETT_SAK_FOR_VIRKSOMHET)
                    )
                } else {
                    listOf(
                        GyldigHendelse(saksHendelsestype = TA_EIERSKAP_I_SAK),
                        GyldigHendelse(saksHendelsestype = OPPRETT_SAK_FOR_VIRKSOMHET)
                    )
                }
            }
            SAKSBEHANDLER -> {
                if (erEtterFristen()) {
                    emptyList()
                } else if (erEierAvSak(rådgiver = rådgiver)) {
                    listOf(GyldigHendelse(saksHendelsestype = TILBAKE))
                } else {
                    listOf(GyldigHendelse(saksHendelsestype = TA_EIERSKAP_I_SAK))
                }
            }
            LESE -> emptyList()
        }

        override fun tilbake() {
            tilstand = finnForrigeTilstand()
        }
    }

    private inner class FullførtTilstand : EndeTilstand(status = FULLFØRT)

    private inner class IkkeAktuellTilstand : EndeTilstand(status = IKKE_AKTUELL)

    private inner class SlettetTilstand : ProsessTilstand(
        status = SLETTET
    ) {
        override fun gyldigeNesteHendelser(rådgiver: Rådgiver): List<GyldigHendelse> = emptyList()
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
                status = NY
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
                status = valueOf(this.string("status")),
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
    KARTLEGGES,
    VI_BISTÅR,
    IKKE_AKTUELL,
    FULLFØRT,
    SLETTET;

    fun ansesSomAvsluttet() = this == IKKE_AKTUELL || this == FULLFØRT || this == SLETTET

    companion object {
        fun filtrerbareStatuser() =
            values().filterNot { it == NY || it == SLETTET }
    }
}
