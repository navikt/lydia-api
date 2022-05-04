package no.nav.lydia.ia.sak.api


import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.SaksHendelsestype
import java.time.LocalDateTime

@Serializable
open class IASakshendelseDto(
    val orgnummer: String,
    val saksnummer: String,
    val hendelsesType: SaksHendelsestype,
    val endretAvHendelseId: String,
    val payload: String? = null
)

@Serializable
class IASakshendelseOppsummeringDto(
    val id : String,
    val orgnummer: String,
    val saksnummer: String,
    val hendelsestype: SaksHendelsestype,
    val opprettetAv: String,
    @Serializable(with = LocalDateTimeSerializer::class)
    val opprettetTidspunkt: LocalDateTime,

){
    companion object {
        fun List<IASakshendelse>.toDto() = this.map { it.toDto() }

        fun IASakshendelse.toDto() = IASakshendelseOppsummeringDto(
            id = this.id,
            orgnummer= this.orgnummer,
            saksnummer= this.saksnummer,
            hendelsestype= this.hendelsesType,
            opprettetAv= this.opprettetAv,
            opprettetTidspunkt= this.opprettetTidspunkt,
        )
    }
}

