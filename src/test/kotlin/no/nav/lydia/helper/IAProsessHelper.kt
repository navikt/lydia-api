package no.nav.lydia.helper

import com.github.kittinunf.fuel.core.extensions.authentication
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.abc.samarbeidsperiode.IASakDto
import no.nav.lydia.abc.samarbeidsperiode.IA_SAK_RADGIVER_PATH
import no.nav.lydia.ia.sak.api.samarbeid.IASamarbeidDto
import kotlin.test.fail

fun IASakDto.hentAlleSamarbeid(token: String = authContainerHelper.saksbehandler1.token) =
    applikasjon.performGet("$IA_SAK_RADGIVER_PATH/$orgnr/$saksnummer/prosesser")
        .authentication().bearer(token = token)
        .tilListeRespons<IASamarbeidDto>().third.fold(
            success = { it },
            failure = { fail(it.message) },
        )
