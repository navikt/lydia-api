package no.nav.lydia.container.ny.flyt.mål

import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.ktor.http.HttpStatusCode
import kotlinx.datetime.LocalDate
import kotlinx.serialization.json.Json
import no.nav.lydia.api.v1.NY_FLYT_API_PATH
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.aktivSamarbeidsperiode
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.avsluttSamarbeid
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.slettSamarbeidsplan
import no.nav.lydia.helper.PlanHelper.Companion.hentPlanResponse
import no.nav.lydia.helper.PlanHelper.Companion.opprettSamarbeidsplan
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.performPut
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.helper.statuskode
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.mål.MålDto
import no.nav.lydia.mål.SamarbeidsmålDto
import no.nav.lydia.mål.SykefraværsmålDto
import no.nav.lydia.mål.Sykefraværsmåltype
import no.nav.lydia.samarbeid.IASamarbeid
import no.nav.lydia.samarbeid.IASamarbeidDto
import no.nav.lydia.samarbeidsperiode.IASakDto
import kotlin.test.Test

class MålTest {
    private val frist = LocalDate(2027, 6, 30)

    private fun sykefraværsmål(
        type: Sykefraværsmåltype = Sykefraværsmåltype.LANGTIDSFRAVÆR,
        nåværende: Double = 7.5,
        mål: Double = 5.25,
    ) = SykefraværsmålDto(type = type, nåværende = nåværende, mål = mål, frist = frist)

    private fun IASakDto.samarbeid() = hentAlleSamarbeid(token = authContainerHelper.superbruker1.token).first()

    private fun IASamarbeidDto.url(orgnr: String) = "$NY_FLYT_API_PATH/virksomhet/$orgnr/samarbeidsperiode/$saksnummer/samarbeid/$id/maal"

    private fun IASakDto.lagreMål(
        mål: MålDto,
        token: String = authContainerHelper.saksbehandler1.token,
        samarbeid: IASamarbeidDto = samarbeid(),
    ) = applikasjon.performPut(samarbeid.url(orgnr))
        .authentication().bearer(token)
        .jsonBody(Json.encodeToString(mål))
        .tilSingelRespons<MålDto>()

    private fun IASakDto.hentMål(
        token: String = authContainerHelper.saksbehandler1.token,
        samarbeid: IASamarbeidDto = samarbeid(),
    ) = applikasjon.performGet(samarbeid.url(orgnr))
        .authentication().bearer(token)
        .tilSingelRespons<MålDto>()

    private fun List<SykefraværsmålDto>.utenId() = map { it.copy(id = null) }

    private data class Sporing(
        val opprettet: String,
        val sistEndret: String,
        val endretAv: String,
    )

    private fun sporing(sykefraværsmålId: Int?) =
        postgresContainerHelper.hentEnkelKolonne<String>(
            "SELECT concat_ws('|', opprettet, sist_endret, endret_av) FROM samarbeid_sykefravaersmaal WHERE id = $sykefraværsmålId",
        ).split("|").let { Sporing(opprettet = it[0], sistEndret = it[1], endretAv = it[2]) }

    private fun antallLagredeMål(samarbeidId: Int): Int =
        postgresContainerHelper.hentEnkelKolonne<Long>(
            """
            SELECT (SELECT count(*) FROM samarbeid_sykefravaersmaal WHERE ia_prosess = $samarbeidId)
                 + (SELECT count(*) FROM samarbeid_maal WHERE ia_prosess = $samarbeidId)
            """.trimIndent(),
        ).toInt()

    @Test
    fun `lagring av mål oppretter ikke plan`() {
        val sak = aktivSamarbeidsperiode()
        sak.hentMål().third.get() shouldBe MålDto(sykefraværsmål = emptyList(), samarbeidsmål = emptyList())

        val lagret = sak.lagreMål(
            MålDto(
                sykefraværsmål = listOf(sykefraværsmål()),
                samarbeidsmål = listOf(SamarbeidsmålDto(mål = "  Bedre dialog mellom leder og ansatte  ", lagretMedKiAdvarsel = true)),
            ),
        )

        lagret.statuskode() shouldBe HttpStatusCode.OK.value
        val mål = lagret.third.get()
        mål.sykefraværsmål.utenId() shouldBe listOf(sykefraværsmål())
        mål.samarbeidsmål shouldHaveSize 1
        mål.samarbeidsmål.first().mål shouldBe "Bedre dialog mellom leder og ansatte"
        mål.samarbeidsmål.first().lagretMedKiAdvarsel shouldBe true
        sak.hentMål().third.get() shouldBe mål

        sak.hentPlanResponse(samarbeidId = sak.samarbeid().id).statuskode() shouldBe HttpStatusCode.NotFound.value
    }

    @Test
    fun `ny lagring oppdaterer, legger til og fjerner mål`() {
        val sak = aktivSamarbeidsperiode()
        val første = sak.lagreMål(
            MålDto(
                sykefraværsmål = listOf(
                    sykefraværsmål(type = Sykefraværsmåltype.LANGTIDSFRAVÆR),
                    sykefraværsmål(type = Sykefraværsmåltype.KORTTIDSFRAVÆR),
                ),
                samarbeidsmål = listOf(SamarbeidsmålDto(mål = "Mål A"), SamarbeidsmålDto(mål = "Mål B")),
            ),
        ).third.get()
        val målA = første.samarbeidsmål.first { it.mål == "Mål A" }
        val korttid = første.sykefraværsmål.first { it.type == Sykefraværsmåltype.KORTTIDSFRAVÆR }

        val andre = sak.lagreMål(
            MålDto(
                sykefraværsmål = listOf(korttid.copy(mål = 2.0)),
                samarbeidsmål = listOf(målA.copy(mål = "Mål A endret"), SamarbeidsmålDto(mål = "Mål C")),
            ),
        ).third.get()

        andre.sykefraværsmål shouldBe listOf(korttid.copy(mål = 2.0))
        andre.samarbeidsmål.map { it.mål } shouldBe listOf("Mål A endret", "Mål C")
        andre.samarbeidsmål.first().id shouldBe målA.id
    }

    @Test
    fun `sykefraværsmål beholder rekkefølgen de ble lagret i`() {
        val sak = aktivSamarbeidsperiode()
        val rekkefølge = listOf(
            Sykefraværsmåltype.TAPTE_DAGSVERK,
            Sykefraværsmåltype.EGENMELDT_FRAVÆR,
            Sykefraværsmåltype.LEGEMELDT_FRAVÆR,
            Sykefraværsmåltype.KORTTIDSFRAVÆR,
        )
        val lagret = sak.lagreMål(MålDto(rekkefølge.map { sykefraværsmål(type = it) }, emptyList())).third.get().sykefraværsmål

        sak.hentMål().third.get().sykefraværsmål.map { it.type } shouldBe rekkefølge

        val endret = listOf(lagret[0].copy(mål = 1.0)) + lagret.drop(2) + sykefraværsmål(type = Sykefraværsmåltype.EGENMELDT_FRAVÆR)
        sak.lagreMål(MålDto(endret, emptyList()))

        sak.hentMål().third.get().sykefraværsmål.map { it.type } shouldBe listOf(
            Sykefraværsmåltype.TAPTE_DAGSVERK,
            Sykefraværsmåltype.LEGEMELDT_FRAVÆR,
            Sykefraværsmåltype.KORTTIDSFRAVÆR,
            Sykefraværsmåltype.EGENMELDT_FRAVÆR,
        )
    }

    @Test
    fun `sykefraværsmål beholder opprettet og sporer hvem som endret sist`() {
        val sak = aktivSamarbeidsperiode()
        val lagret = sak.lagreMål(
            MålDto(
                listOf(sykefraværsmål(type = Sykefraværsmåltype.LANGTIDSFRAVÆR), sykefraværsmål(type = Sykefraværsmåltype.KORTTIDSFRAVÆR)),
                emptyList(),
            ),
        ).third.get().sykefraværsmål
        val (uendret, endret) = lagret
        val førUendret = sporing(uendret.id)
        val førEndret = sporing(endret.id)

        sak.lagreMål(
            MålDto(listOf(uendret, endret.copy(mål = 1.0)), emptyList()),
            token = authContainerHelper.superbruker1.token,
        ).statuskode() shouldBe HttpStatusCode.OK.value

        sporing(uendret.id) shouldBe førUendret
        sporing(endret.id).opprettet shouldBe førEndret.opprettet
        sporing(endret.id).sistEndret shouldNotBe førEndret.sistEndret
        sporing(endret.id).endretAv shouldBe authContainerHelper.superbruker1.navIdent
    }

    @Test
    fun `skal avvise ukjent id og endret type på sykefraværsmål`() {
        val sak = aktivSamarbeidsperiode()
        val lagret = sak.lagreMål(MålDto(listOf(sykefraværsmål()), emptyList())).third.get()
        val mål = lagret.sykefraværsmål.single()

        sak.lagreMål(
            MålDto(listOf(mål.copy(type = Sykefraværsmåltype.KORTTIDSFRAVÆR)), emptyList()),
        ).statuskode() shouldBe HttpStatusCode.BadRequest.value
        sak.lagreMål(
            MålDto(listOf(sykefraværsmål().copy(id = Int.MAX_VALUE)), emptyList()),
        ).statuskode() shouldBe HttpStatusCode.BadRequest.value
        sak.lagreMål(
            MålDto(listOf(mål, sykefraværsmål(type = Sykefraværsmåltype.KORTTIDSFRAVÆR).copy(id = mål.id)), emptyList()),
        ).statuskode() shouldBe HttpStatusCode.BadRequest.value

        val annenSak = aktivSamarbeidsperiode()
        val målIAnnetSamarbeid = annenSak.lagreMål(MålDto(listOf(sykefraværsmål(mål = 3.0)), emptyList()))
            .third.get().sykefraværsmål.single()
        sak.lagreMål(
            MålDto(listOf(målIAnnetSamarbeid.copy(mål = 1.0)), emptyList()),
        ).statuskode() shouldBe HttpStatusCode.BadRequest.value

        sak.hentMål().third.get() shouldBe lagret
        annenSak.hentMål().third.get().sykefraværsmål shouldBe listOf(målIAnnetSamarbeid)
    }

    @Test
    fun `skal avvise ugyldige mål`() {
        val sak = aktivSamarbeidsperiode()

        sak.lagreMål(
            MålDto(listOf(sykefraværsmål(), sykefraværsmål()), emptyList()),
        ).statuskode() shouldBe HttpStatusCode.Conflict.value
        sak.lagreMål(
            MålDto(listOf(sykefraværsmål(nåværende = 100.5)), emptyList()),
        ).statuskode() shouldBe HttpStatusCode.BadRequest.value
        sak.lagreMål(
            MålDto(listOf(sykefraværsmål(mål = -1.0)), emptyList()),
        ).statuskode() shouldBe HttpStatusCode.BadRequest.value
        sak.lagreMål(
            MålDto(listOf(sykefraværsmål(nåværende = 6.123)), emptyList()),
        ).statuskode() shouldBe HttpStatusCode.BadRequest.value
        sak.lagreMål(
            MålDto(emptyList(), listOf(SamarbeidsmålDto(mål = "   "))),
        ).statuskode() shouldBe HttpStatusCode.BadRequest.value
        sak.lagreMål(
            MålDto(emptyList(), listOf(SamarbeidsmålDto(mål = "a".repeat(251)))),
        ).statuskode() shouldBe HttpStatusCode.BadRequest.value
        sak.lagreMål(
            MålDto(emptyList(), listOf(SamarbeidsmålDto(id = Int.MAX_VALUE, mål = "Ukjent"))),
        ).statuskode() shouldBe HttpStatusCode.BadRequest.value
    }

    @Test
    fun `tapte dagsverk kan være over 100`() {
        val sak = aktivSamarbeidsperiode()
        val dagsverk = sykefraværsmål(type = Sykefraværsmåltype.TAPTE_DAGSVERK, nåværende = 1250.0, mål = 900.25)

        sak.lagreMål(MålDto(listOf(dagsverk), emptyList())).third.get().sykefraværsmål.utenId() shouldBe listOf(dagsverk)
    }

    @Test
    fun `sletting av plan beholder målene`() {
        val sak = aktivSamarbeidsperiode()
        val samarbeid = sak.samarbeid()
        val plan = samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr)
        val lagret = sak.lagreMål(
            MålDto(listOf(sykefraværsmål()), listOf(SamarbeidsmålDto(mål = "Mål A"))),
        ).third.get()

        samarbeid.slettSamarbeidsplan(orgnr = sak.orgnr, planId = plan.id)

        antallLagredeMål(samarbeid.id) shouldBe 2
        sak.hentMål().third.get() shouldBe lagret
    }

    @Test
    fun `mål kan ikke endres etter at samarbeidet er fullført`() {
        val sak = aktivSamarbeidsperiode()
        sak.samarbeid().opprettSamarbeidsplan(orgnr = sak.orgnr)
        sak.lagreMål(MålDto(listOf(sykefraværsmål()), emptyList())).statuskode() shouldBe HttpStatusCode.OK.value

        sak.samarbeid().avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.FULLFØRT)

        sak.lagreMål(MålDto(emptyList(), emptyList())).statuskode() shouldBe HttpStatusCode.Conflict.value
    }

    @Test
    fun `tilgangskontroll for mål i samarbeidet`() {
        val sak = aktivSamarbeidsperiode()
        val mål = MålDto(listOf(sykefraværsmål()), emptyList())

        sak.lagreMål(mål, token = authContainerHelper.lesebruker.token).statuskode() shouldBe HttpStatusCode.Forbidden.value
        sak.lagreMål(mål, token = authContainerHelper.saksbehandler2.token).statuskode() shouldBe HttpStatusCode.Forbidden.value
        sak.hentMål(token = authContainerHelper.lesebruker.token).statuskode() shouldBe HttpStatusCode.OK.value

        val annenSak = aktivSamarbeidsperiode(følgerToken = null)
        annenSak.lagreMål(mål).statuskode() shouldBe HttpStatusCode.Forbidden.value
        val samarbeidIAnnenSak = annenSak.samarbeid().copy(saksnummer = sak.saksnummer)
        sak.hentMål(samarbeid = samarbeidIAnnenSak).statuskode() shouldBe HttpStatusCode.BadRequest.value
        sak.lagreMål(mål, samarbeid = samarbeidIAnnenSak).statuskode() shouldBe HttpStatusCode.BadRequest.value
        applikasjon.performPut(sak.samarbeid().url(orgnr = annenSak.orgnr))
            .authentication().bearer(authContainerHelper.saksbehandler1.token)
            .jsonBody(Json.encodeToString(mål))
            .tilSingelRespons<MålDto>()
            .statuskode() shouldBe HttpStatusCode.BadRequest.value
    }
}
