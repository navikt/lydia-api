package no.nav.lydia.helper

import com.github.kittinunf.fuel.core.ResponseResultOf
import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.serialization.responseObject
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.IASakLeveranserPerTjenesteDto
import no.nav.lydia.ia.sak.api.IA_SAK_LEVERANSE_PATH
import no.nav.lydia.ia.sak.api.IA_SAK_RADGIVER_PATH
import no.nav.lydia.ia.sak.api.KanGjennomføreStatusendring
import no.nav.lydia.ia.sak.api.SAMARBEIDSHISTORIKK_PATH
import no.nav.lydia.ia.sak.api.SaksStatusDto
import no.nav.lydia.ia.sak.api.SakshistorikkDto
import no.nav.lydia.ia.sak.api.ny.flyt.NY_FLYT_PATH
import no.nav.lydia.ia.sak.api.samarbeid.IASamarbeidDto
import no.nav.lydia.ia.team.BrukerITeamDto
import no.nav.lydia.ia.team.IA_SAK_TEAM_PATH
import kotlin.test.fail

class SakHelper {
    companion object {
        fun bliMedITeam(
            token: String,
            saksnummer: String,
        ) = TestContainerHelper.applikasjon.performPost("${IA_SAK_TEAM_PATH}/$saksnummer")
            .authentication().bearer(token)
            .tilSingelRespons<BrukerITeamDto>().third.fold(
                success = { respons -> respons },
                failure = { fail(it.message) },
            )
            .also { it.saksnummer shouldBe saksnummer }

        fun IASakDto.bliEierResponse(token: String) =
            TestContainerHelper.applikasjon.performPost("${NY_FLYT_PATH}/$orgnr/bli-eier")
                .authentication().bearer(token = token)
                .tilSingelRespons<IASakDto>()

        fun IASakDto.bliEier(token: String) = bliEierResponse(token).third.get()

        fun IASakDto.leggTilFolger(token: String) = also { bliMedITeam(token = token, saksnummer) }

        fun IASakDto.hentSaksStatus(token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token) =
            TestContainerHelper.applikasjon
                .performGet("${IA_SAK_RADGIVER_PATH}/$orgnr/$saksnummer/status")
                .authentication().bearer(token = token)
                .tilSingelRespons<SaksStatusDto>().third
                .fold(
                    success = { it },
                    failure = {
                        fail(it.response.body().asString("text/plain"))
                    },
                )

        fun hentIASakLeveranser(
            orgnr: String,
            saksnummer: String,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = TestContainerHelper.applikasjon.performGet("${IA_SAK_RADGIVER_PATH}/${IA_SAK_LEVERANSE_PATH}/$orgnr/$saksnummer")
            .authentication().bearer(token = token)
            .tilListeRespons<IASakLeveranserPerTjenesteDto>().third.fold(
                success = { respons -> respons },
                failure = {
                    fail(it.stackTraceToString())
                },
            )

        fun hentSak(
            orgnummer: String,
            saksnummer: String? = null,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ): IASakDto {
            val triple = TestContainerHelper.applikasjon.performGet(
                "${NY_FLYT_PATH}/virksomhet/$orgnummer/samarbeidsperiode${saksnummer?.let {
                    "/$it"
                } ?: ""}",
            )
                .authentication().bearer(token = token)
                .responseObject(IASakDto.Companion.serializer())

            if (triple.statuskode() == 200) {
                return triple.third.get()
            } else if (triple.statuskode() == 204) {
                fail("Ingen aktive saker funnet")
            } else {
                fail(triple.third.toString())
            }
        }

        fun hentSamarbeidshistorikkNyFlyt(
            orgnummer: String,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = hentSamarbeidshistorikkNyFlytRespons(orgnummer = orgnummer, token = token).third.fold(
            success = { respons -> respons },
            failure = { fail(it.stackTraceToString()) },
        )

        fun hentSamarbeidshistorikkNyFlytRespons(
            orgnummer: String,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ): ResponseResultOf<List<SakshistorikkDto>> {
            val url = "${NY_FLYT_PATH}/virksomhet/$orgnummer/historikk"
            return TestContainerHelper.applikasjon.performGet(url)
                .authentication().bearer(token = token)
                .tilListeRespons<SakshistorikkDto>()
        }

        fun hentSamarbeidshistorikk(
            orgnummer: String,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = hentSamarbeidshistorikkRespons(orgnummer, token).third.fold(
            success = { respons -> respons },
            failure = { fail(it.stackTraceToString()) },
        )

        fun hentSamarbeidshistorikkRespons(
            orgnummer: String,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = TestContainerHelper.applikasjon.performGet("${IA_SAK_RADGIVER_PATH}/${SAMARBEIDSHISTORIKK_PATH}/$orgnummer")
            .authentication().bearer(token = token)
            .tilListeRespons<SakshistorikkDto>()

        fun hentSamarbeidshistorikkForOrgnrRespons(
            orgnr: String,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = TestContainerHelper.applikasjon.performGet("${IA_SAK_RADGIVER_PATH}/${SAMARBEIDSHISTORIKK_PATH}/$orgnr")
            .authentication().bearer(token = token)
            .tilListeRespons<SakshistorikkDto>()

        fun IASakDto.kanGjennomføreStatusendring(
            samarbeidDto: IASamarbeidDto,
            statusEndring: String,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = TestContainerHelper.applikasjon.performGet("${IA_SAK_RADGIVER_PATH}/${this.orgnr}/${this.saksnummer}/${samarbeidDto.id}/kan/$statusEndring")
            .authentication().bearer(token)
            .tilSingelRespons<KanGjennomføreStatusendring>()
            .third.fold(
                success = { respons -> respons },
                failure = {
                    fail(it.stackTraceToString())
                },
            )

        fun IASakDto.oppdaterHendelsesTidspunkter(
            antallDagerTilbake: Long,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ): IASakDto {
            TestContainerHelper.postgresContainerHelper.performUpdate(
                """
                update ia_sak_hendelse 
                    set opprettet=(opprettet - interval '$antallDagerTilbake' day)
                    where saksnummer='${this.saksnummer}';
                """.trimIndent(),
            )
            TestContainerHelper.postgresContainerHelper.performUpdate(
                """
                update ia_sak 
                    set endret=(opprettet - interval '$antallDagerTilbake' day)
                    where saksnummer='${this.saksnummer}';
                """.trimIndent(),
            )
            return requireNotNull(hentSak(this.orgnr, saksnummer = this.saksnummer, token = token))
        }
    }
}
