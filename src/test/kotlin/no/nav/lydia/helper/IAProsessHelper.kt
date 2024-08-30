package no.nav.lydia.helper

import com.github.kittinunf.fuel.core.extensions.authentication
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.TestContainerHelper.Companion.lydiaApiContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.oauth2ServerContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.IA_SAK_RADGIVER_PATH
import no.nav.lydia.ia.sak.api.prosess.IAProsessDto
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import kotlin.test.fail

fun IASakDto.nyttNavnPåProsess(
    iaProsessDto: IAProsessDto,
    nyttNavn: String,
    token: String = oauth2ServerContainer.saksbehandler1.token,
) = nyHendelse(
    hendelsestype = IASakshendelseType.ENDRE_PROSESS,
    payload = Json.encodeToString(iaProsessDto.copy(navn = nyttNavn)),
    token = token,
)

fun IASakDto.opprettNyProsses(token: String = oauth2ServerContainer.saksbehandler1.token) =
    nyHendelse(
        hendelsestype = IASakshendelseType.NY_PROSESS,
        token = token,
    )

fun IASakDto.hentIAProsesser(token: String = oauth2ServerContainer.saksbehandler1.token) =
    lydiaApiContainer.performGet("$IA_SAK_RADGIVER_PATH/$orgnr/$saksnummer/prosesser")
        .authentication().bearer(token = token)
        .tilListeRespons<IAProsessDto>().third.fold(
            success = { it },
            failure = { fail(it.message) },
        )
