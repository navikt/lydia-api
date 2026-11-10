package no.nav.lydia.samarbeid

import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.integrasjoner.salesforce.aktiviteter.SalesforceAktivitet
import java.time.ZonedDateTime

@Serializable
data class SalesforceAktivitetRespons(
    val id: String,
    val sistEndretISalesforce: LocalDateTime,
    val type: SalesforceAktivitet.Companion.AktivitetsType,
    val saksnummer: String,
    val samarbeidsId: Int?,
    val planId: String?,
    val tema: String?,
    val undertema: List<String>?,
    val planlagt: LocalDateTime?,
    val fullført: LocalDateTime?,
    val møteStart: LocalDateTime?,
    val møteSlutt: LocalDateTime?,
    val status: SalesforceAktivitet.Companion.AktivitetsStatus?,
    val emne: String?,
)

private fun ZonedDateTime.toKotlinLocalDateTime() = toLocalDateTime().toKotlinLocalDateTime()

internal fun SalesforceAktivitet.tilRespons() =
    SalesforceAktivitetRespons(
        id = id,
        sistEndretISalesforce = sistEndretISalesforce.toKotlinLocalDateTime(),
        type = type,
        saksnummer = saksnummer,
        samarbeidsId = samarbeidsId,
        planId = planId,
        tema = tema,
        undertema = undertema?.split(";"),
        planlagt = planlagt?.toKotlinLocalDateTime(),
        fullført = fullført?.toKotlinLocalDateTime(),
        møteStart = møteStart?.toKotlinLocalDateTime(),
        møteSlutt = møteSlutt?.toKotlinLocalDateTime(),
        status = status,
        emne = emne,
    )
