package no.nav.lydia.historikk

import no.nav.lydia.samarbeidsperiode.IASakshendelseType

object HistorikkUtils {
    fun IASakshendelseType.tilBeskrivelse(): String =
        when (this) {
            IASakshendelseType.VIRKSOMHET_AVREGISTRERT -> {
                "Virksomheten er slettet i Brønnøysundregistrene"
            }

            IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET, IASakshendelseType.VIRKSOMHET_VURDERES, IASakshendelseType.TA_EIERSKAP_I_SAK,
            IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES, IASakshendelseType.VIRKSOMHET_KARTLEGGES, IASakshendelseType.VIRKSOMHET_SKAL_BISTÅS,
            IASakshendelseType.VIRKSOMHET_ER_IKKE_AKTUELL, IASakshendelseType.NY_PROSESS, IASakshendelseType.ENDRE_PROSESS, IASakshendelseType.SLETT_PROSESS,
            IASakshendelseType.FULLFØR_PROSESS, IASakshendelseType.FULLFØR_PROSESS_MASKINELT_PÅ_EN_FULLFØRT_SAK, IASakshendelseType.AVBRYT_PROSESS,
            IASakshendelseType.TILBAKE, IASakshendelseType.FULLFØR_BISTAND, IASakshendelseType.SLETT_SAK, IASakshendelseType.MIGRERING_TIL_NY_FLYT,
            IASakshendelseType.VURDERING_FULLFØRT_UTEN_SAMARBEID, IASakshendelseType.OPPRETT_KARTLEGGING, IASakshendelseType.START_KARTLEGGING,
            IASakshendelseType.FULLFØR_KARTLEGGING, IASakshendelseType.SLETT_KARTLEGGING, IASakshendelseType.OPPRETT_SAMARBEIDSPLAN,
            IASakshendelseType.SLETT_SAMARBEIDSPLAN, IASakshendelseType.ENDRE_PLANLAGT_DATO,
            -> {
                this.name // TODO: Skriv tekster etter behov
            }
        }
}
