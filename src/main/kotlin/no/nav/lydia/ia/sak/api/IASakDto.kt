package no.nav.lydia.ia.sak.api

import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.GyldigHendelse
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle

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
    val gyldigeNesteHendelser: List<GyldigHendelse>,
    val lukket: Boolean,
) {
    companion object {
        fun List<IASak>.toDto(navAnsatt: NavAnsatt) = this.map { it.toDto(navAnsatt) }

        fun IASak.toDto(navAnsatt: NavAnsatt) =
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
                gyldigeNesteHendelser = when (navAnsatt) {
                    is NavAnsattMedSaksbehandlerRolle -> this.gyldigeNesteHendelser(navAnsatt, false)
                    else -> listOf()
                },
                lukket = this.erLukket(),
            )

        fun IASak.erLukket() = this.erEtterFristenForLåsingAvSak() && (this.status == IASak.Status.FULLFØRT || this.status == IASak.Status.IKKE_AKTUELL)
    }
}
