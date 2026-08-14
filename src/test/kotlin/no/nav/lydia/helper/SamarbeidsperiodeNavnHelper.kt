package no.nav.lydia.helper

import kotlinx.serialization.json.Json
import no.nav.lydia.api.v1.NY_FLYT_API_PATH
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.prioritering.sykefraværsstatistikk.api.EierDTO
import kotlin.test.fail

class SamarbeidsperiodeNavnHelper {
    companion object {
        fun hentEiere(
            saksnumre: Set<String>,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = TestContainerHelper.applikasjon.performPost("$NY_FLYT_API_PATH/samarbeidsperiode/eiere")
            .authentication().bearer(token)
            .jsonBody(Json.encodeToString(saksnumre))
            .tilListeRespons<EierDTO>()
            .third
            .fold(success = { it }, failure = { fail(it.message) })

        fun hentRadgivere(
            saksnumre: Set<String>,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = TestContainerHelper.applikasjon.performPost("$NY_FLYT_API_PATH/samarbeidsperiode/radgivere")
            .authentication().bearer(token)
            .jsonBody(Json.encodeToString(saksnumre))
            .tilListeRespons<EierDTO>()
            .third
            .fold(success = { it }, failure = { fail(it.message) })
    }
}
