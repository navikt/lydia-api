package no.nav.lydia.helper

import com.github.kittinunf.fuel.core.extensions.authentication
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.statusoversikt.StatusoversiktResponsDto
import no.nav.lydia.statusoversikt.api.STATUSOVERSIKT_PATH
import no.nav.lydia.sykefraværsstatistikk.api.Søkeparametere

class StatusoversiktHelper {
    companion object {
        fun hentStatusoversikt(
            kommuner: String = "",
            fylker: String = "",
            næringsgrupper: String = "",
            sykefraværsprosentFra: String = "",
            sykefraværsprosentTil: String = "",
            ansatteFra: String = "",
            ansatteTil: String = "",
            bransjeProgram: String = "",
            snittFilter: String = "",
            eiere: String = "",
            sektor: String = "",
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = hentStatusoversiktRespons(
            kommuner = kommuner,
            fylker = fylker,
            næringsgrupper = næringsgrupper,
            sykefraværsprosentFra = sykefraværsprosentFra,
            sykefraværsprosentTil = sykefraværsprosentTil,
            ansatteFra = ansatteFra,
            ansatteTil = ansatteTil,
            bransjeProgram = bransjeProgram,
            snittFilter = snittFilter,
            eiere = eiere,
            sektor = sektor,
            token = token,
        )

        private fun hentStatusoversiktRespons(
            kommuner: String = "",
            fylker: String = "",
            næringsgrupper: String = "",
            sykefraværsprosentFra: String = "",
            sykefraværsprosentTil: String = "",
            ansatteFra: String = "",
            ansatteTil: String = "",
            bransjeProgram: String = "",
            snittFilter: String = "",
            eiere: String = "",
            sektor: String = "",
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = TestContainerHelper.applikasjon.performGet(
            STATUSOVERSIKT_PATH +
                "?${Søkeparametere.KOMMUNER}=$kommuner" +
                "&${Søkeparametere.FYLKER}=$fylker" +
                "&${Søkeparametere.NÆRINGSGRUPPER}=$næringsgrupper" +
                "&${Søkeparametere.SYKEFRAVÆRSPROSENT_FRA}=$sykefraværsprosentFra" +
                "&${Søkeparametere.SYKEFRAVÆRSPROSENT_TIL}=$sykefraværsprosentTil" +
                "&${Søkeparametere.ANSATTE_FRA}=$ansatteFra" +
                "&${Søkeparametere.ANSATTE_TIL}=$ansatteTil" +
                "&${Søkeparametere.BRANSJEPROGRAM}=$bransjeProgram" +
                "&${Søkeparametere.SNITT_FILTER}=$snittFilter" +
                "&${Søkeparametere.IA_SAK_EIERE}=$eiere" +
                "&${Søkeparametere.SEKTOR}=$sektor",
        )
            .authentication().bearer(token)
            .tilSingelRespons<StatusoversiktResponsDto>()
    }
}
