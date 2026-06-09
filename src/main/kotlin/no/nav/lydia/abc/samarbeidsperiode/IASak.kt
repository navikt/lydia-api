package no.nav.lydia.abc.samarbeidsperiode

import kotlinx.datetime.toKotlinLocalDateTime
import kotliquery.Row
import java.time.LocalDateTime

class IASak private constructor(
    val saksnummer: String,
    val orgnr: String,
    val opprettetTidspunkt: LocalDateTime,
    val opprettetAv: String,
    val eidAv: String?,
    val endretTidspunkt: LocalDateTime?,
    val endretAv: String?,
    val endretAvHendelseId: String,
    val status: Status,
) {
    private val sakshendelser = mutableListOf<IASakshendelse>()
    val hendelser get() = sakshendelser.toList()

    fun addHendelser(hendelser: List<IASakshendelse>): IASak {
        sakshendelser.addAll(hendelser)
        return this
    }

    companion object {
        fun Row.tilIASak(): IASak =
            IASak(
                saksnummer = this.string("saksnummer"),
                orgnr = this.string("orgnr"),
                opprettetTidspunkt = this.localDateTime("opprettet"),
                opprettetAv = this.string("opprettet_av"),
                endretTidspunkt = this.localDateTimeOrNull("endret"),
                endretAv = this.stringOrNull("endret_av"),
                status = Status.valueOf(this.string("status")),
                endretAvHendelseId = this.string("endret_av_hendelse"),
                eidAv = this.stringOrNull("eid_av"),
            )

        fun Row.tilIASakDto(): IASakDto =
            IASakDto(
                saksnummer = this.string("saksnummer"),
                orgnr = this.string("orgnr"),
                opprettetTidspunkt = this.localDateTime("opprettet").toKotlinLocalDateTime(),
                opprettetAv = this.string("opprettet_av"),
                endretTidspunkt = this.localDateTimeOrNull("endret")?.toKotlinLocalDateTime(),
                endretAv = this.stringOrNull("endret_av"),
                status = Status.valueOf(this.string("status")),
                endretAvHendelseId = this.string("endret_av_hendelse"),
                eidAv = this.stringOrNull("eid_av"),
                gyldigeNesteHendelser = emptyList(),
            )
    }

    enum class Status {
        NY,
        IKKE_AKTIV,
        VURDERES,
        KONTAKTES,
        KARTLEGGES,
        VI_BISTÅR,
        IKKE_AKTUELL,
        FULLFØRT,
        SLETTET,

        // -- Ny flyt
        VURDERT,
        AKTIV,
        AVSLUTTET,
        ;

        fun regnesSomAvsluttet(): Boolean = this == IKKE_AKTUELL || this == FULLFØRT || this == SLETTET || this == VURDERT || this == AVSLUTTET

        companion object {
            fun filtrerbareStatuser(): List<Status> = entries.filterNot { it == NY || it == SLETTET || it == VURDERT || it == AKTIV || it == AVSLUTTET }
        }
    }
}
