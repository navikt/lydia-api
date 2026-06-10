package no.nav.lydia.dokumentpublisering.arbeidsgiver

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.samarbeid.IASamarbeid

@Serializable
data class SamarbeidMedDokumenterDto(
    val offentligId: String,
    val navn: String,
    val status: IASamarbeid.Status? = null,
    val sistEndret: LocalDateTime? = null,
    val dokumenter: List<DokumentMetadata> = emptyList(),
)
