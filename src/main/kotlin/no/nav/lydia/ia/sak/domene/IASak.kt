package no.nav.lydia.ia.sak.domene

import arrow.core.Either
import arrow.core.right
import kotliquery.Row
import no.nav.lydia.ia.sak.domene.IAProsessStatus.*
import no.nav.lydia.ia.sak.domene.IAProsessStatus.valueOf
import no.nav.lydia.ia.sak.domene.IASakshendelseType.FULLFØR_BISTAND
import no.nav.lydia.ia.sak.domene.IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET
import no.nav.lydia.ia.sak.domene.IASakshendelseType.SLETT_SAK
import no.nav.lydia.ia.sak.domene.IASakshendelseType.TA_EIERSKAP_I_SAK
import no.nav.lydia.ia.sak.domene.IASakshendelseType.TILBAKE
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_ER_IKKE_AKTUELL
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_KARTLEGGES
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_SKAL_BISTÅS
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_VURDERES
import no.nav.lydia.ia.sak.domene.TilstandsmaskinFeil.Companion.feil
import no.nav.lydia.ia.sak.domene.TilstandsmaskinFeil.Companion.generellFeil
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

    fun gyldigeNesteHendelser(rådgiver: Rådgiver) = tilstand.gyldigeNesteHendelser(rådgiver)

    private fun kanUtføreHendelse(hendelse: IASakshendelse, rådgiver: Rådgiver) = when (hendelse) {
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

    private fun utførHendelseSomRådgiver(rådgiver: Rådgiver, hendelse: IASakshendelse) =
        if (kanUtføreHendelse(hendelse = hendelse, rådgiver = rådgiver))
            behandleHendelse(hendelse = hendelse).right()
        else
            generellFeil()

    fun behandleHendelse(hendelse: IASakshendelse): IASak {
        when (hendelse.hendelsesType) {
            VIRKSOMHET_VURDERES,
            VIRKSOMHET_SKAL_KONTAKTES,
            VIRKSOMHET_KARTLEGGES,
            VIRKSOMHET_SKAL_BISTÅS,
            VIRKSOMHET_ER_IKKE_AKTUELL,
            TILBAKE,
            SLETT_SAK,
            FULLFØR_BISTAND -> {
                tilstand.behandleHendelse(hendelse)
                    .map { nyTilstand -> tilstand = nyTilstand }
                    .mapLeft { feil ->
                        log.error("Prøver å utføre en ugyldig hendelse på sak $saksnummer med status ${status.name}")
                        throw IllegalStateException(feil.feilmelding)
                    }
            }

            TA_EIERSKAP_I_SAK -> {
                eidAv = hendelse.opprettetAv
            }

            OPPRETT_SAK_FOR_VIRKSOMHET -> {
                throw IllegalStateException("Ikke en gyldig hendelsestype")
            }
        }
        oppdaterStandardFelter(hendelse = hendelse)
        return this
    }

    private fun oppdaterStandardFelter(hendelse: IASakshendelse) {
        endretAvHendelseId = hendelse.id
        endretAv = hendelse.opprettetAv
        endretTidspunkt = hendelse.opprettetTidspunkt
        sakshendelser.add(hendelse)
    }

    private fun erFørFristenForLåsingAvSak() =
        this@IASak.endretTidspunkt?.toLocalDate()?.atStartOfDay()?.plus(Duration.ofDays(ANTALL_DAGER_FØR_SAK_LÅSES))
            ?.isAfter(now())
            ?: true

    fun erEtterFristenForLåsingAvSak() = !erFørFristenForLåsingAvSak()

    private abstract inner class ProsessTilstand(val status: IAProsessStatus) {

        abstract fun behandleHendelse(hendelse: IASakshendelse): Either<TilstandsmaskinFeil, ProsessTilstand>

        protected fun finnForrigeTilstand(): ProsessTilstand {
            val hendelserUtenTilbakeOgTaEierskap =
                hendelser.filter { it.hendelsesType != TILBAKE && it.hendelsesType != TA_EIERSKAP_I_SAK }
            val sak = fraHendelser(hendelser.minus(hendelserUtenTilbakeOgTaEierskap.last()))
            return tilstandFraStatus(sak.status)
        }

        abstract fun gyldigeNesteHendelser(rådgiver: Rådgiver): List<GyldigHendelse>

    }

    private inner class StartTilstand : ProsessTilstand(
        status = NY
    ) {
        override fun behandleHendelse(hendelse: IASakshendelse) =
            when (hendelse.hendelsesType) {
                VIRKSOMHET_VURDERES -> VurderesTilstand().right()
                else -> generellFeil()
            }

        override fun gyldigeNesteHendelser(rådgiver: Rådgiver): List<GyldigHendelse> = listOf()
    }

    private inner class VurderesTilstand : ProsessTilstand(
        status = VURDERES
    ) {
        override fun behandleHendelse(hendelse: IASakshendelse) =
            when (hendelse.hendelsesType) {
                VIRKSOMHET_SKAL_KONTAKTES -> if (eidAv.isNullOrEmpty()) feil(feilmelding = "En virksomhet kan ikke kontaktes før saken har en eier. Status: $status") else KontaktesTilstand().right()
                SLETT_SAK -> if (eidAv != null) feil(feilmelding = "SLETT er ikke en gyldig hendelse for IASak med eier. Status: $status") else SlettetTilstand().right()
                VIRKSOMHET_ER_IKKE_AKTUELL -> IkkeAktuellTilstand().right()
                else -> generellFeil()
            }

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

        override fun behandleHendelse(hendelse: IASakshendelse) =
            when (hendelse.hendelsesType) {
                VIRKSOMHET_KARTLEGGES -> KartleggesTilstand().right()
                VIRKSOMHET_ER_IKKE_AKTUELL -> IkkeAktuellTilstand().right()
                TILBAKE -> finnForrigeTilstand().right()
                else -> generellFeil()
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
    }

    private inner class KartleggesTilstand : ProsessTilstand(
        status = KARTLEGGES
    ) {
        override fun behandleHendelse(hendelse: IASakshendelse) =
            when (hendelse.hendelsesType) {
                VIRKSOMHET_SKAL_BISTÅS -> ViBistårTilstand().right()
                TILBAKE -> finnForrigeTilstand().right()
                VIRKSOMHET_ER_IKKE_AKTUELL -> IkkeAktuellTilstand().right()
                else -> generellFeil()
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

        override fun behandleHendelse(hendelse: IASakshendelse) =
            when (hendelse.hendelsesType) {
                TILBAKE -> finnForrigeTilstand().right()
                VIRKSOMHET_ER_IKKE_AKTUELL -> IkkeAktuellTilstand().right()
                FULLFØR_BISTAND -> FullførtTilstand().right()
                else -> generellFeil()
            }
    }

    private abstract inner class EndeTilstand(status: IAProsessStatus) : ProsessTilstand(status = status) {
        override fun gyldigeNesteHendelser(rådgiver: Rådgiver): List<GyldigHendelse> = when (rådgiver.rolle) {
            SUPERBRUKER,
            SAKSBEHANDLER -> {
                if (erEtterFristenForLåsingAvSak()) {
                    emptyList()
                } else if (erEierAvSak(rådgiver = rådgiver)) {
                    listOf(GyldigHendelse(saksHendelsestype = TILBAKE))
                } else {
                    listOf(GyldigHendelse(saksHendelsestype = TA_EIERSKAP_I_SAK))
                }
            }
            LESE -> emptyList()
        }

        override fun behandleHendelse(hendelse: IASakshendelse) =
            when (hendelse.hendelsesType) {
                TILBAKE -> finnForrigeTilstand().right()
                else -> generellFeil()
            }
    }

    private inner class FullførtTilstand : EndeTilstand(status = FULLFØRT)

    private inner class IkkeAktuellTilstand : EndeTilstand(status = IKKE_AKTUELL)

    private inner class SlettetTilstand : ProsessTilstand(status = SLETTET) {
        override fun behandleHendelse(hendelse: IASakshendelse) =
            feil("Kan ikke utføre noen hendelser i en slettet tilstand")

        override fun gyldigeNesteHendelser(rådgiver: Rådgiver): List<GyldigHendelse> = emptyList()
    }

    companion object {
        fun Rådgiver.utførHendelsePåSak(sak: IASak, hendelse: IASakshendelse) =
            sak.utførHendelseSomRådgiver(this, hendelse)

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

class TilstandsmaskinFeil(val feilmelding: String) {
    companion object {
        fun feil(feilmelding: String) = Either.Left(TilstandsmaskinFeil(feilmelding = feilmelding))

        fun generellFeil() = feil("Forsøker å utføre en hendelse som ikke er implementert")
    }
}
