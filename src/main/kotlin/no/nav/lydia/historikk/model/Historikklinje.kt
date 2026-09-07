package no.nav.lydia.historikk.model

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import no.nav.lydia.getEnvVar
import no.nav.lydia.prioritering.sykefraværsstatistikk.api.EierDTO
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
    val aktør: EierDTO? = null,
    val årsak: Årsak?,
    val versjon: HistorikkVersjon = HistorikkVersjon.fraTidspunkt(tidspunkt),
)

enum class HistorikkVersjon {
    LEGACY,
    NY_FLYT,
    ;

    companion object {
        val DATO_FOR_MIGRERING_TIL_NY_FLYT_I_PROD = "2026-04-28T00:00:00"
        val DATO_FOR_MIGRERING_TIL_NY_FLYT_I_DEV = "2026-03-31T00:00:00"
        val datoForEndring =
            if (getEnvVar(
                    varName = "NAIS_CLUSTER_NAME",
                    defaultValue = "PROD-GCP",
                ) == "PROD-GCP"
            ) {
                LocalDateTime.parse(DATO_FOR_MIGRERING_TIL_NY_FLYT_I_PROD)
            } else {
                LocalDateTime.parse(DATO_FOR_MIGRERING_TIL_NY_FLYT_I_DEV)
            }

        fun fraTidspunkt(tidspunkt: LocalDateTime) = if (tidspunkt < datoForEndring) LEGACY else NY_FLYT
    }
}

@Serializable
data class Årsak(
    val beskrivelse: String,
    val begrunnelser: List<String>,
)
