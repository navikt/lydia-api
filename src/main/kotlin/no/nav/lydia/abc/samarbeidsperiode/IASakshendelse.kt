package no.nav.lydia.abc.samarbeidsperiode

import com.github.guepardoapps.kulid.ULID
import kotlinx.datetime.toJavaLocalDate
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.sykefraværsstatistikk.PubliseringsinfoDto
import no.nav.lydia.sykefraværsstatistikk.api.Periode
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker
import no.nav.lydia.tilgangskontroll.fia.Rolle
import java.time.LocalDateTime

open class IASakshendelse(
    val id: String,
    val opprettetTidspunkt: LocalDateTime,
    val saksnummer: String,
    val hendelsesType: IASakshendelseType,
    val orgnummer: String,
    val opprettetAv: String,
    val opprettetAvRolle: Rolle?,
    val navEnhet: NavEnhet,
    val resulterendeStatus: IASak.Status?,
) {
    companion object {
        fun nyFørsteHendelse(
            orgnummer: String,
            superbruker: Superbruker,
            navEnhet: NavEnhet,
        ): IASakshendelse {
            val saksnummer = ULID.random()
            return IASakshendelse(
                id = saksnummer,
                opprettetTidspunkt = LocalDateTime.now(),
                saksnummer = saksnummer,
                hendelsesType = IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
                orgnummer = orgnummer,
                opprettetAv = superbruker.navIdent,
                opprettetAvRolle = superbruker.rolle,
                navEnhet = navEnhet,
                resulterendeStatus = IASak.Status.NY,
            )
        }

        fun IASakshendelse.utledPeriodeForStatistikk(allPubliseringsinfo: List<PubliseringsinfoDto>): Periode {
            val hendelseDato = opprettetTidspunkt.toLocalDate()
            return allPubliseringsinfo
                .sortedWith(compareByDescending<PubliseringsinfoDto> { it.gjeldendePeriode.årstall }.thenByDescending { it.gjeldendePeriode.kvartal })
                .firstOrNull { info ->
                    !hendelseDato.isBefore(info.sistePubliseringsdato.toJavaLocalDate()) &&
                        !hendelseDato.isAfter(info.nestePubliseringsdato.toJavaLocalDate())
                }?.gjeldendePeriode?.tilPeriode() ?: Periode.fraDato(opprettetTidspunkt)
        }
    }

    @Serializable
    private data class Value(
        val id: String,
        val opprettetTidspunkt: String,
        val orgnummer: String,
        val saksnummer: String,
        val hendelsesType: IASakshendelseType,
        val opprettetAv: String,
    )

    internal open fun tilKeyValueJsonPair(): Pair<String, String> {
        val key = saksnummer
        val value = Value(
            id = id,
            opprettetTidspunkt = opprettetTidspunkt.toString(),
            orgnummer = orgnummer,
            saksnummer = saksnummer,
            hendelsesType = hendelsesType,
            opprettetAv = opprettetAv,
        )
        return key to Json.encodeToString(value)
    }
}

class VirksomhetIkkeAktuellHendelse(
    id: String,
    opprettetTidspunkt: LocalDateTime,
    saksnummer: String,
    hendelsesType: IASakshendelseType,
    orgnummer: String,
    opprettetAv: String,
    opprettetAvRolle: Rolle?,
    navEnhet: NavEnhet,
    resulterendeStatus: IASak.Status?,
    val valgtÅrsak: ValgtÅrsak,
) : IASakshendelse(
        id,
        opprettetTidspunkt = opprettetTidspunkt,
        saksnummer = saksnummer,
        hendelsesType = hendelsesType,
        orgnummer = orgnummer,
        opprettetAv = opprettetAv,
        opprettetAvRolle = opprettetAvRolle,
        navEnhet = navEnhet,
        resulterendeStatus = resulterendeStatus,
    ) {
    @Serializable
    private data class IkkeAktuellValue(
        val id: String,
        val opprettetTidspunkt: String,
        val orgnummer: String,
        val saksnummer: String,
        val hendelsesType: IASakshendelseType,
        val opprettetAv: String,
        val årsak: Årsak,
    )

    @Serializable
    private data class Årsak(
        val type: String,
        val begrunnelser: List<String>,
    )

    override fun tilKeyValueJsonPair(): Pair<String, String> {
        val key = super.tilKeyValueJsonPair().first
        val value = IkkeAktuellValue(
            id = id,
            opprettetAv = opprettetAv,
            opprettetTidspunkt = opprettetTidspunkt.toString(),
            orgnummer = orgnummer,
            hendelsesType = hendelsesType,
            saksnummer = saksnummer,
            årsak = Årsak(type = valgtÅrsak.type.navn, begrunnelser = valgtÅrsak.begrunnelser.map { it.navn }),
        )
        return key to Json.encodeToString(value)
    }
}

enum class IASakshendelseType {
    OPPRETT_SAK_FOR_VIRKSOMHET,
    VIRKSOMHET_VURDERES,
    TA_EIERSKAP_I_SAK,
    VIRKSOMHET_SKAL_KONTAKTES,
    VIRKSOMHET_KARTLEGGES,
    VIRKSOMHET_SKAL_BISTÅS,
    VIRKSOMHET_ER_IKKE_AKTUELL,

    // -- Prosesser
    NY_PROSESS,
    ENDRE_PROSESS,
    SLETT_PROSESS,
    FULLFØR_PROSESS,
    FULLFØR_PROSESS_MASKINELT_PÅ_EN_FULLFØRT_SAK,
    AVBRYT_PROSESS,
    // --

    TILBAKE,
    FULLFØR_BISTAND,
    SLETT_SAK,

    // -- Migrering til ny flyt
    MIGRERING_TIL_NY_FLYT,

    // -- Ny flyt
    VURDERING_FULLFØRT_UTEN_SAMARBEID,
    OPPRETT_KARTLEGGING,
    START_KARTLEGGING,
    FULLFØR_KARTLEGGING,
    SLETT_KARTLEGGING,
    OPPRETT_SAMARBEIDSPLAN,
    SLETT_SAMARBEIDSPLAN,
    ENDRE_PLANLAGT_DATO,
}
