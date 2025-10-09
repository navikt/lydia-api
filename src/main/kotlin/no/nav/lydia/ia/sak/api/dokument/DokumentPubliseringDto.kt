package no.nav.lydia.ia.sak.api.dokument

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable

@Serializable
data class DokumentPubliseringDto(
    val referanseId: String,
    val opprettetAv: String,
    val dokumentType: Type,
    val opprettetTidspunkt: LocalDateTime,
) {
    companion object {
        fun String.tilDokumentTilPubliseringType(): Type = Type.valueOf(this.uppercase())
    }

    enum class Status {
        OPPRETTET,
        PUBLISERT,
        IKKE_PUBLISERT,
    }

    enum class Type {
        EVALUERING,
        BEHOVSVURDERING,
        SAMARBEIDSPLAN,
    }
}
