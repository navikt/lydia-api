package no.nav.lydia.ia.sak.api

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.SaksHendelsestype
import java.time.LocalDateTime

@Serializable
class IASakshendelseDto(
    val orgnummer: String,
    val saksnummer: String,
    val hendelsesType: SaksHendelsestype,
    val endretAvHendelsesId: String
)

@Serializable
class IASakshendelseOppsummeringDto(
    val id : String,
    val orgnummer: String,
    val saksnummer: String,
    val hendelsestype: SaksHendelsestype,
    val opprettetAv: String,
//    val opprettetTidspunkt: LocalDateTime, // TODO: må finne ut hvordan man serialiserer LocalDateTime

){
    companion object {
        fun List<IASakshendelse>.toDto() = this.map { it.toDto() }

        fun IASakshendelse.toDto() = IASakshendelseOppsummeringDto(
            id = this.id,
            orgnummer= this.orgnummer,
            saksnummer= this.saksnummer,
            hendelsestype= this.hendelsesType,
            opprettetAv= this.opprettetAv,
//            opprettetTidspunkt= this.opprettetTidspunkt,
        )
    }
}


