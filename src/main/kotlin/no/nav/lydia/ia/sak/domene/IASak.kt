package no.nav.lydia.ia.sak.domene

import arrow.core.Either
import arrow.core.right
import kotlinx.datetime.toKotlinLocalDateTime
import kotliquery.Row
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.domene.IASakshendelseType.AVBRYT_PROSESS
import no.nav.lydia.ia.sak.domene.IASakshendelseType.ENDRE_PROSESS
import no.nav.lydia.ia.sak.domene.IASakshendelseType.FULLFØR_BISTAND
import no.nav.lydia.ia.sak.domene.IASakshendelseType.FULLFØR_PROSESS
import no.nav.lydia.ia.sak.domene.IASakshendelseType.FULLFØR_PROSESS_MASKINELT_PÅ_EN_FULLFØRT_SAK
import no.nav.lydia.ia.sak.domene.IASakshendelseType.NY_PROSESS
import no.nav.lydia.ia.sak.domene.IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET
import no.nav.lydia.ia.sak.domene.IASakshendelseType.OPPRETT_SAMARBEIDSPLAN
import no.nav.lydia.ia.sak.domene.IASakshendelseType.SLETT_PROSESS
import no.nav.lydia.ia.sak.domene.IASakshendelseType.SLETT_SAK
import no.nav.lydia.ia.sak.domene.IASakshendelseType.SLETT_SAMARBEIDSPLAN
import no.nav.lydia.ia.sak.domene.IASakshendelseType.TA_EIERSKAP_I_SAK
import no.nav.lydia.ia.sak.domene.IASakshendelseType.TILBAKE
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_ER_IKKE_AKTUELL
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_KARTLEGGES
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_SKAL_BISTÅS
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_VURDERES
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VURDERING_FULLFØRT_UTEN_SAMARBEID
import no.nav.lydia.ia.sak.domene.TilstandsmaskinFeil.Companion.feil
import no.nav.lydia.ia.sak.domene.TilstandsmaskinFeil.Companion.generellFeil
import no.nav.lydia.ia.årsak.domene.GyldigBegrunnelse.Companion.somBegrunnelseType
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Saksbehandler
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker
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
    status: Status,
) {
    private var tilstand: ProsessTilstand
    private val log = LoggerFactory.getLogger(this.javaClass)

    private val sakshendelser = mutableListOf<IASakshendelse>()
    val hendelser get() = sakshendelser.toList()

    init {
        tilstand = tilstandFraStatus(status)
    }

    val status: Status
        get() = tilstand.status

    private fun tilstandFraStatus(status: Status): ProsessTilstand =
        when (status) {
            Status.NY -> StartTilstand()

            Status.VURDERES -> VurderesTilstand()

            Status.IKKE_AKTUELL -> IkkeAktuellTilstand()

            Status.KONTAKTES -> KontaktesTilstand()

            Status.KARTLEGGES -> KartleggesTilstand()

            Status.VI_BISTÅR -> ViBistårTilstand()

            Status.FULLFØRT -> FullførtTilstand()

            Status.IKKE_AKTIV -> throw IllegalStateException()

            Status.SLETTET -> throw IllegalStateException()

            // -- Ny flyt:
            Status.VURDERT -> throw IllegalStateException()

            Status.AKTIV -> throw IllegalStateException()
        }

    fun gyldigeNesteHendelser(
        navAnsatt: NavAnsattMedSaksbehandlerRolle,
        følgerSak: Boolean,
    ) = tilstand.gyldigeNesteHendelser(navAnsatt, følgerSak)

    private fun kanUtføreHendelse(
        hendelse: IASakshendelse,
        navAnsatt: NavAnsattMedSaksbehandlerRolle,
        eierEllerFølgerSak: Boolean,
    ) = when (hendelse) {
        is VirksomhetIkkeAktuellHendelse -> {
            gyldigeNesteHendelser(navAnsatt, eierEllerFølgerSak)
                .first { gyldigHendelse -> gyldigHendelse.saksHendelsestype == hendelse.hendelsesType }.gyldigeÅrsaker
                .filter { it.type == hendelse.valgtÅrsak.type }
                .any {
                    hendelse.valgtÅrsak.begrunnelser.isNotEmpty()
                        .and(it.begrunnelser.somBegrunnelseType().containsAll(hendelse.valgtÅrsak.begrunnelser))
                }
        }

        else -> {
            gyldigeNesteHendelser(navAnsatt, eierEllerFølgerSak)
                .map { gyldigHendelse -> gyldigHendelse.saksHendelsestype }
                .contains(hendelse.hendelsesType)
        }
    }

    private fun erEierAvSak(navAnsatt: NavAnsattMedSaksbehandlerRolle) = eidAv == navAnsatt.navIdent

    private fun utførHendelseSomRådgiver(
        navAnsatt: NavAnsattMedSaksbehandlerRolle,
        hendelse: IASakshendelse,
        følgerSak: Boolean,
    ) = if (kanUtføreHendelse(hendelse = hendelse, navAnsatt = navAnsatt, følgerSak)) {
        behandleHendelse(hendelse = hendelse).right()
    } else {
        generellFeil()
    }

    private fun behandleHendelse(hendelse: IASakshendelse): IASak {
        when (hendelse.hendelsesType) {
            VIRKSOMHET_VURDERES,
            VIRKSOMHET_SKAL_KONTAKTES,
            VIRKSOMHET_KARTLEGGES,
            VIRKSOMHET_SKAL_BISTÅS,
            VIRKSOMHET_ER_IKKE_AKTUELL,
            TILBAKE,
            SLETT_SAK,
            FULLFØR_BISTAND,
            ENDRE_PROSESS,
            NY_PROSESS,
            SLETT_PROSESS,
            FULLFØR_PROSESS,
            FULLFØR_PROSESS_MASKINELT_PÅ_EN_FULLFØRT_SAK,
            AVBRYT_PROSESS,
            -> {
                tilstand.behandleHendelse(hendelse)
                    .map { nyTilstand -> tilstand = nyTilstand }
                    .mapLeft { feil ->
                        log.error(
                            "Prøver å utføre en ugyldig hendelse (${hendelse.hendelsesType.name}) på sak $saksnummer med status ${status.name}",
                        )
                        throw IllegalStateException(feil.feilmelding)
                    }
            }

            TA_EIERSKAP_I_SAK -> {
                eidAv = hendelse.opprettetAv
            }

            OPPRETT_SAK_FOR_VIRKSOMHET -> {
                throw IllegalStateException("Ikke en gyldig hendelsestype")
            }

            // -- Ny flyt:
            VURDERING_FULLFØRT_UTEN_SAMARBEID,
            OPPRETT_SAMARBEIDSPLAN,
            SLETT_SAMARBEIDSPLAN,
            -> {
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

    fun addHendelser(hendelser: List<IASakshendelse>): IASak {
        sakshendelser.addAll(hendelser)
        return this
    }

    private abstract inner class ProsessTilstand(
        val status: Status,
    ) {
        abstract fun behandleHendelse(hendelse: IASakshendelse): Either<TilstandsmaskinFeil, ProsessTilstand>

        protected fun finnForrigeTilstand(): ProsessTilstand =
            when (
                finnForrigeTilstandBasertPåHendelsesrekke(
                    hendelser.map {
                        it.hendelsesType
                    },
                )
            ) {
                VIRKSOMHET_VURDERES -> VurderesTilstand()
                VIRKSOMHET_SKAL_KONTAKTES -> KontaktesTilstand()
                VIRKSOMHET_KARTLEGGES -> KartleggesTilstand()
                VIRKSOMHET_SKAL_BISTÅS -> ViBistårTilstand()
                else -> throw IllegalStateException("Ugyldig forrige tilstand for hendelsesrekke ${hendelser.map { it.hendelsesType }}}")
            }

        abstract fun gyldigeNesteHendelser(
            navAnsatt: NavAnsattMedSaksbehandlerRolle,
            følgerSak: Boolean,
        ): List<GyldigHendelse>
    }

    private inner class StartTilstand :
        ProsessTilstand(
            status = Status.NY,
        ) {
        override fun behandleHendelse(hendelse: IASakshendelse) =
            when (hendelse.hendelsesType) {
                VIRKSOMHET_VURDERES -> VurderesTilstand().right()
                else -> generellFeil()
            }

        override fun gyldigeNesteHendelser(
            navAnsatt: NavAnsattMedSaksbehandlerRolle,
            følgerSak: Boolean,
        ): List<GyldigHendelse> =
            when (navAnsatt) {
                is Superbruker -> listOf(GyldigHendelse(VIRKSOMHET_VURDERES))
                is Saksbehandler -> emptyList()
            }
    }

    private inner class VurderesTilstand :
        ProsessTilstand(
            status = Status.VURDERES,
        ) {
        override fun behandleHendelse(hendelse: IASakshendelse) =
            when (hendelse.hendelsesType) {
                VIRKSOMHET_SKAL_KONTAKTES -> if (eidAv.isNullOrEmpty()) {
                    feil(
                        feilmelding = "En virksomhet kan ikke kontaktes før saken har en eier. Status: $status",
                    )
                } else {
                    KontaktesTilstand().right()
                }

                SLETT_SAK -> if (eidAv !=
                    null
                ) {
                    feil(feilmelding = "SLETT er ikke en gyldig hendelse for IASak med eier. Status: $status")
                } else {
                    SlettetTilstand().right()
                }

                VIRKSOMHET_ER_IKKE_AKTUELL -> IkkeAktuellTilstand().right()

                else -> generellFeil()
            }

        override fun gyldigeNesteHendelser(
            navAnsatt: NavAnsattMedSaksbehandlerRolle,
            følgerSak: Boolean,
        ) = when (navAnsatt) {
            is Saksbehandler -> {
                if (erEierAvSak(navAnsatt)) {
                    listOf(
                        GyldigHendelse(saksHendelsestype = VIRKSOMHET_SKAL_KONTAKTES),
                        GyldigHendelse(saksHendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL),
                    )
                } else {
                    listOf(
                        GyldigHendelse(saksHendelsestype = TA_EIERSKAP_I_SAK),
                    )
                }
            }

            is Superbruker -> {
                if (eidAv == null) {
                    listOf(
                        GyldigHendelse(saksHendelsestype = TA_EIERSKAP_I_SAK),
                        GyldigHendelse(saksHendelsestype = SLETT_SAK),
                    )
                } else if (erEierAvSak(navAnsatt)) {
                    listOf(
                        GyldigHendelse(saksHendelsestype = VIRKSOMHET_SKAL_KONTAKTES),
                        GyldigHendelse(saksHendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL),
                    )
                } else {
                    listOf(
                        GyldigHendelse(saksHendelsestype = TA_EIERSKAP_I_SAK),
                    )
                }
            }
        }
    }

    private inner class KontaktesTilstand :
        ProsessTilstand(
            status = Status.KONTAKTES,
        ) {
        override fun behandleHendelse(hendelse: IASakshendelse) =
            when (hendelse.hendelsesType) {
                VIRKSOMHET_KARTLEGGES -> KartleggesTilstand().right()
                VIRKSOMHET_ER_IKKE_AKTUELL -> IkkeAktuellTilstand().right()
                TILBAKE -> finnForrigeTilstand().right()
                else -> generellFeil()
            }

        override fun gyldigeNesteHendelser(
            navAnsatt: NavAnsattMedSaksbehandlerRolle,
            følgerSak: Boolean,
        ) = if (erEierAvSak(navAnsatt)) {
            listOf(
                GyldigHendelse(saksHendelsestype = VIRKSOMHET_KARTLEGGES),
                GyldigHendelse(saksHendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL),
                GyldigHendelse(saksHendelsestype = TILBAKE),
            )
        } else {
            listOf(GyldigHendelse(saksHendelsestype = TA_EIERSKAP_I_SAK))
        }
    }

    private inner class KartleggesTilstand :
        ProsessTilstand(
            status = Status.KARTLEGGES,
        ) {
        override fun behandleHendelse(hendelse: IASakshendelse) =
            when (hendelse.hendelsesType) {
                VIRKSOMHET_SKAL_BISTÅS -> ViBistårTilstand().right()
                TILBAKE -> finnForrigeTilstand().right()
                VIRKSOMHET_ER_IKKE_AKTUELL -> IkkeAktuellTilstand().right()
                ENDRE_PROSESS, NY_PROSESS, SLETT_PROSESS, AVBRYT_PROSESS -> this.right()
                else -> generellFeil()
            }

        override fun gyldigeNesteHendelser(
            navAnsatt: NavAnsattMedSaksbehandlerRolle,
            følgerSak: Boolean,
        ) = if (erEierAvSak(navAnsatt)) {
            listOf(
                GyldigHendelse(saksHendelsestype = VIRKSOMHET_SKAL_BISTÅS),
                GyldigHendelse(saksHendelsestype = TILBAKE),
                GyldigHendelse(saksHendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL),
                GyldigHendelse(saksHendelsestype = ENDRE_PROSESS),
                GyldigHendelse(saksHendelsestype = SLETT_PROSESS),
                GyldigHendelse(saksHendelsestype = NY_PROSESS),
                GyldigHendelse(saksHendelsestype = AVBRYT_PROSESS),
            )
        } else if (følgerSak) {
            listOf(
                GyldigHendelse(saksHendelsestype = ENDRE_PROSESS),
                GyldigHendelse(saksHendelsestype = SLETT_PROSESS),
                GyldigHendelse(saksHendelsestype = NY_PROSESS),
                GyldigHendelse(saksHendelsestype = FULLFØR_PROSESS),
                GyldigHendelse(saksHendelsestype = AVBRYT_PROSESS),
                GyldigHendelse(saksHendelsestype = TA_EIERSKAP_I_SAK),
            )
        } else {
            listOf(GyldigHendelse(saksHendelsestype = TA_EIERSKAP_I_SAK))
        }
    }

    private inner class ViBistårTilstand :
        ProsessTilstand(
            status = Status.VI_BISTÅR,
        ) {
        override fun gyldigeNesteHendelser(
            navAnsatt: NavAnsattMedSaksbehandlerRolle,
            følgerSak: Boolean,
        ) = if (erEierAvSak(navAnsatt)) {
            listOf(
                GyldigHendelse(saksHendelsestype = TILBAKE),
                GyldigHendelse(saksHendelsestype = FULLFØR_BISTAND),
                GyldigHendelse(saksHendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL),
                GyldigHendelse(saksHendelsestype = ENDRE_PROSESS),
                GyldigHendelse(saksHendelsestype = SLETT_PROSESS),
                GyldigHendelse(saksHendelsestype = NY_PROSESS),
                GyldigHendelse(saksHendelsestype = FULLFØR_PROSESS),
                GyldigHendelse(saksHendelsestype = AVBRYT_PROSESS),
            )
        } else if (følgerSak) {
            listOf(
                GyldigHendelse(saksHendelsestype = ENDRE_PROSESS),
                GyldigHendelse(saksHendelsestype = SLETT_PROSESS),
                GyldigHendelse(saksHendelsestype = NY_PROSESS),
                GyldigHendelse(saksHendelsestype = FULLFØR_PROSESS),
                GyldigHendelse(saksHendelsestype = AVBRYT_PROSESS),
                GyldigHendelse(saksHendelsestype = TA_EIERSKAP_I_SAK),
            )
        } else {
            listOf(GyldigHendelse(saksHendelsestype = TA_EIERSKAP_I_SAK))
        }

        override fun behandleHendelse(hendelse: IASakshendelse) =
            when (hendelse.hendelsesType) {
                TILBAKE -> finnForrigeTilstand().right()
                VIRKSOMHET_ER_IKKE_AKTUELL -> IkkeAktuellTilstand().right()
                FULLFØR_BISTAND -> FullførtTilstand().right()
                ENDRE_PROSESS, NY_PROSESS, SLETT_PROSESS, FULLFØR_PROSESS, AVBRYT_PROSESS -> this.right()
                else -> generellFeil()
            }
    }

    private abstract inner class EndeTilstand(
        status: Status,
    ) : ProsessTilstand(status = status) {
        override fun gyldigeNesteHendelser(
            navAnsatt: NavAnsattMedSaksbehandlerRolle,
            følgerSak: Boolean,
        ): List<GyldigHendelse> =
            if (erEtterFristenForLåsingAvSak()) {
                emptyList()
            } else if (erEierAvSak(navAnsatt = navAnsatt)) {
                listOf(GyldigHendelse(saksHendelsestype = TILBAKE))
            } else {
                listOf(GyldigHendelse(saksHendelsestype = TA_EIERSKAP_I_SAK))
            }

        override fun behandleHendelse(hendelse: IASakshendelse) =
            when (hendelse.hendelsesType) {
                TILBAKE -> finnForrigeTilstand().right()
                FULLFØR_PROSESS_MASKINELT_PÅ_EN_FULLFØRT_SAK -> this.right()
                else -> generellFeil()
            }
    }

    private inner class FullførtTilstand : EndeTilstand(status = Status.FULLFØRT)

    private inner class IkkeAktuellTilstand : EndeTilstand(status = Status.IKKE_AKTUELL)

    private inner class SlettetTilstand : ProsessTilstand(status = Status.SLETTET) {
        override fun behandleHendelse(hendelse: IASakshendelse) = feil("Kan ikke utføre noen hendelser i en slettet tilstand")

        override fun gyldigeNesteHendelser(
            navAnsatt: NavAnsattMedSaksbehandlerRolle,
            følgerSak: Boolean,
        ): List<GyldigHendelse> = emptyList()
    }

    companion object {
        fun NavAnsattMedSaksbehandlerRolle.utførHendelsePåSak(
            sak: IASak,
            hendelse: IASakshendelse,
            følgerSak: Boolean,
        ) = sak.utførHendelseSomRådgiver(this, hendelse, følgerSak)

        fun maskineltBehandleSamarbeidsHendelse(
            iaSak: IASak,
            hendelse: IASakshendelse,
        ) = when (hendelse) {
            is ProsessHendelse -> iaSak.behandleHendelse(hendelse)
            else -> throw IllegalStateException("Kan ikke oppdatere samarbeid på fullførte sak med hendelsestype ${hendelse.hendelsesType.name}")
        }

        fun tilbakeførSak(
            iaSak: IASak,
            hendelse: IASakshendelse,
        ) = when (hendelse) {
            is VirksomhetIkkeAktuellHendelse -> iaSak.behandleHendelse(hendelse)
            else -> throw IllegalStateException("Kan ikke tilbakeføre sak med hendelsestype ${hendelse.hendelsesType.name}")
        }

        fun finnForrigeTilstandBasertPåHendelsesrekke(hendelser: List<IASakshendelseType>): IASakshendelseType {
            val hendelserSomEndrerStatus = hendelser.filter {
                !listOf(
                    TA_EIERSKAP_I_SAK,
                    NY_PROSESS,
                    ENDRE_PROSESS,
                    SLETT_PROSESS,
                    AVBRYT_PROSESS,
                    FULLFØR_PROSESS,
                    FULLFØR_PROSESS_MASKINELT_PÅ_EN_FULLFØRT_SAK,
                ).contains(it)
            }

            val hendelsesRekkeMedHåndterteTilbakeHendelser =
                hendelsesRekkeMedHåndterteEldreTilbakeHendelser(hendelserSomEndrerStatus)

            return hendelsesRekkeMedHåndterteTilbakeHendelser.nestSiste()
        }

        private fun hendelsesRekkeMedHåndterteEldreTilbakeHendelser(liste: List<IASakshendelseType>): List<IASakshendelseType> {
            if (liste.siste() != TILBAKE && liste.nestSiste() != TILBAKE) {
                return liste
            }

            if (liste.nestSiste() == TILBAKE) {
                val rekursjonUtenSisteElement = hendelsesRekkeMedHåndterteEldreTilbakeHendelser(liste.dropLast(1))
                return hendelsesRekkeMedHåndterteEldreTilbakeHendelser(rekursjonUtenSisteElement.plus(liste.siste()))
            }

            if (liste.siste() == TILBAKE) {
                return hendelsesRekkeMedHåndterteEldreTilbakeHendelser(liste.dropLast(2))
            }

            throw IllegalStateException("Merkelig hendelsesrekke: $liste")
        }

        private fun List<IASakshendelseType>.nestSiste() = this.dropLast(1).last()

        fun List<IASakshendelseType>.siste() = this.last()

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
                status = Status.NY,
            )
                .also { sak -> sak.sakshendelser.add(hendelse) }

        fun fraHendelser(hendelser: List<IASakshendelse>): IASak {
            val førsteHendelse = hendelser.first()
            val sak = fraFørsteHendelse(førsteHendelse)
            val resterendeHendelser = hendelser.minus(førsteHendelse)
            resterendeHendelser.forEach(sak::behandleHendelse)
            return sak
        }

        fun IASak?.medHendelser(hendelser: List<IASakshendelse>) =
            if (this?.sakshendelser?.isEmpty() == true) {
                this.sakshendelser.addAll(hendelser)
                this
            } else {
                this
            }

        fun Row.tilIASak(): IASak =
            IASak(
                saksnummer = this.string("saksnummer"),
                orgnr = this.string("orgnr"),
                opprettetTidspunkt = this.localDateTime("opprettet"),
                opprettetAv = this.string("opprettet_av"),
                endretTidspunkt = this.localDateTimeOrNull("endret"),
                endretAv = this.stringOrNull("endret_av"),
                status = Status.valueOf(this.string("status")),
                endretAvHendelseId = this.string("endret_av_hendelse"),
                eidAv = this.stringOrNull("eid_av"),
            )

        fun Row.tilIASakDto(): IASakDto =
            IASakDto(
                saksnummer = this.string("saksnummer"),
                orgnr = this.string("orgnr"),
                opprettetTidspunkt = this.localDateTime("opprettet").toKotlinLocalDateTime(),
                opprettetAv = this.string("opprettet_av"),
                endretTidspunkt = this.localDateTimeOrNull("endret")?.toKotlinLocalDateTime(),
                endretAv = this.stringOrNull("endret_av"),
                status = Status.valueOf(this.string("status")),
                endretAvHendelseId = this.string("endret_av_hendelse"),
                eidAv = this.stringOrNull("eid_av"),
                gyldigeNesteHendelser = emptyList(),
                lukket = false,
            )

        // -- trengs da IASak ikke er en data class
        fun IASak.kopier(): IASak =
            IASak(
                saksnummer = this.saksnummer,
                orgnr = this.orgnr,
                opprettetTidspunkt = this.opprettetTidspunkt,
                opprettetAv = this.opprettetAv,
                endretTidspunkt = this.endretTidspunkt,
                endretAv = this.endretAv,
                status = this.status,
                endretAvHendelseId = this.endretAvHendelseId,
                eidAv = this.eidAv,
            )
    }

    enum class Status {
        NY,
        IKKE_AKTIV,
        VURDERES,
        KONTAKTES,
        KARTLEGGES,
        VI_BISTÅR,
        IKKE_AKTUELL,
        FULLFØRT,
        SLETTET,

        // -- Ny flyt
        VURDERT,
        AKTIV,
        AVSLUTTET,
        ;

        fun regnesSomAvsluttet(): Boolean = this == IKKE_AKTUELL || this == FULLFØRT || this == SLETTET

        companion object {
            fun filtrerbareStatuser(): List<Status> = entries.filterNot { it == NY || it == SLETTET || it == VURDERT || it == AKTIV }
        }
    }
}

class TilstandsmaskinFeil(
    val feilmelding: String,
) {
    companion object {
        fun feil(feilmelding: String) = Either.Left(TilstandsmaskinFeil(feilmelding = feilmelding))

        fun generellFeil() = feil(feilmelding = "Forsøker å utføre en hendelse som ikke er implementert")
    }
}
