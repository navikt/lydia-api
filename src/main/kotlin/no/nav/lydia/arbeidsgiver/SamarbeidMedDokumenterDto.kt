package no.nav.lydia.arbeidsgiver

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid

@Serializable
data class SamarbeidMedDokumenterDto(
    @Deprecated("Bruk offentligId istedenfor id")
    val id: Int,
    val offentligId: String,
    val navn: String,
    val status: IASamarbeid.Status? = null,
    val sistEndret: LocalDateTime? = null,
    val dokumenter: List<DokumentMetadata> = emptyList(),
)
