package no.nav.lydia.abc.samarbeidsperiode

import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.Transient

@Serializable
data class IASakDto(
    val saksnummer: String,
    val orgnr: String,
    var status: IASak.Status,
    val opprettetAv: String,
    val opprettetTidspunkt: LocalDateTime,
    val endretAv: String?,
    val endretTidspunkt: LocalDateTime?,
    val eidAv: String?,
    val endretAvHendelseId: String,
    val gyldigeNesteHendelser: List<Unit>, // TODO: [OPPRYDDING] kan fjernes etter at den er fjernet fra frontend
    val lukket: Boolean = false, // TODO: [OPPRYDDING] kan fjernes etter at den er fjernet fra frontend
) {
    @Transient
    private val sakshendelser = mutableListOf<IASakshendelse>()
    val hendelser get() = sakshendelser.toList()

    fun addHendelser(hendelser: List<IASakshendelse>): IASakDto {
        sakshendelser.addAll(hendelser)
        return this
    }

    companion object {
        fun List<IASak>.toDto() = this.map { it.toDto() }

        fun IASak.toDto() =
            IASakDto(
                saksnummer = this.saksnummer,
                orgnr = this.orgnr,
                status = this.status,
                opprettetAv = this.opprettetAv,
                opprettetTidspunkt = this.opprettetTidspunkt.toKotlinLocalDateTime(),
                endretAv = this.endretAv,
                endretTidspunkt = this.endretTidspunkt?.toKotlinLocalDateTime(),
                eidAv = this.eidAv,
                endretAvHendelseId = this.endretAvHendelseId,
                gyldigeNesteHendelser = listOf(), // TODO: [OPPRYDDING] Fjern fra frontend
            )
    }
}
