package no.nav.lydia.helper

import com.github.kittinunf.fuel.core.extensions.authentication
import no.nav.lydia.api.ANTALL_TREFF
import no.nav.lydia.api.FILTERVERDIER_PATH
import no.nav.lydia.api.HISTORISK_STATISTIKK
import no.nav.lydia.api.PUBLISERINGSINFO
import no.nav.lydia.api.SISTE_4_KVARTALER
import no.nav.lydia.api.SISTE_TILGJENGELIGE_KVARTAL
import no.nav.lydia.api.SYKEFRAVÆRSSTATISTIKK_PATH
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.prioritering.sykefraværsstatistikk.Publiseringsinfo
import no.nav.lydia.prioritering.sykefraværsstatistikk.api.FilterverdierDto
import no.nav.lydia.prioritering.sykefraværsstatistikk.api.Søkeparametere
import no.nav.lydia.prioritering.sykefraværsstatistikk.api.VirksomhetsoversiktDto
import no.nav.lydia.prioritering.sykefraværsstatistikk.api.VirksomhetsoversiktResponsDto
import no.nav.lydia.prioritering.sykefraværsstatistikk.api.VirksomhetsstatistikkSiste4KvartalDto
import no.nav.lydia.prioritering.sykefraværsstatistikk.domene.HistoriskStatistikk
import no.nav.lydia.prioritering.sykefraværsstatistikk.domene.VirksomhetsstatistikkSisteKvartal
import no.nav.lydia.prioritering.virksomhet.domene.Sektor
import kotlin.test.fail

class StatistikkHelper {
    companion object {
        fun hentSykefravær(
            success: (VirksomhetsoversiktResponsDto) -> Unit,
            kommuner: String = "",
            fylker: String = "",
            næringsgrupper: String = "",
            sorteringsnokkel: String = "",
            sorteringsretning: String = "",
            sykefraværsprosentFra: String = "",
            sykefraværsprosentTil: String = "",
            ansatteFra: String = "",
            ansatteTil: String = "",
            iaStatus: String = "",
            side: String = "",
            bransjeProgram: String = "",
            eiere: String = "",
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = hentSykefraværRespons(
            kommuner = kommuner,
            fylker = fylker,
            næringsgrupper = næringsgrupper,
            sorteringsnokkel = sorteringsnokkel,
            sorteringsretning = sorteringsretning,
            sykefraværsprosentFra = sykefraværsprosentFra,
            sykefraværsprosentTil = sykefraværsprosentTil,
            ansatteFra = ansatteFra,
            ansatteTil = ansatteTil,
            iaStatus = iaStatus,
            side = side,
            bransjeProgram = bransjeProgram,
            eiere = eiere,
            token = token,
        ).third
            .fold(success = { response -> success.invoke(response) }, failure = {
                fail("${it.message} - ${it.response.body().asString("text/plain")}")
            })

        fun hentSykefravær(
            kommuner: String = "",
            fylker: String = "",
            næringsgrupper: String = "",
            sorteringsnokkel: String = "",
            sorteringsretning: String = "",
            sykefraværsprosentFra: String = "",
            sykefraværsprosentTil: String = "",
            snittFilter: String = "",
            ansatteFra: String = "",
            ansatteTil: String = "",
            iaStatus: String = "",
            virksomhetTilstand: String = "",
            side: String = "",
            bransjeProgram: String = "",
            eiere: String = "",
            sektor: List<Sektor> = listOf(),
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = hentSykefraværRespons(
            kommuner = kommuner,
            fylker = fylker,
            næringsgrupper = næringsgrupper,
            sorteringsnokkel = sorteringsnokkel,
            sorteringsretning = sorteringsretning,
            sykefraværsprosentFra = sykefraværsprosentFra,
            sykefraværsprosentTil = sykefraværsprosentTil,
            snittFilter = snittFilter,
            ansatteFra = ansatteFra,
            ansatteTil = ansatteTil,
            iaStatus = iaStatus,
            virkomhetTilstand = virksomhetTilstand,
            side = side,
            bransjeProgram = bransjeProgram,
            eiere = eiere,
            sektor = sektor,
            token = token,
        ).third.get()

        fun hentSykefraværRespons(
            kommuner: String = "",
            fylker: String = "",
            næringsgrupper: String = "",
            sorteringsnokkel: String = "",
            sorteringsretning: String = "",
            sykefraværsprosentFra: String = "",
            sykefraværsprosentTil: String = "",
            snittFilter: String = "",
            ansatteFra: String = "",
            ansatteTil: String = "",
            iaStatus: String = "",
            virkomhetTilstand: String = "",
            side: String = "",
            bransjeProgram: String = "",
            eiere: String = "",
            sektor: List<Sektor> = listOf(),
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = TestContainerHelper.applikasjon.performGet(
            SYKEFRAVÆRSSTATISTIKK_PATH +
                "?${Søkeparametere.KOMMUNER}=$kommuner" +
                "&${Søkeparametere.FYLKER}=$fylker" +
                "&${Søkeparametere.NÆRINGSGRUPPER}=$næringsgrupper" +
                "&${Søkeparametere.SORTERINGSNØKKEL}=$sorteringsnokkel" +
                "&${Søkeparametere.SORTERINGSRETNING}=$sorteringsretning" +
                "&${Søkeparametere.SYKEFRAVÆRSPROSENT_FRA}=$sykefraværsprosentFra" +
                "&${Søkeparametere.SYKEFRAVÆRSPROSENT_TIL}=$sykefraværsprosentTil" +
                "&${Søkeparametere.SNITT_FILTER}=$snittFilter" +
                "&${Søkeparametere.ANSATTE_FRA}=$ansatteFra" +
                "&${Søkeparametere.ANSATTE_TIL}=$ansatteTil" +
                "&${Søkeparametere.IA_STATUS}=$iaStatus" +
                "&${Søkeparametere.VIRKSOMHET_TILSTAND}=$virkomhetTilstand" +
                "&${Søkeparametere.SIDE}=$side" +
                "&${Søkeparametere.BRANSJEPROGRAM}=$bransjeProgram" +
                "&${Søkeparametere.IA_SAK_EIERE}=$eiere" +
                "&${Søkeparametere.SEKTOR}=${sektor.joinToString(separator = ",") { it.kode }}",
        )
            .authentication().bearer(token)
            .tilSingelRespons<VirksomhetsoversiktResponsDto>()

        fun hentStatistikkHistorikk(orgnr: String) = hentStatistikkHistorikkRespons(orgnr).third.get()

        private fun hentStatistikkHistorikkRespons(
            orgnr: String,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = TestContainerHelper.applikasjon.performGet(
            "${SYKEFRAVÆRSSTATISTIKK_PATH}/$orgnr/${HISTORISK_STATISTIKK}",
        )
            .authentication().bearer(token)
            .tilSingelRespons<HistoriskStatistikk>()

        fun hentSykefraværForVirksomhetSiste4KvartalerRespons(
            orgnummer: String,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = TestContainerHelper.applikasjon.performGet("${SYKEFRAVÆRSSTATISTIKK_PATH}/$orgnummer/${SISTE_4_KVARTALER}")
            .authentication().bearer(token)
            .tilSingelRespons<VirksomhetsstatistikkSiste4KvartalDto>()

        private fun hentPubliseringsinfoRespons(token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token) =
            TestContainerHelper.applikasjon.performGet("${SYKEFRAVÆRSSTATISTIKK_PATH}/$PUBLISERINGSINFO")
                .authentication().bearer(token)
                .tilSingelRespons<Publiseringsinfo>()

        private fun hentSykefraværForVirksomhetSisteTilgjengeligKvartalRespons(
            orgnummer: String,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = TestContainerHelper.applikasjon.performGet("${SYKEFRAVÆRSSTATISTIKK_PATH}/$orgnummer/${SISTE_TILGJENGELIGE_KVARTAL}")
            .authentication().bearer(token)
            .tilSingelRespons<VirksomhetsstatistikkSisteKvartal>()

        fun hentSykefraværForVirksomhetSiste4Kvartaler(
            orgnummer: String,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = hentSykefraværForVirksomhetSiste4KvartalerRespons(orgnummer = orgnummer, token = token).third
            .fold(success = { response -> response }, failure = { fail(it.message) })

        fun hentPubliseringsinfo(token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token) =
            hentPubliseringsinfoRespons(token).third
                .fold(success = { response -> response }, failure = { fail(it.message) })

        fun hentSykefraværForVirksomhetSisteTilgjengeligKvartal(
            orgnummer: String,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = hentSykefraværForVirksomhetSisteTilgjengeligKvartalRespons(orgnummer = orgnummer, token = token).third
            .fold(success = { response -> response }, failure = { fail(it.message) })

        fun hentSykefraværForAlleVirksomheter(): List<VirksomhetsoversiktDto> {
            var side = 1
            val liste = mutableListOf<VirksomhetsoversiktDto>()

            do {
                val sykefravær = hentSykefravær(side = "${side++}")
                liste.addAll(sykefravær.data)
            } while (sykefravær.data.size == Søkeparametere.VIRKSOMHETER_PER_SIDE)

            return liste.toList()
        }

        // Defaultverdiane her er standard-verdiane i kall frå frontend per 2023-11-09
        fun hentSykefraværForAlleVirksomheterMedFilter(
            side: Int = 1,
            kommuner: String = "",
            fylker: String = "",
            næringsgrupper: String = "",
            sorteringsnokkel: String = "",
            sorteringsretning: String = "",
            sykefraværsprosentFra: String = "0.00",
            sykefraværsprosentTil: String = "100.00",
            snittFilter: String = "",
            ansatteFra: String = "5",
            ansatteTil: String = "",
            iaStatus: String = "",
            bransjeProgram: String = "",
            eiere: String = "",
            sektor: List<Sektor> = listOf(),
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ): List<VirksomhetsoversiktDto> {
            var itererbarSide = side
            val liste = mutableListOf<VirksomhetsoversiktDto>()

            do {
                val sykefravær = hentSykefravær(
                    side = "${itererbarSide++}",
                    kommuner = kommuner,
                    fylker = fylker,
                    næringsgrupper = næringsgrupper,
                    sorteringsnokkel = sorteringsnokkel,
                    sorteringsretning = sorteringsretning,
                    sykefraværsprosentFra = sykefraværsprosentFra,
                    sykefraværsprosentTil = sykefraværsprosentTil,
                    snittFilter = snittFilter,
                    ansatteFra = ansatteFra,
                    ansatteTil = ansatteTil,
                    iaStatus = iaStatus,
                    bransjeProgram = bransjeProgram,
                    eiere = eiere,
                    sektor = sektor,
                    token = token,
                )
                liste.addAll(sykefravær.data)
            } while (sykefravær.data.size == Søkeparametere.VIRKSOMHETER_PER_SIDE)

            return liste.toList()
        }

        fun hentTotaltAntallTreffISykefravær(
            kommuner: String = "",
            fylker: String = "",
            næringsgrupper: String = "",
            sorteringsnokkel: String = "",
            sorteringsretning: String = "",
            sykefraværsprosentFra: String = "",
            sykefraværsprosentTil: String = "",
            ansatteFra: String = "",
            ansatteTil: String = "",
            iaStatus: String = "",
            virksomhetTilstand: String = "",
            side: String = "",
            bransjeProgram: String = "",
            eiere: String = "",
            sektor: List<Sektor> = listOf(),
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ): Int =
            TestContainerHelper.applikasjon.performGet(
                "${SYKEFRAVÆRSSTATISTIKK_PATH}/${ANTALL_TREFF}" +
                    "?${Søkeparametere.KOMMUNER}=$kommuner" +
                    "&${Søkeparametere.FYLKER}=$fylker" +
                    "&${Søkeparametere.NÆRINGSGRUPPER}=$næringsgrupper" +
                    "&${Søkeparametere.SORTERINGSNØKKEL}=$sorteringsnokkel" +
                    "&${Søkeparametere.SORTERINGSRETNING}=$sorteringsretning" +
                    "&${Søkeparametere.SYKEFRAVÆRSPROSENT_FRA}=$sykefraværsprosentFra" +
                    "&${Søkeparametere.SYKEFRAVÆRSPROSENT_TIL}=$sykefraværsprosentTil" +
                    "&${Søkeparametere.ANSATTE_FRA}=$ansatteFra" +
                    "&${Søkeparametere.ANSATTE_TIL}=$ansatteTil" +
                    "&${Søkeparametere.IA_STATUS}=$iaStatus" +
                    "&${Søkeparametere.VIRKSOMHET_TILSTAND}=$virksomhetTilstand" +
                    "&${Søkeparametere.SIDE}=$side" +
                    "&${Søkeparametere.BRANSJEPROGRAM}=$bransjeProgram" +
                    "&${Søkeparametere.IA_SAK_EIERE}=$eiere" +
                    "&${Søkeparametere.SEKTOR}=${sektor.joinToString(separator = ",") { it.kode }}",
            )
                .authentication().bearer(token)
                .tilSingelRespons<Int>()
                .third
                .fold(success = { response -> response }, failure = { fail(it.message) })

        fun hentFilterverdier(token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token) =
            TestContainerHelper.applikasjon.performGet("${SYKEFRAVÆRSSTATISTIKK_PATH}/${FILTERVERDIER_PATH}")
                .authentication().bearer(token)
                .tilSingelRespons<FilterverdierDto>()
                .third
                .fold(success = { response -> response }, failure = { fail(it.message) })
    }
}
