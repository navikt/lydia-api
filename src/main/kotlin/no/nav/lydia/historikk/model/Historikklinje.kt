package no.nav.lydia.historikk.model

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import no.nav.lydia.samarbeidsperiode.IASak
import no.nav.lydia.samarbeidsperiode.IASakshendelseType

@Serializable
data class Historikklinje(
    val beskrivelse: String,
    val tidspunkt: LocalDateTime?,
    @SerialName("relatert_hendelse") val relatertHendelse: HistorikkHendelse?,
)

@Serializable
data class HistorikkHendelse(
    @SerialName("hendelse_id")
    val hendelseId: String, // ULID
    val hendelsetype: IASakshendelseType,
    @SerialName("resulterende_status")
    val resulterendeStatus: IASak.Status,
    val tidspunkt: LocalDateTime,
    @SerialName("hendelse_opprettet_av")
    val hendelseOpprettetAv: String, // NavIdent
    val årsak: Årsak?,
    val versjon: HistorikkVersjon = HistorikkVersjon.fraTidspunkt(tidspunkt),
)

enum class HistorikkVersjon {
    LEGACY,
    NY_FLYT,
    ;

    companion object {
        val datoForEndring = LocalDateTime.parse("2026-04-28T00:00:00")

        fun fraTidspunkt(tidspunkt: LocalDateTime) = if (tidspunkt < datoForEndring) LEGACY else NY_FLYT
    }
}

@Serializable
data class Årsak(
    val beskrivelse: String,
    val begrunnelser: List<String>,
)
