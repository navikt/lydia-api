package no.nav.lydia.ia.sak.domene

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import com.github.guepardoapps.kulid.ULID
import io.ktor.http.*
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakshendelseDto
import java.time.LocalDateTime

open class IASakshendelse(
    val id: String,
    val opprettetTidspunkt: LocalDateTime,
    val saksnummer: String,
    val hendelsesType: SaksHendelsestype,
    val orgnummer: String,
    val opprettetAv: String,
) {
    companion object {
        fun fromDto(dto: IASakshendelseDto, navIdent: String) =
            when (dto.hendelsesType) {
                SaksHendelsestype.VIRKSOMHET_ER_IKKE_AKTUELL -> AvslagsHendelse.fromDto(dto, navIdent)
                else -> IASakshendelse(
                    id = ULID.random(),
                    opprettetTidspunkt = LocalDateTime.now(),
                    saksnummer = dto.saksnummer,
                    hendelsesType = dto.hendelsesType,
                    orgnummer = dto.orgnummer,
                    opprettetAv = navIdent,
                ).right()
            }
    }
}

class AvslagsHendelse(
    id: String,
    opprettetTidspunkt: LocalDateTime,
    saksnummer: String,
    hendelsesType: SaksHendelsestype,
    orgnummer: String,
    opprettetAv: String,
    årsak: Årsak
) : IASakshendelse(
    id,
    opprettetTidspunkt = opprettetTidspunkt,
    saksnummer = saksnummer,
    hendelsesType = hendelsesType,
    orgnummer = orgnummer,
    opprettetAv = opprettetAv
) {
    companion object {
        fun fromDto(dto: IASakshendelseDto, navIdent: String): Either<Feil, AvslagsHendelse> =
            dto.payload?.let { payload ->
                try {
                    val årsak = Json.decodeFromString<Årsak>(dto.payload)
                    AvslagsHendelse(
                        id = ULID.random(),
                        opprettetTidspunkt = LocalDateTime.now(),
                        saksnummer = dto.saksnummer,
                        hendelsesType = dto.hendelsesType,
                        orgnummer = dto.orgnummer,
                        opprettetAv = navIdent,
                        årsak = årsak
                    ).right()
                } catch (e: Exception) {
                   SaksHendelseFeil.`kunne ikke deserialisere årsak`.left()
                }
            } ?: SaksHendelseFeil.`kunne ikke deserialisere årsak`.left()
    }
}

object SaksHendelseFeil {
    val `kunne ikke deserialisere årsak` =  Feil(feilmelding = "Kunne ikke deserialisere årsak", httpStatusCode = HttpStatusCode.BadRequest)
}

@kotlinx.serialization.Serializable
class Årsak(val type: String, val begrunnelser: List<String>)

enum class SaksHendelsestype {
    OPPRETT_SAK_FOR_VIRKSOMHET,
    VIRKSOMHET_VURDERES,
    TA_EIERSKAP_I_SAK,
    VIRKSOMHET_SKAL_KONTAKTES,
    VIRKSOMHET_ER_IKKE_AKTUELL
}
