package no.nav.lydia.helper

import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.core.extensions.jsonBody
import kotlinx.datetime.LocalDate
import kotlinx.serialization.json.Json
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.TestContainerHelper.Companion.performPut
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.ny.flyt.NY_FLYT_API_PATH
import no.nav.lydia.ia.sak.api.plan.EndreTemaRequest
import no.nav.lydia.ia.sak.api.plan.EndreUndertemaRequest
import no.nav.lydia.ia.sak.api.plan.PLAN_BASE_ROUTE
import no.nav.lydia.ia.sak.api.plan.PlanDto
import no.nav.lydia.ia.sak.api.plan.PlanDtoI
import no.nav.lydia.ia.sak.api.plan.PlanMedPubliseringStatusDto
import no.nav.lydia.ia.sak.api.plan.PlanUndertemaDto
import no.nav.lydia.ia.sak.api.samarbeid.IASamarbeidDto
import no.nav.lydia.ia.sak.domene.plan.InnholdMalDto
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema
import no.nav.lydia.ia.sak.domene.plan.TemaMalDto
import kotlin.test.fail

class PlanHelper {
    companion object {
        val START_DATO = LocalDate(year = 2021, monthNumber = 1, dayOfMonth = 1)
        val SLUTT_DATO = LocalDate(year = 2022, monthNumber = 2, dayOfMonth = 2)

        fun PlanDtoI.antallTemaInkludert() = temaer.filter { it.inkludert }.size

        fun PlanDtoI.antallInnholdInkludert() = temaer.flatMap { it.undertemaer }.filter { it.inkludert }.size

        fun PlanDtoI.antallInnholdMedStatus(status: PlanUndertema.Status) =
            temaer.flatMap { it.undertemaer }.filter {
                it.inkludert &&
                    it.status == status
            }.size

        fun PlanDtoI.tidligstStartDato(): LocalDate =
            this.temaer.flatMap { it.undertemaer }
                .filter { it.startDato != null }
                .minOf { it.startDato!! }

        fun PlanDtoI.senesteSluttDato(): LocalDate =
            this.temaer.flatMap { it.undertemaer }
                .filter { it.sluttDato != null }
                .maxOf { it.sluttDato!! }

        fun IASakDto.hentPlan(
            prosessId: Int = hentAlleSamarbeid().first().id,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = hentPlanResponse(
            samarbeidId = prosessId,
            token = token,
        ).third.fold(
            success = { respons -> respons },
            failure = { fail(it.message) },
        )

        fun IASakDto.hentPlanResponse(
            samarbeidId: Int = hentAlleSamarbeid().first().id,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = TestContainerHelper.applikasjon.performGet("${PLAN_BASE_ROUTE}/$orgnr/$saksnummer/prosess/$samarbeidId")
            .authentication().bearer(token)
            .tilSingelRespons<PlanMedPubliseringStatusDto>()

        private fun hentPlan(
            orgnr: String,
            saksnummer: String,
            prosessId: Int,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = TestContainerHelper.applikasjon.performGet("${PLAN_BASE_ROUTE}/$orgnr/$saksnummer/prosess/$prosessId")
            .authentication().bearer(token)
            .tilSingelRespons<PlanMedPubliseringStatusDto>().third.fold(
                success = { respons -> respons },
                failure = { fail(it.message) },
            )

        fun IASakDto.endreStatusPåInnholdIPlan(
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
            temaId: Int,
            innholdId: Int,
            status: PlanUndertema.Status,
        ) = endreStatus(
            token = token,
            orgnr = orgnr,
            saksnummer = saksnummer,
            temaId = temaId,
            undertemaId = innholdId,
            status = status,
            prosessId = hentAlleSamarbeid().first().id,
        )

        fun PlanMalDto.inkluderAlt(): PlanMalDto =
            this.copy(
                tema = this.tema.map { tema ->
                    TemaMalDto(
                        rekkefølge = tema.rekkefølge,
                        navn = tema.navn,
                        inkludert = true,
                        innhold = tema.innhold.map { innhold ->
                            InnholdMalDto(
                                rekkefølge = innhold.rekkefølge,
                                navn = innhold.navn,
                                inkludert = true,
                                startDato = LocalDate(2021, 1, 1),
                                sluttDato = LocalDate(2021, 1, 2),
                            )
                        },
                    )
                },
            )

        fun PlanMalDto.inkluderEttTemaOgEttInnhold(
            temanummer: Int,
            innholdnummer: Int,
            startDato: LocalDate = START_DATO,
            sluttDato: LocalDate = SLUTT_DATO,
        ): PlanMalDto =
            this.copy(
                tema = tema.map { tema ->
                    if (temanummer == tema.rekkefølge) {
                        tema.copy(
                            inkludert = true,
                            innhold = tema.innhold.inkluderEttInnhold(
                                innholdnummer,
                                startDato = startDato,
                                sluttDato = sluttDato,
                            ),
                        )
                    } else {
                        tema
                    }
                },
            )

        fun PlanMalDto.inkluderEttTemaOgAltInnhold(
            temanummer: Int,
            startDato: LocalDate = START_DATO,
            sluttDato: LocalDate = SLUTT_DATO,
        ): PlanMalDto =
            this.copy(
                tema = tema.map { tema ->
                    if (temanummer == tema.rekkefølge) {
                        tema.copy(
                            inkludert = true,
                            innhold = tema.innhold.inkluderAltInnholdIMal(startDato = startDato, sluttDato = sluttDato),
                        )
                    } else {
                        tema
                    }
                },
            )

        private fun List<InnholdMalDto>.inkluderAltInnholdIMal(
            startDato: LocalDate = START_DATO,
            sluttDato: LocalDate = SLUTT_DATO,
        ): List<InnholdMalDto> =
            this.map { innhold ->
                innhold.copy(
                    inkludert = true,
                    startDato = startDato,
                    sluttDato = sluttDato,
                )
            }

        private fun List<InnholdMalDto>.inkluderEttInnhold(
            innholdnummer: Int,
            startDato: LocalDate = START_DATO,
            sluttDato: LocalDate = SLUTT_DATO,
        ): List<InnholdMalDto> =
            this.map { innhold ->
                if (innholdnummer == innhold.rekkefølge) {
                    innhold.copy(
                        inkludert = true,
                        startDato = startDato,
                        sluttDato = sluttDato,
                    )
                } else {
                    innhold
                }
            }

        fun List<PlanUndertemaDto>.inkluderAltInnhold(
            startDato: LocalDate = START_DATO,
            sluttDato: LocalDate = SLUTT_DATO,
        ): List<PlanUndertemaDto> =
            this.map { innhold ->
                innhold.copy(
                    inkludert = true,
                    startDato = startDato,
                    sluttDato = sluttDato,
                )
            }

        fun PlanMedPubliseringStatusDto.inkluderTemaOgAltInnhold(
            temaId: Int,
            startDato: LocalDate = START_DATO,
            sluttDato: LocalDate = SLUTT_DATO,
        ): PlanMedPubliseringStatusDto =
            this.copy(
                temaer = temaer.map { tema ->
                    if (tema.id == temaId) {
                        tema.copy(
                            inkludert = true,
                            undertemaer = tema.undertemaer.inkluderAltInnhold(
                                startDato = startDato,
                                sluttDato = sluttDato,
                            ),
                        )
                    } else {
                        tema
                    }
                },
            )

        fun PlanDto.inkluderAlt(
            startDato: LocalDate = START_DATO,
            sluttDato: LocalDate = SLUTT_DATO,
        ): PlanDto =
            this.copy(
                temaer = temaer.map { tema ->
                    tema.copy(
                        inkludert = true,
                        undertemaer = tema.undertemaer.inkluderAltInnhold(
                            startDato = startDato,
                            sluttDato = sluttDato,
                        ),
                    )
                },
            )

        fun PlanMedPubliseringStatusDto.inkluderAlt(
            startDato: LocalDate = START_DATO,
            sluttDato: LocalDate = SLUTT_DATO,
        ): PlanMedPubliseringStatusDto =
            this.copy(
                temaer = temaer.map { tema ->
                    tema.copy(
                        inkludert = true,
                        undertemaer = tema.undertemaer.inkluderAltInnhold(
                            startDato = startDato,
                            sluttDato = sluttDato,
                        ),
                    )
                },
            )

        // TODO: [OPPRYDDING] Bør gå bort ifra denne måten å opprette planer
        fun IASakDto.opprettEnPlan(
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
            plan: PlanMalDto = hentPlanMal().inkluderAlt(),
        ) = hentAlleSamarbeid().first().opprettSamarbeidsplan(
            orgnr = orgnr,
            planMal = plan,
            token = token,
        )

        fun IASamarbeidDto.opprettSamarbeidsplan(
            orgnr: String,
            planMal: PlanMalDto = hentPlanMal().inkluderAlt(),
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = TestContainerHelper.applikasjon.performPost("${NY_FLYT_API_PATH}/virksomhet/$orgnr/samarbeidsperiode/${this.saksnummer}/samarbeid/${this.id}/plan")
            .authentication().bearer(token)
            .jsonBody(
                Json.encodeToString(planMal),
            ).tilSingelRespons<PlanMedPubliseringStatusDto>().third.fold(
                success = { it },
                failure = { fail(it.message) },
            )

        fun IASakDto.endreEttTemaIPlan(
            temaId: Int,
            endring: List<EndreUndertemaRequest>,
            prosessId: Int = hentAlleSamarbeid().first().id,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = TestContainerHelper.applikasjon.performPut("${PLAN_BASE_ROUTE}/$orgnr/$saksnummer/prosess/$prosessId/$temaId")
            .jsonBody(Json.encodeToString(endring))
            .authentication().bearer(token)
            .tilSingelRespons<PlanDto>().third.fold(
                success = { respons -> respons },
                failure = { fail(it.message) },
            )

        fun IASakDto.endreFlereTemaerIPlan(
            endring: List<EndreTemaRequest>,
            prosessId: Int = hentAlleSamarbeid().first().id,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = TestContainerHelper.applikasjon.performPut("${PLAN_BASE_ROUTE}/$orgnr/$saksnummer/prosess/$prosessId")
            .jsonBody(Json.encodeToString(endring))
            .authentication().bearer(token)
            .tilSingelRespons<PlanDto>().third.fold(
                success = { respons -> respons },
                failure = { fail(it.message) },
            )

        private fun endrePlan(
            orgnr: String,
            saksnummer: String,
            prosessId: Int,
            endring: List<EndreTemaRequest>,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = TestContainerHelper.applikasjon.performPut("${PLAN_BASE_ROUTE}/$orgnr/$saksnummer/prosess/$prosessId")
            .jsonBody(Json.encodeToString(endring))
            .authentication().bearer(token)
            .tilSingelRespons<PlanDto>().third.fold(
                success = { respons -> respons },
                failure = { fail(it.message) },
            )

        private fun endreStatus(
            orgnr: String,
            saksnummer: String,
            prosessId: Int,
            status: PlanUndertema.Status,
            temaId: Int,
            undertemaId: Int,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = TestContainerHelper.applikasjon.performPut("${PLAN_BASE_ROUTE}/$orgnr/$saksnummer/prosess/$prosessId/$temaId/$undertemaId")
            .jsonBody(Json.encodeToString(status))
            .authentication().bearer(token)
            .tilSingelRespons<PlanDto>().third.fold(
                success = { respons -> respons },
                failure = { fail(it.message) },
            )

        fun PlanDtoI.tilRequest(): List<EndreTemaRequest> =
            this.temaer.map { tema ->
                EndreTemaRequest(
                    tema.id,
                    tema.inkludert,
                    tema.undertemaer.tilRequest(),
                )
            }

        fun List<PlanUndertemaDto>.tilRequest(): List<EndreUndertemaRequest> =
            this.map { innhold ->
                EndreUndertemaRequest(
                    innhold.id,
                    innhold.inkludert,
                    innhold.startDato,
                    innhold.sluttDato,
                )
            }

        fun hentPlanMal(token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token) =
            TestContainerHelper.applikasjon.performGet("${PLAN_BASE_ROUTE}/mal")
                .authentication().bearer(token)
                .tilSingelRespons<PlanMalDto>().third.fold(
                    success = { respons -> respons },
                    failure = { fail(it.message) },
                )

        fun PlanMedPubliseringStatusDto.planleggOgFullførAlleUndertemaer(
            orgnummer: String,
            saksnummer: String,
            prosessId: Int,
            token: String = TestContainerHelper.authContainerHelper.saksbehandler1.token,
        ) = this.copy(
            temaer = temaer.map { tema ->
                tema.copy(
                    inkludert = true,
                    undertemaer = tema.undertemaer.map {
                        it.copy(
                            inkludert = true,
                            startDato = START_DATO,
                            sluttDato = SLUTT_DATO,
                        )
                    },
                )
            },
        ).tilRequest().also { endringer ->
            endrePlan(
                orgnr = orgnummer,
                saksnummer = saksnummer,
                prosessId = prosessId,
                endring = endringer,
                token = token,
            )
        }.forEach { tema ->
            tema.undertemaer.forEach {
                endreStatus(
                    orgnr = orgnummer,
                    saksnummer = saksnummer,
                    prosessId = prosessId,
                    status = PlanUndertema.Status.FULLFØRT,
                    temaId = tema.id,
                    undertemaId = it.id,
                )
            }
        }.let {
            hentPlan(
                orgnr = orgnummer,
                saksnummer = saksnummer,
                prosessId = prosessId,
                token = token,
            )
        }
    }
}
