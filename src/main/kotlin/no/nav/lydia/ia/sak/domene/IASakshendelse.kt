package no.nav.lydia.ia.sak.domene

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import com.github.guepardoapps.kulid.ULID
import io.ktor.http.HttpStatusCode
import kotlinx.serialization.Serializable
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakshendelseDto
import no.nav.lydia.ia.sak.domene.SaksHendelsestype.VIRKSOMHET_ER_IKKE_AKTUELL
import no.nav.lydia.ia.årsak.domene.GyldigÅrsak
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import java.time.LocalDateTime

open class IASakshendelse(
    val id: String,
    val opprettetTidspunkt: LocalDateTime,
    val saksnummer: String,
    val hendelsesType: SaksHendelsestype,
    val orgnummer: String,
    val opprettetAv: String
) {
    companion object {
        fun fromDto(dto: IASakshendelseDto, navIdent: String) =
            when (dto.hendelsesType) {
                VIRKSOMHET_ER_IKKE_AKTUELL -> VirksomhetIkkeAktuellHendelse.fromDto(dto, navIdent)
                else -> IASakshendelse(
                    id = ULID.random(),
                    opprettetTidspunkt = LocalDateTime.now(),
                    saksnummer = dto.saksnummer,
                    hendelsesType = dto.hendelsesType,
                    orgnummer = dto.orgnummer,
                    opprettetAv = navIdent,
                ).right()
            }

        fun nyFørsteHendelse(orgnummer : String, opprettetAv: String): IASakshendelse {
            val saksnummer = ULID.random()
            return IASakshendelse(
                id = saksnummer,
                opprettetTidspunkt = LocalDateTime.now(),
                saksnummer = saksnummer,
                hendelsesType = SaksHendelsestype.OPPRETT_SAK_FOR_VIRKSOMHET,
                orgnummer = orgnummer,
                opprettetAv = opprettetAv,
            )
        }

        fun IASak.nyHendelseBasertPåSak(hendelsestype: SaksHendelsestype, opprettetAv: String) =
            IASakshendelse(
                id = ULID.random(),
                opprettetTidspunkt = LocalDateTime.now(),
                saksnummer = this.saksnummer,
                hendelsesType = hendelsestype,
                orgnummer = this.orgnr,
                opprettetAv = opprettetAv,
            )
    }

    @Serializable
    private data class Value(val id: String, val opprettetTidspunkt: String, val orgnummer: String, val saksnummer: String, val hendelsesType: SaksHendelsestype, val opprettetAv: String)

    internal open fun tilKeyValueJsonPair(): Pair<String, String> {
        val key = saksnummer
        val value = Value(
            id = id,
            opprettetTidspunkt = opprettetTidspunkt.toString(),
            orgnummer = orgnummer,
            saksnummer = saksnummer,
            hendelsesType = hendelsesType,
            opprettetAv = opprettetAv
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
    val valgtÅrsak: ValgtÅrsak
) : IASakshendelse(
    id,
    opprettetTidspunkt = opprettetTidspunkt,
    saksnummer = saksnummer,
    hendelsesType = VIRKSOMHET_ER_IKKE_AKTUELL,
    orgnummer = orgnummer,
    opprettetAv = opprettetAv
) {
    companion object {
        fun fromDto(dto: IASakshendelseDto, navIdent: String): Either<Feil, VirksomhetIkkeAktuellHendelse> =
            dto.payload?.let { payload ->
                try {
                    VirksomhetIkkeAktuellHendelse(
                        id = ULID.random(),
                        opprettetTidspunkt = LocalDateTime.now(),
                        saksnummer = dto.saksnummer,
                        orgnummer = dto.orgnummer,
                        opprettetAv = navIdent,
                        valgtÅrsak = Json.decodeFromString(dto.payload)
                    ).right()
                } catch (e: Exception) {
                    SaksHendelseFeil.`kunne ikke deserialisere årsak`.left()
                }
            } ?: SaksHendelseFeil.`kunne ikke deserialisere årsak`.left()
    }

    @Serializable
    private data class IkkeAktuellValue(
        val id: String,
        val opprettetTidspunkt: String,
        val orgnummer: String,
        val saksnummer: String,
        val hendelsesType: SaksHendelsestype,
        val opprettetAv: String,
        val årsak: Årsak
    )

    @Serializable
    private data class Årsak(val type: String, val begrunnelser: List<String>)

    override fun tilKeyValueJsonPair(): Pair<String, String> {
        val key = super.tilKeyValueJsonPair().first
        val value = IkkeAktuellValue(
            id = id,
            opprettetAv = opprettetAv,
            opprettetTidspunkt = opprettetTidspunkt.toString(),
            orgnummer = orgnummer,
            hendelsesType = hendelsesType,
            saksnummer = saksnummer,
            årsak = Årsak(type = valgtÅrsak.type.navn, begrunnelser = valgtÅrsak.begrunnelser.map { it.navn })
        )
        return key to Json.encodeToString(value)
    }
}

object SaksHendelseFeil {
    val `kunne ikke deserialisere årsak` =
        Feil(feilmelding = "Kunne ikke deserialisere årsak", httpStatusCode = HttpStatusCode.BadRequest)
}

enum class SaksHendelsestype {
    OPPRETT_SAK_FOR_VIRKSOMHET,
    VIRKSOMHET_VURDERES,
    TA_EIERSKAP_I_SAK,
    VIRKSOMHET_SKAL_KONTAKTES,
    VIRKSOMHET_KARTLEGGES,
    VIRKSOMHET_SKAL_BISTÅS,
    VIRKSOMHET_ER_IKKE_AKTUELL,
    TILBAKE,
    FULLFØR_BISTAND,
    SLETT_SAK
}

@Serializable
class GyldigHendelse(
    val saksHendelsestype: SaksHendelsestype
) {
    val gyldigeÅrsaker: List<GyldigÅrsak> = when (saksHendelsestype) {
        VIRKSOMHET_ER_IKKE_AKTUELL -> GyldigÅrsak.from(saksHendelsestype)
        else -> emptyList()
    }
}
