package no.nav.lydia.helper

import com.github.kittinunf.fuel.core.extensions.authentication
import kotlinx.serialization.json.Json
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.ia.sak.DEFAULT_SAMARBEID_NAVN
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.IA_SAK_RADGIVER_PATH
import no.nav.lydia.ia.sak.api.prosess.IAProsessDto
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import kotlin.test.fail

fun IASakDto.nyttNavnPåSamarbeid(
    iaProsessDto: IAProsessDto = hentAlleSamarbeid().first(),
    nyttNavn: String,
    token: String = authContainerHelper.saksbehandler1.token,
) = nyHendelse(
    hendelsestype = IASakshendelseType.ENDRE_PROSESS,
    payload = Json.encodeToString(iaProsessDto.copy(navn = nyttNavn)),
    token = token,
)

fun IASakDto.opprettNyttSamarbeid(
    navn: String = DEFAULT_SAMARBEID_NAVN,
    token: String = authContainerHelper.saksbehandler1.token,
) = nyHendelse(
    hendelsestype = IASakshendelseType.NY_PROSESS,
    token = token,
    payload = Json.encodeToString(
        IAProsessDto(
            id = 0,
            saksnummer = saksnummer,
            navn = navn,
        ),
    ),
)

fun IASakDto.hentAlleSamarbeid(token: String = authContainerHelper.saksbehandler1.token) =
    applikasjon.performGet("$IA_SAK_RADGIVER_PATH/$orgnr/$saksnummer/prosesser")
        .authentication().bearer(token = token)
        .tilListeRespons<IAProsessDto>().third.fold(
            success = { it },
            failure = { fail(it.message) },
        )
