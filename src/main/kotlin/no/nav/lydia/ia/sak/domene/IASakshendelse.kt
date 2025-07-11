package no.nav.lydia.ia.sak.domene

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import com.github.guepardoapps.kulid.ULID
import io.ktor.http.HttpStatusCode
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakshendelseDto
import no.nav.lydia.ia.sak.api.samarbeid.IASamarbeidDto
import no.nav.lydia.ia.sak.domene.IASakshendelseType.AVBRYT_PROSESS
import no.nav.lydia.ia.sak.domene.IASakshendelseType.ENDRE_PROSESS
import no.nav.lydia.ia.sak.domene.IASakshendelseType.FULLFØR_PROSESS
import no.nav.lydia.ia.sak.domene.IASakshendelseType.NY_PROSESS
import no.nav.lydia.ia.sak.domene.IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET
import no.nav.lydia.ia.sak.domene.IASakshendelseType.SLETT_PROSESS
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_ER_IKKE_AKTUELL
import no.nav.lydia.ia.årsak.domene.GyldigÅrsak
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.ia.årsak.domene.validerBegrunnelser
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker
import no.nav.lydia.tilgangskontroll.fia.Rolle
import java.time.LocalDateTime

open class IASakshendelse(
    val id: String,
    val opprettetTidspunkt: LocalDateTime,
    val saksnummer: String,
    val hendelsesType: IASakshendelseType,
    val orgnummer: String,
    val opprettetAv: String,
    val opprettetAvRolle: Rolle?,
    val navEnhet: NavEnhet,
    val resulterendeStatus: IASak.Status?,
) {
    companion object {
        fun fromDto(
            dto: IASakshendelseDto,
            saksbehandler: NavAnsattMedSaksbehandlerRolle,
            navEnhet: NavEnhet,
        ) = when (dto.hendelsesType) {
            VIRKSOMHET_ER_IKKE_AKTUELL -> VirksomhetIkkeAktuellHendelse.fromDto(dto, saksbehandler, navEnhet)

            NY_PROSESS,
            ENDRE_PROSESS,
            SLETT_PROSESS,
            FULLFØR_PROSESS,
            AVBRYT_PROSESS,
            -> ProsessHendelse.fromDto(dto, saksbehandler, navEnhet)

            else -> IASakshendelse(
                id = ULID.random(),
                opprettetTidspunkt = LocalDateTime.now(),
                saksnummer = dto.saksnummer,
                hendelsesType = dto.hendelsesType,
                orgnummer = dto.orgnummer,
                opprettetAv = saksbehandler.navIdent,
                opprettetAvRolle = saksbehandler.rolle,
                navEnhet = navEnhet,
                resulterendeStatus = null,
            ).right()
        }

        fun nyFørsteHendelse(
            orgnummer: String,
            superbruker: Superbruker,
            navEnhet: NavEnhet,
        ): IASakshendelse {
            val saksnummer = ULID.random()
            return IASakshendelse(
                id = saksnummer,
                opprettetTidspunkt = LocalDateTime.now(),
                saksnummer = saksnummer,
                hendelsesType = OPPRETT_SAK_FOR_VIRKSOMHET,
                orgnummer = orgnummer,
                opprettetAv = superbruker.navIdent,
                opprettetAvRolle = superbruker.rolle,
                navEnhet = navEnhet,
                resulterendeStatus = IASak.Status.NY,
            )
        }

        fun IASak.nyHendelseBasertPåSak(
            hendelsestype: IASakshendelseType,
            superbruker: Superbruker,
            navEnhet: NavEnhet,
        ) = IASakshendelse(
            id = ULID.random(),
            opprettetTidspunkt = LocalDateTime.now(),
            saksnummer = this.saksnummer,
            hendelsesType = hendelsestype,
            orgnummer = this.orgnr,
            opprettetAv = superbruker.navIdent,
            opprettetAvRolle = superbruker.rolle,
            navEnhet = navEnhet,
            resulterendeStatus = null,
        )
    }

    @Serializable
    private data class Value(
        val id: String,
        val opprettetTidspunkt: String,
        val orgnummer: String,
        val saksnummer: String,
        val hendelsesType: IASakshendelseType,
        val opprettetAv: String,
    )

    internal open fun tilKeyValueJsonPair(): Pair<String, String> {
        val key = saksnummer
        val value = Value(
            id = id,
            opprettetTidspunkt = opprettetTidspunkt.toString(),
            orgnummer = orgnummer,
            saksnummer = saksnummer,
            hendelsesType = hendelsesType,
            opprettetAv = opprettetAv,
        )
        return key to Json.encodeToString(value)
    }
}

class VirksomhetIkkeAktuellHendelse(
    id: String,
    opprettetTidspunkt: LocalDateTime,
    saksnummer: String,
    orgnummer: String,
    opprettetAv: String,
    opprettetAvRolle: Rolle?,
    navEnhet: NavEnhet,
    resulterendeStatus: IASak.Status?,
    val valgtÅrsak: ValgtÅrsak,
) : IASakshendelse(
        id,
        opprettetTidspunkt = opprettetTidspunkt,
        saksnummer = saksnummer,
        hendelsesType = VIRKSOMHET_ER_IKKE_AKTUELL,
        orgnummer = orgnummer,
        opprettetAv = opprettetAv,
        opprettetAvRolle = opprettetAvRolle,
        navEnhet = navEnhet,
        resulterendeStatus = resulterendeStatus,
    ) {
    companion object {
        fun fromDto(
            dto: IASakshendelseDto,
            navAnsatt: NavAnsatt,
            navEnhet: NavEnhet,
        ): Either<Feil, VirksomhetIkkeAktuellHendelse> =
            dto.payload?.let { payload ->

                try {
                    val valgtÅrsak: ValgtÅrsak = Json.decodeFromString(dto.payload)
                    if (!valgtÅrsak.validerBegrunnelser()) {
                        return SaksHendelseFeil.`valgte begrunnelser tilhører ikke riktig årsak`.left()
                    }

                    VirksomhetIkkeAktuellHendelse(
                        id = ULID.random(),
                        opprettetTidspunkt = LocalDateTime.now(),
                        saksnummer = dto.saksnummer,
                        orgnummer = dto.orgnummer,
                        opprettetAv = navAnsatt.navIdent,
                        opprettetAvRolle = navAnsatt.rolle,
                        valgtÅrsak = valgtÅrsak,
                        navEnhet = navEnhet,
                        resulterendeStatus = null,
                    ).right()
                } catch (e: Exception) {
                    SaksHendelseFeil.`kunne ikke deserialisere payload`.left()
                }
            } ?: SaksHendelseFeil.`kunne ikke deserialisere payload`.left()
    }

    @Serializable
    private data class IkkeAktuellValue(
        val id: String,
        val opprettetTidspunkt: String,
        val orgnummer: String,
        val saksnummer: String,
        val hendelsesType: IASakshendelseType,
        val opprettetAv: String,
        val årsak: Årsak,
    )

    @Serializable
    private data class Årsak(
        val type: String,
        val begrunnelser: List<String>,
    )

    override fun tilKeyValueJsonPair(): Pair<String, String> {
        val key = super.tilKeyValueJsonPair().first
        val value = IkkeAktuellValue(
            id = id,
            opprettetAv = opprettetAv,
            opprettetTidspunkt = opprettetTidspunkt.toString(),
            orgnummer = orgnummer,
            hendelsesType = hendelsesType,
            saksnummer = saksnummer,
            årsak = Årsak(type = valgtÅrsak.type.navn, begrunnelser = valgtÅrsak.begrunnelser.map { it.navn }),
        )
        return key to Json.encodeToString(value)
    }
}

class ProsessHendelse(
    id: String,
    opprettetTidspunkt: LocalDateTime,
    saksnummer: String,
    hendelsesType: IASakshendelseType,
    orgnummer: String,
    opprettetAv: String,
    opprettetAvRolle: Rolle?,
    navEnhet: NavEnhet,
    resulterendeStatus: IASak.Status?,
    val samarbeidDto: IASamarbeidDto,
) : IASakshendelse(
        id,
        opprettetTidspunkt,
        saksnummer,
        hendelsesType,
        orgnummer,
        opprettetAv,
        opprettetAvRolle,
        navEnhet,
        resulterendeStatus,
    ) {
    companion object {
        fun fromDto(
            dto: IASakshendelseDto,
            navAnsatt: NavAnsatt,
            navEnhet: NavEnhet,
        ): Either<Feil, ProsessHendelse> =
            dto.payload?.let { payload ->
                ProsessHendelse(
                    id = ULID.random(),
                    opprettetTidspunkt = LocalDateTime.now(),
                    saksnummer = dto.saksnummer,
                    hendelsesType = dto.hendelsesType,
                    orgnummer = dto.orgnummer,
                    opprettetAv = navAnsatt.navIdent,
                    opprettetAvRolle = navAnsatt.rolle,
                    samarbeidDto = Json.decodeFromString<IASamarbeidDto>(payload),
                    navEnhet = navEnhet,
                    resulterendeStatus = null,
                ).right()
            } ?: SaksHendelseFeil.`kunne ikke deserialisere payload`.left()
    }
}

object SaksHendelseFeil {
    val `valgte begrunnelser tilhører ikke riktig årsak` =
        Feil(feilmelding = "valgte begrunnelser tilhører ikke riktig årsak", httpStatusCode = HttpStatusCode.BadRequest)
    val `kunne ikke deserialisere payload` =
        Feil(feilmelding = "Kunne ikke deserialisere payload", httpStatusCode = HttpStatusCode.BadRequest)
}

enum class IASakshendelseType {
    OPPRETT_SAK_FOR_VIRKSOMHET,
    VIRKSOMHET_VURDERES,
    TA_EIERSKAP_I_SAK,
    VIRKSOMHET_SKAL_KONTAKTES,
    VIRKSOMHET_KARTLEGGES,
    VIRKSOMHET_SKAL_BISTÅS,
    VIRKSOMHET_ER_IKKE_AKTUELL,

    // -- Prosesser
    NY_PROSESS,
    ENDRE_PROSESS,
    SLETT_PROSESS,
    FULLFØR_PROSESS,
    FULLFØR_PROSESS_MASKINELT_PÅ_EN_FULLFØRT_SAK,
    AVBRYT_PROSESS,
    // --

    TILBAKE,
    FULLFØR_BISTAND,
    SLETT_SAK,
}

@Serializable
class GyldigHendelse(
    val saksHendelsestype: IASakshendelseType,
) {
    val gyldigeÅrsaker: List<GyldigÅrsak> = when (saksHendelsestype) {
        VIRKSOMHET_ER_IKKE_AKTUELL -> GyldigÅrsak.from(saksHendelsestype)
        else -> emptyList()
    }
}
