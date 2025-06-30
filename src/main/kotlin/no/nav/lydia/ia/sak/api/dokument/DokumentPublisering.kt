package no.nav.lydia.ia.sak.api.dokument

import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import java.util.UUID

data class DokumentPublisering(
    val dokumentId: UUID,
    val referanseId: UUID,
    val opprettetAv: NavAnsatt,
    val status: Status,
    val dokumentType: Type,
) {
    companion object {
        fun String.tilDokumentTilPubliseringType(): Type =
            when (this) {
                "Evaluering" -> Type.EVALUERING
                "Behovsvurdering" -> Type.BEHOVSVURDERING
                "Samarbeidsplan" -> Type.SAMARBEIDSPLAN
                else -> throw kotlin.IllegalArgumentException("Ugyldig type: $this")
            }

        fun String?.tilDokumentTilPubliseringStatus(): Status =
            when (this) {
                "OPPRETTET" -> Status.OPPRETTET
                "PUBLISERT" -> Status.PUBLISERT
                "IKKE_PUBLISERT" -> Status.IKKE_PUBLISERT
                else -> Status.IKKE_PUBLISERT
            }
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
