package no.nav.lydia.helper

import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.core.extensions.jsonBody
import io.kotest.matchers.collections.shouldHaveSize
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.container.ia.sak.kartlegging.BehovsvurderingApiTest
import no.nav.lydia.helper.TestContainerHelper.Companion.performDelete
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.TestContainerHelper.Companion.performPut
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.ny.flyt.NY_FLYT_API_PATH
import no.nav.lydia.ia.sak.api.samarbeid.IASamarbeidDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.OppdaterBehovsvurderingDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SPØRREUNDERSØKELSE_BASE_ROUTE
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseResultatDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseSvarDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseUtenInnholdDto
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.integrasjoner.kartlegging.HendelsType
import no.nav.lydia.integrasjoner.kartlegging.SpørreundersøkelseHendeleseNøkkel
import java.util.UUID
import kotlin.test.fail

class IASakSpørreundersøkelseHelper {
    companion object {
        fun opprettSpørreundersøkelse(
            orgnr: String,
            saksnummer: String,
            samarbeidId: Int,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
            type: Spørreundersøkelse.Type,
        ) = TestContainerHelper.applikasjon.performPost(
            "${NY_FLYT_API_PATH}/virksomhet/$orgnr/samarbeidsperiode/$saksnummer/samarbeid/$samarbeidId/kartlegging/${type.name}",
        ).authentication().bearer(token)

        fun hentSpørreundersøkelser(
            orgnr: String,
            saksnummer: String,
            prosessId: Int,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = TestContainerHelper.applikasjon.performGet("${SPØRREUNDERSØKELSE_BASE_ROUTE}/$orgnr/$saksnummer/prosess/$prosessId/")
            .authentication().bearer(token)
            .tilListeRespons<SpørreundersøkelseUtenInnholdDto>().third.fold(
                success = { it },
                failure = { fail(it.message) },
            )

        fun SpørreundersøkelseDto.hentKartleggingresultatPdf(
            orgnr: String,
            saksnummer: String,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = TestContainerHelper.applikasjon.performGet("${SPØRREUNDERSØKELSE_BASE_ROUTE}/$orgnr/$saksnummer/$id/pdf")
            .authentication().bearer(token)
            .response().third.fold(
                success = { it },
                failure = { fail(it.message) },
            )

        fun hentSpørreundersøkelse(
            orgnr: String,
            saksnummer: String,
            prosessId: Int,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
            type: Spørreundersøkelse.Type,
        ) = TestContainerHelper.applikasjon.performGet("${SPØRREUNDERSØKELSE_BASE_ROUTE}/$orgnr/$saksnummer/prosess/$prosessId/type/${type.name}")
            .authentication().bearer(token)
            .tilListeRespons<SpørreundersøkelseUtenInnholdDto>().third.fold(
                success = { it },
                failure = { fail(it.message) },
            )

        fun IASamarbeidDto.opprettKartlegging(
            orgnr: String,
            type: Spørreundersøkelse.Type,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = opprettSpørreundersøkelse(
            orgnr = orgnr,
            saksnummer = saksnummer,
            samarbeidId = id,
            token = token,
            type = type,
        ).tilSingelRespons<SpørreundersøkelseDto>().third.get()

        fun IASakDto.opprettKartlegging(
            samarbeidId: Int = hentAlleSamarbeid().first().id,
            type: Spørreundersøkelse.Type,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = opprettSpørreundersøkelse(
            orgnr = orgnr,
            saksnummer = saksnummer,
            samarbeidId = samarbeidId,
            token = token,
            type = type,
        ).tilSingelRespons<SpørreundersøkelseDto>().third.fold(
            success = { respons -> respons },
            failure = { fail(it.message) },
        )

        fun IASakDto.opprettBehovsvurdering(
            samarbeidId: Int = hentAlleSamarbeid().first().id,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = opprettSpørreundersøkelse(
            orgnr = orgnr,
            saksnummer = saksnummer,
            samarbeidId = samarbeidId,
            token = token,
            type = Spørreundersøkelse.Type.Behovsvurdering,
        ).tilSingelRespons<SpørreundersøkelseDto>().third.fold(
            success = { respons -> respons },
            failure = { fail(it.message) },
        )

        fun IASakDto.opprettSvarOgAvsluttSpørreundersøkelse(
            type: Spørreundersøkelse.Type,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
            samarbeidId: Int = hentAlleSamarbeid().first().id,
            temaIdx: Int = 0,
            spørsmålIdx: Int = 0,
            svaralternativIdx: Int = 0,
            antallSvarPåSpørsmål: Int = 3,
        ): SpørreundersøkelseDto =
            when (type) {
                Spørreundersøkelse.Type.Evaluering -> opprettEvaluering(
                    prosessId = samarbeidId,
                    token = token,
                )

                Spørreundersøkelse.Type.Behovsvurdering -> opprettBehovsvurdering(
                    samarbeidId = samarbeidId,
                    token = token,
                )
            }
                .start(
                    token = token,
                    orgnummer = orgnr,
                    saksnummer = saksnummer,
                )
                .also {
                    it.svarPåSpørsmål(
                        temaIdx = temaIdx,
                        spørsmålIdx = spørsmålIdx,
                        svaralternativIdx = svaralternativIdx,
                        antallSvarPåSpørsmål = antallSvarPåSpørsmål,
                    )
                }
                .fullfør(
                    token = token,
                    orgnummer = orgnr,
                    saksnummer = saksnummer,
                )

        fun IASakDto.opprettEvaluering(
            prosessId: Int = hentAlleSamarbeid().first().id,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = opprettSpørreundersøkelse(
            orgnr = orgnr,
            saksnummer = saksnummer,
            samarbeidId = prosessId,
            token = token,
            type = Spørreundersøkelse.Type.Evaluering,
        ).tilSingelRespons<SpørreundersøkelseDto>().third.fold(
            success = { respons -> respons },
            failure = { fail(it.message) },
        )

        fun IASakDto.hentForhåndsvisning(
            prosessId: Int = hentAlleSamarbeid().first().id,
            type: Spørreundersøkelse.Type,
            spørreundersøkseId: String,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ): SpørreundersøkelseDto =
            TestContainerHelper.applikasjon.performGet(
                "${SPØRREUNDERSØKELSE_BASE_ROUTE}/$orgnr/$saksnummer/prosess/$prosessId/type/${type.name}/$spørreundersøkseId",
            )
                .authentication().bearer(token)
                .tilSingelRespons<SpørreundersøkelseDto>().third.fold(
                    success = { it },
                    failure = { fail(it.message) },
                )

        fun SpørreundersøkelseDto.start(
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
            orgnummer: String,
            saksnummer: String,
        ): SpørreundersøkelseDto =
            TestContainerHelper.applikasjon.performPost(
                "${NY_FLYT_API_PATH}/virksomhet/$orgnummer/samarbeidsperiode/$saksnummer/samarbeid/$samarbeidId/kartlegging/$id/start",
            )
                .authentication().bearer(token)
                .tilSingelRespons<SpørreundersøkelseDto>().third.fold(
                    success = { it },
                    failure = { fail(it.message) },
                )

        fun SpørreundersøkelseDto.fullfør(
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
            orgnummer: String,
            saksnummer: String,
        ) = TestContainerHelper.applikasjon.performPost(
            "${NY_FLYT_API_PATH}/virksomhet/$orgnummer/samarbeidsperiode/$saksnummer/samarbeid/$samarbeidId/kartlegging/$id/fullfor",
        )
            .authentication().bearer(token)
            .tilSingelRespons<SpørreundersøkelseDto>().third.fold(
                success = { it },
                failure = { fail(it.message) },
            )

        fun SpørreundersøkelseDto.svarPåSpørsmål(
            temaIdx: Int = 0,
            spørsmålIdx: Int = 0,
            svaralternativIdx: Int = 0,
            antallSvarPåSpørsmål: Int = 3,
        ) {
            val førsteSpørsmål = this.temaer[temaIdx].spørsmålOgSvaralternativer[spørsmålIdx]
            val førsteSvaralternativ = førsteSpørsmål.svaralternativer[svaralternativIdx]

            repeat(antallSvarPåSpørsmål) {
                val sesjonId = UUID.randomUUID()
                sendKartleggingSvarTilKafka(
                    kartleggingId = this.id,
                    spørsmålId = førsteSpørsmål.id,
                    sesjonId = sesjonId.toString(),
                    svarIder = listOf(førsteSvaralternativ.svarId),
                )
            }
        }

        fun SpørreundersøkelseDto.slett(
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
            orgnummer: String,
            saksnummer: String,
        ) = slettResponse(token = token, orgnummer = orgnummer, saksnummer = saksnummer).third.get()

        fun SpørreundersøkelseDto.slettResponse(
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
            orgnummer: String,
            saksnummer: String,
        ) = TestContainerHelper.applikasjon.performDelete(
            "${NY_FLYT_API_PATH}/virksomhet/$orgnummer/samarbeidsperiode/$saksnummer/samarbeid/$samarbeidId/kartlegging/$id",
        )
            .authentication().bearer(token)
            .tilSingelRespons<SpørreundersøkelseDto>()

        fun SpørreundersøkelseDto.flytt(
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
            orgnummer: String,
            saksnummer: String,
            samarbeidId: Int,
        ) = TestContainerHelper.applikasjon.performPut("${SPØRREUNDERSØKELSE_BASE_ROUTE}/$id")
            .authentication().bearer(token)
            .jsonBody(
                Json.encodeToString(
                    OppdaterBehovsvurderingDto(
                        orgnummer = orgnummer,
                        saksnummer = saksnummer,
                        prosessId = samarbeidId,
                    ),
                ),
            ).tilSingelRespons<SpørreundersøkelseDto>().third.fold(
                success = { it },
                failure = { fail("${it.message}: ${it.response.body().asString("text/plain")}") },
            )

        fun SpørreundersøkelseDto.svarAlternativerTilEtFlervalgSpørsmål(): List<String> =
            this.svarAlternativerTilEtSpørsmål(BehovsvurderingApiTest.ID_TIL_SPØRSMÅL_MED_FLERVALG_MULIGHETER).map { it.svarId }

        fun SpørreundersøkelseDto.svarAlternativerTilEtSpørsmål(spørsmålId: String) =
            this.temaer.map { tema ->
                tema.spørsmålOgSvaralternativer.firstOrNull { it.id == spørsmålId }
            }.first()!!.svaralternativer

        fun SpørreundersøkelseDto.sendKartleggingFlervalgSvarTilKafka(
            sesjonId: String = UUID.randomUUID().toString(),
            svarIder: List<String> = this.svarAlternativerTilEtFlervalgSpørsmål(),
        ) = sendKartleggingSvarTilKafka(
            kartleggingId = id,
            spørsmålId = BehovsvurderingApiTest.ID_TIL_SPØRSMÅL_MED_FLERVALG_MULIGHETER,
            sesjonId = sesjonId,
            svarIder = svarIder,
        )

        fun SpørreundersøkelseDto.sendKartleggingSvarTilKafka(
            spørsmålId: String = temaer.first().spørsmålOgSvaralternativer.first().id,
            sesjonId: String = UUID.randomUUID().toString(),
            svarIder: List<String> =
                listOf(temaer.first().spørsmålOgSvaralternativer.first().svaralternativer.first().svarId),
        ) = sendKartleggingSvarTilKafka(
            kartleggingId = id,
            spørsmålId = spørsmålId,
            sesjonId = sesjonId,
            svarIder = svarIder,
        )

        fun SpørreundersøkelseDto.stengTema(temaId: Int) {
            temaer.filter { it.temaId == temaId } shouldHaveSize 1
            TestContainerHelper.kafkaContainerHelper.sendOgVentTilKonsumert(
                nøkkel = Json.encodeToString(
                    SpørreundersøkelseHendeleseNøkkel(
                        this.id,
                        HendelsType.STENG_TEMA,
                    ),
                ),
                melding = Json.encodeToString(temaId),
                topic = Topic.SPORREUNDERSOKELSE_HENDELSE_TOPIC,
            )
        }

        fun sendKartleggingSvarTilKafka(
            kartleggingId: String = UUID.randomUUID().toString(),
            spørsmålId: String = UUID.randomUUID().toString(),
            sesjonId: String = UUID.randomUUID().toString(),
            svarIder: List<String> = listOf(UUID.randomUUID().toString(), UUID.randomUUID().toString()),
        ): SpørreundersøkelseSvarDto {
            val spørreundersøkelseSvarDto = SpørreundersøkelseSvarDto(
                spørreundersøkelseId = kartleggingId,
                spørsmålId = spørsmålId,
                sesjonId = sesjonId,
                svarIder = svarIder,
            )
            TestContainerHelper.kafkaContainerHelper.sendOgVentTilKonsumert(
                nøkkel = "${sesjonId}_$spørsmålId",
                melding = Json.encodeToString(
                    spørreundersøkelseSvarDto,
                ),
                topic = Topic.SPORREUNDERSOKELSE_SVAR_TOPIC,
            )
            return spørreundersøkelseSvarDto
        }

        fun hentSpørreundersøkelseResultat(
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
            orgnr: String,
            saksnummer: String,
            spørreundersøkelseId: String,
        ): SpørreundersøkelseResultatDto =
            TestContainerHelper.applikasjon.performGet("${SPØRREUNDERSØKELSE_BASE_ROUTE}/$orgnr/$saksnummer/$spørreundersøkelseId")
                .authentication().bearer(token)
                .tilSingelRespons<SpørreundersøkelseResultatDto>().third.fold(
                    success = { respons -> respons },
                    failure = { fail(it.message) },
                )
    }
}
